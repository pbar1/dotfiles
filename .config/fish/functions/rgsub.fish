function rgsub
  for f in (rg --files-with-matches $argv[1])
    set tmp_f (mktemp)
    rg --passthru --replace=$argv[2] $argv[1] $f > $tmp_f
    mv $tmp_f $f
  end
end
