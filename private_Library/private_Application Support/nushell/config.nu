 let carapace_completer = {|spans|
 carapace $spans.0 nushell ...$spans | from json
 }
 $env.config = {
  show_banner: false,
  completions: {
  case_sensitive: false # case-sensitive completions
  quick: true    # set to false to prevent auto-selecting completions
  partial: true    # set to false to prevent partial filling of the prompt
  algorithm: "fuzzy"    # prefix or fuzzy
  external: {
  # set to false to prevent nushell looking into $env.PATH to find more suggestions
      enable: true
  # set to lower can improve completion performance at the cost of omitting some options
      max_results: 100
      completer: $carapace_completer # check 'carapace_completer'
    }
  }
 }

 def lsd [] { ls | where type == dir }

 $env.PATH = ($env.PATH |
 split row (char esep) |
 prepend /home/myuser/.apps |
 append /usr/bin/env
 )

$env.config = {
  hooks: {
    pre_prompt: [{ ||
      if (which direnv | is-empty) {
        return
      }

      direnv export json | from json | default {} | load-env
      if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
        $env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
      }
    }]
  }
}

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
zoxide init nushell | save -f ~/.zoxide.nu
source ~/.zoxide.nu

alias __builtin_cd = cd
alias cd = z
alias c = clear
alias gm = git commit -m

