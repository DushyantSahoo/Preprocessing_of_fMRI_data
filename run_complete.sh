for i in /Users/cyber/Desktop/data/* ; do
  if [ -d "$i" ]; then
  	echo $i
    cd $i

    for j in "$i"/* ; do
    	k=1
      if [ -d "$j" ]; then
        cd $j
		echo $j
		if [ -f $j/func/rest.nii.gz ]; then
      if [ ! -d $j/func/rest.feat ]; then
  			if [ $k -eq 1 ]; then
  				Rscript /Users/cyber/Desktop/data/change_var.R $j/func/rest.nii.gz
          echo "run"
  			fi
  			let "k += 1"
      
  			Rscript /Users/cyber/Desktop/data/change_file.R $j/
  			/usr/local/fsl/bin/feat /Users/cyber/Desktop/data/design.fsf
      fi
		fi

      fi
    done

  fi
done
