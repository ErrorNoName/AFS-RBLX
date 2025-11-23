
--[[
   Credits:
   MelonScripter - Converted and aligned
   Nebula_Zoroark - Creator
   Emper - Reanimate
   MyWorld - Optimization
   808scripty - Mobile UI

   Katana Wings:
   [PAID] https://www.roblox.com/catalog/16171905812/Big-Kindle-Katana-Silver
   [PAID] https://www.roblox.com/catalog/16171915973/Big-Kindle-Katana-Toxic-Pick
   [PAID] https://www.roblox.com/catalog/16294169158/Big-Kindle-Katana-Deep-Blue
   [PAID] https://www.roblox.com/catalog/16294165546/Big-Kindle-Katana-Deep-Red
   
   Greatsword Wings:
   [PAID] https://www.roblox.com/catalog/4506945409/Corrupt-Demonic-Greatsword
   [PAID] https://www.roblox.com/catalog/4458601937/Frozen-Demonic-Greatsword
   [PAID] https://www.roblox.com/catalog/4794315940/Golden-Demonic-Greatsword
   [PAID] https://www.roblox.com/catalog/4315489767/Demonic-Greatsword
    
   Fedora Wings:
   [FREE] https://www.roblox.com/catalog/4584029953/International-Fedora-Poland
   [FREE] https://www.roblox.com/catalog/3662265036/International-Fedora-Indonesia
   [FREE] https://www.roblox.com/catalog/4324158403/International-Fedora-Japan
   [FREE] https://www.roblox.com/catalog/3443038622/International-Fedora-Peru
  
   Black Rig:
   // https://www.roblox.com/catalog/14255528083/Torso-Extension
   // https://www.roblox.com/catalog/17374846953/Extra-Right-Black-Arm
   // https://www.roblox.com/catalog/17374851733/Extra-Left-Black-Arm
   // https://www.roblox.com/catalog/17401151565/Extra-Right-Black-Leg
   // https://www.roblox.com/catalog/17387616772/Extra-Left-Black-Leg
  
   White Arms:
   // https://www.roblox.com/catalog/14255554762/Extra-Left-White-Arm
   // https://www.roblox.com/catalog/14255556501/Extra-Right-White-Arm

   Cheap Paid Rig:
   // https://www.roblox.com/catalog/12344545199/Extra-Left-hand-moving-Blocky-white
   // https://www.roblox.com/catalog/12344591101/Extra-Right-hand-moving-Blocky-white
   // https://www.roblox.com/catalog/13779879140/Black-Fluffy-Fur-Body
   // https://www.roblox.com/catalog/11263254795/Dummy-Head-For-Headless
   // https://www.roblox.com/catalog/11159410305/Rectangle-Head-For-Headless
   
   Free Rig:
   // https://www.roblox.com/catalog/3033910400/International-Fedora-Germany
   // https://www.roblox.com/catalog/3409612660/International-Fedora-USA
   // https://www.roblox.com/catalog/3398308134/International-Fedora-Canada
   // https://www.roblox.com/catalog/3033908130/International-Fedora-France
   // https://www.roblox.com/catalog/4819740796/Robox
   

   Socials:
   // https://x.com/MelonScripter
   // https://www.youtube.com/@MelonScripter
]]

game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Melon's (FE) Converts/Scripts"; Text = "Thanks for using!"; Icon = "rbxthumb://type=Asset&id=13446503788&w=150&h=150"})
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)

function Reanimate()
	local OptionsAccessories = nil
	local OptionsRigTransparency = nil
	local OptionsRigR15 = nil
	local OptionsRigSetHumanoidDescription = nil
	local OptionsRigSetCharacter = nil
	local OptionsTeleportXandZoffset = nil
	local OptionsTeleportYoffset = nil
	local OptionsDisableScripts = nil
	local OptionsDisableScreenGUIs = nil
	local OptionsFlingEnabled = nil
	local OptionsFlingToolFling = nil
	local OptionsFlingTimeout = nil
	local OptionsFlingVelocity = nil
	local OptionsFlingHighlightTargets = nil

	local BindableEvent = nil
	local Boolean = false
	local Humanoid = nil
	local Rig = nil
	local RigHumanoid = nil
	local RigHumanoidRootPart = nil
	local Success = false
	local Time = nil
	local DeltaTime = nil
	local LastTime = nil

	local Attachments = { }
	local BaseParts = { }
	local Blacklist = { }
	local Enableds = { }
	local Handles = { }
	local Highlights = { }
	local RBXScriptConnections = { }
	local RigAccessories = { }
	local Tables = { }
	local Targets = { }

	local CFrame = CFrame
	local CFrameAngles = CFrame.Angles
	local CFrameidentity = CFrame.identity
	local CFramenew = CFrame.new

	local coroutine = coroutine
	local coroutinecreate = coroutine.create
	local coroutineclose = coroutine.close
	local coroutineresume = coroutine.resume

	local Enum = Enum
	local HumanoidStateType = Enum.HumanoidStateType
	local Physics = HumanoidStateType.Physics
	local Running = HumanoidStateType.Running
	local Track = Enum.CameraType.Track
	local UserInputType = Enum.UserInputType
	local MouseButton1 = UserInputType.MouseButton1
	local Touch = UserInputType.Touch

	local game = game
	local Clone = game.Clone
	local Destroy = game.Destroy
	local FindFirstAncestorOfClass = game.FindFirstAncestorOfClass
	local FindFirstChildOfClass = game.FindFirstChildOfClass
	local GetPropertyChangedSignal = game.GetPropertyChangedSignal
	local GetChildren = game.GetChildren
	local GetDescendants = game.GetDescendants
	local IsA = game.IsA
	local Players = FindFirstChildOfClass(game, "Players")
	local CreateHumanoidModelFromUserId = Players.CreateHumanoidModelFromUserId
	local LocalPlayer = Players.LocalPlayer
	local Mouse = LocalPlayer:GetMouse()
	local RunService = FindFirstChildOfClass(game, "RunService")
	local PostSimulation = RunService.PostSimulation
	local PreRender = RunService.PreRender
	local PreSimulation = RunService.PreSimulation
	local Connect = PostSimulation.Connect
	local Disconnect = Connect(GetPropertyChangedSignal(game, "Parent"), function() end).Disconnect
	local Wait = PostSimulation.Wait
	local StarterGui = FindFirstChildOfClass(game, "StarterGui")
	local SetCore = StarterGui.SetCore
	local UserInputService = FindFirstChildOfClass(game, "UserInputService")
	local IsMouseButtonPressed = UserInputService.IsMouseButtonPressed
	local Workspace = FindFirstChildOfClass(game, "Workspace")
	local CurrentCamera = Workspace.CurrentCamera

	local Instancenew = Instance.new
	local Humanoid = Instancenew("Humanoid")
	local ApplyDescription = Humanoid.ApplyDescription
	local ChangeState = Humanoid.ChangeState
	local GetAppliedDescription = Humanoid.GetAppliedDescription
	local Move = Humanoid.Move
	Destroy(Humanoid)
	local Part = Instancenew("Part")
	local GetJoints = Part.GetJoints
	Destroy(Part)

	local math = math
	local mathabs = math.abs
	local mathrandom = math.random
	local mathsin = math.sin

	local osclock = os.clock

	local pairs = pairs
	local pcall = pcall

	local script = script

	local string = string
	local stringchar = string.char
	local stringfind = string.find
	local stringrep = string.rep

	local table = table
	local tableclear = table.clear
	local tablefind = table.find
	local tableinsert = table.insert
	local tableremove = table.remove

	local task = task
	local taskdefer = task.defer
	local taskdelay = task.delay
	local taskspawn = task.spawn
	local taskwait = task.wait

	local sethiddenproperty = sethiddenproperty or function() end

	local type = type
	local typeof = typeof

	local Vector3 = Vector3
	local Vector3new = Vector3.new
	local Vector3yAxis = Vector3.yAxis
	local Vector3zero = Vector3.zero

	local CameraCFrame = CFrameidentity

	local LimbSize = Vector3new(1, 2, 1)
	local TorsoSize = Vector3new(2, 2, 1)

	local function BreakJoints(Parent)
		for _, Instance in pairs(GetDescendants(Parent)) do
			if IsA(Instance, "JointInstance") then
				Destroy(Instance)
			end
		end
	end

	local function CameraSubject()
		CurrentCamera.CameraSubject = RigHumanoid
		Wait(PreRender)
		CurrentCamera.CFrame = CameraCFrame
	end

	local function CameraType()
		if CurrentCamera.CameraType ~= Track then
			CurrentCamera.CameraType = Track
		end
	end

	local function Camera()
		local Camera = Workspace.CurrentCamera

		if Camera then
			CameraCFrame = Camera.CFrame
			CurrentCamera = Camera

			CameraSubject()
			CameraType()

			tableinsert(RBXScriptConnections, Connect(GetPropertyChangedSignal(Camera, "CameraSubject"), CameraSubject))
			tableinsert(RBXScriptConnections, Connect(GetPropertyChangedSignal(Camera, "CameraType"), CameraType))
		end
	end

	local function FindFirstChildOfClassAndName(Parent, ClassName, Name)
		for Index, Instance in pairs(GetChildren(Parent)) do
			if IsA(Instance, ClassName) and Instance.Name == Name then
				return Instance
			end
		end
	end

	local function WaitForChildOfClassAndName(Parent, ...)
		local Instance = FindFirstChildOfClassAndName(Parent, ...)

		while not Instance and typeof(Parent) == "Instance" do
			Instance = FindFirstChildOfClassAndName(Parent, ...)
			Wait(Parent.ChildAdded)
		end

		return Instance
	end

	local function Invisible(Instance)
		if IsA(Instance, "BasePart") or IsA(Instance, "Decal") then
			Instance.Transparency = OptionsRigTransparency
		elseif IsA(Instance, "ForceField") or IsA(Instance, "Explosion") then
			Instance.Visible = false
		elseif IsA(Instance, "ParticleEmitter") or IsA(Instance, "Fire") or IsA(Instance, "Sparkles") then
			Instance.Enabled = false
		end
	end

	local function DescendantAdded(Instance)
		if IsA(Instance, "Attachment") then
			local Handle = Instance.Parent

			if IsA(Handle, "BasePart") then
				local AttachmentsAttachment = Attachments[Instance.Name]

				if AttachmentsAttachment then
					local MeshId = ""
					local TextureId = ""

					if IsA(Handle, "MeshPart") then
						MeshId = Handle.MeshId
						TextureId = Handle.TextureID
					else
						local SpecialMesh = FindFirstChildOfClass(Handle, "SpecialMesh")

						if SpecialMesh then
							MeshId = SpecialMesh.MeshId
							TextureId = SpecialMesh.TextureId
						end
					end

					for Index, Table in pairs(OptionsAccessories) do
						if stringfind(MeshId, Table.MeshId or "") and stringfind(TextureId, Table.TextureId or "") then
							local Instance = FindFirstChildOfClassAndName(Rig, "BasePart", Table.Name)

							local AlternativeName = Table.AlternativeName
							local AlternativeInstance = false

							if not Instance and AlternativeName then
								Instance = FindFirstChildOfClassAndName(Rig, "BasePart", AlternativeName)
								AlternativeInstance = true
							end

							if Instance and not tablefind(Blacklist, Instance) then
								if Table.Blacklist then
									tableinsert(Blacklist, Instance)
								end
								BreakJoints(Handle)
								tableinsert(Tables, { Part0 = Handle, Part1 = Instance, CFrame = AlternativeInstance and Table.AllowAlternativeCFrame and Table.AlternativeCFrame or Table.CoordinateFrame, LastPosition = Instance.Position })
								return
							end
						end
					end
					for Index, Table in pairs(RigAccessories) do
						local TableHandle = Table.Handle

						if typeof(TableHandle) == "Instance" and Table.MeshId == MeshId and Table.TextureId == TextureId then
							BreakJoints(Handle)
							tableinsert(Tables, { Part0 = Handle, Part1 = TableHandle, LastPosition = TableHandle.Position })
							return
						end
					end

					local Accessory = Handle.Parent

					if IsA(Accessory, "Accessory") then
						local AccessoryClone = Instancenew("Accessory")
						AccessoryClone.Name = Accessory.Name

						local HandleClone = Clone(Handle)
						Invisible(HandleClone)
						BreakJoints(HandleClone)
						HandleClone.Parent = AccessoryClone

						local Weld = Instancenew("Weld")
						Weld.Name = "AccessoryWeld"
						Weld.C0 = Instance.CFrame
						Weld.C1 = AttachmentsAttachment.CFrame
						Weld.Part0 = HandleClone
						Weld.Part1 = AttachmentsAttachment.Parent
						Weld.Parent = HandleClone

						tableinsert(RigAccessories, { Handle = HandleClone, MeshId = MeshId, TextureId = TextureId })
						tableinsert(Tables, { Part0 = Handle, Part1 = HandleClone, LastPosition = HandleClone.Position })

						AccessoryClone.Parent = Rig
					end
				end
			end
		elseif IsA(Instance, "BasePart") then
			Instance.CanQuery = false
			tableinsert(BaseParts, Instance)
		end
	end

	local function ApplyDescriptionRig()
		local Description = GetAppliedDescription(Humanoid)
		Description.HatAccessory = ""
		Description.BackAccessory = ""
		Description.FaceAccessory = ""
		Description.HairAccessory = ""
		Description.NeckAccessory = ""
		Description.FrontAccessory = ""
		Description.WaistAccessory = ""
		Description.ShouldersAccessory = ""
		ApplyDescription(RigHumanoid, Description)

		for Index, Instance in pairs(GetDescendants(Rig)) do
			Invisible(Instance)
		end
	end

	local function SetCharacter()
		taskwait()
		LocalPlayer.Character = Rig
	end
	local Tools = { }
	local function CharacterAdded()
		local Character = LocalPlayer.Character

		if Character and Character ~= Rig then
			if OptionsFlingToolFling then
				for Index, Backpack in pairs(GetChildren(LocalPlayer)) do
					if IsA(Backpack, "Backpack") then
						for Index, Instance in pairs(GetChildren(Backpack)) do
							if IsA(Instance, "Tool") then
								Tools[Instance] = FindFirstChildOfClassAndName(Instance, "BasePart", "Handle")	
								Instance.Parent = Character
							end
						end
					end
				end
			end

			if OptionsRigSetCharacter then
				taskspawn(SetCharacter)
			end

			tableclear(BaseParts)
			tableclear(Blacklist)
			tableclear(Tables)

			if CurrentCamera then
				CameraCFrame = CurrentCamera.CFrame
			end

			for Index, Instance in pairs(GetDescendants(Character)) do
				DescendantAdded(Instance)
			end

			tableinsert(RBXScriptConnections, Connect(Character.DescendantAdded, DescendantAdded))

			Humanoid = WaitForChildOfClassAndName(Character, "Humanoid", "Humanoid")
			local HumanoidRootPart = WaitForChildOfClassAndName(Character, "BasePart", "HumanoidRootPart")

			if Boolean then
				Camera()

				if HumanoidRootPart then
					RigHumanoidRootPart.CFrame = HumanoidRootPart.CFrame
					Boolean = false
				end

				if OptionsRigSetHumanoidDescription and RigHumanoid and Humanoid then
					pcall(ApplyDescriptionRig)
				end
			end

			if HumanoidRootPart then
				for Index, Table in pairs(Targets) do
					if not HumanoidRootPart then
						break
					end

					if Humanoid then
						ChangeState(Humanoid, Physics)
					end

					local Target = Table.Target

					local Timeout = Time + OptionsFlingTimeout
					local LastPosition = Target.Position

					while Target and HumanoidRootPart do
						if Time > Timeout then
							break
						end

						local Position = Target.Position
						local LinearVelocity = ( Position - LastPosition ) / DeltaTime

						if LinearVelocity.Magnitude > 50 then
							break
						end

						LastPosition = Position

						HumanoidRootPart.AssemblyAngularVelocity = OptionsFlingVelocity
						HumanoidRootPart.AssemblyLinearVelocity = OptionsFlingVelocity

						HumanoidRootPart.CFrame = Target.CFrame * CFramenew(0, 0, 4 * mathsin(Time * 30)) * CFrameAngles(mathrandom(- 360, 360), mathrandom(- 360, 360), mathrandom(- 360, 360)) + ( LinearVelocity * 0.5) 
						taskwait()
					end

					local Highlight = Table.Highlight

					if Highlight then
						Destroy(Highlight)
					end

					Targets[Index] = nil
				end

				if Humanoid then
					ChangeState(Humanoid, Running)
				end

				if RigHumanoidRootPart then
					HumanoidRootPart.AssemblyAngularVelocity = Vector3zero
					HumanoidRootPart.AssemblyLinearVelocity = Vector3zero

					HumanoidRootPart.CFrame = RigHumanoidRootPart.CFrame + Vector3new(mathrandom(- OptionsTeleportXandZoffset, OptionsTeleportXandZoffset), OptionsTeleportYoffset, mathrandom(- OptionsTeleportXandZoffset, OptionsTeleportXandZoffset))
				end
			end

			taskwait(0.26 + Wait(PreSimulation))

			if Character then
				BreakJoints(Character)
			end
	

		end
	end

	local function PostSimulationConnect()
		sethiddenproperty(LocalPlayer, "SimulationRadius", 2147483647)

		Time = osclock()
		DeltaTime = Time - LastTime
		LastTime = Time

		local Integer = 29 + mathsin(Time)
		local Vector3 = Vector3new(0, 0, 0.002 * mathsin(Time * 25))

		for Index, Table in pairs(Tables) do
			local Part0 = Table.Part0
			local Part1 = Table.Part1

			if Part0 and # GetJoints(Part0) == 0 and Part0.ReceiveAge == 0 and Part1 then
				Part0.AssemblyAngularVelocity = Vector3zero

				local Position = Part1.Position
				local LinearVelocity = ( ( Table.LastPosition - Position ) / DeltaTime ) * Integer
				Table.LastPosition = Position

				Part0.AssemblyLinearVelocity = Vector3new(LinearVelocity.X, Integer, LinearVelocity.Z)

				Part0.CFrame = Part1.CFrame * ( Table.CFrame or CFrameidentity ) + Vector3
			end
		end

		local Hit = Mouse.Hit
		local Holding = IsMouseButtonPressed(UserInputService, MouseButton1)

		for Tool, BasePart in pairs(Tools) do
			if BasePart.ReceiveAge == 0 and # GetJoints(BasePart) == 0 then
				BasePart.CanCollide = false
				BasePart.AssemblyAngularVelocity = OptionsFlingVelocity
				BasePart.AssemblyLinearVelocity = OptionsFlingVelocity

				if Holding then
					BasePart.CFrame = Hit
				elseif RigHumanoidRootPart then
					BasePart.CFrame = RigHumanoidRootPart.CFrame * CFramenew(0, OptionsTeleportYoffset, 0) * CFrameAngles(mathrandom(- 360, 360), mathrandom(- 360, 360), mathrandom(- 360, 360))
				else
					BasePart.CFrame = CFrameidentity
				end
			end
		end

		if RigHumanoid and Humanoid then
			RigHumanoid.Jump = Humanoid.Jump
			Move(RigHumanoid, Humanoid.MoveDirection)
		end

		if not Success then
			Success = pcall(SetCore, StarterGui, "ResetButtonCallback", BindableEvent)
		else
			SetCore(StarterGui, "ResetButtonCallback", BindableEvent)
		end
	end

	local function PreSimulationConnect()
		for Index, BasePart in pairs(BaseParts) do
			BasePart.CanCollide = false
		end
	end

	local function Fling(Target)
		if typeof(Target) == "Instance" then
			if IsA(Target, "Humanoid") then
				Target = Target.Parent
			end
			if IsA(Target.Parent, "Accessory") then
				Target = FindFirstAncestorOfClass(Target, "Model")
			end
			if IsA(Target, "Model") then
				Target = FindFirstChildOfClassAndName(Target, "BasePart", "HumanoidRootPart")
			end
			if IsA(Target, "BasePart") then
				for Index, Table in pairs(Targets) do
					if Table.Target == Target then
						return
					end
				end

				local Parent = Target.Parent

				local Highlight = nil

				if OptionsFlingHighlightTargets then
					Highlight = Instancenew("Highlight")
					Highlight.Adornee = Parent
					Highlight.Parent = Parent
					tableinsert(Highlights, Highlight)
				end

				tableinsert(Targets, {Highlight = Highlight, Target = Target})
			end
		end
	end

	local function InputBegan(InputObject)
		local UserInputType = InputObject.UserInputType

		if UserInputType == MouseButton1 or UserInputType == Touch then
			local Target = Mouse.Target

			if Target and not Target.Anchored then
				local Model = Target.Parent

				if IsA(Model, "Model") and FindFirstChildOfClass(Model, "Humanoid") then
					local HumanoidRootPart = FindFirstChildOfClassAndName(Model, "BasePart", "HumanoidRootPart")

					if HumanoidRootPart then
						Fling(HumanoidRootPart)
					end
				else
					Fling(Target)
				end
			end
		end
	end

	local function gameDescendantAdded(Instance)
		if ( OptionsDisableScreenGUIs and IsA(Instance, "ScreenGui") ) or ( OptionsDisableScripts and Instance ~= script and ( IsA(Instance, "LocalScript") or IsA(Instance, "Script") ) ) then
			Enableds[Instance] = Instance.Enabled
			Instance.Enabled = false

			tableinsert(RBXScriptConnections, Connect(GetPropertyChangedSignal(Instance, "Enabled"), function()
				Enableds[Instance] = Instance.Enabled
				Instance.Enabled = false
			end))
		end
	end

	local function Stop()
		for Index, RBXScriptConnection in pairs(RBXScriptConnections) do
			Disconnect(RBXScriptConnection)
		end
		for Index, Highlight in pairs(Highlights) do
			Destroy(Highlight)
		end
		for Instance, Boolean in pairs(Enableds) do
			Instance.Enabled = Boolean
		end

		tableclear(Attachments)
		tableclear(BaseParts)
		tableclear(Enableds)
		tableclear(Handles)
		tableclear(Highlights)
		tableclear(RBXScriptConnections)
		tableclear(Tables)
		tableclear(Targets)

		if Rig then
			Destroy(Rig)
		end

		Destroy(BindableEvent)
		SetCore(StarterGui, "ResetButtonCallback", true)
	end

	local Emperean = {
		Stop = Stop,
		Start = function(Options)
			Options = Options or { }
			OptionsAccessories = Options.Accessories or {}
			local OptionsRig = Options.Rig
			OptionsRigTransparency = OptionsRig.Transparency
			OptionsRigR15 = OptionsRig.R15
			OptionsRigSetHumanoidDescription = OptionsRig.SetHumanoidDescription
			OptionsRigSetCharacter = OptionsRig.SetCharacter
			local OptionsTeleport = Options.Teleport or {}
			local XandYoffset = OptionsTeleport.XandYoffset
			OptionsTeleportXandZoffset = XandYoffset and mathabs(XandYoffset) or 6
			OptionsTeleportYoffset = OptionsTeleport.Yoffset or 0
			local OptionsDisable = Options.Disable
			OptionsDisableScripts = OptionsDisable.Scripts
			OptionsDisableScreenGUIs = OptionsDisable.GUIs
			local OptionsFling = Options.Fling or {}
			OptionsFlingEnabled = OptionsFling.Enabled
			OptionsFlingToolFling = OptionsFling.ToolFling
			OptionsFlingTimeout = OptionsFling.Timeout or 1.5
			OptionsFlingVelocity = OptionsFling.Velocity or Vector3new(0, 4096, 0)
			OptionsFlingHighlightTargets = OptionsFling.HighlightTargets

			if OptionsDisableScripts or OptionsDisableScreenGUIs then
				for Index, Instance in pairs(GetDescendants(game)) do
					gameDescendantAdded(Instance)
				end

				tableinsert(RBXScriptConnections, Connect(game.DescendantAdded, gameDescendantAdded))
			end

			Boolean = true
			LastTime = osclock()

			Rig = OptionsRigR15 and CreateHumanoidModelFromUserId(Players, 5532894300) or CreateHumanoidModelFromUserId(Players, 5532891747)
			Rig.Name = "MaxDesignPro"
			RigHumanoid = Rig.Humanoid
			RigHumanoidRootPart = Rig.HumanoidRootPart
			Rig.Parent = Workspace

			for Index, Instance in pairs(GetDescendants(Rig)) do
				if IsA(Instance, "Attachment") then
					Attachments[Instance.Name] = Instance
				else
					Invisible(Instance)
				end
			end

			BindableEvent = Instancenew("BindableEvent")
			Connect(BindableEvent.Event, Stop)

			tableinsert(RBXScriptConnections, Connect(GetPropertyChangedSignal(Workspace, "CurrentCamera"), Camera))

			CharacterAdded()
			tableinsert(RBXScriptConnections, Connect(GetPropertyChangedSignal(LocalPlayer, "Character"), CharacterAdded))

			if OptionsFlingEnabled then
				tableinsert(RBXScriptConnections, Connect(UserInputService.InputBegan, InputBegan))
			end

			tableinsert(RBXScriptConnections, Connect(PreSimulation, PreSimulationConnect))
			tableinsert(RBXScriptConnections, Connect(PostSimulation, PostSimulationConnect))

			return { 
				Rig = Rig,
				Options = Options,
				Fling = Fling,
			},
			taskwait()
		end,
	}

	Emperean.Start({
		Accessories = {
			--  Free Rig
			{ Blacklist = true, Name = "Torso", AlternativeName = "UpperTorso", MeshId = "4819720316", TextureId = "4819722776", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 0, -0.25), AlternativeCFrame = CFrameidentity },
			{ Blacklist = true, Name = "Right Arm", AlternativeName = "RightLowerArm", MeshId = "3030546036", TextureId = "3033903209", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(-1.57, 0, -1.57), AlternativeCFrame = CFrameidentity },
			{ Blacklist = true, Name = "Left Arm", AlternativeName = "LeftLowerArm", MeshId = "3030546036", TextureId = "3360978739", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(-1.57, 0, 1.57), AlternativeCFrame = CFrameidentity },
			{ Blacklist = true, Name = "Right Leg", AlternativeName = "RightLowerLeg", MeshId = "3030546036", TextureId = "3033898741", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(-1.57, 0, -1.57), AlternativeCFrame = CFrameidentity },
			{ Blacklist = true, Name = "Left Leg", AlternativeName = "LeftLowerLeg", MeshId = "3030546036", TextureId = "3409604993", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(-1.57, 0, 1.57), AlternativeCFrame = CFrameidentity },

			-- Cheap Paid Rig
			{ Blacklist = true, Name = "Right Arm", AlternativeName = "RightLowerArm", MeshId = "12344206657", TextureId = "12344206675", AllowAlternativeCFrame = false, CoordinateFrame = CFramenew(-0.095, 0, 0) * CFrameAngles(- 2, 0, 0), AlternativeCFrame = CFrameidentity },
			{ Blacklist = true, Name = "Left Arm", AlternativeName = "LeftLowerArm", MeshId = "12344207333", TextureId = "12344207341", AllowAlternativeCFrame = false, CoordinateFrame = CFramenew(0.095, 0, 0) * CFrameAngles(- 2, 0, 0), AlternativeCFrame = CFrameidentity },
			{ Blacklist = true, Name = "Right Leg", AlternativeName = "RightLowerLeg", MeshId = "11263221350", TextureId = "11263219250", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(1.57, - 1.57, 0), AlternativeCFrame = CFrameidentity },
			{ Blacklist = true, Name = "Left Leg", AlternativeName = "LeftLowerLeg", MeshId = "11159370334", TextureId = "11159284657", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(1.57, 1.57, 0), AlternativeCFrame = CFrameidentity },
			
			-- Noob Rig
			{ Blacklist = true, Name = "Torso", AlternativeName = "UpperTorso", MeshId = "18640899369", TextureId = "18640899481", AllowAlternativeCFrame = false, CoordinateFrame = CFrameidentity, AlternativeCFrame = CFrameidentity },
			{ Blacklist = true, Name = "Right Arm", AlternativeName = "RightLowerArm", MeshId = "18640914129", TextureId = "18640914168", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 0), AlternativeCFrame = CFrameidentity },
			{ Blacklist = true, Name = "Left Arm", AlternativeName = "LeftLowerArm", MeshId = "18640914129", TextureId = "18640914168", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 0), AlternativeCFrame = CFrameidentity },    
			{ Blacklist = true, Name = "Right Leg", AlternativeName = "RightLowerLeg", MeshId = "18640901641", TextureId = "18640901676", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 0), AlternativeCFrame = CFrameidentity },
			{ Blacklist = true, Name = "Left Leg", AlternativeName = "LeftLowerLeg", MeshId = "18640901641", TextureId = "18640901676", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 0), AlternativeCFrame = CFrameidentity },
			
			-- Accurate Paid Rig
			{ Blacklist = true, Name = "Torso", AlternativeName = "UpperTorso", MeshId = "14241018198", TextureId = "14251599953", AllowAlternativeCFrame = false, CoordinateFrame = CFrameidentity, AlternativeCFrame = CFrameidentity },
			{ Blacklist = true, Name = "Right Arm", AlternativeName = "RightLowerArm", MeshId = "17374767929", TextureId = "17374768001", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 1.57), AlternativeCFrame = CFrameidentity },
			{ Blacklist = true, Name = "Left Arm", AlternativeName = "LeftLowerArm", MeshId = "17374767929", TextureId = "17374768001", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 1.57), AlternativeCFrame = CFrameidentity },	
			{ Blacklist = true, Name = "Right Leg", AlternativeName = "RightLowerLeg", MeshId = "17387586286", TextureId = "17387586304", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 1.57), AlternativeCFrame = CFrameidentity },
			{ Blacklist = true, Name = "Left Leg", AlternativeName = "LeftLowerLeg", MeshId = "17387586286", TextureId = "17387586304", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 1.57), AlternativeCFrame = CFrameidentity },

			-- White arms below
			{ Blacklist = true, Name = "Right Arm", AlternativeName = "RightLowerArm", MeshId = "14255522247", TextureId = "14255543546", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 1.57), AlternativeCFrame = CFrameidentity },
			{ Blacklist = true, Name = "Left Arm", AlternativeName = "LeftLowerArm", MeshId = "14255522247", TextureId = "14255543546", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 1.57), AlternativeCFrame = CFrameidentity },
	    
        	-- Katanas
            { Blacklist = true, Name = "RightWing1", AlternativeName = "RightLowerArm", MeshId = "16171691872", TextureId = "16294099174", AllowAlternativeCFrame = false, CoordinateFrame = CFramenew(-0.10, -1.75, 0) * CFrameAngles(0, 0, 1.25), AlternativeCFrame = CFrameidentity },
 	     	{ Blacklist = true, Name = "LeftWing1", AlternativeName = "RightLowerArm", MeshId = "16171691872", TextureId = "16171719893", AllowAlternativeCFrame = false, CoordinateFrame = CFramenew(0.10, -1.75, 0) * CFrameAngles(0, -2.57, 1.25), AlternativeCFrame = CFrameidentity },
            { Blacklist = true, Name = "RightWing2", AlternativeName = "RightLowerArm", MeshId = "16171691872", TextureId = "16294100872", AllowAlternativeCFrame = false, CoordinateFrame = CFramenew(-0.10, -1.75, 0) * CFrameAngles(0, 0, 1.25), AlternativeCFrame = CFrameidentity },
 	     	{ Blacklist = true, Name = "LeftWing2", AlternativeName = "RightLowerArm", MeshId = "16171691872", TextureId = "16171912713", AllowAlternativeCFrame = false, CoordinateFrame = CFramenew(0.10, -1.75, 0) * CFrameAngles(0, -2.57, 1.25), AlternativeCFrame = CFrameidentity },
	    	
            -- Greatswords
            -- Requested by HarlemAniman
            { Blacklist = true, Name = "RightWing1", AlternativeName = "RightLowerArm", MeshId = "4315410540", TextureId = "4506940486", AllowAlternativeCFrame = false, CoordinateFrame = CFramenew(-0.05, -1.75, 0) * CFrameAngles(0, 0, 0.75), AlternativeCFrame = CFrameidentity },
            { Blacklist = true, Name = "RightWing2", AlternativeName = "RightLowerArm", MeshId = "4315410540", TextureId = "4794299274", AllowAlternativeCFrame = false, CoordinateFrame = CFramenew(-0.05, -1.75, 0) * CFrameAngles(0, 0, 0.75), AlternativeCFrame = CFrameidentity },
 	     	{ Blacklist = true, Name = "LeftWing1", AlternativeName = "RightLowerArm", MeshId = "4315410540", TextureId = "4315250791", AllowAlternativeCFrame = false, CoordinateFrame = CFramenew(-0.05, -1.75, 0) * CFrameAngles(0, 0, 0.75), AlternativeCFrame = CFrameidentity },
            { Blacklist = true, Name = "LeftWing2", AlternativeName = "RightLowerArm", MeshId = "4315410540", TextureId = "4458626951", AllowAlternativeCFrame = false, CoordinateFrame = CFramenew(-0.05, -1.75, 0) * CFrameAngles(0, 0, 0.75), AlternativeCFrame = CFrameidentity },
	    	
             -- Fedoras
            { Blacklist = true, Name = "RightWing1", AlternativeName = "RightLowerArm", MeshId = "4489232754", TextureId = "4584026407", AllowAlternativeCFrame = false, CoordinateFrame = CFramenew(0.15,0,0) * CFrameAngles(0,0,-0.45), AlternativeCFrame = CFrameidentity },
		    { Blacklist = true, Name = "RightWing2", AlternativeName = "RightLowerArm", MeshId = "3030546036", TextureId = "3650139425", AllowAlternativeCFrame = false, CoordinateFrame = CFramenew(0.15,0,0) * CFrameAngles(0,0,-0.45), AlternativeCFrame = CFrameidentity },
	    	{ Blacklist = true, Name = "LeftWing1", AlternativeName = "RightLowerArm", MeshId = "4324138105", TextureId = "4324138210", AllowAlternativeCFrame = false, CoordinateFrame = CFramenew(0.15,0,0) * CFrameAngles(0,0,0.45), AlternativeCFrame = CFrameidentity },
	     	{ Blacklist = true, Name = "LeftWing2", AlternativeName = "RightLowerArm", MeshId = "3030546036", TextureId = "3443321249", AllowAlternativeCFrame = false, CoordinateFrame = CFramenew(0.15,0,0) * CFrameAngles(0,0,0.45), AlternativeCFrame = CFrameidentity },

		},
		Rig = {
			Transparency = 1,
			R15 = false,
			SetHumanoidDescription = true,
			SetCharacter = false
		},
		Teleport = {
			XandZoffset = 0,
			Yoffset = -100
		},
		Disable = {
			Scripts = true,
			ScreenGUIs = false
		},
		Fling = {
			Enabled = true,
			ToolFling = true,
			Timeout = 0.65,
			Velocity = Vector3new(15250, 16250, 15250),
			HighlightTargets = true
		}
	})
end

Reanimate()

function CreateWeapon(Name)
	local Part = Instance.new("Part")
	Part.Name = Name
	Part.CanCollide = false
	Part.Transparency = 1
	Part.Parent = workspace.MaxDesignPro
end

function WeldWeapon(Part0, Part1)
	local Weld = Instance.new("Weld")
	Weld.Part0 = Part0
	Weld.Part1 = Part1
	Weld.Parent = workspace.MaxDesignPro
end

local data = {}
 
local script = game:GetObjects("rbxassetid://5446036971")[1]
 
script.WingPiece.qPerfectionWeld:Destroy()
 
do
local NEVER_BREAK_JOINTS = false
 
local function CallOnChildren(Instance, FunctionToCall)
	FunctionToCall(Instance)
 
	for _, Child in next, Instance:GetChildren() do
		CallOnChildren(Child, FunctionToCall)
	end
end
 
local function GetBricks(StartInstance)
	local List = {}
	CallOnChildren(StartInstance, function(Item)
		if Item:IsA("BasePart") then
			List[#List+1] = Item;
		end
	end)
 
	return List
end
 
local function Modify(Instance, Values)
	assert(type(Values) == "table", "Values is not a table");
 
	for Index, Value in next, Values do
		if type(Index) == "number" then
			Value.Parent = Instance
		else
			Instance[Index] = Value
		end
	end
	return Instance
end
 
local function Make(ClassType, Properties)
	return Modify(Instance.new(ClassType), Properties)
end
 
local Surfaces = {"TopSurface", "BottomSurface", "LeftSurface", "RightSurface", "FrontSurface", "BackSurface"}
local HingSurfaces = {"Hinge", "Motor", "SteppingMotor"}
 
local function HasWheelJoint(Part)
	for _, SurfaceName in pairs(Surfaces) do
		for _, HingSurfaceName in pairs(HingSurfaces) do
			if Part[SurfaceName].Name == HingSurfaceName then
				return true
			end
		end
	end
 
	return false
end
 
local function ShouldBreakJoints(Part)
	if NEVER_BREAK_JOINTS then
		return false
	end
 
	if HasWheelJoint(Part) then
		return false
	end
 
	local Connected = Part:GetConnectedParts()
 
	if #Connected == 1 then
		return false
	end
 
	for _, Item in pairs(Connected) do
		if HasWheelJoint(Item) then
			return false
		elseif not Item:IsDescendantOf(script.Parent) then
			return false
		end
	end
 
	return true
end
 
local function WeldTogether(Part0, Part1, JointType, WeldParent)
 
	JointType = JointType or "Weld"
	local RelativeValue = Part1:FindFirstChild("qRelativeCFrameWeldValue")
 
	local NewWeld = Part1:FindFirstChild("qCFrameWeldThingy") or Instance.new(JointType)
	Modify(NewWeld, {
		Name = "qCFrameWeldThingy";
		Part0  = Part0;
		Part1  = Part1;
		C0     = CFrame.new();--Part0.CFrame:inverse();
		C1     = RelativeValue and RelativeValue.Value or Part1.CFrame:toObjectSpace(Part0.CFrame); --Part1.CFrame:inverse() * Part0.CFrame;-- Part1.CFrame:inverse();
		Parent = Part1;
	})
 
	if not RelativeValue then
		RelativeValue = Make("CFrameValue", {
			Parent     = Part1;
			Name       = "qRelativeCFrameWeldValue";
			Archivable = true;
			Value      = NewWeld.C1;
		})
	end
 
	return NewWeld
end
 
local function WeldParts(Parts, MainPart, JointType, DoNotUnanchor)
 
	for _, Part in pairs(Parts) do
		if ShouldBreakJoints(Part) then
			Part:BreakJoints()
		end
	end
 
	for _, Part in pairs(Parts) do
		if Part ~= MainPart then
			WeldTogether(MainPart, Part, JointType, MainPart)
		end
	end
 
	if not DoNotUnanchor then
		for _, Part in pairs(Parts) do
			Part.Anchored = false
		end
		MainPart.Anchored = false
	end
end
 
local function PerfectionWeld()	
	local Parts = GetBricks(script.WingPiece)
	WeldParts(Parts, script.WingPiece.Main, "Weld", false)
end
PerfectionWeld()
end
 
--// Shortcut Variables \\--
local S = setmetatable({},{__index = function(s,i) return game:service(i) end})
local CF = {N=CFrame.new,A=CFrame.Angles,fEA=CFrame.fromEulerAnglesXYZ}
local C3 = {tRGB= function(c3) return c3.r*255,c3.g*255,c3.b*255 end,N=Color3.new,RGB=Color3.fromRGB,HSV=Color3.fromHSV,tHSV=Color3.toHSV}
local V3 = {N=Vector3.new,FNI=Vector3.FromNormalId,A=Vector3.FromAxis}
local M = {C=math.cos,R=math.rad,S=math.sin,P=math.pi,RNG=math.random,MRS=math.randomseed,H=math.huge,RRNG = function(min,max,div) return math.rad(math.random(min,max)/(div or 1)) end}
local R3 = {N=Region3.new}
local De = S.Debris
local WS = workspace
local Lght = S.Lighting
local RepS = S.ReplicatedStorage
local IN = Instance.new
local Plrs = S.Players
local UIS = S.UserInputService
 
local Player = game.Players.LocalPlayer
data.User = Player
data.Local = Player
local Char = workspace.MaxDesignPro
local Mouse = Player:GetMouse()
local Hum = Char:FindFirstChildOfClass'Humanoid'
local Torso = Char.Torso
local RArm = Char["Right Arm"]
local LArm = Char["Left Arm"]
local RLeg = Char["Right Leg"]
local LLeg = Char["Left Leg"]	
local Root = Char:FindFirstChild'HumanoidRootPart'
local Head = Char.Head
local Sine = 0;
local Change = 1
local Attack=false
local NeutralAnims=true
local timePos=30;
local walking=true;
local legAnims=true;
local movement = 8
local footsound=0;
local WalkSpeed=16;
local Combo=0;
local Mode='Achromatic'
local vaporwaveMode=false;
local WingAnim='NebG1'
local music;
local hue = 0;
local WingSine=0;
local MusicMode=1;
local visSong = 1702473314;
local EffectFolder = script:WaitForChild'FXFolder'
local PrimaryColor = Color3.new(1,1,1)
local ClickTimer = 0;
local ClickAttack = 1;
local camera = workspace.CurrentCamera
local LastSphere = time();
local Frame_Speed = 60
local VaporwaveSongs={
	2231500330;
	654094806;
	743334292;
	334283059;
	2082142910;
}
 
 
local WingPiece = script:WaitForChild'WingPiece'
WingPiece.Parent=nil
local WingAnims={}
local Playlist={
	Default=1702473314;
	ScrapBoy=1215691669;
	Defeated=860594509;
	Annihilate=2116461106;
	DashAndDodge=2699922745;
	ZenWavy=2231500330;
	Beachwalk=334283059;
	Pyrowalk=2082142910;
	Vapor90s=654094806;
}
 
--[[
Achromatic - The Big Black - Lost Soul
Iniquitous
Mythical - Legendary
Ruined - Th1rt3en
Atramentous - Vanta Black
Subzero - Frostbite
Troubadour
Infectious - Radioactive
Love - Lust
]]
 
--2699922745
local modeInfo={
	{Name="Achromatic",Walkspeed=16,moveVal=8,Font=Enum.Font.Arcade,StrokeColor=C3.N(.5,.5,.5);Music=2533527428,LeftWing={0,BrickColor.new'White'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'White'.Color,Enum.Material.Neon};WingAnim='NebG1'};
	{Name="Iniquitous",Walkspeed=16,moveVal=8,Font=Enum.Font.Garamond,StrokeColor=C3.N(.2,.2,.2);Music=2656505560,LeftWing={0,BrickColor.new'Black'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'Black'.Color,Enum.Material.Neon};WingAnim='NebG1'};
	{Name="Mythical",Walkspeed=16,moveVal=8,Font=Enum.Font.Fantasy,StrokeColor=C3.N(.6,.0,.9);Music=556122490,LeftWing={0,BrickColor.new'Alder'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'Alder'.Color,Enum.Material.Neon};WingAnim='StarG'};
	{Name="Ruined",Walkspeed=16,moveVal=8,Font=Enum.Font.Arcade,StrokeColor=C3.N(0,0,0);Music=2297862957,LeftWing={0,Color3.fromRGB(190,104,98),Enum.Material.Neon};RightWing={0,BrickColor.new'Black'.Color,Enum.Material.Neon};WingAnim='Aprins'};
	{Name="Atramentous",Walkspeed=14,moveVal=8,Font=Enum.Font.Garamond,StrokeColor=C3.N(.1,.1,.1);Music=924339757,LeftWing={0,BrickColor.new'Dark stone grey'.Color,Enum.Material.Glass};RightWing={0,BrickColor.new'Really black'.Color,Enum.Material.Glass};WingAnim={'NebG3',2}};
	{Name="Subzero",Walkspeed=10,moveVal=6,Font=Enum.Font.Gotham,StrokeColor=C3.RGB(0,190,190);Music=144121562,LeftWing={0,BrickColor.new'Pastel light blue'.Color,Enum.Material.Glass};RightWing={0,BrickColor.new'Pastel light blue'.Color,Enum.Material.Glass};WingAnim='NebG1'};	
	{Name="Troubadour",Walkspeed=16,moveVal=8,Font=Enum.Font.Arcade,StrokeColor=C3.N(.5,.5,.5);Music=visSong,LeftWing={0,BrickColor.new'White'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'White'.Color,Enum.Material.Neon};WingAnim='StarG'};
	{Name="Infectious",Walkspeed=16,moveVal=8,Font=Enum.Font.Gotham,StrokeColor=C3.RGB(98,37,209);Music=603291385,LeftWing={0,BrickColor.new'Dark indigo'.Color,Enum.Material.DiamondPlate};RightWing={0,BrickColor.new'Dark indigo'.Color,Enum.Material.DiamondPlate};WingAnim='NebG1'};	
	{Name="Love",Walkspeed=16,moveVal=8,Font=Enum.Font.Arcade,StrokeColor=C3.RGB(255,152,220);Music=1030177093,LeftWing={0,BrickColor.new'Pink'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'Pink'.Color,Enum.Material.Neon};WingAnim='StarG'};
	--MAJORS--
	{Name="The Big Black",Walkspeed=64,moveVal=20,Font=Enum.Font.Arcade,StrokeColor=C3.N(.2,.2,.2);Music=183142252,LeftWing={0,BrickColor.new'Really black'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'Dark stone grey'.Color,Enum.Material.Glass};WingAnim={'NebG3',10}};
	{Name="Legendary",Walkspeed=64,moveVal=20,Font=Enum.Font.Gotham,StrokeColor=C3.N(.4,.4,0);Music=468018712,LeftWing={0,BrickColor.new'Gold'.Color,Enum.Material.Glass};RightWing={0,BrickColor.new'Gold'.Color,Enum.Material.Glass};WingAnim={'NebG2',10}};
	{Name="Lust",Walkspeed=16,moveVal=8,Font=Enum.Font.Fantasy,StrokeColor=C3.N(1,0,1);Music=391089144,LeftWing={0,BrickColor.new'Hot pink'.Color,Enum.Material.Neon};RightWing={0,BrickColor.new'Hot pink'.Color,Enum.Material.Neon};WingAnim='LustFrench'};
 
}
 
NewInstance = function(instance,parent,properties)
	local inst = Instance.new(instance)
	inst.Parent = parent
	if(properties)then
		for i,v in next, properties do
			pcall(function() inst[i] = v end)
		end
	end
	return inst;
end
 
function newMotor(P0,P1,C0,C1)
	return NewInstance('Motor',P0,{Part0=P0,Part1=P1,C0=C0,C1=C1})
end
 
local welds = {}
local WeldDefaults = {}
 
table.insert(welds,newMotor(Torso,Head,CF.N(0,1.5,0),CF.N()))
table.insert(welds,newMotor(Root,Torso,CF.N(),CF.N()))
table.insert(welds,newMotor(Torso,RLeg,CF.N(.5,-1,0),CF.N(0,1,0)))
table.insert(welds,newMotor(Torso,RArm,CF.N(1.5,.5,0),CF.N(0,.5,0)))
table.insert(welds,newMotor(Torso,LLeg,CF.N(-.5,-1,0),CF.N(0,1,0)))
table.insert(welds,newMotor(Torso,LArm,CF.N(-1.5,.5,0),CF.N(0,.5,0)))
 
WeldDefaults={}
for i = 1,#welds do
	local v=welds[i]
	WeldDefaults[i]=v.C0
end
 
local NK,RJ,RH,RS,LH,LS=unpack(welds)
 
local NKC0,RJC0,RHC0,RSC0,LHC0,LSC0=unpack(WeldDefaults)
 
function makeMusic(id,pit,timePos)
	local sound = Torso:FindFirstChild(Player.Name.."song") or Char:FindFirstChild(Player.Name.."song")
	local parent = (MusicMode==2 and Char or Torso)
	if(not sound)then 
		sound = NewInstance("Sound",parent,{Name=Player.Name.."song",Volume=(MusicMode==3 and 0 or 5),Pitch=(pit or 1),Looped=true})
		NewInstance("EqualizerSoundEffect",sound,{HighGain=0,MidGain=2,LowGain=10})
	end
	if(id=='stop')then
		if(sound)then
			sound:Stop()
		end
	else
		local timePos = typeof(timePos)=='number' and timePos or sound.TimePosition
		sound.Volume = (MusicMode==3 and 0 or 5)
		sound.Name = Player.Name.."song"
		sound.Looped=true
		sound.SoundId = "rbxassetid://"..id
		sound.Pitch=(pit or 1)
		sound:Play()
		sound.TimePosition = timePos
	end
	return sound;
end
 
function playMusic(id,pitch,timePos)
	return makeMusic(id,pitch,timePos)
end
 
for _,v in next, Hum:GetPlayingAnimationTracks() do
	v:Stop(0);
end
 
-- SCRIPT STUFF --
 
function swait(num)
	if num == 0 or num == nil then
		game:GetService("RunService").RenderStepped:wait()
	else
		for i = 0, num do
			game:GetService("RunService").RenderStepped:wait()
		end
	end
end
 
--// Effects \\--
 
function Tween(obj,props,time,easing,direction,repeats,backwards)
	local info = TweenInfo.new(time or .5, easing or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out, repeats or 0, backwards or false)
	local tween = S.TweenService:Create(obj, info, props)
 
	tween:Play()
end
 
function StartShake(Settings)
	return true
end
 
function Camshake(shakedata)
	StartShake(shakedata)
end
 
local Effects=NewInstance("Folder",Char)
Effects.Name=Player.Name..'Effects'
 
 
function ShowDamage(Pos, Text, Time, Color)
	local Pos = Pos or V3.N(0, 0, 0)
	local Text = tostring(Text or "")
	local Time = Time or 2
	local Color = Color or C3.N(1, 0, 1)
	local EffectPart = Part(Effects,Color,Enum.Material.SmoothPlastic,V3.N(.05,.05,.05),CFrame.new(Pos),true,false)
	EffectPart.Transparency=1
	local BillboardGui = NewInstance("BillboardGui",EffectPart,{
		Size = UDim2.new(3,0,3,0),
		Adornee = EffectPart,
	})
 
	local TextLabel = NewInstance("TextLabel",BillboardGui,{
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Text = Text,
		TextColor3 = Color,
		TextScaled = true,
		Font = Enum.Font.ArialBold, 
	})
	S.Debris:AddItem(EffectPart, Time+.5)
	delay(0, function()
		local rot=math.random(-10,10)/15
		local raise=.2
		local Frames = Time/Frame_Speed
		for i=0,1.1,.02 do
			swait()
			TextLabel.Rotation=TextLabel.Rotation+rot
			raise=raise-.008
			EffectPart.Position = EffectPart.Position + Vector3.new(0, raise, 0)
			TextLabel.TextTransparency=i
			TextLabel.TextStrokeTransparency=i
		end
		if EffectPart and EffectPart.Parent then
			EffectPart:Destroy()
		end
	end)
end
 
 
local baseSound = IN("Sound")
 
function Soond(parent,id,pitch,volume,looped,effect,autoPlay)
	local Sound = baseSound:Clone()
	Sound.SoundId = "rbxassetid://".. tostring(id or 0)
	Sound.Pitch = pitch or 1
	Sound.Volume = volume or 1
	Sound.Looped = looped or false
	if(autoPlay)then
		coroutine.wrap(function()
			repeat wait() until Sound.IsLoaded
			Sound.Playing = autoPlay or false
		end)()
	end
	if(not looped and effect)then
		Sound.Stopped:connect(function()
			Sound.Volume = 0
			Sound:destroy()
		end)
	elseif(effect)then
		warn("Sound can't be looped and a sound effect!")
	end
	Sound.Parent =parent or Torso
	return Sound
end
 
function SoondPart(id,pitch,volume,looped,effect,autoPlay,cf)
	local soundPart = NewInstance("Part",Effects,{Transparency=1,CFrame=cf or Torso.CFrame,Anchored=true,CanCollide=false,Size=V3.N()})
	local Sound = IN("Sound")
	Sound.SoundId = "rbxassetid://".. tostring(id or 0)
	Sound.Pitch = pitch or 1
	Sound.Volume = volume or 1
	Sound.Looped = looped or false
	if(autoPlay)then
		coroutine.wrap(function()
			repeat wait() until Sound.IsLoaded
			Sound.Playing = autoPlay or false
		end)()
	end
	if(not looped and effect)then
		Sound.Stopped:connect(function()
			Sound.Volume = 0
			soundPart:destroy()
		end)
	elseif(effect)then
		warn("Sound can't be looped and a sound effect!")
	end
	Sound.Parent = soundPart
	return Sound,soundPart
end
 
function SoundPart(...)
	return SoondPart(...)
end
 
function Sound(...)
	return Soond(...)
end
 
function Part(parent,color,material,size,cframe,anchored,cancollide)
	local part = IN("Part")
	part.Parent = parent or Char
	part[typeof(color) == 'BrickColor' and 'BrickColor' or 'Color'] = color or C3.N(0,0,0)
	part.Material = material or Enum.Material.SmoothPlastic
	part.TopSurface,part.BottomSurface=10,10
	part.Size = size or V3.N(1,1,1)
	part.CFrame = cframe or CF.N(0,0,0)
	part.CanCollide = cancollide or false
	part.Anchored = anchored or false
	return part
end
 
function Weld(part0,part1,c0,c1)
	local weld = IN("Weld")
	weld.Parent = part0
	weld.Part0 = part0
	weld.Part1 = part1
	weld.C0 = c0 or CF.N()
	weld.C1 = c1 or CF.N()
	return weld
end
 
function Mesh(parent,meshtype,meshid,textid,scale,offset)
	local part = IN("SpecialMesh")
	part.MeshId = meshid or ""
	part.TextureId = textid or ""
	part.Scale = scale or V3.N(1,1,1)
	part.Offset = offset or V3.N(0,0,0)
	part.MeshType = meshtype or Enum.MeshType.Sphere
	part.Parent = parent
	return part
end
 
function GotEffect(data)
	-- just for easy reference
	local color = data.Color or Color3.new(.7,.7,.7);
	local endcolor = data.EndColor or nil;
	local mat = data.Material or Enum.Material.SmoothPlastic;
	local cframe = data.CFrame or CFrame.new();
	local endpos = data.EndPos or nil;
	local meshdata = data.Mesh or {}
	local sounddata = data.Sound or {}
	local size = data.Size or Vector3.new(1,1,1)
	local endsize = data.EndSize or Vector3.new(6,6,6)
	local rotinc = data.RotInc or {0,0,0} -- ONLY FOR LEGACY SYSTEM
	local transparency = data.Transparency or NumberRange.new(0,1)
	local acceleration = data.Acceleration or nil; -- ONLY FOR LEGACY SYSTEM
	local endrot = data.EndRotation or {0,0,0} -- ONLY FOR EXPERIMENTAL SYSTEM
	local style = data.Style or false; -- ONLY FOR EXPERIMENTAL SYSTEM
	local lifetime = data.Lifetime or 1;
	local system = data.FXSystem;
	local setpart = typeof(data.Part)=='string' and EffectFolder:FindFirstChild(tostring(data.Part)):Clone() or typeof(data.Part)=='Instance' and data.Part or nil
 
	local S,PM;
 
	local P = setpart or Part(Effects,color,mat,Vector3.new(1,1,1),cframe,true,false)
 
	if(not P:IsA'MeshPart' and not P:IsA'UnionOperation')then
		if(meshdata == "Blast")then
			PM = Mesh(P,Enum.MeshType.FileMesh,'rbxassetid://20329976','',size,Vector3.new(0,0,-size.X/8))
		elseif(meshdata == 'Ring')then
			PM = Mesh(P,Enum.MeshType.FileMesh,'rbxassetid://559831844','',size,Vector3.new(0,0,0))
		elseif(meshdata == 'Slash1')then
			PM = Mesh(P,Enum.MeshType.FileMesh,'rbxassetid://662586858','',Vector3.new(size.X/10,.001,size.Z/10),Vector3.new(0,0,0))
		elseif(meshdata == 'Slash2')then
			PM = Mesh(P,Enum.MeshType.FileMesh,'rbxassetid://448386996','',Vector3.new(size.X/1000,size.Y/100,size.Z/100),Vector3.new(0,0,0))
		elseif(meshdata == 'Tornado1')then
			PM = Mesh(P,Enum.MeshType.FileMesh,'rbxassetid://443529437','',size/10,Vector3.new(0,0,0))
		elseif(meshdata == 'Tornado2')then
			PM = Mesh(P,Enum.MeshType.FileMesh,'rbxassetid://168892432','',size/4,Vector3.new(0,0,0))
		elseif(meshdata == 'Skull')then
			PM = Mesh(P,Enum.MeshType.FileMesh,'rbxassetid://4770583','',size*2,Vector3.new(0,0,0))
		elseif(meshdata == 'Crystal')then
			PM = Mesh(P,Enum.MeshType.FileMesh,'rbxassetid://9756362','',size,Vector3.new(0,0,0))
		elseif(meshdata == 'Cloud')then
			PM = Mesh(P,Enum.MeshType.FileMesh,'rbxassetid://1095708','',size,Vector3.new(0,0,0))
		elseif(typeof(meshdata) == 'table')then
			local Type = meshdata.Type or Enum.MeshType.Brick
			local ID = meshdata.ID or '';
			local Tex = meshdata.Texture or '';
			local Offset = meshdata.Offset or Vector3.new(0,0,0)
			PM = Mesh(P,Type,ID,Tex,size,Offset)
		else
			PM = Mesh(P,Enum.MeshType.Brick,'','',size)
		end
	end
	local startTrans = typeof(transparency) == 'number' and transparency or typeof(transparency) == 'NumberRange' and transparency.Min or typeof(transparency) == 'table' and transparency[1] or 0
	local endTrans = typeof(transparency) == 'NumberRange' and transparency.Max or typeof(transparency) == 'table' and transparency[2] or 1
 
	P.Material = mat
	P.CFrame = cframe
	P.Color = (typeof(color)=='BrickColor' and color.Color or color)
	P.Anchored = true
	P.CanCollide = false
	P.Transparency = startTrans
	P.Parent = Effects
	local random = Random.new();
	game:service'Debris':AddItem(P,lifetime+3)
 
 
	-- actual effect stuff
	local mult = 1;
	if(PM)then
		if(PM.MeshId == 'rbxassetid://20329976')then
			PM.Offset = Vector3.new(0,0,-PM.Scale.Z/8)
		elseif(PM.MeshId == 'rbxassetid://4770583')then
			mult = 2
		elseif(PM.MeshId == 'rbxassetid://168892432')then
			mult = .25
		elseif(PM.MeshId == 'rbxassetid://443529437')then
			mult = .1
		elseif(PM.MeshId == 'rbxassetid://443529437')then
			mult = .1
		end
	end	
	coroutine.wrap(function()
		if(system == 'Legacy' or system == 1 or system == nil)then
			local frames = (typeof(lifetime) == 'NumberRange' and random:NextNumber(lifetime.Min,lifetime.Max) or typeof(lifetime) == 'number' and lifetime or 1)*Frame_Speed
			for i = 0, frames do
				local div = (i/frames)
				P.Transparency=(startTrans+(endTrans-startTrans)*div)
 
				if(PM)then PM.Scale = size:lerp(endsize*mult,div) else P.Size = size:lerp(endsize*mult,div) end
 
				local RotCF=CFrame.Angles(0,0,0)
 
				if(rotinc == 'random')then
					RotCF=CFrame.Angles(math.rad(random:NextNumber(-180,180)),math.rad(random:NextNumber(-180,180)),math.rad(random:NextNumber(-180,180)))
				elseif(typeof(rotinc) == 'table')then
					RotCF=CFrame.Angles(unpack(rotinc))
				end
 
				if(PM and PM.MeshId == 'rbxassetid://20329976')then
					PM.Offset = Vector3.new(0,0,-PM.Scale.Z/8)
				end
 
				if(endpos and typeof(endpos) == 'CFrame')then
					P.CFrame=cframe:lerp(endpos,div)*RotCF
				elseif(acceleration and typeof(acceleration) == 'table' and acceleration.Force)then
					local force = acceleration.Force;
					if(typeof(force)=='CFrame')then
						force=force.p;
					end
					if(typeof(force)=='Vector3')then
						if(acceleration.LookAt)then
							P.CFrame=(CFrame.new(P.Position,force)+force)*RotCF
						else
							P.CFrame=(P.CFrame+force)*RotCF
						end
					end
				else
					P.CFrame=P.CFrame*RotCF
				end
 
				if(endcolor and typeof(endcolor) == 'Color3')then
					P.Color = color:lerp(endcolor,div)
				end
				swait()
			end
			P:destroy()
		elseif(system == 'Experimental' or system == 2)then
			local info = TweenInfo.new(lifetime,style,Enum.EasingDirection.InOut,0,false,0)
			local info2 = TweenInfo.new(lifetime,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0)
			if(style == Enum.EasingStyle.Elastic)then
				info = TweenInfo.new(lifetime*2,style,Enum.EasingDirection.Out,0,false,0)
			elseif(style == Enum.EasingStyle.Bounce)then
				info = TweenInfo.new(lifetime,style,Enum.EasingDirection.Out,0,false,0)
			end
			local tweenPart = game:service'TweenService':Create(P,info2,{
				CFrame=(typeof(endpos) == 'CFrame' and endpos or P.CFrame)*CFrame.Angles(unpack(endrot)),
				Color=typeof(endcolor) == 'Color3' and endcolor or color,
				Transparency=endTrans,
			})
			local off = Vector3.new(0,0,0)
			if(PM.MeshId == 'rbxassetid://20329976')then off=Vector3.new(0,0,(endsize*mult).Z/8) end
 
			local tweenMesh = game:service'TweenService':Create(PM,info,{
				Scale=endsize*mult,
				Offset=off,
			})
			tweenPart:Play()
			tweenMesh:Play()
		end
	end)()
end
 
function Effect(edata)
	GotEffect(edata)
end
 
function Trail(data)
	coroutine.wrap(function()
		data.Frames = typeof(data.Frames)=='number' and data.Frames or 60
		data.CFrame = typeof(data.CFrame)=='CFrame' and data.CFrame or Root.CFrame
		local ep = typeof(data.EndPos)=='CFrame' and data.EndPos or data.CFrame*CFrame.new(0,5,0);
		data.EndPos=nil
		local trailPart = Part(Effects,BrickColor.new'White',Enum.Material.SmoothPlastic,V3.N(.05,.05,.05),data.CFrame,true,false)
		trailPart.Transparency=1
		local start = data.CFrame
		for i = 1, data.Frames do
			trailPart.CFrame = start:lerp(ep,i/data.Frames)
			data.CFrame = trailPart.CFrame
			Effect(data)
			swait()
		end	
	end)()
end
 
function ClientTrail(data)
	coroutine.wrap(function()
		data.Frames = typeof(data.Frames)=='number' and data.Frames or 60
		data.CFrame = typeof(data.CFrame)=='CFrame' and data.CFrame or Root.CFrame
		local ep = typeof(data.EndPos)=='CFrame' and data.EndPos or data.CFrame*CFrame.new(0,5,0);
		data.EndPos=nil
		local trailPart = Part(Effects,BrickColor.new'White',Enum.Material.SmoothPlastic,V3.N(.05,.05,.05),data.CFrame,true,false)
		trailPart.Transparency=1
		local start = data.CFrame
		for i = 1, data.Frames do
			trailPart.CFrame = start:lerp(ep,i/data.Frames)
			data.CFrame = trailPart.CFrame
			GotEffect(data)
			swait()
		end	
	end)()
end
 
 
if(Char:FindFirstChild('NGRWings'..Player.Name))then
	Char['NGRWings'..Player.Name]:destroy()
end
 
for _,v in next, Char:children() do
	if(v.Name:lower():find'wings')then 
		v:destroy()
	end
end
 
local wingModel = Instance.new("Model",Char)
wingModel.Name="NGRWings"..Player.Name
local rightWing = NewInstance("Model",wingModel,{Name='Right'})
local leftWing = NewInstance("Model",wingModel,{Name='Left'})
 
 
 
local LWP1 = WingPiece:Clone();
LWP1.Parent = leftWing
CreateWeapon("LeftWing1")
WeldWeapon(workspace.MaxDesignPro["LeftWing1"], LWP1.Main)

local LWP2 = WingPiece:Clone();
LWP2.Parent = leftWing
CreateWeapon("LeftWing2")
WeldWeapon(workspace.MaxDesignPro["LeftWing2"], LWP2.Main)

local LWP3 = WingPiece:Clone();
LWP3.Parent = leftWing

local RWP1 = WingPiece:Clone();
RWP1.Parent = rightWing
CreateWeapon("RightWing1")
WeldWeapon(workspace.MaxDesignPro["RightWing1"], RWP1.Main)

local RWP2 = WingPiece:Clone();
RWP2.Parent = rightWing
CreateWeapon("RightWing2")
WeldWeapon(workspace.MaxDesignPro["RightWing2"], RWP2.Main)

local RWP3 = WingPiece:Clone();
RWP3.Parent = rightWing

local LWP1W=Weld(LWP1.PrimaryPart,Torso,CF.N(2,-2,-1)*CF.A(0,0,0))
local LWP2W=Weld(LWP2.PrimaryPart,Torso,CF.N(4.25,-1,-1)*CF.A(0,0,M.R(15)))
local LWP3W=Weld(LWP3.PrimaryPart,Torso,CF.N(6.5,.5,-1)*CF.A(0,0,M.R(30)))
local RWP1W=Weld(RWP1.PrimaryPart,Torso,CF.N(-2,-2,-1)*CF.A(0,0,0))
local RWP2W=Weld(RWP2.PrimaryPart,Torso,CF.N(-4.25,-1,-1)*CF.A(0,0,M.R(-15)))
local RWP3W=Weld(RWP3.PrimaryPart,Torso,CF.N(-6.5,.5,-1)*CF.A(0,0,M.R(-30)))
 
local bbg=Head:FindFirstChild'Nametag' or NewInstance("BillboardGui",Head,{
	Adornee=Head;
	Name='Nametag';
	Size=UDim2.new(4,0,1.2,0);
	StudsOffset=V3.N(-8,5.3,0);
})
local text=bbg:FindFirstChild'TextLabel' or NewInstance("TextLabel",bbg,{
	Size=UDim2.new(5,0,3.5,0);
	TextScaled=true;
	BackgroundTransparency=1;
	TextStrokeTransparency=0;
	Font=Enum.Font.Arcade;
	TextColor3=C3.N(1,1,1);
	Text='Achromatic'
})
 
function getMode(modeName)
	for i,v in next, modeInfo do
		if(v.Name==modeName)then
			return v
		end
	end
	return modeInfo[1]
end
 
function IsVaporwave(song)
	for i = 1,#VaporwaveSongs do
		if(VaporwaveSongs[i]==song)then
			return true
		end
	end
	return false
end
 
local blush = NewInstance('Decal',Head,{Transparency=1,Texture='rbxassetid://0',Color3=(Player.UserId==5719877 and C3.N(.45,0,1) or C3.N(1,0,0))})
 
function changeMudo(modeName)
	local info = getMode(modeName)
	Mode=info.Name
	WalkSpeed=info.Walkspeed
	movement=info.moveVal
	music=makeMusic(info.Music or 0,info.Pitch or 1,info.TimePos or music and music.TimePosition or 0)
	WingAnim=info.WingAnim or 'NebG1'
	text.Text = info.Name
	text.TextColor3 = info.LeftWing[2]
	text.TextStrokeColor3 = info.StrokeColor
	text.Font=info.Font;
	if(Mode=='Love' or Mode=='Lust')then
		blush.Transparency=0
		blush.Texture='rbxassetid://2664127437'
	else
		blush.Transparency=1
		blush.Texture='rbxassetid://0'
	end
	for _,v in next,leftWing:GetDescendants() do
		if(v:IsA'BasePart' and v.Name~='Main')then
			--v.Transparency=info.LeftWing[1]
			v.Color=info.LeftWing[2]
			v.Material=info.LeftWing[3]
		elseif(v:IsA'Trail')then
			--v.Transparency=NumberSequence.new(info.LeftWing[1],1)
			v.Color=ColorSequence.new(info.LeftWing[2])	
		end
	end
 
	for _,v in next,rightWing:GetDescendants() do
		if(v:IsA'BasePart' and v.Name~='Main')then
			--v.Transparency=info.RightWing[1]
			v.Color=info.RightWing[2]
			v.Material=info.RightWing[3]
		elseif(v:IsA'Trail')then
			--v.Transparency=NumberSequence.new(info.RightWing[1],1)
			v.Color=ColorSequence.new(info.RightWing[2])	
		end
	end
 
	PrimaryColor = info.PrimaryColor or info.LeftWing[2]
end
 
function changeMode(modeName)
	changeMudo(modeName)
end	
 
function syncStuff(data)
	local neut,legwelds,c0s,c1s,sine,mov,walk,inc,musicmode,tpos,pit,wingsin,visSett,mode,newhue=unpack(data)
	local head0,torso0,rleg0,rarm0,lleg0,larm0=unpack(c0s)
	local head1,torso1,rleg1,rarm1,lleg1,larm1=unpack(c1s)
	legAnims=legwelds
	NeutralAnims=neut
	if(not neut)then
		NK.C0=head0
		RJ.C0=torso0
		RH.C0=rleg0
		RS.C0=rarm0
		LH.C0=lleg0
		LS.C0=larm0
 
		NK.C1=head1
		RJ.C1=torso1
		RH.C1=rleg1
		RS.C1=rarm1
		LH.C1=lleg1
		LS.C1=larm1
	end
	if(Mode~=mode)then
		changeMudo(mode)
	end
	movement=mov
	walking=walk
	Change=inc
	print(MusicMode,musicmode)
	if(musicmode~=MusicMode and music)then
		MusicMode=musicmode
		if(MusicMode==1)then
			music:Pause()
			music.Volume=5
			music.Parent=Torso
			music:Resume()
		elseif(MusicMode==2)then
			music:Pause()
			music.Volume=5
			music.Parent=Char
			music:Resume()
		elseif(MusicMode==3)then
			music.Volume = 0
		end
	end
	if(Sine-sine>.8 or Sine-sine<-.8)then
		Sine=sine
	end
	if(hue-newhue>.8 or hue-newhue<-.8)then
		hue=newhue
	end
	if(WingSine-wingsin>.8 or WingSine-wingsin<-.8)then
		WingSine=wingsin
	end
	if(music and (music.TimePosition-tpos>.8 or music.TimePosition-tpos<-.8))then
		music.TimePosition=tpos
	end
	if(music and pit)then
		music.Pitch = pit
	end
	if(Mode=='Troubadour' and music.SoundId~='rbxassetid://'..visSett.Music)then
		music.SoundId='rbxassetid://'..visSett.Music
	end
	getMode('Troubadour').Music = visSett.Music
	getMode('Troubadour').Pitch = visSett.Pitch
end
 
 
local footstepSounds = {
	[Enum.Material.Grass]=510933218;
	[Enum.Material.Metal]=1263161138;
	[Enum.Material.CorrodedMetal]=1263161138;
	[Enum.Material.DiamondPlate]=1263161138;
	[Enum.Material.Wood]=2452053757;
	[Enum.Material.WoodPlanks]=2452053757;
	[Enum.Material.Sand]=134456884;
	[Enum.Material.Snow]=2452051182;
}
 
 
function Vaporwaveify(s)
	local function wide(a)
		if a<'!' or a>'~' then return a end
		if a==' ' then return '  ' end 
		a = a:byte()+160
		if a<256 then return string.char(239,188,a-64) end
		return string.char(239,189,a-128)
	end
	return(s:gsub(".",wide))
end
 
 
 
function Choot(text)
	--if(game.PlaceId ~= 843468296)then
		coroutine.wrap(function()
			if(Char:FindFirstChild'ChatGUI')then Char.ChatGUI:destroy() end
			local BBG = NewInstance("BillboardGui",Char,{Name='ChatGUI',Size=UDim2.new(0,100,0,40),StudsOffset=V3.N(0,2,0),Adornee=Head})
			local Txt = NewInstance("TextLabel",BBG,{Text = "",BackgroundTransparency=1,TextColor3=PrimaryColor,BorderSizePixel=0,Font=Enum.Font.Antique,TextSize=50,TextStrokeTransparency=1,Size=UDim2.new(1,0,.5,0)})
			for i = 1, #text do
				--Txt.Text = Vaporwaveify(text:sub(1,i))
				Txt.TextColor3=(Mode=='Troubadour' and Color3.fromHSV(hue/360,1,math.clamp(music.PlaybackLoudness/475,0,1)) or PrimaryColor)
				if(vaporwaveMode and Mode=='Troubadour')then
					Txt.Text = Vaporwaveify(text:sub(1,i))
				else
					Txt.Text = text:sub(1,i)
				end
				wait((vaporwaveMode) and .1 or .025)
			end
			for i = 0, 60 do
				Txt.TextColor3=(Mode=='Troubadour' and Color3.fromHSV(hue/360,1,math.clamp(music.PlaybackLoudness/475,0,1)) or PrimaryColor)
				swait()
			end
			for i = 0, 1, .025 do
				Txt.TextTransparency=i
				swait()
			end
			BBG:destroy()
		end)()
	--else
	--	Chat2(text)
	--end
end
 
function Chat(text)
	Choot(text)
end
 
function DealDamage(...)
	return true
end
 
function getRegion(point,range,ignore)
    return workspace:FindPartsInRegion3WithIgnoreList(R3.N(point-V3.N(1,1,1)*range/2,point+V3.N(1,1,1)*range/2),ignore,100)
end
function AOEDamage(where,range,options)
	local hit = {}
	for _,v in next, getRegion(where,range,{Char}) do
		if(v.Parent and v.Parent:FindFirstChildOfClass'Humanoid' and not hit[v.Parent:FindFirstChildOfClass'Humanoid'])then
			local callTable = {Who=v.Parent}
			hit[v.Parent:FindFirstChildOfClass'Humanoid'] = true
			for _,v in next, options do callTable[_] = v end
			DealDamage(callTable)
		end
	end
	return hit
end
 
 
function Click1()
	Attack=true
	NeutralAnims=false
	legAnims=false
	local orig = WalkSpeed
	WalkSpeed=4
	for i = 0, 1, 0.1 do
		swait()
		local Alpha = .3
		RJ.C0 = RJ.C0:lerp(CF.N(0,0,0)*CF.A(M.R(0),M.R(-44.6),M.R(0)),Alpha)
		LH.C0 = LH.C0:lerp(CF.N(-0.8,-1,-0.3)*CF.A(M.R(-17.4),M.R(44.4),M.R(7.1)),Alpha)
		RH.C0 = RH.C0:lerp(CF.N(0.4,-1,0)*CF.A(M.R(1.6),M.R(-13.1),M.R(7)),Alpha)
		LS.C0 = LS.C0:lerp(CF.N(-1.3,0.5,-0.3)*CF.A(M.R(90),M.R(0),M.R(-44.6)),Alpha)
		RS.C0 = RS.C0:lerp(CF.N(1.4,0.5,-0.1)*CF.A(M.R(90),M.R(0),M.R(-44.6)),Alpha)
		NK.C0 = NK.C0:lerp(CF.N(0,1.5,0)*CF.A(M.R(0),M.R(44.6),M.R(0)),Alpha)
	end
	for i = 0, 1, 0.1 do
		swait()
		AOEDamage(RArm.CFrame.p,2,{
			DamageColor=(Mode=='Troubadour' and C3.HSV(hue/360,1,math.clamp(music.PlaybackLoudness/475,0,1)) or PrimaryColor);
			MinimumDamage=5;
			MaximumDamage=15;
		})
		local Alpha = .3
		RJ.C0 = RJ.C0:lerp(CF.N(0,0,-0.7)*CF.A(M.R(0),M.R(50.5),M.R(0)),Alpha)
		LH.C0 = LH.C0:lerp(CF.N(-0.5,-0.7,-0.6)*CF.A(M.R(-26),M.R(0),M.R(0)),Alpha)
		RH.C0 = RH.C0:lerp(CF.N(0.6,-1.1,-0.1)*CF.A(M.R(20.2),M.R(-47.6),M.R(15.2)),Alpha)
		LS.C0 = LS.C0:lerp(CF.N(-1.3,0.5,0)*CF.A(M.R(0),M.R(0),M.R(-20.4)),Alpha)
		RS.C0 = RS.C0:lerp(CF.N(1.4,0.5,-0.5)*CF.A(M.R(90),M.R(0),M.R(50.5)),Alpha)
		NK.C0 = NK.C0:lerp(CF.N(0,1.5,0)*CF.A(M.R(0),M.R(-50.5),M.R(0)),Alpha)
	end
	WalkSpeed=orig
	legAnims=true
	Attack=false
	NeutralAnims=true
end
 
function SwordSummon()
	Attack = true
	NeutralAnims = false
	local orig=WalkSpeed
	WalkSpeed=4
	legAnims=false
	for i = 0, 1, 0.1 do
		swait()
		local Alpha = .3
		Effect{
			Lifetime=.25;
			Mesh={Type=Enum.MeshType.Sphere};
			CFrame=RArm.CFrame*CF.N(0,-1,0)*CF.A(M.RRNG(0,360),M.RRNG(0,360),M.RRNG(0,360));
			Color=PrimaryColor;
			Transparency={.5,1};
			Material=Enum.Material.Neon;
			Size=Vector3.new(.6,1,.6);
			EndSize=Vector3.new(.1,3,.1);
		}
		RJ.C0 = RJ.C0:lerp(CF.N(0,-0.2,-0.1)*CF.A(M.R(-12.4),M.R(-15.7),M.R(0)),Alpha)
		LH.C0 = LH.C0:lerp(CF.N(-0.5,-0.7,-0.5)*CF.A(M.R(16.2),M.R(15.2),M.R(-0.8)),Alpha)
		RH.C0 = RH.C0:lerp(CF.N(0.5,-1,0)*CF.A(M.R(-28.5),M.R(0),M.R(0)),Alpha)
		LS.C0 = LS.C0:lerp(CF.N(-1.4,0.5,0)*CF.A(M.R(27.2),M.R(-3.8),M.R(-5)),Alpha)
		RS.C0 = RS.C0:lerp(CF.N(1.3,0.6,0)*CF.A(M.R(-33.8),M.R(-18.1),M.R(24.8)),Alpha)
		NK.C0 = NK.C0:lerp(CF.N(0,1.5,0)*CF.A(M.R(13.4),M.R(15.3),M.R(-3.6)),Alpha)
	end
	for i = 0, 5 do
		delay(.05*i,function()
			local pos = Root.CFrame*CF.N(0,-2,-2-i*4)*CF.A(M.R(80),0,0)
			local pos2 = Root.CFrame*CF.N(0,-3,-2-i*4)
			Camshake({
			    Duration=.2;
				FadeOut=.2;
			    Intensity=1.5;
			    Position=Vector3.new(.5,.5,.5);
			    Rotation=Vector3.new(.5,.5,3);
			    DropDist=15;
			    IneffectiveDist=40;
			    Origin=pos2;
			})
			AOEDamage(pos.p,5,{
				DamageColor=(Mode=='Troubadour' and C3.HSV(hue/360,1,math.clamp(music.PlaybackLoudness/475,0,1)) or PrimaryColor);
				MinimumDamage=(Mode=='Troubadour' and music.PlaybackLoudness/10 or 10);
				MaximumDamage=(Mode=='Troubadour' and music.PlaybackLoudness/8 or 35);
			})
			SoundPart(178452221,1,2,false,true,true,pos)
			Effect{
				Lifetime=.4;
				Part='Sword',
				--Mesh={Type=Enum.MeshType.Sphere};
				CFrame=pos;
				Color=PrimaryColor;
				Transparency={0,1};
				Material=Enum.Material.Neon;
				Size=V3.N(0.8,2.5,6.8);
				EndSize=V3.N(0.8,2.5,16);
			}
			Effect{
				Lifetime=.4;
				Mesh={Type=Enum.MeshType.Sphere};
				CFrame=pos2;
				Color=PrimaryColor;
				Transparency={0,1};
				Material=Enum.Material.Neon;
				Size=V3.N(4,.1,4);
				EndSize=V3.N(6,.1,6);
			}
			Effect{
				Lifetime=.1;
				Mesh={Type=Enum.MeshType.Sphere};
				CFrame=pos;
				Color=PrimaryColor;
				Transparency={0,1};
				Material=Enum.Material.Neon;
				Size=V3.N(7,7,7);
				EndSize=V3.N(12,12,12);
			}
			for i = 1, 5 do
				Effect{
					Lifetime=.5;
					Mesh={Type=Enum.MeshType.Sphere};
					CFrame=pos;
					Color=PrimaryColor;
					Transparency={0,1};
					Material=Enum.Material.Neon;
					Size=V3.N(1,1,1);
					EndSize=V3.N(1,1,1);
					Acceleration={Force=V3.N(M.RNG(-75,75)/100,M.RNG(-75,75)/100,M.RNG(-75,75)/100)};
				}
			end
		end)
	end
	for i = 0, 1, 0.1 do
		swait()
		local Alpha = .3
		RJ.C0 = RJ.C0:lerp(CF.N(0,0,0)*CF.A(M.R(0),M.R(70.7),M.R(0)),Alpha)
		LH.C0 = LH.C0:lerp(CF.N(-0.5,-1,0)*CF.A(M.R(0),M.R(0),M.R(-14.4)),Alpha)
		RH.C0 = RH.C0:lerp(CF.N(0.6,-1,0)*CF.A(M.R(15.1),M.R(-63.2),M.R(13.5)),Alpha)
		LS.C0 = LS.C0:lerp(CF.N(-1.3,0.6,-0.1)*CF.A(M.R(0),M.R(15.9),M.R(-25.4)),Alpha)
		RS.C0 = RS.C0:lerp(CF.N(1.4,0.3,-0.2)*CF.A(M.R(0),M.R(19.3),M.R(157.1)),Alpha)
		NK.C0 = NK.C0:lerp(CF.N(0,1.5,0)*CF.A(M.R(0),M.R(-70.7),M.R(0)),Alpha)
	end
	legAnims=true
	WalkSpeed=orig
	Attack = false
	NeutralAnims = true
end
 
function Bombs()
	Attack=true
	NeutralAnims=false
	legAnims=false
	local orig = WalkSpeed
	WalkSpeed=0
	for i = 0, 1, 0.1 do
		swait()
		local Alpha = .3
		RJ.C0 = RJ.C0:lerp(CF.N(0,0,0)*CF.A(M.R(0),M.R(0),M.R(0)),Alpha)
		LH.C0 = LH.C0:lerp(CF.N(-0.5,-1,0)*CF.A(M.R(0),M.R(0),M.R(0)),Alpha)
		RH.C0 = RH.C0:lerp(CF.N(0.5,-1,0)*CF.A(M.R(0),M.R(0),M.R(0)),Alpha)
		LS.C0 = LS.C0:lerp(CF.N(-1.3,0.5,-0.5)*CF.A(M.R(90),M.R(0),M.R(19.1)),Alpha)
		RS.C0 = RS.C0:lerp(CF.N(1.3,0.5,-0.5)*CF.A(M.R(90),M.R(0),M.R(-21.3)),Alpha)
		NK.C0 = NK.C0:lerp(CF.N(0,1.5,0)*CF.A(M.R(0),M.R(0),M.R(0)),Alpha)
	end
	coroutine.wrap(function()
		for i = 0, 2 do
			Camshake({
			    Duration=.2;
				FadeOut=.2;
			    Intensity=1.5;
			    Position=Vector3.new(.5,.5,.5);
			    Rotation=Vector3.new(.5,.5,3);
			    DropDist=15;
			    IneffectiveDist=40;
			    Origin=Root.CFrame*CF.N(0,0,-4-i*4);
			})
			SoundPart(206083252,.8,4,false,true,true,Root.CFrame*CF.N(0,0,-4-i*4))
			AOEDamage(Root.CFrame*CF.N(0,0,-4-i*4).p,5,{
				DamageColor=PrimaryColor;
				MinimumDamage=25;
				MaximumDamage=45;
			})
			Effect{
				Lifetime=.4;
				Mesh={Type=Enum.MeshType.Sphere};
				Color=PrimaryColor;
				Material=Enum.Material.Neon;
				CFrame=Root.CFrame*CF.N(0,0,-4-i*4);
				Size=V3.N(1,1,1);
				EndSize=V3.N(10,10,10);
			}
			Effect{
				Lifetime=.4;
				Part='Ring';
				Color=PrimaryColor;
				Material=Enum.Material.Neon;
				CFrame=Root.CFrame*CF.N(0,0,-4-i*4)*CF.A(M.RRNG(0,360),M.RRNG(0,360),M.RRNG(0,360));
				RotInc={M.RNG(-25,25)/100,M.RNG(-25,25)/100,M.RNG(-25,25)/100};
				Size=V3.N(4,4,.2);
				EndSize=V3.N(13,13,.2);
			}
			Effect{
				Lifetime=.4;
				Part='Ring';
				Color=PrimaryColor;
				Material=Enum.Material.Neon;
				CFrame=Root.CFrame*CF.N(0,0,-4-i*4)*CF.A(M.RRNG(0,360),M.RRNG(0,360),M.RRNG(0,360));
				RotInc={M.RNG(-25,25)/100,M.RNG(-25,25)/100,M.RNG(-25,25)/100};
				Size=V3.N(4,4,.2);
				EndSize=V3.N(13,13,.2);
			}
			swait(4)
		end
	end)()
	for i = 0, 1, 0.1 do
		swait()
		local Alpha = .3
		RJ.C0 = RJ.C0:lerp(CF.N(0,-0.2,0.7)*CF.A(M.R(18.2),M.R(0),M.R(0)),Alpha)
		LH.C0 = LH.C0:lerp(CF.N(-0.5,-1.1,-0.4)*CF.A(M.R(-33.4),M.R(0),M.R(0)),Alpha)
		RH.C0 = RH.C0:lerp(CF.N(0.5,-0.9,-0.2)*CF.A(M.R(-6.7),M.R(0),M.R(0)),Alpha)
		LS.C0 = LS.C0:lerp(CF.N(-1.4,0.4,0.1)*CF.A(M.R(90.7),M.R(-2.5),M.R(-50)),Alpha)
		RS.C0 = RS.C0:lerp(CF.N(1.4,0.5,0.2)*CF.A(M.R(89.5),M.R(2.6),M.R(50)),Alpha)
		NK.C0 = NK.C0:lerp(CF.N(0,1.5,0)*CF.A(M.R(0),M.R(0),M.R(0)),Alpha)
	end
	WalkSpeed=orig
	legAnims=true
	Attack=false
	NeutralAnims=true
end
 
 
function ClickCombo()
	ClickTimer=180
	if(Combo==1)then
		Click1()
		Combo=2
	elseif(Combo==2)then
		SwordSummon()
		Combo=3
	elseif(Combo==3)then
		Bombs()
		Combo=1
	end
end
 
function VaporTaunt()
	Attack = true
	NeutralAnims = false
	local orig=WalkSpeed
	WalkSpeed=0
	legAnims=false
	Chat"You need to chill out.."
	for i = 0, 14, 0.1 do
		swait()
		local Alpha = .1
		RJ.C0 = RJ.C0:lerp(CF.N(-0.1,-0.1-.1*M.S(Sine/36),0.6)*CF.A(M.R(55.3+2.5*M.C(Sine/36)),M.R(0),M.R(0)),Alpha)
		LH.C0 = LH.C0:lerp(CF.N(-0.6,-1.2,-0.1)*CF.A(M.R(56.3+10*M.C(Sine/36)),M.R(0),M.R(24)),Alpha)
		RH.C0 = RH.C0:lerp(CF.N(0.9,-1.2,-0.2)*CF.A(M.R(25+5*M.C(Sine/36)),M.R(3.5),M.R(-43.9)),Alpha)
		LS.C0 = LS.C0:lerp(CF.N(-1,0.8,0)*CF.A(M.R(11.4-5*M.C(Sine/42)),M.R(-3.3),M.R(137.5)),Alpha)
		RS.C0 = RS.C0:lerp(CF.N(1.4,0.5,-0.2)*CF.A(M.R(61-5*M.C(Sine/42)),M.R(0),M.R(0)),Alpha)
		NK.C0 = NK.C0:lerp(CF.N(0,1.4,-0.3)*CF.A(M.R(-38.9-5*M.C(Sine/42)),M.R(0),M.R(0)),Alpha)
	end
	legAnims=true
	WalkSpeed=orig
	Attack = false
	NeutralAnims = true
end
 
 
 
UIS.InputBegan:connect(function(io,gpe)
	if(gpe or Attack or data.User~=data.Local)then return end
	--MODES
	if(io.KeyCode == Enum.KeyCode.One and Mode~='Achromatic')then 
		changeMode'Achromatic'
	elseif(io.KeyCode == Enum.KeyCode.Two and Mode~='Iniquitous')then 
		changeMode'Iniquitous'
	elseif(io.KeyCode == Enum.KeyCode.Three and Mode~='Mythical')then 
		changeMode'Mythical'
	elseif(io.KeyCode == Enum.KeyCode.Four and Mode~='Ruined')then 
		changeMode'Ruined'
	elseif(io.KeyCode == Enum.KeyCode.Five and Mode~='Atramentous')then 
		changeMode'Atramentous'
	elseif(io.KeyCode == Enum.KeyCode.Six and Mode~='Subzero')then 
		changeMode'Subzero'
	elseif(io.KeyCode == Enum.KeyCode.Seven and Mode~='Troubadour')then 
		changeMode'Troubadour'
	elseif(io.KeyCode == Enum.KeyCode.Eight and Mode~='Infectious')then 
		changeMode'Infectious'
	elseif(io.KeyCode == Enum.KeyCode.Nine and Mode~='Love')then 
		changeMode'Love'
	elseif(io.KeyCode == Enum.KeyCode.Y and Mode=='Achromatic')then 
		changeMode'The Big Black'
	elseif(io.KeyCode == Enum.KeyCode.Y and Mode=='Mythical')then 
		changeMode'Legendary'
 
	elseif(io.KeyCode == Enum.KeyCode.Y and Mode=='Love')then 
		changeMode'Lust'
	--TOGGLE MUSIC
	elseif(io.KeyCode == Enum.KeyCode.M and getMode(Mode))then 
		MusicMode=MusicMode+1
		if(MusicMode>3)then MusicMode=1 end
		if(MusicMode==1)then
			music:Pause()
			music.Volume=5
			music.Parent=Torso
			music:Resume()
		elseif(MusicMode==2)then
			music:Pause()
			music.Volume=5
			music.Parent=Char
			music:Resume()
		elseif(MusicMode==3)then
			music.Volume = 0
		end
	elseif(io.KeyCode==Enum.KeyCode.B)then
		--TAUNTS
		if(vaporwaveMode and Mode=='Troubadour')then
			VaporTaunt()
		end
	end
	if(vaporwaveMode)then return end
	--ATTACKS
	if(io.UserInputType==Enum.UserInputType.MouseButton1)then
		ClickCombo()
	end
end)



local main = Instance.new("ScreenGui")
local epic = Instance.new("Frame")
local backgroundtitle = Instance.new("TextLabel")
local creator = Instance.new("TextLabel")
local title = Instance.new("TextLabel")
local close = Instance.new("TextButton")
local fbutton = Instance.new("TextButton")
local ebutton = Instance.new("TextButton")
local qbutton = Instance.new("TextButton")
local tbutton = Instance.new("TextButton")
local main2 = Instance.new("ScreenGui")
local epic2 = Instance.new("Frame")
local backgroundtitle2 = Instance.new("TextLabel")
local creator2 = Instance.new("TextLabel")
local title2 = Instance.new("TextLabel")
local close2 = Instance.new("TextButton")
local fbutton2 = Instance.new("TextButton")
local ebutton2 = Instance.new("TextButton")
local qbutton2 = Instance.new("TextButton")
local tbutton2 = Instance.new("TextButton")

main.Name = "main"
main.Parent = game.CoreGui
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

epic.Name = "epic"
epic.Parent = main
epic.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
epic.Position = UDim2.new(0.0911376476, 0, 0.466830462, 0)
epic.Size = UDim2.new(0, 181, 0, 178)
epic.Active = true
epic.Draggable = true

creator.Name = "creator"
creator.Parent = epic
creator.BackgroundColor3 = Color3.fromRGB(1, 1, 1)
creator.Position = UDim2.new(0.00442049652, 0, 0.762519121, 0)
creator.Size = UDim2.new(0, 181, 0, 42)
creator.Font = Enum.Font.SourceSans
creator.Text = "made by scripty sir"
creator.TextColor3 = Color3.fromRGB(0, 0, 0)
creator.TextScaled = true
creator.TextSize = 14.000
creator.TextWrapped = false

title.Name = "title"
title.Parent = epic
title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1.000
title.Position = UDim2.new(0.0497237556, 0, 0, 0)
title.Size = UDim2.new(0, 119, 0, 43)
title.Font = Enum.Font.SciFi
title.Text = "control key"
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.TextScaled = true
title.TextSize = 14.000
title.TextWrapped = true

close.Name = "close"
close.Parent = epic
close.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
close.Position = UDim2.new(0.76795578, 0, 0, 0)
close.Size = UDim2.new(0, 43, 0, 43)
close.Font = Enum.Font.GothamBlack
close.Text = "X"
close.TextColor3 = Color3.fromRGB(0, 0, 0)
close.TextScaled = true
close.TextSize = 14.000
close.TextWrapped = true
close.MouseButton1Down:connect(function()
epic.Visible = false
end)

fbutton.Name = "fbutton"
fbutton.Parent = epic
fbutton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
fbutton.Position = UDim2.new(0.243093923, 0, 0.344781578, 0)
fbutton.Size = UDim2.new(0, 84, 0, 42)
fbutton.Font = Enum.Font.SourceSans
fbutton.Text = "Achromatic"
fbutton.Font = Enum.Font.Highway
fbutton.TextScaled = true
fbutton.TextColor3 = Color3.fromRGB(0, 0, 0)
fbutton.TextSize = 14.000
fbutton.MouseButton1Down:connect(function()
   changeMode'Achromatic'()
end)

ebutton.Name = "ebutton"
ebutton.Parent = epic
ebutton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ebutton.Position = UDim2.new(0.553093923, 0, 0.654781578, 0)
ebutton.Size = UDim2.new(0, 84, 0, 42)
ebutton.Font = Enum.Font.SourceSans
ebutton.Text = "Iniquitous"
ebutton.Font = Enum.Font.Highway
ebutton.TextScaled = true
ebutton.TextColor3 = Color3.fromRGB(0, 0, 0)
ebutton.TextSize = 14.000
ebutton.MouseButton1Down:connect(function()
   changeMode'Iniquitous'()
end)

qbutton.Name = "qbutton"
qbutton.Parent = epic
qbutton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
qbutton.Position = UDim2.new(0.154781578, 0, 0.053093923, 0)
qbutton.Size = UDim2.new(0, 84, 0, 42)
qbutton.Font = Enum.Font.SourceSans
qbutton.Text = "Mythical"
qbutton.Font = Enum.Font.Highway
qbutton.TextScaled = true
qbutton.TextColor3 = Color3.fromRGB(0, 0, 0)
qbutton.TextSize = 14.000
qbutton.MouseButton1Down:connect(function()
   changeMode'Mythical'()
end)

tbutton.Name = "tbutton"
tbutton.Parent = epic
tbutton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbutton.Position = UDim2.new(0.854781578, 0, 0.963093923, 0)
tbutton.Size = UDim2.new(0, 84, 0, 42)
tbutton.Font = Enum.Font.SourceSans
tbutton.Text = "Ruined"
tbutton.Font = Enum.Font.Highway
tbutton.TextScaled = true
tbutton.TextColor3 = Color3.fromRGB(0, 0, 0)
tbutton.TextSize = 14.000
tbutton.MouseButton1Down:connect(function()
   changeMode'Ruined'()
end)

local main = Instance.new("ScreenGui")
local epic = Instance.new("Frame")
local backgroundtitle = Instance.new("TextLabel")
local creator = Instance.new("TextLabel")
local title = Instance.new("TextLabel")
local close = Instance.new("TextButton")
local fbutton = Instance.new("TextButton")
local ebutton = Instance.new("TextButton")
local qbutton = Instance.new("TextButton")
local tbutton = Instance.new("TextButton")
local main2 = Instance.new("ScreenGui")
local epic2 = Instance.new("Frame")
local backgroundtitle2 = Instance.new("TextLabel")
local creator2 = Instance.new("TextLabel")
local title2 = Instance.new("TextLabel")
local close2 = Instance.new("TextButton")
local fbutton2 = Instance.new("TextButton")
local ebutton2 = Instance.new("TextButton")
local qbutton2 = Instance.new("TextButton")
local tbutton2 = Instance.new("TextButton")

main.Name = "main"
main.Parent = game.CoreGui
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

epic.Name = "epic"
epic.Parent = main
epic.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
epic.Position = UDim2.new(0.0911376476, 0, 0.466830462, 0)
epic.Size = UDim2.new(0, 181, 0, 178)
epic.Active = true
epic.Draggable = true

creator.Name = "creator"
creator.Parent = epic
creator.BackgroundColor3 = Color3.fromRGB(1, 1, 1)
creator.Position = UDim2.new(0.00442049652, 0, 0.762519121, 0)
creator.Size = UDim2.new(0, 181, 0, 42)
creator.Font = Enum.Font.SourceSans
creator.Text = "made by scripty sir"
creator.TextColor3 = Color3.fromRGB(0, 0, 0)
creator.TextScaled = true
creator.TextSize = 14.000
creator.TextWrapped = false

title.Name = "title"
title.Parent = epic
title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1.000
title.Position = UDim2.new(0.0497237556, 0, 0, 0)
title.Size = UDim2.new(0, 119, 0, 43)
title.Font = Enum.Font.SciFi
title.Text = "control key"
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.TextScaled = true
title.TextSize = 14.000
title.TextWrapped = true

close.Name = "close"
close.Parent = epic
close.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
close.Position = UDim2.new(0.76795578, 0, 0, 0)
close.Size = UDim2.new(0, 43, 0, 43)
close.Font = Enum.Font.GothamBlack
close.Text = "X"
close.TextColor3 = Color3.fromRGB(0, 0, 0)
close.TextScaled = true
close.TextSize = 14.000
close.TextWrapped = true
close.MouseButton1Down:connect(function()
epic.Visible = false
end)

fbutton.Name = "fbutton"
fbutton.Parent = epic
fbutton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
fbutton.Position = UDim2.new(0.243093923, 0, 0.344781578, 0)
fbutton.Size = UDim2.new(0, 84, 0, 42)
fbutton.Font = Enum.Font.Highway
fbutton.Text = "Atramentous"
fbutton.TextScaled = true
fbutton.TextColor3 = Color3.fromRGB(0, 0, 0)
fbutton.TextSize = 14.000
fbutton.MouseButton1Down:connect(function()
   changeMode'Atramentous'()
end)

ebutton.Name = "ebutton"
ebutton.Parent = epic
ebutton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ebutton.Position = UDim2.new(0.553093923, 0, 0.654781578, 0)
ebutton.Size = UDim2.new(0, 84, 0, 42)
ebutton.Font = Enum.Font.Highway
ebutton.Text = "Subzero"
ebutton.TextScaled = true
ebutton.TextColor3 = Color3.fromRGB(0, 0, 0)
ebutton.TextSize = 14.000
ebutton.MouseButton1Down:connect(function()
   changeMode'Subzero'()
end)

qbutton.Name = "qbutton"
qbutton.Parent = epic
qbutton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
qbutton.Position = UDim2.new(0.154781578, 0, 0.053093923, 0)
qbutton.Size = UDim2.new(0, 84, 0, 42)
qbutton.Font = Enum.Font.Highway
qbutton.Text = "Troubadour"
qbutton.TextScaled = true
qbutton.TextColor3 = Color3.fromRGB(0, 0, 0)
qbutton.TextSize = 14.000
qbutton.MouseButton1Down:connect(function()
   changeMode'Troubadour'()
end)

tbutton.Name = "tbutton"
tbutton.Parent = epic
tbutton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbutton.Position = UDim2.new(0.854781578, 0, 0.963093923, 0)
tbutton.Size = UDim2.new(0, 84, 0, 42)
tbutton.Font = Enum.Font.Highway
tbutton.Text = "Infectious"
tbutton.TextScaled = true
tbutton.TextColor3 = Color3.fromRGB(0, 0, 0)
tbutton.TextSize = 14.000
tbutton.MouseButton1Down:connect(function()
   changeMode'Infectious'()
end)


local main = Instance.new("ScreenGui")
local epic = Instance.new("Frame")
local backgroundtitle = Instance.new("TextLabel")
local creator = Instance.new("TextLabel")
local title = Instance.new("TextLabel")
local close = Instance.new("TextButton")
local fbutton = Instance.new("TextButton")
local ebutton = Instance.new("TextButton")
local qbutton = Instance.new("TextButton")
local tbutton = Instance.new("TextButton")
local main2 = Instance.new("ScreenGui")
local epic2 = Instance.new("Frame")
local backgroundtitle2 = Instance.new("TextLabel")
local creator2 = Instance.new("TextLabel")
local title2 = Instance.new("TextLabel")
local close2 = Instance.new("TextButton")
local fbutton2 = Instance.new("TextButton")
local ebutton2 = Instance.new("TextButton")
local qbutton2 = Instance.new("TextButton")
local tbutton2 = Instance.new("TextButton")

main.Name = "main"
main.Parent = game.CoreGui
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

epic.Name = "epic"
epic.Parent = main
epic.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
epic.Position = UDim2.new(0.0911376476, 0, 0.466830462, 0)
epic.Size = UDim2.new(0, 181, 0, 178)
epic.Active = true
epic.Draggable = true

creator.Name = "creator"
creator.Parent = epic
creator.BackgroundColor3 = Color3.fromRGB(1, 1, 1)
creator.Position = UDim2.new(0.00442049652, 0, 0.762519121, 0)
creator.Size = UDim2.new(0, 181, 0, 42)
creator.Font = Enum.Font.SourceSans
creator.Text = "made by scripty sir"
creator.TextColor3 = Color3.fromRGB(0, 0, 0)
creator.TextScaled = true
creator.TextSize = 14.000
creator.TextWrapped = false

title.Name = "title"
title.Parent = epic
title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1.000
title.Position = UDim2.new(0.0497237556, 0, 0, 0)
title.Size = UDim2.new(0, 119, 0, 43)
title.Font = Enum.Font.SciFi
title.Text = "control key"
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.TextScaled = true
title.TextSize = 14.000
title.TextWrapped = true

close.Name = "close"
close.Parent = epic
close.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
close.Position = UDim2.new(0.76795578, 0, 0, 0)
close.Size = UDim2.new(0, 43, 0, 43)
close.Font = Enum.Font.GothamBlack
close.Text = "X"
close.TextColor3 = Color3.fromRGB(0, 0, 0)
close.TextScaled = true
close.TextSize = 14.000
close.TextWrapped = true
close.MouseButton1Down:connect(function()
epic.Visible = false
end)

fbutton.Name = "fbutton"
fbutton.Parent = epic
fbutton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
fbutton.Position = UDim2.new(0.243093923, 0, 0.344781578, 0)
fbutton.Size = UDim2.new(0, 84, 0, 42)
fbutton.Font = Enum.Font.SourceSans
fbutton.Text = "Love"
fbutton.Font = Enum.Font.Highway
fbutton.TextScaled = true
fbutton.TextColor3 = Color3.fromRGB(0, 0, 0)
fbutton.TextSize = 14.000
fbutton.MouseButton1Down:connect(function()
      changeMode('Love')
end)

ebutton.Name = "ebutton"
ebutton.Parent = epic
ebutton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ebutton.Position = UDim2.new(0.553093923, 0, 0.654781578, 0)
ebutton.Size = UDim2.new(0, 84, 0, 42)
ebutton.Font = Enum.Font.SourceSans
ebutton.Text = "Big Black"
ebutton.Font = Enum.Font.Highway
ebutton.TextScaled = true
ebutton.TextColor3 = Color3.fromRGB(0, 0, 0)
ebutton.TextSize = 14.000
ebutton.MouseButton1Down:connect(function()
   changeMode('The Big Black')
end)

qbutton.Name = "qbutton"
qbutton.Parent = epic
qbutton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
qbutton.Position = UDim2.new(0.154781578, 0, 0.053093923, 0)
qbutton.Size = UDim2.new(0, 84, 0, 42)
qbutton.Font = Enum.Font.SourceSans
qbutton.Text = "Legendary"
qbutton.Font = Enum.Font.Highway
qbutton.TextScaled = true
qbutton.TextColor3 = Color3.fromRGB(0, 0, 0)
qbutton.TextSize = 14.000
qbutton.MouseButton1Down:connect(function()
   changeMode'Legendary'()
end)

tbutton.Name = "tbutton"
tbutton.Parent = epic
tbutton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tbutton.Position = UDim2.new(0.854781578, 0, 0.963093923, 0)
tbutton.Size = UDim2.new(0, 84, 0, 42)
tbutton.Font = Enum.Font.SourceSans
tbutton.Text = "Lust"
tbutton.Font = Enum.Font.Highway
tbutton.TextScaled = true
tbutton.TextColor3 = Color3.fromRGB(0, 0, 0)
tbutton.TextSize = 14.000
tbutton.MouseButton1Down:connect(function()
   changeMode'Lust'()
end)

 
WingAnims.StarG=function()
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(2,-2,-1)*CF.A(M.R(5+10*M.C(WingSine/32)),0,M.R(0+5*M.C(WingSine/32))),.2)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(4.25,-1,-1)*CF.A(M.R(10+15*M.C(WingSine/32)),0,M.R(15+7.5*M.C(WingSine/32))),.2)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(6.5,.5,-1)*CF.A(M.R(15+20*M.C(WingSine/32)),0,M.R(30+9*M.C(WingSine/32))),.2)
 
	RWP1W.C0 = RWP1W.C0:lerp(CF.N(-2,-2,-1)*CF.A(M.R(5+10*M.C(WingSine/32)),0,M.R(0-5*M.C(WingSine/32))),.2)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(-4.25,-1,-1+.05*M.S(WingSine/35))*CF.A(M.R(10+15*M.C(WingSine/32)),0,M.R(-15-7.5*M.C(WingSine/32))),.2)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(-6.5,.5,-1)*CF.A(M.R(15+20*M.C(WingSine/32)),0,M.R(-30-9*M.C(WingSine/32))),.2)
end
 
WingAnims.Cytus=function()
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(.15*M.C(WingSine/32),1.5+.35*M.S(WingSine/32),-1)*CF.A(0,0,M.R(60+5*M.C(WingSine/32))),.2)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(.1*M.C(WingSine/32),1.5+.25*M.C(WingSine/32),-1)*CF.A(0,0,M.R(90+2.5*M.C(WingSine/32))),.2)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(.25*M.C(WingSine/32),1.5-.05*M.S(WingSine/32),-1)*CF.A(0,0,M.R(120-5*M.C(WingSine/32))),.2)
 
	RWP1W.C0 = RWP1W.C0:lerp(CF.N(-.15*M.C(WingSine/32),1.5-.15*M.C(WingSine/32),-1)*CF.A(0,0,M.R(-60-5*M.C(WingSine/32))),.2)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(-.1*M.C(WingSine/32),1.5+.3*M.S(WingSine/32),-1)*CF.A(0,0,M.R(-90-2.5*M.C(WingSine/32))),.2)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(-.25*M.C(WingSine/32),1.5+.15*M.S(WingSine/32),-1)*CF.A(0,0,M.R(-120+5*M.C(WingSine/32))),.2)
end
 
WingAnims.Aprins=function()
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+2.5*M.C(WingSine/36)),M.R(60+5000*M.C(WingSine/400))),.2)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+7.5*M.C(WingSine/32)),M.R(90+5000*M.C(WingSine/400))),.2)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+5*M.C(WingSine/39)),M.R(120+5000*M.C(WingSine/400))),.2)
 
	RWP1W.C0 = RWP1W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+2.5*M.C(WingSine/36)),M.R(-60+5000*M.C(WingSine/400))),.2)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+7.5*M.C(WingSine/32)),M.R(-90+5000*M.C(WingSine/400))),.2)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+5*M.C(WingSine/39)),M.R(-120+5000*M.C(WingSine/400))),.2)
end
 
WingAnims.NebG1=function()
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(.15,1.5,-1)*CF.A(M.R(5+10*M.C(WingSine/32)),0,M.R(60)),.2)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(.1,1.5,-1)*CF.A(M.R(10+15*M.C(WingSine/32)),0,M.R(90)),.2)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(.25,1.5,-1)*CF.A(M.R(15+20*M.C(WingSine/32)),0,M.R(120)),.2)
 
	RWP1W.C0 = RWP1W.C0:lerp(CF.N(-.15,1.5,-1)*CF.A(M.R(5+10*M.C(WingSine/32)),0,M.R(-60)),.2)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(-.1,1.5,-1)*CF.A(M.R(10+15*M.C(WingSine/32)),0,M.R(-90)),.2)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(-.25,1.5,-1)*CF.A(M.R(15+20*M.C(WingSine/32)),0,M.R(-120)),.2)
end
 
WingAnims.NebG2=function(div)
	div=div or 25
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+2.5*M.C(WingSine/36)),M.R(0+2000*M.R(WingSine/div))),.2)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+7.5*M.C(WingSine/32)),M.R(120+2000*M.R(WingSine/div))),.2)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+5*M.C(WingSine/39)),M.R(-120+2000*M.R(WingSine/div))),.2)
 
	RWP1W.C0 = RWP1W.C0:lerp(CF.N(0,4.5,-1)*CF.A(0,M.R(0+2.5*M.C(WingSine/36)),M.R(0-2000*M.R(WingSine/div))),.2)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(0,4.5,-1)*CF.A(0,M.R(0+7.5*M.C(WingSine/32)),M.R(120-2000*M.R(WingSine/div))),.2)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(0,4.5,-1)*CF.A(0,M.R(0+5*M.C(WingSine/39)),M.R(-120-2000*M.R(WingSine/div))),.2)
end
 
WingAnims.NebG3=function(mult)
	mult=mult or 1
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+2.5*M.C(WingSine/36)),M.R(0+WingSine*mult)),.2)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+7.5*M.C(WingSine/32)),M.R(135+WingSine*mult)),.2)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(0,1.5,-1)*CF.A(0,M.R(0+5*M.C(WingSine/39)),M.R(225+WingSine*mult)),.2)
 
	RWP1W.C0 = RWP1W.C0:lerp(CF.N(0,1.5,-1.5)*CF.A(0,M.R(0+2.5*M.C(WingSine/36)),M.R(0-WingSine*mult)),.2)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(0,1.5,-1.5)*CF.A(0,M.R(0+7.5*M.C(WingSine/32)),M.R(135-WingSine*mult)),.2)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(0,1.5,-1.5)*CF.A(0,M.R(0+5*M.C(WingSine/39)),M.R(225-WingSine*mult)),.2)
end
 
WingAnims.LustFrench=function()
	LWP1W.C0 = LWP1W.C0:lerp(CF.N(0,1.5,0)*CF.A(0,M.R(0+2.5*M.C(WingSine/36)),M.R(0+WingSine))*CF.A(0,M.R(90),0)*CF.N(-2,0,0),.2)
	LWP2W.C0 = LWP2W.C0:lerp(CF.N(0,1.5,0)*CF.A(0,M.R(0+7.5*M.C(WingSine/32)),M.R(135+WingSine))*CF.A(0,M.R(90),0)*CF.N(-2,0,0),.2)
	LWP3W.C0 = LWP3W.C0:lerp(CF.N(0,1.5,0)*CF.A(0,M.R(0+5*M.C(WingSine/39)),M.R(225+WingSine))*CF.A(0,M.R(90),0)*CF.N(-2,0,0),.2)
 
	RWP1W.C0 = RWP1W.C0:lerp(CF.N(0,1.5,0)*CF.A(0,M.R(0+2.5*M.C(WingSine/36)),M.R(0-WingSine))*CF.A(0,M.R(90),0)*CF.N(-2,0,0),.2)
	RWP2W.C0 = RWP2W.C0:lerp(CF.N(0,1.5,0)*CF.A(0,M.R(0+7.5*M.C(WingSine/32)),M.R(135-WingSine))*CF.A(0,M.R(90),0)*CF.N(-2,0,0),.2)
	RWP3W.C0 = RWP3W.C0:lerp(CF.N(0,1.5,0)*CF.A(0,M.R(0+5*M.C(WingSine/39)),M.R(225-WingSine))*CF.A(0,M.R(90),0)*CF.N(-2,0,0),.2)
end
 
if(data.User==data.Local)then
	Player.Chatted:connect(function(m)
		if(m:sub(1,3) == "/e")then m=m:sub(4) end
		if(m:sub(1,5) == "play/")then
			getMode('Troubadour').Music=Playlist[m:sub(6)] or tonumber(m:sub(6)) or 0
			music.SoundId="rbxassetid://"..getMode('Troubadour').Music;
		elseif(m:sub(1,5) == "tpos/")then
			music.TimePosition = tonumber(m:sub(6)) or 0
		elseif(m:sub(1,6) == "pitch/")then
			music.Pitch = tonumber(m:sub(7)) or 0
			getMode('Troubadour').Pitch=music.Pitch
		end
	end)
end
 
 
while true do
	swait()
	ClickTimer=math.max(ClickTimer-1,0)
	if(ClickTimer<=0 and Combo~=1)then
		print('reset')
		Combo=1
	end
	Sine=Sine+Change
	hue=hue+1
	if(hue>360)then hue=1 end
	local hitfloor,posfloor = workspace:FindPartOnRayWithIgnoreList(Ray.new(Root.CFrame.p,((CFrame.new(Root.Position,Root.Position - Vector3.new(0,1,0))).lookVector).unit * (4)), {Effects,Char,workspace[Player.Name]})
	local Walking = (math.abs(Root.Velocity.x) > 1 or math.abs(Root.Velocity.z) > 1)
	local State = (Hum.PlatformStand and 'Paralyzed' or Hum.Sit and 'Sit' or (not hitfloor or hitfloor.CanCollide==false) and Root.Velocity.y < -1 and "Fall" or (not hitfloor or hitfloor.CanCollide==false) and Root.Velocity.y > 1 and "Jump" or hitfloor and Walking and "Walk" or hitfloor and "Idle")
	Hum.WalkSpeed = WalkSpeed
	local sidevec = math.clamp((Torso.Velocity*Torso.CFrame.rightVector).X+(Torso.Velocity*Torso.CFrame.rightVector).Z,-Hum.WalkSpeed,Hum.WalkSpeed)
	local forwardvec =  math.clamp((Torso.Velocity*Torso.CFrame.lookVector).X+(Torso.Velocity*Torso.CFrame.lookVector).Z,-Hum.WalkSpeed,Hum.WalkSpeed)
	local sidevelocity = sidevec/Hum.WalkSpeed
	local forwardvelocity = forwardvec/Hum.WalkSpeed
 
	local lhit,lpos = workspace:FindPartOnRayWithIgnoreList(Ray.new(LLeg.CFrame.p,((CFrame.new(LLeg.Position,LLeg.Position - Vector3.new(0,1,0))).lookVector).unit * (2)), {Effects,Char,workspace[Player.Name]})
	local rhit,rpos = workspace:FindPartOnRayWithIgnoreList(Ray.new(RLeg.CFrame.p,((CFrame.new(RLeg.Position,RLeg.Position - Vector3.new(0,1,0))).lookVector).unit * (2)), {Effects,Char,workspace[Player.Name]})
	if(Mode=='Troubadour' and IsVaporwave(getMode'Troubadour'.Music))then
		vaporwaveMode=true
		text.Text='Ｖａｐｏｒｗａｖｅ'
		WingAnim='NebG3'
	else
		if(Mode=='Troubadour')then
			text.Text='Troubadour'
			WingAnim=getMode'Troubadour'.WingAnim
		end
		vaporwaveMode=false
	end
 
	if(Mode~='Lust' and WingAnim and WingAnims[WingAnim])then
		WingAnims[WingAnim]()
	elseif(Mode=='Lust')then
		if(State=='Idle')then
			WingAnims.LustFrench()
		else
			WingAnims.NebG3(1)	
		end
	elseif(WingAnim and typeof(WingAnim)=='table' and WingAnims[WingAnim[1]])then
		local gay={unpack(WingAnim)};
		table.remove(gay,1)
		WingAnims[WingAnim[1]](unpack(gay))
	else
		WingAnims.NebG1()
	end
 
	if(Mode=='Troubadour' and NeutralAnims)then
		WingSine=WingSine+(0.1+music.PlaybackLoudness/300)
	else
		WingSine=WingSine+1
	end
 
	if(music)then
		if(Mode=='Troubadour')then
			local clr = Color3.fromHSV(hue/360,1,math.clamp(music.PlaybackLoudness/475,0,1))
			local clr2 = Color3.fromHSV(hue/360,1,math.clamp(music.PlaybackLoudness/950,0,1))
			text.TextColor3 = clr
			PrimaryColor = clr2
			for _,v in next, wingModel:GetDescendants() do
				if(v:IsA'BasePart')then
					v.Color = clr2
				elseif(v:IsA'Trail')then
					v.Color = ColorSequence.new(clr2)
				end
			end
		end
	end
 
	if(Mode=='The Big Black')then
		local pos = Head.Position
		local dist = (camera.CFrame.p-pos).magnitude
		local DropDist = 1
		local IneffectiveDist = 15
		local modifier = dist < DropDist and 1 or dist < IneffectiveDist and (0 - 1) / (IneffectiveDist - DropDist) * (dist - DropDist) + 1 or 0
	end
 
	if(Mode=='Troubadour' and data.User==data.Local)then
		Tween(camera,{FieldOfView=70-(music.PlaybackLoudness/20)},.2,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
	else
		Tween(camera,{FieldOfView=70},.2,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
	end
 
	if(State == 'Idle')then
		if(Mode=='Troubadour' and NeutralAnims and not vaporwaveMode)then Change = 0.1+music.PlaybackLoudness/200 else Change = 1 end
		if(Mode=='Achromatic')then
			local Alpha = .1
			if(NeutralAnims)then	
				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,0+.05*M.C(Sine/32),0)*CF.A(M.R(0+1*M.S(Sine/64)),M.R(5),0),Alpha)
				NK.C0 = NK.C0:lerp(NKC0*CF.A(M.R(-10-2.5*M.S(Sine/32)),M.R(-5),0),Alpha)
				LS.C0 = LS.C0:lerp(LSC0*CF.N(0,0+.05*M.S(Sine/32),0)*CF.A(0,M.R(5+5*M.C(Sine/32)),M.R(-10-5*M.C(Sine/32))),Alpha)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(0,0+.05*M.S(Sine/32),0)*CF.A(0,M.R(5-5*M.C(Sine/32)),M.R(10+5*M.C(Sine/32))),Alpha)
			end
			if(legAnims)then 
				if(NeutralAnims)then
					LH.C0 = LH.C0:lerp(LHC0*CF.N(0,0-.05*M.C(Sine/32),0),Alpha)
					RH.C0 = RH.C0:lerp(RHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(0,M.R(-5),0),Alpha)
				else
					LH.C0 = LH.C0:lerp(LHC0,Alpha)
					RH.C0 = RH.C0:lerp(RHC0,Alpha)
				end
			end
		elseif(Mode=='Iniquitous')then
			local Alpha = .1
			if(NeutralAnims)then	
				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,0+.05*M.C(Sine/32),0)*CF.A(M.R(0+3*M.S(Sine/64)),0,0),Alpha)
				if(M.RNG(1,45)==1)then
					NK.C0 = NK.C0:lerp(NKC0*CF.A(M.RRNG(-25,25),M.RRNG(-25,25),M.RRNG(-25,25)),.8)
				else
					NK.C0 = NK.C0:lerp(NKC0*CF.A(M.R(-10-2.5*M.S(Sine/32)),0,0),Alpha)
				end
				LS.C0 = LS.C0:lerp(LSC0*CF.N(.3,0+.05*M.S(Sine/32),.1)*CF.A(M.R(-35),M.R(5+2.5*M.C(Sine/32)),M.R(35-1.5*M.C(Sine/32))),Alpha)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(-.3,0+.05*M.S(Sine/32),.1)*CF.A(M.R(-25),M.R(5-2.5*M.C(Sine/32)),M.R(-35+1.5*M.C(Sine/32))),Alpha)
			end
			if(legAnims)then 
				if(NeutralAnims)then
					LH.C0 = LH.C0:lerp(LHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(0,0,M.R(-2.5)),Alpha)
					RH.C0 = RH.C0:lerp(RHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(0,0,M.R(2.5)),Alpha)
				else
					LH.C0 = LH.C0:lerp(LHC0*CF.A(0,0,M.R(-2.5)),Alpha)
					RH.C0 = RH.C0:lerp(RHC0*CF.A(0,0,M.R(2.5)),Alpha)
				end
			end
		elseif(Mode=='Mythical')then
			local Alpha = .1
			if(NeutralAnims)then	
				GotEffect{
					Lifetime=.5;
					Mesh={Type=Enum.MeshType.Sphere};
					CFrame=LArm.CFrame*CF.N(0,-1,0)*CF.A(M.RRNG(0,360),M.RRNG(0,360),M.RRNG(0,360));
					Color=BrickColor.new'Alder'.Color;
					Transparency={.5,1};
					Material=Enum.Material.Neon;
					Size=Vector3.new(.3,2,.3);
					EndSize=Vector3.new(.1,1,.1);
				}
				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,0+.05*M.C(Sine/32),0)*CF.A(M.R(0+1*M.S(Sine/64)),M.R(-15),0),Alpha)
				NK.C0 = NK.C0:lerp(NKC0*CF.A(M.R(-10-2.5*M.S(Sine/32)),M.R(15),0),Alpha)
				LS.C0 = LS.C0:lerp(LSC0*CF.N(.5,0+.05*M.S(Sine/32),-.5)*CF.A(M.R(15+1.5*M.C(Sine/51)),M.R(5+5*M.C(Sine/57)),M.R(85-5*M.C(Sine/46))),Alpha)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(-.3,0+.05*M.S(Sine/32),.1)*CF.A(M.R(-25),M.R(5-2.5*M.C(Sine/32)),M.R(-35+1.5*M.C(Sine/32))),Alpha)
			end
			if(legAnims)then 
				if(NeutralAnims)then
					LH.C0 = LH.C0:lerp(LHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(0,M.R(15),0),Alpha)
					RH.C0 = RH.C0:lerp(RHC0*CF.N(0,0-.05*M.C(Sine/32),0),Alpha)
				else
					LH.C0 = LH.C0:lerp(LHC0,Alpha)
					RH.C0 = RH.C0:lerp(RHC0,Alpha)
				end
			end
		elseif(Mode=='Ruined')then
			local Alpha = .1
			if(NeutralAnims)then	
				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,0+.05*M.C(Sine/32),0)*CF.A(M.R(-5+1*M.S(Sine/64)),M.R(-25),0),Alpha)
				if(M.RNG(1,25)==1)then
					NK.C0 = NK.C0:lerp(NKC0*CF.A(M.RRNG(-25,25),M.RRNG(-25,25),M.RRNG(-25,25)),.8)
				else
					NK.C0 = NK.C0:lerp(NKC0*CF.A(M.R(-10-2.5*M.S(Sine/32)),M.R(35),M.R(-10))*CF.A(M.RRNG(-5,5),M.RRNG(-5,5),M.RRNG(-5,5)),Alpha)
				end
				LS.C0 = LS.C0:lerp(LSC0*CF.N(0,0+.05*M.S(Sine/32),0)*CF.A(0,M.R(5+5*M.C(Sine/32)),M.R(-10-5*M.C(Sine/32))),Alpha)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(-.1,0+.05*M.S(Sine/32),0)*CF.A(M.R(175),M.R(5-2.5*M.C(Sine/32)),M.R(-25-1.5*M.C(Sine/32))),Alpha)
			end
			if(legAnims)then 
				if(NeutralAnims)then
					LH.C0 = LH.C0:lerp(LHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(M.R(-10),M.R(25),0),Alpha)
					RH.C0 = RH.C0:lerp(RHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(M.R(5),0,0),Alpha)
				else
					LH.C0 = LH.C0:lerp(LHC0,Alpha)
					RH.C0 = RH.C0:lerp(RHC0,Alpha)
				end
			end
		--[[elseif(Mode=='Atramentous')then
			local Alpha = .1
			if(NeutralAnims)then	
				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(-.2+.4*M.C(Sine/39),.5+.2*M.C(Sine/32),0)*CF.A(M.R(-2+5*M.S(Sine/58)),M.R(-15+5*M.C(Sine/42)),0),Alpha)
				NK.C0 = NK.C0:lerp(NKC0*CF.A(M.R(-7-2.5*M.S(Sine/32)),M.R(15),0),Alpha)
				LS.C0 = LS.C0:lerp(LSC0*CF.N(0,0+.05*M.S(Sine/32),0)*CF.A(0,0,M.R(-15+5*M.S(Sine/32))),Alpha)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(0,0+.05*M.S(Sine/32),0)*CF.A(0,0,M.R(15-5*M.S(Sine/32))),Alpha)
			end
			if(legAnims)then 
				if(NeutralAnims)then
					LH.C0 = LH.C0:lerp(LHC0*CF.N(0,.5,-.2)*CF.A(0,0,M.R(-5)),Alpha)
					RH.C0 = RH.C0:lerp(RHC0*CF.A(0,0,M.R(5)),Alpha)
				else
					LH.C0 = LH.C0:lerp(LHC0,Alpha)
					RH.C0 = RH.C0:lerp(RHC0,Alpha)
				end
			end]]
		elseif(Mode=='Atramentous')then
			local Alpha = .1
			if(NeutralAnims)then	
				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,0+.05*M.C(Sine/32),0)*CF.A(M.R(-25+1*M.S(Sine/64)),0,0),Alpha)
				NK.C0 = NK.C0:lerp(NKC0*CF.A(M.R(-10-2.5*M.S(Sine/32)),M.R(-5),0),Alpha)
				LS.C0 = LS.C0:lerp(LSC0*CF.N(0,0+.05*M.S(Sine/32),0)*CF.A(M.R(25),M.R(5+5*M.C(Sine/32)),M.R(-10-5*M.C(Sine/32))),Alpha)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(0,0+.05*M.S(Sine/32),0)*CF.A(M.R(25),M.R(5-5*M.C(Sine/32)),M.R(10+5*M.C(Sine/32))),Alpha)
			end
			if(legAnims)then 
				if(NeutralAnims)then
					LH.C0 = LH.C0:lerp(LHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(M.R(25),0,M.R(-3)),Alpha)
					RH.C0 = RH.C0:lerp(RHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(M.R(25),0,M.R(3)),Alpha)
				else
					LH.C0 = LH.C0:lerp(LHC0,Alpha)
					RH.C0 = RH.C0:lerp(RHC0,Alpha)
				end
			end
		elseif(Mode=='Subzero')then
			local Alpha = .1
			if(NeutralAnims)then	
				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,0+.05*M.C(Sine/32),0)*CF.A(0,M.R(28),0),Alpha)
				NK.C0 = NK.C0:lerp(NKC0*CF.A(M.R(-7-2.5*M.S(Sine/32)),M.R(-28),0),Alpha)
				LS.C0 = LS.C0:lerp(LSC0*CF.N(.5,-.1+.05*M.S(Sine/32),-.8)*CF.A(M.R(13),M.R(-12),M.R(104-2*M.S(Sine/36))),Alpha)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(-.5,0+.05*M.S(Sine/32),-.6)*CF.A(M.R(-17),M.R(-20),M.R(-79+1*M.S(Sine/36))),Alpha)
			end
			if(legAnims)then 
				if(NeutralAnims)then
					LH.C0 = LH.C0:lerp(LHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(0,0,M.R(-1)),Alpha)
					RH.C0 = RH.C0:lerp(RHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(M.R(4),M.R(-28),M.R(8)),Alpha)
				else
					LH.C0 = LH.C0:lerp(LHC0,Alpha)
					RH.C0 = RH.C0:lerp(RHC0,Alpha)
				end
			end
		elseif(Mode=='Troubadour')then
			if(vaporwaveMode)then
			  	local Alpha = .1
				if(NeutralAnims)then
					RJ.C0 = RJ.C0:lerp(CF.N(0,-0.2-.1*M.S(Sine/36),0.6)*CF.A(M.R(74.3+2.5*M.C(Sine/36)),M.R(0),M.R(0)),Alpha)
					LS.C0 = LS.C0:lerp(CF.N(-1,0.8,0)*CF.A(M.R(11.4-5*M.C(Sine/42)),M.R(-3.3),M.R(137.5)),Alpha)
					RS.C0 = RS.C0:lerp(CF.N(1,0.9,-0.1)*CF.A(M.R(13.7-5*M.C(Sine/42)),M.R(7.7),M.R(-136.2)),Alpha)
					NK.C0 = NK.C0:lerp(CF.N(0,1.4,-0.3)*CF.A(M.R(-16.6-5*M.C(Sine/42)),M.R(0),M.R(0)),Alpha)
					if(legAnims)then
						LH.C0 = LH.C0:lerp(CF.N(-0.7,-1,0)*CF.A(M.R(37.2+10*M.C(Sine/36)),M.R(0),M.R(24)),Alpha)
						RH.C0 = RH.C0:lerp(CF.N(0.8,-1.1,-0.1)*CF.A(M.R(5.9+5*M.C(Sine/36)),M.R(3.5),M.R(-43.9)),Alpha)
					end
				elseif(legAnims)then
					LH.C0 = LH.C0:lerp(LHC0,Alpha)
					RH.C0 = RH.C0:lerp(RHC0,Alpha)
				end
			else
				local Alpha = .3
				if(NeutralAnims)then	
					RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,0+.05*M.C(Sine/20)+(music.PlaybackLoudness/5000),0)*CF.A(M.R(0+1*M.S(Sine/64)),M.R(35),0),Alpha)
					NK.C0 = NK.C0:lerp(NKC0*CF.A(M.R(0+1*M.S(Sine/24)),M.R(-35),0),Alpha)
					LS.C0 = LS.C0:lerp(LSC0*CF.A(0,0,M.R(-15+10*M.C(Sine/20))),Alpha)
					RS.C0 = RS.C0:lerp(RSC0*CF.A(M.R(75-(music.PlaybackLoudness/7.5)),M.R(5),M.R(35)),Alpha)
				end
				if(legAnims)then 
					if(NeutralAnims)then
						LH.C0 = LH.C0:lerp(LHC0*CF.N(0,-.05*M.C(Sine/20)-(music.PlaybackLoudness/5000),0)*CF.A(0,M.R(25),0),Alpha)
						RH.C0 = RH.C0:lerp(RHC0*CF.N(0,-.05*M.C(Sine/20)-(music.PlaybackLoudness/5000),0),Alpha)
					else
						LH.C0 = LH.C0:lerp(LHC0,Alpha)
						RH.C0 = RH.C0:lerp(RHC0,Alpha)
					end
				end
			end
		elseif(Mode=='Infectious')then
			local Alpha = .1
			if(NeutralAnims)then	
				GotEffect{
					Lifetime=.2;
					Mesh={Type=Enum.MeshType.Sphere};
					CFrame=LArm.CFrame*CF.N(0,-1,0)*CF.A(M.RRNG(0,360),M.RRNG(0,360),M.RRNG(0,360));
					Color=BrickColor.new'Dark indigo'.Color;
					Transparency={0,1};
					Material=Enum.Material.Neon;
					Size=Vector3.new(.5,1,.5);
					EndSize=Vector3.new(.1,3,.1);
				}
				GotEffect{
					Lifetime=.2;
					Mesh={Type=Enum.MeshType.Sphere};
					CFrame=RArm.CFrame*CF.N(0,-1,0)*CF.A(M.RRNG(0,360),M.RRNG(0,360),M.RRNG(0,360));
					Color=BrickColor.new'Dark indigo'.Color;
					Transparency={0,1};
					Material=Enum.Material.Neon;
					Size=Vector3.new(.5,1,.5);
					EndSize=Vector3.new(.1,3,.1);
				}
				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,0+.05*M.C(Sine/32),0)*CF.A(M.R(0+1*M.S(Sine/64)),M.R(-15),0),Alpha)
				NK.C0 = NK.C0:lerp(NKC0*CF.A(M.R(-10-2.5*M.S(Sine/32)),M.R(15),0),Alpha)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(-.5,0+.05*M.S(Sine/32),-.4)*CF.A(M.R(25),M.R(5-2.5*M.C(Sine/32)),M.R(-65+1.5*M.C(Sine/32))),Alpha)
				LS.C0 = LS.C0:lerp(LSC0*CF.N(0,0+.05*M.S(Sine/32),0)*CF.A(0,M.R(5-5*M.C(Sine/32)),M.R(-10-5*M.C(Sine/32))),Alpha)
			end
			if(legAnims)then 
				if(NeutralAnims)then
					LH.C0 = LH.C0:lerp(LHC0*CF.N(0,0-.05*M.C(Sine/32),0)*CF.A(0,M.R(15),0),Alpha)
					RH.C0 = RH.C0:lerp(RHC0*CF.N(0,0-.05*M.C(Sine/32),0),Alpha)
				else
					LH.C0 = LH.C0:lerp(LHC0,Alpha)
					RH.C0 = RH.C0:lerp(RHC0,Alpha)
				end
			end
		elseif(Mode=='Love')then
			local Alpha = .1
			if(NeutralAnims)then	
				RJ.C0 = RJ.C0:lerp(CF.N(0,0,0)*CF.A(0,0,M.R(0+5*M.C(Sine/16))),Alpha)
				NK.C0 = NK.C0:lerp(NKC0*CF.A(0,0,-M.R(0+5*M.C(Sine/16))),Alpha)
				LS.C0 = LS.C0:lerp(LSC0*CF.N(0,-.15,0)*CF.A(M.R(15),0,M.R(20)),Alpha)
				RS.C0 = RS.C0:lerp(RSC0*CF.A(0,0,M.R(5+5*M.S(Sine/16))),Alpha)
			end
			if(legAnims)then 
				if(NeutralAnims)then
					LH.C0 = LH.C0:lerp(LHC0*CF.A(0,0,-M.R(0+5*M.C(Sine/16)))*CF.A(M.R(-15),M.R(25),0),Alpha)
					RH.C0 = RH.C0:lerp(RHC0*CF.A(0,0,-M.R(0+5*M.C(Sine/16))),Alpha)
				else
					LH.C0 = LH.C0:lerp(LHC0,Alpha)
					RH.C0 = RH.C0:lerp(RHC0,Alpha)
				end
			end
		elseif(Mode=='The Big Black')then
			local Alpha = .1
			if(NeutralAnims)then
				GotEffect{
					Lifetime=.5;
					Mesh={Type=Enum.MeshType.Sphere};
					CFrame=RArm.CFrame*CF.N(0,-1,0)*CF.A(M.RRNG(0,360),M.RRNG(0,360),M.RRNG(0,360));
					Color=BrickColor.new'Black'.Color;
					Transparency={0,1};
					Material=Enum.Material.Neon;
					Size=Vector3.new(.5,1,.5);
					EndSize=Vector3.new(.1,3,.1);
				}
				RJ.C0 = RJ.C0:lerp(CF.N(0,0+.05*M.C(Sine/32),0.2)*CF.A(M.R(15.5),M.R(20.8),M.R(0)),Alpha)
				LS.C0 = LS.C0:lerp(CF.N(-0.9,0.4,-0.7)*CF.A(M.R(121.8),M.R(14.6),M.R(84.8))*CF.A(M.R(0+3*M.S(Sine/32)),0,0),Alpha)
				RS.C0 = RS.C0:lerp(CF.N(1.3,0.3,-0.1)*CF.A(M.R(40+5*M.C(Sine/44)),M.R(-11.6),M.R(65.5+2.5*M.C(Sine/36))),Alpha)
				if(M.RNG(1,45)==1)then
					NK.C0 = NK.C0:lerp(NKC0*CF.A(M.RRNG(-25,25),M.RRNG(-25,25),M.RRNG(-25,25)),.8)
				else
					NK.C0 = NK.C0:lerp(CF.N(0,1.5,-0.2)*CF.A(M.R(-15.6),M.R(-20.1),M.R(-5.5))*CF.A(M.R(0+1.5*M.S(Sine/32)),0,0),Alpha)
				end
				if(legAnims)then
					LH.C0 = LH.C0:lerp(CF.N(-0.6,-1-.05*M.C(Sine/32),0.1)*CF.A(M.R(-27.6),M.R(0),M.R(13.8)),Alpha)
					RH.C0 = RH.C0:lerp(CF.N(0.6,-1.1-.05*M.C(Sine/32),-0.1)*CF.A(M.R(-16.5),M.R(-20),M.R(-5.8)),Alpha)
				end
			elseif(legAnims)then
				LH.C0 = LH.C0:lerp(LHC0,Alpha)
				RH.C0 = RH.C0:lerp(RHC0,Alpha)
			end
		elseif(Mode=='Legendary')then
			local Alpha = .1
			if(NeutralAnims)then
				RJ.C0 = RJ.C0:lerp(CF.N(0,4.8+.2*M.C(Sine/24),0)*CF.A(M.R(30+5*M.S(Sine/24)),M.R(16.7),M.R(-9.4)),Alpha)
				LS.C0 = LS.C0:lerp(CF.N(-1.1,1,0.2)*CF.A(M.R(173.3+1*M.S(Sine/28)),M.R(19.9+2*M.S(Sine/28)),M.R(38.7)),Alpha)
				RS.C0 = RS.C0:lerp(CF.N(0.7,0.3,-0.6)*CF.A(M.R(46.8+1*M.S(Sine/28)),M.R(6.4+2*M.S(Sine/28)),M.R(-79.6)),Alpha)
				NK.C0 = NK.C0:lerp(CF.N(0,1.4,-0.5)*CF.A(M.R(-40-5*M.S(Sine/24)),M.R(-18.7),M.R(-3.7)),Alpha)
				if(legAnims)then
					LH.C0 = LH.C0:lerp(CF.N(-0.5,-1,0)*CF.A(M.R(1.9+7.5*M.S(Sine/24)),M.R(19.2),M.R(-5.7)),Alpha)
					RH.C0 = RH.C0:lerp(CF.N(0.4,-1,-0.8)*CF.A(M.R(-63.8+7.5*M.S(Sine/24)),M.R(-15),M.R(8.3)),Alpha)
				end
			elseif(legAnims)then
				LH.C0 = LH.C0:lerp(LHC0,Alpha)
				RH.C0 = RH.C0:lerp(RHC0,Alpha)
			end
			elseif(Mode=='Lust')then
				local Alpha = .1
				if(NeutralAnims)then
					RJ.C0 = RJ.C0:lerp(CF.N(0,0.7+.1*M.C(Sine/36),0)*CF.A(M.R(0),M.R(0),M.R(-90-2.5*M.S(Sine/36))),Alpha)
					LS.C0 = LS.C0:lerp(CF.N(-1.2,0.1,0.1)*CF.A(M.R(23),M.R(16.5),M.R(20.6)),Alpha)
					RS.C0 = RS.C0:lerp(CF.N(0.8,1,-0.4)*CF.A(M.R(-162),M.R(-11.2),M.R(-22.6)),Alpha)
					NK.C0 = NK.C0:lerp(CF.N(-0.2,1.4,0)*CF.A(M.R(0),M.R(0),M.R(48.9)),Alpha)
					if(legAnims)then
						LH.C0 = LH.C0:lerp(CF.N(-0.9,-1.1,-0.2)*CF.A(M.R(-19.3),M.R(6.5),M.R(54.3-7.5*M.S(Sine/36))),Alpha)
						RH.C0 = RH.C0:lerp(CF.N(0.4,-0.9,0)*CF.A(M.R(0),M.R(0),M.R(25.9-7.5*M.S(Sine/36))),Alpha)
					end
			elseif(legAnims)then
				LH.C0 = LH.C0:lerp(LHC0,Alpha)
				RH.C0 = RH.C0:lerp(RHC0,Alpha)
			end
		end
    elseif(State == 'Walk')then
		--[[if(Mode=='Atramentous')then
			local Alpha = .1
  			if(NeutralAnims)then
 				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(-.2+.4*M.C(Sine/39),.5+.2*M.C(Sine/32),0)*CF.A(M.R(-85+5*M.S(Sine/58)),M.R(0+5*M.C(Sine/42)),0),Alpha)
 				LS.C0 = LS.C0:lerp(CFrame.new(-1.50198829, 0.580981374, 0.000380858371, 0.963434994, 0.267942399, 1.75953949e-06, -0.267942399, 0.963434994, 5.1856041e-06, -3.05473804e-07, -5.48362732e-06, 1)*CF.A(0,0,M.R(0+5*M.S(Sine/32))),Alpha)
  				RS.C0 = RS.C0:lerp(CFrame.new(1.54895508, 0.519735038, 0.000380946265, 0.98034811, -0.197275475, -1.24170782e-07, 0.19727549, 0.980348051, 9.53674316e-07, -5.96046448e-08, -9.23871994e-07, 1)*CF.A(0,0,M.R(0-5*M.S(Sine/32))),Alpha)
  				NK.C0 = NK.C0:lerp(NKC0*CF.A(M.R(65-5*M.S(Sine/58)),0,0),Alpha)
			end
			if(legAnims)then
				LH.C0 = LH.C0:lerp(CFrame.new(-0.49666214, -0.990924835, 0.00763010979, 1, 0, 0, 0, 1, 0, 0, 0, 1),Alpha)
				RH.C0 = RH.C0:lerp(CFrame.new(0.498336792, -0.303280592, -0.883536756, 1, 0, 0, 0, 0.886996508, 0.461776346, 0, -0.461776316, 0.886996448),Alpha)
			end
		else]]
 
			local wsVal = 4
			local Alpha = .2
			if(Mode=='Subzero')then Change=.3 elseif(Mode=='The Big Black' or Mode=='Legendary')then Change=1 else Change=.5 end
			if(NeutralAnims)then
				RJ.C0 = RJ.C0:lerp(RJC0*CF.N(0,.05+Change/4*M.C(Sine/(wsVal/2)),0)*CF.A(M.R(-(Change*20)-movement/20*M.C(Sine/(wsVal/2)))*forwardvelocity,M.R(0+5*M.C(Sine/wsVal)),M.R(-(Change*20)-movement/20*M.C(Sine/(wsVal/2)))*sidevelocity+M.R(0-1*M.C(Sine/wsVal))),Alpha)
				NK.C0 = NK.C0:lerp(NKC0,Alpha)
				LS.C0 = LS.C0:lerp(LSC0*CF.N(0,0,0)*CF.A(M.R(0+55*(movement/8)*M.S(Sine/wsVal))*forwardvelocity,0,0),Alpha)
				RS.C0 = RS.C0:lerp(RSC0*CF.N(0,0,0)*CF.A(M.R(0-55*(movement/8)*M.S(Sine/wsVal))*forwardvelocity,0,0),Alpha)
			end
			if(legAnims)then 
				LH.C0 = LH.C0:lerp(LHC0*CF.N(0,0-movement/15*M.C(Sine/wsVal)/2,(-.1+movement/15*M.C(Sine/wsVal))*(.5+.5*forwardvelocity))*CF.A((M.R(-10*forwardvelocity+Change*5-movement*M.C(Sine/wsVal))+-(movement/10)*M.S(Sine/wsVal))*forwardvelocity,0,(M.R(Change*5-movement*M.C(Sine/wsVal))+-(movement/10)*M.S(Sine/wsVal))*(sidevec/(Hum.WalkSpeed*2))),Alpha)
				RH.C0 = RH.C0:lerp(RHC0*CF.N(0,0+movement/15*M.C(Sine/wsVal)/2,(-.1-movement/15*M.C(Sine/wsVal))*(.5+.5*forwardvelocity))*CF.A((M.R(-10*forwardvelocity+Change*5+movement*M.C(Sine/wsVal))+(movement/10)*M.S(Sine/wsVal))*forwardvelocity,0,(M.R(Change*5+movement*M.C(Sine/wsVal))+(movement/10)*M.S(Sine/wsVal))*(sidevec/(Hum.WalkSpeed*2))),Alpha)
				local footstepIds = {141491460,141491460}
				if(lhit and lhit.CanCollide and footstepSounds[lhit.Material])then
					if(lhit.Material==Enum.Material.Sand and lhit.Color.r*255>=160 and lhit.Color.g*255>=160 and lhit.Color.b*255>=160)then
						footstepIds[1] = footstepSounds[Enum.Material.Snow]
					else
						footstepIds[1] = footstepSounds[lhit.Material]
					end
				end
 
				if(rhit and rhit.CanCollide and footstepSounds[rhit.Material])then
					if(rhit.Material==Enum.Material.Sand and rhit.Color.r*255>=160 and rhit.Color.g*255>=160 and rhit.Color.b*255>=160)then
						footstepIds[2] = footstepSounds[Enum.Material.Snow]
					else
						footstepIds[2] = footstepSounds[rhit.Material]
					end
				end
 
 
				if(M.C(Sine/wsVal)/2>=.2 and footsound==0 and lhit)then
					local step = Part(Effects,lhit.Color,lhit.Material,V3.N(1,.1,1),CF.N(lpos),true,false)
					step.Transparency=(footstepIds[1]==footstepSounds[Enum.Material.Snow] and 0 or 1)
					local snd = Soond(step,footstepIds[1],M.RNG(80,100)/100,3,false,true,true)
					footsound=1
					S.Debris:AddItem(step,snd.TimeLength+2)
				elseif(M.C(Sine/wsVal)/2<=-.2 and footsound==1 and rhit)then
					local step = Part(Effects,rhit.Color,rhit.Material,V3.N(1,.1,1),CF.N(rpos),true,false)
					step.Transparency=(footstepIds[2]==footstepSounds[Enum.Material.Snow] and 0 or 1)
					local snd = Soond(step,footstepIds[2],M.RNG(80,100)/100,3,false,true,true)
					footsound=0
					S.Debris:AddItem(step,snd.TimeLength+2)
				end
			end
        --end
	elseif(State == 'Jump')then
		local Alpha = .1
		local idk = math.min(math.max(Root.Velocity.Y/50,-M.R(90)),M.R(90))
		if(NeutralAnims)then
			LS.C0 = LS.C0:lerp(LSC0*CF.A(M.R(-5),0,M.R(-90)),Alpha)
			RS.C0 = RS.C0:lerp(RSC0*CF.A(M.R(-5),0,M.R(90)),Alpha)
			RJ.C0 = RJ.C0:lerp(RJC0*CF.A(math.min(math.max(Root.Velocity.Y/100,-M.R(45)),M.R(45)),0,0),Alpha)
			NK.C0 = NK.C0:lerp(NKC0*CF.A(math.min(math.max(Root.Velocity.Y/100,-M.R(45)),M.R(45)),0,0),Alpha)
		end
		if(legAnims)then 
			LH.C0 = LH.C0:lerp(LHC0*CF.A(0,0,M.R(-5)),Alpha)
			RH.C0 = RH.C0:lerp(RHC0*CF.N(0,1,-1)*CF.A(M.R(-5),0,M.R(5)),Alpha)
		end
	elseif(State == 'Fall')then
		local Alpha = .1
		local idk = math.min(math.max(Root.Velocity.Y/50,-M.R(90)),M.R(90))
		if(NeutralAnims)then
			LS.C0 = LS.C0:lerp(LSC0*CF.A(M.R(-5),0,M.R(-90)+idk),Alpha)
			RS.C0 = RS.C0:lerp(RSC0*CF.A(M.R(-5),0,M.R(90)-idk),Alpha)
			RJ.C0 = RJ.C0:lerp(RJC0*CF.A(math.min(math.max(Root.Velocity.Y/100,-M.R(45)),M.R(45)),0,0),Alpha)
			NK.C0 = NK.C0:lerp(NKC0*CF.A(math.min(math.max(Root.Velocity.Y/100,-M.R(45)),M.R(45)),0,0),Alpha)
		end
		if(legAnims)then 
			LH.C0 = LH.C0:lerp(LHC0*CF.A(0,0,M.R(-5)),Alpha)
			RH.C0 = RH.C0:lerp(RHC0*CF.N(0,1,-1)*CF.A(M.R(-5),0,M.R(5)),Alpha)
		end
	elseif(State == 'Paralyzed')then
		local Alpha = .1
		if(NeutralAnims)then
			LS.C0 = LS.C0:lerp(LSC0,Alpha)
			RS.C0 = RS.C0:lerp(RSC0,Alpha)
			RJ.C0 = RJ.C0:lerp(RJC0,Alpha)
			NK.C0 = NK.C0:lerp(NKC0,Alpha)
		end
		if(legAnims)then 
			LH.C0 = LH.C0:lerp(LHC0,Alpha)
			RH.C0 = RH.C0:lerp(RHC0,Alpha)
		end
	elseif(State == 'Sit')then
 
	end
	if(data.User==data.Local)then
		local syncStuff={
			NeutralAnims;
			legAnims;
			{NK.C0,RJ.C0,RH.C0,RS.C0,LH.C0,LS.C0};
			{NK.C1,RJ.C1,RH.C1,RS.C1,LH.C1,LS.C1};
			Sine;
			movement;
			walking;	
			Change;
			--// OPTIONAL SYNC \\--
			MusicMode;
			(music and music.TimePosition or 0);
			(music and music.Pitch or 1);
			WingSine;
			getMode('Troubadour');
			Mode;
			hue;
		}
	end
end
 