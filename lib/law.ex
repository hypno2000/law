defmodule Law do
  @moduledoc """
  Documentation for Law.
  """
  project_top_path = Mix.Project.deps_path() |> Path.join("..")
  git_hooks_path = Path.join(project_top_path, ".git/hooks")
  case File.exists?(git_hooks_path) do
    true ->
      pre_commit_hook_path = Path.join(git_hooks_path, "pre-commit")
      case  project_top_path
            |> Path.join("pre-commit")
            |> File.ln_s(pre_commit_hook_path) do
        :ok -> Mix.shell.info("pre-commit hook #{pre_commit_hook_path} created")
        {:error, :eexist} -> Mix.shell.info("pre-commit hook #{pre_commit_hook_path} already exists, do nothing")
        error -> raise("Can not create symbolic link for pre-commit hook #{pre_commit_hook_path} because of error #{inspect error}")
      end
    false ->
      raise("It seems path #{git_hooks_path} is not exist. To keep the Law, your Elixir project should be in git repository.")
  end
end
