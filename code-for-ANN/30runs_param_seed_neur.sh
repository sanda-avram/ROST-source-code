
noRuns=30
trainFile="../data-preprocessing/FANNsets/${1}_trainSet$2"
validFile="../data-preprocessing/FANNsets/${1}_validSet$2"
testFile="../data-preprocessing/FANNsets/${1}_testSet$2"
noInputs=`awk '(NR==2){print NF}' $testFile`
noOutputs=10
noLayers=3
maxEpochs=500

make

dir="myOut/"
if [ ! -d $dir ]
then
  mkdir $dir
fi
for noHiddenNeurons in `seq 5 50`
do
  outFile=$dir`date "+%Y-%m-%d-%H-%M"`"run-${2}_"$noHiddenNeurons
  ./my_trainValidTest_seedFib $noRuns $trainFile $validFile $testFile $noInputs $noOutputs $noLayers $noHiddenNeurons $maxEpochs >> $outFile
  bash showResults.sh $dir stats

#   #sleep 2
done
