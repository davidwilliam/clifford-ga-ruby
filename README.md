# Clifford GA Ruby

Ruby library for data representation and data concealment with Ruby.

## Requirements

This code requires Ruby installed on your system. There are [several options for downloading and installing Ruby](https://www.ruby-lang.org/en/downloads/ "Download Ruby").

This project uses only Ruby standard libraries, so once you have Ruby installed (version 2.6.3 and greater), you have everything required to run the code. We tested our implementation on Mac OSX version 10.13.6 with ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-darwin17].

## Usage

### Running tests

Once Ruby is installed on your machine, from the command line and in the root directory of the project, run the tests to check the code with the following command:

`$ rake`

You should get a result similiar to the following:

```console
Run options: --seed 9109

# Running:

...........

Finished in 5.316182s, 2.0692 runs/s, 9.0290 assertions/s.

11 runs, 48 assertions, 0 failures, 0 errors, 0 skips
```

### Ruby Interactive Shell

You can also run code from the Ruby Interactive Shell (IRB). From the project's root directory, execute the following command on the terminal:

`$ irb`

You will see the IRB's prompt. Next, command snippets for specific cases that can be executed on IRB.

#### Working with multivectors

Require the file the will boot the entire project on IRB:

`> require './boot'`

Creating a multivector:

`> m = Clifford::Multivector3D.new [2,3,4,5,6,7,8,9]`

which returns

`=> 2e0 + 3e1 + 4e2 + 5e3 + 6e12 + 7e13 + 8e23 + 9e123`

Clifford conjugation:

`> m.clifford_conjugation` or `> m.cc`

`=> 2e0 + -3e1 + -4e2 + -5e3 + -6e12 + -7e13 + -8e23 + 9e123`

Reverse:

`> m.reverse`

`=> 2e0 + 3e1 + 4e2 + 5e3 + -6e12 + -7e13 + -8e23 + -9e123`

Amplitude squared:

`> m.amplitude_squared`

`=> 22e0 + 0e1 + 0e2 + 0e3 + 0e12 + 0e13 + 0e23 + -16e123`

Rationalize:

`> m.rationalize`

`=> 740e0 + 0e1 + 0e2 + 0e3 + 0e12 + 0e13 + 0e23 + 0e123`

Inverse:

`> m.inverse`

`=> -5/37e0 + 31/370e1 + -10/37e2 + -7/370e3 + -53/185e12 + -9/74e13 + -56/185e23 + 23/74e123`

Geometric product:

`> m.geometric_product(m.inverse)` or `>> m.gp(m.inverse)`

`=> 1e0 + 0e1 + 0e2 + 0e3 + 0e12 + 0e13 + 0e23 + 0e123`

`> m.gp(m)`

`=> -176e0 + -132e1 + 142e2 + -88e3 + 114e12 + -44e13 + 86e23 + 88e123`

Addition:

`> m.plus(m)`

`=> 4e0 + 6e1 + 8e2 + 10e3 + 12e12 + 14e13 + 16e23 + 18e123`

Subtraction:

`> m.minus(m)`

`=> 0e0 + 0e1 + 0e2 + 0e3 + 0e12 + 0e13 + 0e23 + 0e123`

Scalar division:

`> m.scalar_div(2)`

`=> 1e0 + 3/2e1 + 2e2 + 5/2e3 + 3e12 + 7/2e13 + 4e23 + 9/2e123`

Scalar multiplication:

`> m.scalar_mul(2)`

`=> 4e0 + 6e1 + 8e2 + 10e3 + 12e12 + 14e13 + 16e23 + 18e123`

All multivectors M in Cl(3,0) can be decomposed as in M = Z + F. Obtaining Z:

`> m.z`

`=> 2e0 + 0e1 + 0e2 + 0e3 + 0e12 + 0e13 + 0e23 + 9e123`

Obtaining F:

`> m.f`

`=> 0e0 + 3e1 + 4e2 + 5e3 + 6e12 + 7e13 + 8e23 + 0e123`

Obtaining F squared:

`> m.f2`

`=> -99e0 + 0e1 + 0e2 + 0e3 + 0e12 + 0e13 + 0e23 + 52e123`

Obtaining the eigenvalues a multivector:

`> m.eigenvalues`

`=> [(4.5323662175072155+19.26707741568027i), (-0.5323662175072155-1.2670774156802675i)]`

#### Packing multivectors

##### Clifford Eigenvalue Packing Scheme

`> a = Clifford::Packing.cep_forward(23)`

`181/2e0 + -35507199447/428048393e1 + -68935712985/856096786e2 + 144683344314/428048393e3 + -29616707322/428048393e12 + 145732761090/428048393e13 + 20785971411/428048393e23 + 0e123`

`> b = Clifford::Packing.cep_forward(18)`

`=> 111e0 + -244605151746/2140241965e1 + -47489046723/428048393e2 + 996707483052/2140241965e3 + -204026205996/2140241965e12 + 200787359724/428048393e13 + 143192247498/2140241965e23 + 0e123`

Recovering the packed message:

`> Clifford::Packing.cep_backward(a)`

`=> 23`

`> Clifford::Packing.cep_backward(b)`

`=> 18`

Addition:

`a_plus_b = a.plus(b)`

`=> 403/2e0 + -422141148981/2140241965e1 + -163913806431/856096786e2 + 1720124204622/2140241965e3 + -352109742606/2140241965e12 + 346520120814/428048393e13 + 247122104553/2140241965e23 + 0e123`

`> Clifford::Packing.cep_backward(a_plus_b)`

`=> 41`

Multiplication:

`> a_times_b = a.gp(b)`

`=> 16323e0 + -41843261926098/2140241965e1 + -8123690799099/428048393e2 + 170501283310476/2140241965e3 + -34901644206348/2140241965e12 + 34347592536012/428048393e13 + 24495112531674/2140241965e23 + 0e123`

`> Clifford::Packing.cep_backward(a_times_b)`

`=> 414`

##### Complex Magnitude Squared Packing Scheme

`> a = Clifford::Packing.cmsp_forward(26)`

`=> 6.471338332083668+31.438854634950513ie0 + 4.906228887222669+41.4679929927055ie1 + 22e2 + 29e3 + 19e12 + 22e13 + 18e23 + 24e123`

`> b = Clifford::Packing.cmsp_forward(41)`

`=> -103.99587604803894-2.337670283500854ie0 + -94.53195854374974-2.5717024463389007ie1 + 52e2 + 49e3 + 38e12 + 36e13 + 56e23 + 51e123`

Multiplication:

`> a_times_b = a.gp(b)`

`=> -2137.6509095698448-7217.307040332529ie0 + -3020.185983839764-7312.5882643378845ie1 + 1275.1442302572004+3208.0377749836557ie2 + -2027.457499218519+3022.136640447904ie3 + 2675.8162018045127+3363.173830181745ie12 + -1063.1090798591918+3186.881048207597ie13 + -3806.080154069653+3771.64457837006ie23 + -3495.689206319693+3823.1944631358633ie123`

`> Clifford::Packing.cmsp_backward(a_times_b)`

`=> 1066`

#### Concealing multivectors

##### Clifford Sylvester's Equation Concelament Scheme

First, pack two multivectors A and B:

`> a = Clifford::Packing.cep_forward(12)`

`=> 74e0 + -163070101164/2140241965e1 + -31659364482/428048393e2 + 664471655368/2140241965e3 + -136017470664/2140241965e12 + 133858239816/428048393e13 + 95461498332/2140241965e23 + 0e123`

`> b = Clifford::Packing.cep_forward(19)`

`=> 177/2e0 + -182796323079/2140241965e1 + -70978252629/856096786e2 + 744851291098/2140241965e3 + -152471196954/2140241965e12 + 150050768826/428048393e13 + 107009260227/2140241965e23 + 0e123`

Generate a tuple of secret keys:

`k = Clifford::Tools.generate_regular_keys`

`=> [189e0 + 216e1 + 202e2 + 222e3 + 152e12 + 172e13 + 202e23 + 187e123, 184e0 + 235e1 + 176e2 + 225e3 + 148e12 + 177e13 + 144e23 + 145e123]`

Conceal:

`> ca = Clifford::Concealment.csec_forward(k,a)`

`=> -618818306222/428048393e0 + -19501147572462/2140241965e1 + 265089164434222/2140241965e2 + 361931982799054/2140241965e3 + 263927103941858/2140241965e12 + 352630738821406/2140241965e13 + 51070915692586/2140241965e23 + -3998489933290/428048393e123`

`> cb = Clifford::Concealment.csec_forward(k,b)`

`=> 384383003877/856096786e0 + -33009163124779/4280483930e1 + 603290221657139/4280483930e2 + 822044307451883/4280483930e3 + 598832474024101/4280483930e12 + 798864039917347/4280483930e13 + 122715122589577/4280483930e23 + -7387370951481/856096786e123`

Addition over concealed data:

`> ca_plus_cb = ca.plus(cb)`

`=> -853253608567/856096786e0 + -72011458269703/4280483930e1 + 1133468550525583/4280483930e2 + 1545908273049991/4280483930e3 + 1126686681907817/4280483930e12 + 1504125517560159/4280483930e13 + 224856953974749/4280483930e23 + -15384350818061/856096786e123`

`> a_plus_b = Clifford::Concealment.csec_backward(k,ca_plus_cb)`

`=> 325/2e0 + -345866424243/2140241965e1 + -134296981593/856096786e2 + 1409322946466/2140241965e3 + -288488667618/2140241965e12 + 283909008642/428048393e13 + 202470758559/2140241965e23 + 0e123`

`> Clifford::Packing.cep_backward(a_plus_b)`

`=> 31`

##### Modular Concelament Scheme

First, generate modular secret keys:

`> k = Clifford::Tools.generate_modular_keys`

`=> [449/2e0 + 9205570227/2140241965e1 + 3574444377/856096786e2 + -37510496674/2140241965e3 + 7678405602/2140241965e12 + -7556513538/428048393e13 + -5388955551/2140241965e23 + 0e123, 351/2e0 + 74959643277/2140241965e1 + 29106189927/856096786e2 + -305442615774/2140241965e3 + 62524159902/2140241965e12 + -61531610238/428048393e13 + -43881495201/2140241965e23 + 0e123]`

Create two multivectors A and B:

`> a = Clifford::Packing.cep_forward(22)`

`=> 159/2e0 + -30246873603/428048393e1 + -58723014765/856096786e2 + 123248774786/428048393e3 + -25229046978/428048393e12 + 124142722410/428048393e13 + 17706568239/428048393e23 + 0e123`

`> b = Clifford::Packing.cep_forward(25)`

`=> 129e0 + -273536943888/2140241965e1 + -53106030744/428048393e2 + 1114597615456/2140241965e3 + -228158337888/2140241965e12 + 224536402272/428048393e13 + 160128964944/2140241965e23 + 0e123`

Conceal:

`> ca = Clifford::Concealment.mc_forward(k,a)`

`=> 14908785/2e0 + 947656906366827/428048393e1 + 1839835456554885/856096786e2 + -3861475210965874/428048393e3 + 790444689377202/428048393e12 + -3889483250769690/428048393e13 + -554759870391351/428048393e23 + 0e123`

`> cb = Clifford::Concealment.mc_forward(k,b)`

`=> 16241565/2e0 + 3841917117527769/2140241965e1 + 1491783637407819/856096786e2 + -15654893255403878/2140241965e3 + 3204559542777894/2140241965e12 + -3153688255543686/428048393e13 + -2249064432343197/2140241965e23 + 0e123`

`> ca_times_cb = ca.gp(cb)`

`=> 63167002896385e0 + 13423547250531991237194/428048393e1 + 13030622168392992896235/428048393e2 + -54697744091672128203228/428048393e3 + 11196638325009710340444/428048393e12 + -55094477596356546423180/428048393e13 + -7858166054471528380722/428048393e23 + 0e123`

`> a_times_b = Clifford::Concealment.mc_backward(k,ca_times_cb)`

`=> 29521e0 + -76198450013262/2140241965e1 + -14793604006581/428048393e2 + 310490456897844/2140241965e3 + -63557453913012/2140241965e12 + 62548501059828/428048393e13 + 44606694648006/2140241965e23 + 0e123`

`> Clifford::Packing.cep_backward(a_times_b)`

`=> 550`
