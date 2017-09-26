" Vim syntax file
"  Language: GRESS Macros
"  Author: Karl Smith
"  Revision Date: 27-Mar-2017

if exists("b:current_syntax")
	finish
endif

let b:current_syntax = "gress"

syn match gressComment "#.*$" display

" TODO: Improve the number matching for case like 0. or 0.0a
syn match gressInteger '\<\d\+' display "Integer
syn match gressFloat '\<\d\+\.\d*\>' display "Floating point
syn match gressFloat '\<\d\+\(\.\d*\)\=[eE][+-]\=\d\+' display "Exponential

syn region gressString start="'" end="'"
syn region gressString start="\"" end="\""

syn keyword gressBoolean true false

syn keyword gressType keV MeV
syn keyword gressType deg degree rad radian
syn keyword gressType cm mm

syn keyword gressMacro RANDOM INDEX

hi def link gressComment Comment
hi def link gressBoolean Boolean
hi def link gressType Type
hi def link gressInteger Number
hi def link gressFloat Number
hi def link gressString String
hi def link gressMacro Macro

"setlocal iskeyword+=/
syn region gressCommand start="/" end="\s" oneline
syn match gressTag_boolError "true" contained
syn match gressTag_noArgError ".*" contained
syn match gressTag_notANumError "[^0-9.+-E]\+" contained

" Following line higlights and command like item, even if it is inavlid.
"hi def link gressCommand Statement
hi def link gressCmd_root Statement
hi def link gressTag_boolError Error
hi def link gressTag_noArgError Error
hi def link gressTag_notANumError Error

" The /control tree
syn match gressCmd_root "/control\S*"me=s+8 containedin=gressCommand contains=gressCmd_control
syn match gressCmd_control "/shell"

hi def link gressCmd_control Statement

" The /gps tree
syn match gressCmd_root "/gps\S*"he=s+4 containedin=gressCommand contains=gressCmd_gps
syn match gressCmd_gps "/ang\S*"he=s+4 contains=gressCmd_gps_ang
syn match gressCmd_gps_ang "/maxtheta"
syn match gressCmd_gps_ang "/mintheta"
syn match gressCmd_gps_ang "/maxphi"
syn match gressCmd_gps_ang "/minphi"
syn match gressCmd_gps_ang "/type.*"he=s+5 contains=gressTag_gps_ang_type
syn keyword gressTag_gps_ang_type cos iso contained
syn match gressCmd_gps "/direction"
syn match gressCmd_gps "/ene\S*"he=s+4 contains=gressCmd_gps_ene
syn match gressCmd_gps_ene "/alpha"
syn match gressCmd_gps_ene "/bandalpha"
syn match gressCmd_gps_ene "/bandbeta"
syn match gressCmd_gps_ene "/bandezero"
syn match gressCmd_gps_ene "/bandnorm"
syn match gressCmd_gps_ene "/diffspec"
syn match gressCmd_gps_ene "/max"
syn match gressCmd_gps_ene "/min"
syn match gressCmd_gps_ene "/mono"
syn match gressCmd_gps_ene "/type.*"he=s+5 contains=gressTag_gps_ene_type
syn keyword gressTag_gps_ene_type Band DiscUser Mono Pow contained
syn match gressCmd_gps "/hist\S*"he=s+5 contains=gressCmd_gps_hist
syn match gressCmd_gps_hist "/point"
syn match gressCmd_gps_hist "/type.*"he=s+5 contains=gressTag_gps_hist_type
syn keyword gressTag_gps_hist_type energy
syn match gressCmd_gps "/particle.*"he=s+9 contains=gressTag_gps_particle
syn keyword gressTag_gps_particle e- proton gamma contained
syn match gressCmd_gps "/pos\S*"he=s+4 contains=gressCmd_gps_pos
syn match gressCmd_gps_pos "/centre"
syn match gressCmd_gps_pos "/half[xy]"
syn match gressCmd_gps_pos "/radius"
syn match gressCmd_gps_pos "/shape.*"he=s+6 contains=gressTag_gps_pos_shape
syn keyword gressTag_gps_pos_shape Sphere Circle Rectangle contained
syn match gressCmd_gps_pos "/srcdistance"
syn match gressCmd_gps_pos "/srctheta"
syn match gressCmd_gps_pos "/srcphi"
syn match gressCmd_gps_pos "/type.*"he=s+5 contains=gressTag_gps_pos_type
syn keyword gressTag_gps_pos_type Plane Surface contained
syn match gressCmd_gps "/SetHistoFile"

hi def link gressCmd_gps Statement
hi def link gressCmd_gps_ang Statement
hi def link gressTag_gps_ang_type Tag
hi def link gressCmd_gps_hist Statement
hi def link gressTag_gps_hist_type Tag
hi def link gressCmd_gps_ene Statement
hi def link gressTag_gps_ene_type Tag
hi def link gressTag_gps_particle Tag
hi def link gressCmd_gps_pos Statement
hi def link gressTag_gps_pos_shape Tag
hi def link gressTag_gps_pos_type Tag

" The /phy tree
syn match gressCmd_root "/phy/\S*"he=s+4 containedin=gressCommand contains=gressCmd_phy
syn match gressCmd_phy "/evttype.*"he=s+8 contains=gressTag_phy_evttype
syn keyword gressTag_phy_evttype flux thrown triggered contained
syn match gressCmd_phy "/list\S*"he=s+5 contains=gressCmd_phy_list
syn match gressCmd_phy_list "/em.*"he=s+3 contains=gressTag_phy_list_em
syn keyword gressTag_phy_list_em standard contained
syn match gressCmd_phy "/multiE"
syn match gressCmd_phy "/planewavesource"
syn match gressCmd_phy "/pointtargetsource3"
syn match gressCmd_phy "/rndmseed"
syn match gressCmd_phy "/ROOTsource"
syn match gressCmd_phy "/perfectAbsorber"
syn match gressCmd_phy "/pointsource"

hi def link gressCmd_phy Statement
hi def link gressTag_phy_evttype Tag
hi def link gressCmd_phy_list Statement
hi def link gressTag_phy_list_em Tag

" The /run tree
syn match gressCmd_root "/run/\S*"he=s+4 containedin=gressCommand contains=gressCmd_run
syn match gressCmd_run "/initialize"
syn match gressCmd_run "/beamOn"

hi def link gressCmd_run Statement

" The /tracking tree
syn match gressCmd_root "/tracking/\S*"he=s+9 containedin=gressCommand contains=gressCmd_tracking
syn match gressCmd_tracking "/storeTrajectory"he=s+16 "contains=gressTag_notANumError

hi def link gressCmd_tracking Statement

" The /vis tree
syn match gressCmd_root "/vis/\S*"he=s+4 containedin=gressCommand contains=gressCmd_vis
syn match gressCmd_vis "/drawVolume"
syn match gressCmd_vis "/heprep/\S*"he=s+7 contains=gressCmd_vis_heprep
syn match gressCmd_vis_heprep "/addPointAttributes"
syn match gressCmd_vis_heprep "/appendGeometry"
syn match gressCmd_vis_heprep "/setEventNumberSuffix"
syn match gressCmd_vis_heprep "/setOverwrite"
syn match gressCmd_vis_heprep "/useSolids" "contains=gressTag_boolError
syn match gressCmd_vis "/open.*"he=s+5 contains=gressTag_vis_open
syn keyword gressTag_vis_open G4HepRepFile HepRepFile G4HepRep HepRepXML contained
syn keyword gressTag_vis_open VRML1FILE VRML2FILE contained
syn keyword gressTag_vis_open OpenGLImmediateQt OGLIQt OGL contained
syn keyword gressTag_vis_open OpenGLStoredQt OGLSQt OGL OGLS contained
syn keyword gressTag_vis_open OGLIX contained
syn match gressCmd_vis "/scene/\S*"he=s+6 contains=gressCmd_vis_scene
syn match gressCmd_vis_scene "/add/\S*"he=s+4 contains=gressCmd_vis_scene_add
syn match gressCmd_vis_scene_add "/trajectories"
syn match gressCmd_vis_scene "/create"
syn match gressCmd_vis_scene "/endOfEventAction.*"he=s+17 contains=gressTag_vis_scene_endOfEventAction
syn keyword gressTag_vis_scene_endOfEventAction accumulate refresh contained
syn match gressCmd_vis_scene "/endOfRunAction.*"he=s+15 contains=gressTag_vis_scene_endOfRunAction
syn keyword gressTag_vis_scene_endOfRunAction accumulate refresh contained
syn match gressCmd_vis_scene "/list"
syn match gressCmd_vis "/sceneHandler/\S*"he=s+13 contains=gressCmd_vis_sceneHandler
syn match gressCmd_vis_sceneHandler "/list"
syn match gressCmd_vis "/viewer/\S*"he=s+7 contains=gressCmd_vis_viewer
"syn match gressCmd_vis_viewer "/flush.*"me=s+6 contains=gressTag_noArgError
syn match gressCmd_vis_viewer "/flush"
syn match gressCmd_vis_viewer "/list"
syn match gressCmd_vis_viewer "/set\S*"he=s+4 contains=gressCmd_vis_viewer_set
syn match gressCmd_vis_viewer_set "/autoRefresh"
syn match gressCmd_vis_viewer_set "/background"
syn match gressCmd_vis_viewer_set "/lightsThetaPhi"
syn match gressCmd_vis_viewer_set "/lineSegmentsPerCircle"
syn match gressCmd_vis_viewer_set "/upThetaPhi"
syn match gressCmd_vis_viewer_set "/viewpointThetaPhi"
syn match gressCmd_vis_viewer "/zoom"

hi def link gressCmd_vis Statement
hi def link gressCmd_vis_heprep Statement
hi def link gressTag_vis_open Tag
hi def link gressCmd_vis_scene Statement
hi def link gressCmd_vis_scene_add Statement
hi def link gressTag_vis_scene_endOfEventAction Tag
hi def link gressTag_vis_scene_endOfRunAction Tag
hi def link gressCmd_vis_sceneHandler Statement
hi def link gressCmd_vis_viewer Statement
hi def link gressCmd_vis_viewer_set Statement

" The /gress tree
syn match gressCmd_root "/gress/\S*"he=s+6 containedin=gressCommand contains=gressCmd_gress
syn match gressCmd_gress "/ggdmlfile"
syn match gressCmd_gress "/rootfile"

hi def link gressCmd_gress Statement

