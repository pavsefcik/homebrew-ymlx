class Ymlx < Formula
  desc "Local MLX LLM manager, OpenAI-compatible API on :11500"
  homepage "https://github.com/pavsefcik/ymlx"
  url "https://github.com/pavsefcik/ymlx/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "170aefaec58eab14da0446f60c161e5bb23de18de5625e7c919d394b12283d81"
  license "MIT"

  # SHA256 is for the current `main` tree. After tagging a release run
  #   make formula
  # (from the ymlx checkout) to recompute it from the real GitHub tag tarball.

  # Apple Silicon (MLX) only.
  depends_on "gum"  # menu rendering
  depends_on :macos
  depends_on "uv"   # drives the mlx-vlm tool

  on_macos do
    depends_on arch: :arm
  end

  def install
    # Keep the full tree (ymlx.zsh sources lib/ymlx-helpers.zsh by relative
    # path) under libexec, then expose a thin `ymlx` wrapper. Exclude the repo's
    # own ymlx-launcher.zsh: its brew-aware replacement is written below, and
    # Homebrew refuses to overwrite files it already installed.
    libexec.install Dir["*"] - ["ymlx-launcher.zsh"]

    (bin/"ymlx").write <<~EOS
      #!/usr/bin/env bash
      set -euo pipefail
      exec zsh "#{libexec}/ymlx.zsh" "$@"
    EOS
    chmod 0755, bin/"ymlx"

    # Sourceable shim so `ymlx` also works from a shared ~/.zshrc line:
    #   source "$(brew --prefix)/opt/ymlx/libexec/ymlx-launcher.zsh"
    # (mlx-vlm itself is installed at runtime as a uv tool.)
    (libexec/"ymlx-launcher.zsh").write <<~EOS
      # ymlx launcher (Homebrew install)
      _YMLX_DIR="#{libexec}"
      ymlx() { zsh "$_YMLX_DIR/ymlx.zsh" "$@"; }
    EOS
  end

  test do
    assert_path_exists libexec/"ymlx.zsh"
    assert_path_exists libexec/"lib/ymlx-helpers.zsh"
    assert_path_exists bin/"ymlx"
  end
end
