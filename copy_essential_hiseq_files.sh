#STEPS
SOURCE="140306_D00172_0117_AH989DADXX"
mkdir $SOURCE
cd $SOURCE
mkdir -p Data/Intensities/BaseCalls
cp /data/sequencer/hiseq_D00172/$SOURCE/RunInfo.xml .
cp /data/sequencer/hiseq_D00172/$SOURCE/runParameters.xml .
cd Data/Intensities
mkdir L001
mkdir L002
mkdir L003
mkdir L004
mkdir L005
mkdir L006
mkdir L007
mkdir L008
cp /data/sequencer/hiseq_D00172/$SOURCE/Data/Intensities/config.xml .
cp /data/sequencer/hiseq_D00172/$SOURCE/Data/Intensities/RTAConfiguration.xml .
cp /data/sequencer/hiseq_D00172/$SOURCE/Data/Intensities/*pos.txt .
cp /data/sequencer/hiseq_D00172/$SOURCE/Data/Intensities/L001/*.clocs L001/
cp /data/sequencer/hiseq_D00172/$SOURCE/Data/Intensities/L002/*.clocs L002/
cp /data/sequencer/hiseq_D00172/$SOURCE/Data/Intensities/L003/*.clocs L003/
cp /data/sequencer/hiseq_D00172/$SOURCE/Data/Intensities/L004/*.clocs L004/
cp /data/sequencer/hiseq_D00172/$SOURCE/Data/Intensities/L005/*.clocs L005/
cp /data/sequencer/hiseq_D00172/$SOURCE/Data/Intensities/L006/*.clocs L006/
cp /data/sequencer/hiseq_D00172/$SOURCE/Data/Intensities/L007/*.clocs L007/
cp /data/sequencer/hiseq_D00172/$SOURCE/Data/Intensities/L008/*.clocs L008/
cd BaseCalls
cp /data/sequencer/hiseq_D00172/$SOURCE/Data/Intensities/BaseCalls/SampleSheet.csv .
cp /data/sequencer/hiseq_D00172/$SOURCE/Data/Intensities/BaseCalls/config.xml .
mkdir L001
mkdir L002
mkdir L003
mkdir L004
mkdir L005
mkdir L006
mkdir L007
mkdir L008
cp -r /data/sequencer/hiseq_D00172/$SOURCE/Data/Intensities/BaseCalls/L001/* L001/ &
cp -r /data/sequencer/hiseq_D00172/$SOURCE/Data/Intensities/BaseCalls/L002/* L002/ &
cp -r /data/sequencer/hiseq_D00172/$SOURCE/Data/Intensities/BaseCalls/L003/* L003/ &
cp -r /data/sequencer/hiseq_D00172/$SOURCE/Data/Intensities/BaseCalls/L004/* L004/ &
cp -r /data/sequencer/hiseq_D00172/$SOURCE/Data/Intensities/BaseCalls/L005/* L005/ &
cp -r /data/sequencer/hiseq_D00172/$SOURCE/Data/Intensities/BaseCalls/L006/* L006/ &
cp -r /data/sequencer/hiseq_D00172/$SOURCE/Data/Intensities/BaseCalls/L007/* L007/ &
cp -r /data/sequencer/hiseq_D00172/$SOURCE/Data/Intensities/BaseCalls/L008/* L008/ &
