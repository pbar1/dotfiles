function gg
  set main_origin (git symbolic-ref refs/remotes/origin/HEAD | sed 's|^refs/remotes/origin/||')
  if git remote | grep --quiet upstream
    set main_upstream (git symbolic-ref refs/remotes/upstream/HEAD | sed 's|^refs/remotes/upstream/||')
    git fetch upstream && git checkout $main_origin && git merge upstream/$main_upstream && git push origin $main_origin
  else
    git checkout $main_origin && git pull
  end
end
