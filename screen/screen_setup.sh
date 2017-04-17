project=$1
command=$2

dir=""
if [ $project = "api" ]; then
  dir=$(greadlink -f ~/Development/at-api-server)
elif [ $project = "portal" ]; then
  dir=$(greadlink -f ~/Development/portal)
elif [ $project = "connector" ]; then
  dir=$(greadlink -f ~/Development/emm-connector)
else
  exit 1
fi

ruby_script=$(greadlink -f ~/.screen_setup.rb)
cd $dir

if [ -n "${command}" ]; then
  echo $ruby_script
  ruby $ruby_script $project $command
fi
