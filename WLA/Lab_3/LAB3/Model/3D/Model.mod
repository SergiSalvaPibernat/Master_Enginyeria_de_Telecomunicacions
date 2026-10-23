'# MWS Version: Version 2021.2 - Jan 06 2021 - ACIS 30.0.1 -

'# length = mm
'# frequency = GHz
'# time = ns
'# frequency range: fmin = 2 fmax = 3
'# created = '[VERSION]2021.2|30.0.1|20210106[/VERSION]


'@ use template: Antenna - Planar.cfg

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
'set the units
With Units
    .Geometry "mm"
    .Frequency "GHz"
    .Voltage "V"
    .Resistance "Ohm"
    .Inductance "NanoH"
    .TemperatureUnit  "Kelvin"
    .Time "ns"
    .Current "A"
    .Conductance "Siemens"
    .Capacitance "PikoF"
End With

'----------------------------------------------------------------------------

Plot.DrawBox True

With Background
     .Type "Normal"
     .Epsilon "1.0"
     .Mu "1.0"
     .XminSpace "0.0"
     .XmaxSpace "0.0"
     .YminSpace "0.0"
     .YmaxSpace "0.0"
     .ZminSpace "0.0"
     .ZmaxSpace "0.0"
End With

With Boundary
     .Xmin "expanded open"
     .Xmax "expanded open"
     .Ymin "expanded open"
     .Ymax "expanded open"
     .Zmin "expanded open"
     .Zmax "expanded open"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
End With

' optimize mesh settings for planar structures

With Mesh
     .MergeThinPECLayerFixpoints "True"
     .RatioLimit "20"
     .AutomeshRefineAtPecLines "True", "6"
     .FPBAAvoidNonRegUnite "True"
     .ConsiderSpaceForLowerMeshLimit "False"
     .MinimumStepNumber "5"
     .AnisotropicCurvatureRefinement "True"
     .AnisotropicCurvatureRefinementFSM "True"
End With

With MeshSettings
     .SetMeshType "Hex"
     .Set "RatioLimitGeometry", "20"
     .Set "EdgeRefinementOn", "1"
     .Set "EdgeRefinementRatio", "6"
End With

With MeshSettings
     .SetMeshType "HexTLM"
     .Set "RatioLimitGeometry", "20"
End With

With MeshSettings
     .SetMeshType "Tet"
     .Set "VolMeshGradation", "1.5"
     .Set "SrfMeshGradation", "1.5"
End With

' change mesh adaption scheme to energy
' 		(planar structures tend to store high energy
'     	 locally at edges rather than globally in volume)

MeshAdaption3D.SetAdaptionStrategy "Energy"

' switch on FD-TET setting for accurate farfields

FDSolver.ExtrudeOpenBC "True"

PostProcess1D.ActivateOperation "vswr", "true"
PostProcess1D.ActivateOperation "yz-matrices", "true"

With FarfieldPlot
	.ClearCuts ' lateral=phi, polar=theta
	.AddCut "lateral", "0", "1"
	.AddCut "lateral", "90", "1"
	.AddCut "polar", "90", "1"
End With

'----------------------------------------------------------------------------

With MeshSettings
     .SetMeshType "Hex"
     .Set "Version", 1%
End With

With Mesh
     .MeshType "PBA"
End With

'set the solver type
ChangeSolverType("HF Time Domain")

'----------------------------------------------------------------------------

'@ new component: component1

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
Component.New "component1"

'@ define brick: component1:Groundplane

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
With Brick
     .Reset 
     .Name "Groundplane" 
     .Component "component1" 
     .Material "PEC" 
     .Xrange "-W_ground/2", "W_ground/2" 
     .Yrange "-L_ground/2", "L_ground/2" 
     .Zrange "0", "0" 
     .Create
End With

'@ define material: Rogers RT5880 (lossy)

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
With Material
     .Reset
     .Name "Rogers RT5880 (lossy)"
     .Folder ""
.FrqType "all"
.Type "Normal"
.SetMaterialUnit "GHz", "mm"
.Epsilon "2.2"
.Mu "1.0"
.Kappa "0.0"
.TanD "0.0009"
.TanDFreq "10.0"
.TanDGiven "True"
.TanDModel "ConstTanD"
.KappaM "0.0"
.TanDM "0.0"
.TanDMFreq "0.0"
.TanDMGiven "False"
.TanDMModel "ConstKappa"
.DispModelEps "None"
.DispModelMu "None"
.DispersiveFittingSchemeEps "General 1st"
.DispersiveFittingSchemeMu "General 1st"
.UseGeneralDispersionEps "False"
.UseGeneralDispersionMu "False"
.Rho "0.0"
.ThermalType "Normal"
.ThermalConductivity "0.20"
.SetActiveMaterial "all"
.Colour "0.94", "0.82", "0.76"
.Wireframe "False"
.Transparency "0"
.Create
End With

'@ define brick: component1:substrate

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
With Brick
     .Reset 
     .Name "substrate" 
     .Component "component1" 
     .Material "Rogers RT5880 (lossy)" 
     .Xrange "-W_ground/2", "W_ground/2" 
     .Yrange "-L_ground/2", "L_ground/2" 
     .Zrange "0", "h_substrate" 
     .Create
End With

'@ define brick: component1:patch

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
With Brick
     .Reset 
     .Name "patch" 
     .Component "component1" 
     .Material "PEC" 
     .Xrange "-W/2", "W/2" 
     .Yrange "-L/2", "L/2" 
     .Zrange "h_substrate", "h_substrate" 
     .Create
End With

'@ new component: component2

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
Component.New "component2"

'@ define cylinder: component2:coax_inner

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
With Cylinder 
     .Reset 
     .Name "coax_inner" 
     .Component "component2" 
     .Material "PEC" 
     .OuterRadius "coax_in/2" 
     .InnerRadius "0" 
     .Axis "z" 
     .Zrange "-l_coax", "h_substrate" 
     .Xcenter "0" 
     .Ycenter "-y0" 
     .Segments "0" 
     .Create 
End With

'@ define material: PTFE (lossy)

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
With Material
     .Reset
     .Name "PTFE (lossy)"
     .Folder ""
.FrqType "all"
.Type "Normal"
.SetMaterialUnit "GHz", "mm"
.Epsilon "2.1"
.Mu "1.0"
.Kappa "0.0"
.TanD "0.0002"
.TanDFreq "10.0"
.TanDGiven "True"
.TanDModel "ConstTanD"
.KappaM "0.0"
.TanDM "0.0"
.TanDMFreq "0.0"
.TanDMGiven "False"
.TanDMModel "ConstKappa"
.DispModelEps "None"
.DispModelMu "None"
.DispersiveFittingSchemeEps "General 1st"
.DispersiveFittingSchemeMu "General 1st"
.UseGeneralDispersionEps "False"
.UseGeneralDispersionMu "False"
.Rho "2200.0"
.ThermalType "Normal"
.ThermalConductivity "0.2"
.SpecificHeat "1000", "J/K/kg"
.SetActiveMaterial "all"
.MechanicsType "Isotropic"
.YoungsModulus "0.5"
.PoissonsRatio "0.4"
.ThermalExpansionRate "140"
.Colour "0.94", "0.82", "0.76"
.Wireframe "False"
.Transparency "0"
.Create
End With

'@ define cylinder: component2:coax_teflon

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
With Cylinder 
     .Reset 
     .Name "coax_teflon" 
     .Component "component2" 
     .Material "PTFE (lossy)" 
     .OuterRadius "coax_out/2" 
     .InnerRadius "coax_in/2" 
     .Axis "z" 
     .Zrange "-l_coax", "0" 
     .Xcenter "0" 
     .Ycenter "-y0" 
     .Segments "0" 
     .Create 
End With

'@ define cylinder: component2:coax_outer

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
With Cylinder 
     .Reset 
     .Name "coax_outer" 
     .Component "component2" 
     .Material "PEC" 
     .OuterRadius "coax_out/2+outer_width" 
     .InnerRadius "coax_out/2" 
     .Axis "z" 
     .Zrange "-l_coax", "0" 
     .Xcenter "0" 
     .Ycenter "-y0" 
     .Segments "0" 
     .Create 
End With

'@ boolean insert shapes: component1:Groundplane, component2:coax_inner

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
With Solid
     .Version 10
     .Insert "component1:Groundplane", "component2:coax_inner" 
     .Version 1
End With

'@ boolean insert shapes: component1:patch, component2:coax_inner

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
With Solid
     .Version 10
     .Insert "component1:patch", "component2:coax_inner" 
     .Version 1
End With

'@ boolean insert shapes: component1:substrate, component2:coax_inner

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
With Solid
     .Version 10
     .Insert "component1:substrate", "component2:coax_inner" 
     .Version 1
End With

'@ boolean insert shapes: component1:Groundplane, component2:coax_outer

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
With Solid
     .Version 10
     .Insert "component1:Groundplane", "component2:coax_outer" 
     .Version 1
End With

'@ boolean insert shapes: component1:patch, component2:coax_outer

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
With Solid
     .Version 10
     .Insert "component1:patch", "component2:coax_outer" 
     .Version 1
End With

'@ boolean insert shapes: component1:substrate, component2:coax_outer

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
With Solid
     .Version 10
     .Insert "component1:substrate", "component2:coax_outer" 
     .Version 1
End With

'@ boolean insert shapes: component1:Groundplane, component2:coax_teflon

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
With Solid
     .Version 10
     .Insert "component1:Groundplane", "component2:coax_teflon" 
     .Version 1
End With

'@ boolean insert shapes: component1:patch, component2:coax_teflon

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
With Solid
     .Version 10
     .Insert "component1:patch", "component2:coax_teflon" 
     .Version 1
End With

'@ boolean insert shapes: component1:substrate, component2:coax_teflon

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
With Solid
     .Version 10
     .Insert "component1:substrate", "component2:coax_teflon" 
     .Version 1
End With

'@ pick face

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
Pick.PickFaceFromId "component2:coax_teflon", "1"

'@ define port: 1

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
With Port 
     .Reset 
     .PortNumber "1" 
     .Label ""
     .Folder ""
     .NumberOfModes "1"
     .AdjustPolarization "False"
     .PolarizationAngle "0.0"
     .ReferencePlaneDistance "-l_coax"
     .TextSize "50"
     .TextMaxLimit "0"
     .Coordinates "Picks"
     .Orientation "positive"
     .PortOnBound "True"
     .ClipPickedPortToBound "False"
     .Xrange "-2.05", "2.05"
     .Yrange "-7.05", "-2.95"
     .Zrange "-10", "-10"
     .XrangeAdd "0.0", "0.0"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .WaveguideMonitor "False"
     .Create 
End With

'@ define frequency range

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
Solver.FrequencyRange "2", "3"

'@ define farfield monitor: farfield (f=2.45)

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=2.45)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "2.45" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-50", "50", "-50", "50", "-10", "1.5" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeInflateWithOffset "False" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .EnableNearfieldCalculation "True" 
     .Create 
End With

'@ change solver type

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
ChangeSolverType "HF Time Domain"

'@ define time domain solver parameters

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
Mesh.SetCreator "High Frequency" 

With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "All"
     .StimulationMode "All"
     .SteadyStateLimit "-40"
     .MeshAdaption "False"
     .AutoNormImpedance "False"
     .NormingImpedance "50"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ set PBA version

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
Discretizer.PBAVersion "2021010621"

'@ define monitor: h-field (f=2.45)

'[VERSION]2021.2|30.0.1|20210106[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=2.45)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "2.45" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-50", "50", "-50", "50", "-10", "1.5" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

