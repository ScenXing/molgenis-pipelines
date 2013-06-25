#MOLGENIS walltime=2:00:00 nodes=1 cores=1 mem=4

#FOREACH mergedStudy
mkdir -p ${expressionFolder}

rm -f ${expressionFolder}/fileList.txt

<#assign samples=sample?size - 1>
<#list 0..samples as i>
  cat "${sample[i]}\t${gtfExpression[i]}" >> ${expressionFolder}/fileList.txt
</#list> 

/cm/shared/apps/sunjdk/jdk1.6.0_21/bin/java \
	Xmx4g \
	-jar ${processReadCountsJar} \
	--mode makeExpressionTable \
	--fileList ${expressionFolder}/fileList.txt \
	--annot ${annotationTxt} \
	--out ${expressionTable}
