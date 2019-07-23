/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
/// Sample PMML file based on Iris measurements in <class>DataMining.IrisDataset</class>.
Class DataMining.PMML.Iris Extends %DeepSee.PMML.Definition [ DependsOn = DataMining.IrisCube, ProcedureBlock ]
{

XData PMML [ XMLNamespace = "http://www.intersystems.com/deepsee/pmml" ]
{
<PMML xmlns="http://www.dmg.org/PMML-4_3" xmlns:data="http://jpmml.org/jpmml-model/InlineTable" version="4.3">
	<Header>
		<Application name="JPMML-SkLearn" version="1.5.15"/>
		<Timestamp>2019-06-20T17:11:41Z</Timestamp>
	</Header>
	<MiningBuildTask>
		<Extension>PMMLPipeline(steps=[('estimator', GaussianNB(priors=None, var_smoothing=1e-09))])</Extension>
	</MiningBuildTask>
	<DataDictionary>
		<DataField name="Species" optype="categorical" dataType="integer">
			<Value value="0"/>
			<Value value="1"/>
			<Value value="2"/>
		</DataField>
		<DataField name="SepalLength" optype="continuous" dataType="double"/>
		<DataField name="SepalWidth" optype="continuous" dataType="double"/>
		<DataField name="PetalLength" optype="continuous" dataType="double"/>
		<DataField name="PetalWidth" optype="continuous" dataType="double"/>
	</DataDictionary>
	<NaiveBayesModel threshold="0.0" functionName="classification">
		<MiningSchema>
			<MiningField name="Species" usageType="target"/>
			<MiningField name="SepalLength"/>
			<MiningField name="SepalWidth"/>
			<MiningField name="PetalLength"/>
			<MiningField name="PetalWidth"/>
		</MiningSchema>
		<Output>
			<OutputField name="probability(0)" optype="continuous" dataType="double" feature="probability" value="0"/>
			<OutputField name="probability(1)" optype="continuous" dataType="double" feature="probability" value="1"/>
			<OutputField name="probability(2)" optype="continuous" dataType="double" feature="probability" value="2"/>
		</Output>
		<BayesInputs>
			<BayesInput fieldName="SepalLength">
				<TargetValueStats>
					<TargetValueStat value="0">
						<GaussianDistribution mean="5.005999999999999" variance="0.12176400309550259"/>
					</TargetValueStat>
					<TargetValueStat value="1">
						<GaussianDistribution mean="5.936" variance="0.2611040030955028"/>
					</TargetValueStat>
					<TargetValueStat value="2">
						<GaussianDistribution mean="6.587999999999998" variance="0.39625600309550263"/>
					</TargetValueStat>
				</TargetValueStats>
			</BayesInput>
			<BayesInput fieldName="SepalWidth">
				<TargetValueStats>
					<TargetValueStat value="0">
						<GaussianDistribution mean="3.428000000000001" variance="0.14081600309550263"/>
					</TargetValueStat>
					<TargetValueStat value="1">
						<GaussianDistribution mean="2.7700000000000005" variance="0.09650000309550268"/>
					</TargetValueStat>
					<TargetValueStat value="2">
						<GaussianDistribution mean="2.9739999999999998" variance="0.10192400309550273"/>
					</TargetValueStat>
				</TargetValueStats>
			</BayesInput>
			<BayesInput fieldName="PetalLength">
				<TargetValueStats>
					<TargetValueStat value="0">
						<GaussianDistribution mean="1.4620000000000002" variance="0.029556003095502676"/>
					</TargetValueStat>
					<TargetValueStat value="1">
						<GaussianDistribution mean="4.26" variance="0.21640000309550278"/>
					</TargetValueStat>
					<TargetValueStat value="2">
						<GaussianDistribution mean="5.552" variance="0.2984960030955029"/>
					</TargetValueStat>
				</TargetValueStats>
			</BayesInput>
			<BayesInput fieldName="PetalWidth">
				<TargetValueStats>
					<TargetValueStat value="0">
						<GaussianDistribution mean="0.2459999999999999" variance="0.010884003095502673"/>
					</TargetValueStat>
					<TargetValueStat value="1">
						<GaussianDistribution mean="1.3259999999999998" variance="0.03832400309550265"/>
					</TargetValueStat>
					<TargetValueStat value="2">
						<GaussianDistribution mean="2.026" variance="0.07392400309550265"/>
					</TargetValueStat>
				</TargetValueStats>
			</BayesInput>
		</BayesInputs>
		<BayesOutput fieldName="Species">
			<TargetValueCounts>
				<TargetValueCount value="0" count="50"/>
				<TargetValueCount value="1" count="50"/>
				<TargetValueCount value="2" count="50"/>
			</TargetValueCounts>
		</BayesOutput>
	</NaiveBayesModel>
</PMML>
}

}
