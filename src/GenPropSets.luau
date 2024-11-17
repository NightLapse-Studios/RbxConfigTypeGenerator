--!strict
--!native

local ApiTools = require("ApiTools")
local ApiTypes = require("ApiTypes")
local Runtime = require("Runtime")

local function format_1(s: string, r: string): string
	return string.format(s, r)
end

local function format_2(s: string, r: string): string
	return string.format(s, r, r)
end

local function format_3(s: string, r: string): string
	return string.format(s, r, r, r)
end

local function format_4(s: string, r: string): string
	return string.format(s, r, r, r, r)
end

local VALUETYPE_FORMATTERS: { [string]: { [string]: typeof(format_1)}} = {
    Class = {
        Attachment = format_1,
        BasePart = format_1,
        Camera = format_1,
        ControllerBase = format_1,
        ControllerSensor = format_1,
        GuiObject = format_1,
        Hole = format_1,
        Humanoid = format_1,
        Instance = format_1,
        LocalizationTable = format_1,
        Model = format_1,
        PVInstance = format_1,
        Player = format_1,
        SkateboardController = format_1,
        SoundGroup = format_1,
        SpawnLocation = format_1,
        StyleSheet = format_1,
        Team = format_1,
    },
    DataType = {
        Axes = format_2,
        BrickColor = format_1,
        CFrame = format_1,
        Color3 = format_2,
        ColorSequence = format_4,
        Content = format_1,
        Faces = format_3,
        Font = format_2,
        NumberRange = format_2,
        NumberSequence = format_4,
        PhysicalProperties = format_2,
        ProtectedString = format_1,
        Ray = format_2,
        Rect = format_3,
        UDim = format_2,
        UDim2 = format_2,
        Vector2 = format_2,
        Vector3 = format_2,
    },
    Enum = {
        AccessModifierType = format_1,
        AccessoryType = format_1,
        ActuatorRelativeTo = format_1,
        ActuatorType = format_1,
        AdShape = format_1,
        AdUnitStatus = format_1,
        AdornCullingMode = format_1,
        AlignType = format_1,
        AlphaMode = format_1,
        AnimationPriority = format_1,
        ApplyStrokeMode = format_1,
        AspectType = format_1,
        AudioSubType = format_1,
        AutomaticSize = format_1,
        BinType = format_1,
        BodyPart = format_1,
        BorderMode = format_1,
        ButtonStyle = format_1,
        CameraMode = format_1,
        CameraType = format_1,
        ChatMode = format_1,
        CollisionFidelity = format_1,
        DevCameraOcclusionMode = format_1,
        DevComputerCameraMovementMode = format_1,
        DevComputerMovementMode = format_1,
        DevTouchCameraMovementMode = format_1,
        DevTouchMovementMode = format_1,
        DialogBehaviorType = format_1,
        DialogPurpose = format_1,
        DialogTone = format_1,
        DominantAxis = format_1,
        DragDetectorDragStyle = format_1,
        DragDetectorResponseStyle = format_1,
        EasingDirection = format_1,
        EasingStyle = format_1,
        ElasticBehavior = format_1,
        ExplosionType = format_1,
        FieldOfViewMode = format_1,
        FillDirection = format_1,
        Font = format_1,
        FontSize = format_1,
        ForceLimitMode = format_1,
        FormFactor = format_1,
        FrameStyle = format_1,
        GuiState = format_1,
        HandlesStyle = format_1,
        HighlightDepthMode = format_1,
        HorizontalAlignment = format_1,
        HumanoidCollisionType = format_1,
        HumanoidDisplayDistanceType = format_1,
        HumanoidHealthDisplayType = format_1,
        HumanoidRigType = format_1,
        IKControlType = format_1,
        InOut = format_1,
        InputType = format_1,
        KeyCode = format_1,
        LeftRight = format_1,
        LineJoinMode = format_1,
        Material = format_1,
        MaterialPattern = format_1,
        MembershipType = format_1,
        MeshType = format_1,
        ModelLevelOfDetail = format_1,
        ModelStreamingMode = format_1,
        NameOcclusion = format_1,
        NormalId = format_1,
        OrientationAlignmentMode = format_1,
        PartType = format_1,
        ParticleEmitterShape = format_1,
        ParticleEmitterShapeInOut = format_1,
        ParticleEmitterShapeStyle = format_1,
        ParticleFlipbookLayout = format_1,
        ParticleFlipbookMode = format_1,
        ParticleOrientation = format_1,
        PlaybackState = format_1,
        PoseEasingDirection = format_1,
        PoseEasingStyle = format_1,
        PositionAlignmentMode = format_1,
        ProximityPromptExclusivity = format_1,
        ProximityPromptStyle = format_1,
        RenderFidelity = format_1,
        RenderingTestComparisonMethod = format_1,
        ResamplerMode = format_1,
        ReservedHighlightId = format_1,
        ReturnKeyType = format_1,
        RollOffMode = format_1,
        RotationOrder = format_1,
        RunContext = format_1,
        SafeAreaCompatibility = format_1,
        ScaleType = format_1,
        ScreenInsets = format_1,
        ScrollBarInset = format_1,
        ScrollingDirection = format_1,
        SelectionBehavior = format_1,
        SensorMode = format_1,
        SensorUpdateType = format_1,
        ServiceVisibility = format_1,
        SizeConstraint = format_1,
        SortOrder = format_1,
        StartCorner = format_1,
        Style = format_1,
        SurfaceGuiShape = format_1,
        SurfaceGuiSizingMode = format_1,
        SurfaceType = format_1,
        TableMajorAxis = format_1,
        TerrainFace = format_1,
        TextDirection = format_1,
        TextInputType = format_1,
        TextTruncate = format_1,
        TextXAlignment = format_1,
        TextYAlignment = format_1,
        TextureMode = format_1,
        TopBottom = format_1,
        UsageContext = format_1,
        VelocityConstraintMode = format_1,
        VerticalAlignment = format_1,
        VerticalScrollBarPosition = format_1,
        WrapLayerAutoSkin = format_1,
        WrapLayerDebugMode = format_1,
        WrapTargetDebugMode = format_1,
        ZIndexBehavior = format_1,
    },
    Primitive = {
        bool = format_1,
        double = format_1,
        float = format_1,
        int = format_1,
        int64 = format_1,
        string = format_1,
    },
}

local VALUETYPE_CTOR_MAP: { [string]: { [string]: string}} = {
    Class = {
        Attachment = [[function(self, a1: Attachment)
	self.props.%s = a1
	return self
end]],
        BasePart = [[function(self, a1: BasePart)
	self.props.%s = a1
	return self
end]],
        Camera = [[function(self, a1: Camera)
	self.props.%s = a1
	return self
end]],
        ControllerBase = [[function(self, a1: ControllerBase)
	self.props.%s = a1
	return self
end]],
        ControllerSensor = [[function(self, a1: ControllerSensor)
	self.props.%s = a1
	return self
end]],
        GuiObject = [[function(self, a1: GuiObject)
	self.props.%s = a1
	return self
end]],
        Hole = [[function(self, a1: Hole)
	self.props.%s = a1
	return self
end]],
        Humanoid = [[function(self, a1: Humanoid)
	self.props.%s = a1
	return self
end]],
        Instance = [[function(self, a1: Instance)
	self.props.%s = a1
	return self
end]],
        LocalizationTable = [[function(self, a1: LocalizationTable)
	self.props.%s = a1
	return self
end]],
        Model = [[function(self, a1: Model)
	self.props.%s = a1
	return self
end]],
        PVInstance = [[function(self, a1: PVInstance)
	self.props.%s = a1
	return self
end]],
        Player = [[function(self, a1: Player)
	self.props.%s = a1
	return self
end]],
        SkateboardController = [[function(self, a1: SkateboardController)
	self.props.%s = a1
	return self
end]],
        SoundGroup = [[function(self, a1: SoundGroup)
	self.props.%s = a1
	return self
end]],
        SpawnLocation = [[function(self, a1: SpawnLocation)
	self.props.%s = a1
	return self
end]],
        StyleSheet = [[function(self, a1: StyleSheet)
	self.props.%s = a1
	return self
end]],
        Team = [[function(self, a1: Team)
	self.props.%s = a1
	return self
end]],
    },
    DataType = {
        Axes = [[function(self, a1, ...)
	if typeof(a1) == "Axes" or typeof(a1) == "function" then
		self.props.%s = a1
	else
		assert(typeof(a1) == "EnumItem")
		self.props.%s = Axes.new(a1, ...)
	end

	return self
end]],
        BrickColor = [[function(self, a1)
	assert(typeof(a1) == "BrickColor" or typeof(a1) == "function")
	self.props.%s = a1

	return self
end]],
        CFrame = [[function(self, a1)
	assert(typeof(a1) == "CFrame" or typeof(a1) == "function")
	self.props.%s = a1

	return self
end]],
        Color3 = [[function(self, a1, a2, a3)
	if typeof(a1) == "number" then
		self.props.%s = Color3.new(a1, a2)
	elseif typeof(a1) == "Color3" or typeof(a1) == "function" then
		self.props.%s = a1
	end

	return self
end]],
        ColorSequence = [[function(self, a1, a2)
	if typeof(a2) == "Color3" then
		self.props.%s = ColorSequence.new(a1, a2)
	elseif typeof(a1) == "Color3" then
		self.props.%s = ColorSequence.new(a1)
	elseif typeof(a1) == "table" then
		self.props.%s = ColorSequence.new(a1)
	else
		assert(typeof(a1) == "ColorSequence" or typeof(a1) == "function")
		self.proprs.%s = a1
	end

	return self
end]],
        Content = [[function(self, a1)
	assert(typeof(a1) == "string" or typeof(a1) == "function")
	self.props.%s = a1

	return self
end]],
        Faces = [[function(self, a1, ...)
	if typeof(a1) == "Faces" then
		self.props.%s = a1
	elseif typeof(a1) == "EnumItem" then
		self.props.%s = Faces.new(a1, ...)
	else
		assert(typeof(a1) == "function")
		self.props.%s = a1
	end

	return self
end]],
        Font = [[function(self, a1, a2, a3)
	if typeof(a1) == "string" then
		assert(typeof(a2) == "EnumItem")
		assert(typeof(a3) == "EnumItem")
		self.props.%s = Font.new(a1, a2, a3)
	else
		assert(typeof(a1) == "Font" or typeof(a1) == "function")
		self.props.%s = a1
	end

	return self
end]],
        NumberRange = [[function(self, a1, a2, a3, a4, a5)
	if typeof(a4) == "number" then
		self.props.%s = PhysicalProperties.new(a1, a2, a3, a4, a5)
	else
		self.props.%s = PhysicalProperties.new(a1, a2, a3)
	end

	return self
end]],
        NumberSequence = [[function(self, a1, a2)
	if typeof(a2) == "number" then
		self.props.%s = NumberSequence.new(a1, a2)
	elseif typeof(a1) == "number" then
		self.props.%s = NumberSequence.new(a1)
	elseif typeof(a1) == "table" then
		self.props.%s = NumberSequence.new(a1)
	else
		assert(typeof(a1) == "NumberSequence" or typeof(a1) == "function")
		self.proprs.%s = a1
	end

	return self
end]],
        PhysicalProperties = [[function(self, a1, a2, a3, a4, a5)
	if typeof(a4) == "number" then
		self.props.%s = PhysicalProperties.new(a1, a2, a3, a4, a5)
	else
		self.props.%s = PhysicalProperties.new(a1, a2, a3)
	end

	return self
end]],
        ProtectedString = [[function(self, a1)
	assert(typeof(a1) == "string" or typeof(a1) == "function")
	self.props.%s = a1

	return self
end]],
        Ray = [[function(self, a1, a2)
	if typeof(a1) == "Ray" or typeof(a1) == "function" then
		self.props.%s = a1
	else
		self.props.%s = Ray.new(a1, a2)
	end

	return self
end]],
        Rect = [[function(self, a1, a2, a3, a4)
	if typeof(a1) == "Rect" or typeof(a1) == "function" then
		self.props.%s = a1
	elseif typeof(a1) == "number" then
		self.props.%s = Rect.new(a1, a2, a3, a4)
	else
		self.props.%s = Rect.new(a1, a2)
	end

	return self
end]],
        UDim = [[function(self, a1, a2)
	if typeof(a1) == "UDim" or typeof(a1) == "function" then
		self.props.%s = a1
	else
		self.props.%s = UDim.new(a1, a2)
	end

	return self
end]],
        UDim2 = [[function(self, a1, a2, a3, a4)
	if typeof(a1) == "UDim2" or typeof(a1) == "function" then
		self.props.%s = a1
	else
		self.props.%s = UDim2.new(a1, a2, a3, a4)
	end

	return self
end]],
        Vector2 = [[function(self, a1, a2)
	if typeof(a1) == "Vector2" or typeof(a1) == "function" then
		self.props.%s = a1
	else
		self.props.%s = Vector2.new(a1, a2)
	end

	return self
end]],
        Vector3 = [[function(self, a1, a2, a3)
	if typeof(a1) == "Vector3" or typeof(a1) == "function" then
		self.props.%s = a1
	else
		self.props.%s = Vector3.new(a1, a2, a3)
	end

	return self
end]],
    },
    Enum = {
        AccessModifierType = [[function(self, a1: Enum.AccessModifierType)
	self.props.%s = a1
	return self
end]],
        AccessoryType = [[function(self, a1: Enum.AccessoryType)
	self.props.%s = a1
	return self
end]],
        ActuatorRelativeTo = [[function(self, a1: Enum.ActuatorRelativeTo)
	self.props.%s = a1
	return self
end]],
        ActuatorType = [[function(self, a1: Enum.ActuatorType)
	self.props.%s = a1
	return self
end]],
        AdShape = [[function(self, a1: Enum.AdShape)
	self.props.%s = a1
	return self
end]],
        AdUnitStatus = [[function(self, a1: Enum.AdUnitStatus)
	self.props.%s = a1
	return self
end]],
        AdornCullingMode = [[function(self, a1: Enum.AdornCullingMode)
	self.props.%s = a1
	return self
end]],
        AlignType = [[function(self, a1: Enum.AlignType)
	self.props.%s = a1
	return self
end]],
        AlphaMode = [[function(self, a1: Enum.AlphaMode)
	self.props.%s = a1
	return self
end]],
        AnimationPriority = [[function(self, a1: Enum.AnimationPriority)
	self.props.%s = a1
	return self
end]],
        ApplyStrokeMode = [[function(self, a1: Enum.ApplyStrokeMode)
	self.props.%s = a1
	return self
end]],
        AspectType = [[function(self, a1: Enum.AspectType)
	self.props.%s = a1
	return self
end]],
        AudioSubType = [[function(self, a1: Enum.AudioSubType)
	self.props.%s = a1
	return self
end]],
        AutomaticSize = [[function(self, a1: Enum.AutomaticSize)
	self.props.%s = a1
	return self
end]],
        BinType = [[function(self, a1: Enum.BinType)
	self.props.%s = a1
	return self
end]],
        BodyPart = [[function(self, a1: Enum.BodyPart)
	self.props.%s = a1
	return self
end]],
        BorderMode = [[function(self, a1: Enum.BorderMode)
	self.props.%s = a1
	return self
end]],
        ButtonStyle = [[function(self, a1: Enum.ButtonStyle)
	self.props.%s = a1
	return self
end]],
        CameraMode = [[function(self, a1: Enum.CameraMode)
	self.props.%s = a1
	return self
end]],
        CameraType = [[function(self, a1: Enum.CameraType)
	self.props.%s = a1
	return self
end]],
        ChatMode = [[function(self, a1: Enum.ChatMode)
	self.props.%s = a1
	return self
end]],
        CollisionFidelity = [[function(self, a1: Enum.CollisionFidelity)
	self.props.%s = a1
	return self
end]],
        DevCameraOcclusionMode = [[function(self, a1: Enum.DevCameraOcclusionMode)
	self.props.%s = a1
	return self
end]],
        DevComputerCameraMovementMode = [[function(self, a1: Enum.DevComputerCameraMovementMode)
	self.props.%s = a1
	return self
end]],
        DevComputerMovementMode = [[function(self, a1: Enum.DevComputerMovementMode)
	self.props.%s = a1
	return self
end]],
        DevTouchCameraMovementMode = [[function(self, a1: Enum.DevTouchCameraMovementMode)
	self.props.%s = a1
	return self
end]],
        DevTouchMovementMode = [[function(self, a1: Enum.DevTouchMovementMode)
	self.props.%s = a1
	return self
end]],
        DialogBehaviorType = [[function(self, a1: Enum.DialogBehaviorType)
	self.props.%s = a1
	return self
end]],
        DialogPurpose = [[function(self, a1: Enum.DialogPurpose)
	self.props.%s = a1
	return self
end]],
        DialogTone = [[function(self, a1: Enum.DialogTone)
	self.props.%s = a1
	return self
end]],
        DominantAxis = [[function(self, a1: Enum.DominantAxis)
	self.props.%s = a1
	return self
end]],
        DragDetectorDragStyle = [[function(self, a1: Enum.DragDetectorDragStyle)
	self.props.%s = a1
	return self
end]],
        DragDetectorResponseStyle = [[function(self, a1: Enum.DragDetectorResponseStyle)
	self.props.%s = a1
	return self
end]],
        EasingDirection = [[function(self, a1: Enum.EasingDirection)
	self.props.%s = a1
	return self
end]],
        EasingStyle = [[function(self, a1: Enum.EasingStyle)
	self.props.%s = a1
	return self
end]],
        ElasticBehavior = [[function(self, a1: Enum.ElasticBehavior)
	self.props.%s = a1
	return self
end]],
        ExplosionType = [[function(self, a1: Enum.ExplosionType)
	self.props.%s = a1
	return self
end]],
        FieldOfViewMode = [[function(self, a1: Enum.FieldOfViewMode)
	self.props.%s = a1
	return self
end]],
        FillDirection = [[function(self, a1: Enum.FillDirection)
	self.props.%s = a1
	return self
end]],
        Font = [[function(self, a1: Enum.Font)
	self.props.%s = a1
	return self
end]],
        FontSize = [[function(self, a1: Enum.FontSize)
	self.props.%s = a1
	return self
end]],
        ForceLimitMode = [[function(self, a1: Enum.ForceLimitMode)
	self.props.%s = a1
	return self
end]],
        FormFactor = [[function(self, a1: Enum.FormFactor)
	self.props.%s = a1
	return self
end]],
        FrameStyle = [[function(self, a1: Enum.FrameStyle)
	self.props.%s = a1
	return self
end]],
        GuiState = [[function(self, a1: Enum.GuiState)
	self.props.%s = a1
	return self
end]],
        HandlesStyle = [[function(self, a1: Enum.HandlesStyle)
	self.props.%s = a1
	return self
end]],
        HighlightDepthMode = [[function(self, a1: Enum.HighlightDepthMode)
	self.props.%s = a1
	return self
end]],
        HorizontalAlignment = [[function(self, a1: Enum.HorizontalAlignment)
	self.props.%s = a1
	return self
end]],
        HumanoidCollisionType = [[function(self, a1: Enum.HumanoidCollisionType)
	self.props.%s = a1
	return self
end]],
        HumanoidDisplayDistanceType = [[function(self, a1: Enum.HumanoidDisplayDistanceType)
	self.props.%s = a1
	return self
end]],
        HumanoidHealthDisplayType = [[function(self, a1: Enum.HumanoidHealthDisplayType)
	self.props.%s = a1
	return self
end]],
        HumanoidRigType = [[function(self, a1: Enum.HumanoidRigType)
	self.props.%s = a1
	return self
end]],
        IKControlType = [[function(self, a1: Enum.IKControlType)
	self.props.%s = a1
	return self
end]],
        InOut = [[function(self, a1: Enum.InOut)
	self.props.%s = a1
	return self
end]],
        InputType = [[function(self, a1: Enum.InputType)
	self.props.%s = a1
	return self
end]],
        KeyCode = [[function(self, a1: Enum.KeyCode)
	self.props.%s = a1
	return self
end]],
        LeftRight = [[function(self, a1: Enum.LeftRight)
	self.props.%s = a1
	return self
end]],
        LineJoinMode = [[function(self, a1: Enum.LineJoinMode)
	self.props.%s = a1
	return self
end]],
        Material = [[function(self, a1: Enum.Material)
	self.props.%s = a1
	return self
end]],
        MaterialPattern = [[function(self, a1: Enum.MaterialPattern)
	self.props.%s = a1
	return self
end]],
        MembershipType = [[function(self, a1: Enum.MembershipType)
	self.props.%s = a1
	return self
end]],
        MeshType = [[function(self, a1: Enum.MeshType)
	self.props.%s = a1
	return self
end]],
        ModelLevelOfDetail = [[function(self, a1: Enum.ModelLevelOfDetail)
	self.props.%s = a1
	return self
end]],
        ModelStreamingMode = [[function(self, a1: Enum.ModelStreamingMode)
	self.props.%s = a1
	return self
end]],
        NameOcclusion = [[function(self, a1: Enum.NameOcclusion)
	self.props.%s = a1
	return self
end]],
        NormalId = [[function(self, a1: Enum.NormalId)
	self.props.%s = a1
	return self
end]],
        OrientationAlignmentMode = [[function(self, a1: Enum.OrientationAlignmentMode)
	self.props.%s = a1
	return self
end]],
        PartType = [[function(self, a1: Enum.PartType)
	self.props.%s = a1
	return self
end]],
        ParticleEmitterShape = [[function(self, a1: Enum.ParticleEmitterShape)
	self.props.%s = a1
	return self
end]],
        ParticleEmitterShapeInOut = [[function(self, a1: Enum.ParticleEmitterShapeInOut)
	self.props.%s = a1
	return self
end]],
        ParticleEmitterShapeStyle = [[function(self, a1: Enum.ParticleEmitterShapeStyle)
	self.props.%s = a1
	return self
end]],
        ParticleFlipbookLayout = [[function(self, a1: Enum.ParticleFlipbookLayout)
	self.props.%s = a1
	return self
end]],
        ParticleFlipbookMode = [[function(self, a1: Enum.ParticleFlipbookMode)
	self.props.%s = a1
	return self
end]],
        ParticleOrientation = [[function(self, a1: Enum.ParticleOrientation)
	self.props.%s = a1
	return self
end]],
        PlaybackState = [[function(self, a1: Enum.PlaybackState)
	self.props.%s = a1
	return self
end]],
        PoseEasingDirection = [[function(self, a1: Enum.PoseEasingDirection)
	self.props.%s = a1
	return self
end]],
        PoseEasingStyle = [[function(self, a1: Enum.PoseEasingStyle)
	self.props.%s = a1
	return self
end]],
        PositionAlignmentMode = [[function(self, a1: Enum.PositionAlignmentMode)
	self.props.%s = a1
	return self
end]],
        ProximityPromptExclusivity = [[function(self, a1: Enum.ProximityPromptExclusivity)
	self.props.%s = a1
	return self
end]],
        ProximityPromptStyle = [[function(self, a1: Enum.ProximityPromptStyle)
	self.props.%s = a1
	return self
end]],
        RenderFidelity = [[function(self, a1: Enum.RenderFidelity)
	self.props.%s = a1
	return self
end]],
        RenderingTestComparisonMethod = [[function(self, a1: Enum.RenderingTestComparisonMethod)
	self.props.%s = a1
	return self
end]],
        ResamplerMode = [[function(self, a1: Enum.ResamplerMode)
	self.props.%s = a1
	return self
end]],
        ReservedHighlightId = [[function(self, a1: Enum.ReservedHighlightId)
	self.props.%s = a1
	return self
end]],
        ReturnKeyType = [[function(self, a1: Enum.ReturnKeyType)
	self.props.%s = a1
	return self
end]],
        RollOffMode = [[function(self, a1: Enum.RollOffMode)
	self.props.%s = a1
	return self
end]],
        RotationOrder = [[function(self, a1: Enum.RotationOrder)
	self.props.%s = a1
	return self
end]],
        RunContext = [[function(self, a1: Enum.RunContext)
	self.props.%s = a1
	return self
end]],
        SafeAreaCompatibility = [[function(self, a1: Enum.SafeAreaCompatibility)
	self.props.%s = a1
	return self
end]],
        ScaleType = [[function(self, a1: Enum.ScaleType)
	self.props.%s = a1
	return self
end]],
        ScreenInsets = [[function(self, a1: Enum.ScreenInsets)
	self.props.%s = a1
	return self
end]],
        ScrollBarInset = [[function(self, a1: Enum.ScrollBarInset)
	self.props.%s = a1
	return self
end]],
        ScrollingDirection = [[function(self, a1: Enum.ScrollingDirection)
	self.props.%s = a1
	return self
end]],
        SelectionBehavior = [[function(self, a1: Enum.SelectionBehavior)
	self.props.%s = a1
	return self
end]],
        SensorMode = [[function(self, a1: Enum.SensorMode)
	self.props.%s = a1
	return self
end]],
        SensorUpdateType = [[function(self, a1: Enum.SensorUpdateType)
	self.props.%s = a1
	return self
end]],
        ServiceVisibility = [[function(self, a1: Enum.ServiceVisibility)
	self.props.%s = a1
	return self
end]],
        SizeConstraint = [[function(self, a1: Enum.SizeConstraint)
	self.props.%s = a1
	return self
end]],
        SortOrder = [[function(self, a1: Enum.SortOrder)
	self.props.%s = a1
	return self
end]],
        StartCorner = [[function(self, a1: Enum.StartCorner)
	self.props.%s = a1
	return self
end]],
        Style = [[function(self, a1: Enum.Style)
	self.props.%s = a1
	return self
end]],
        SurfaceGuiShape = [[function(self, a1: Enum.SurfaceGuiShape)
	self.props.%s = a1
	return self
end]],
        SurfaceGuiSizingMode = [[function(self, a1: Enum.SurfaceGuiSizingMode)
	self.props.%s = a1
	return self
end]],
        SurfaceType = [[function(self, a1: Enum.SurfaceType)
	self.props.%s = a1
	return self
end]],
        TableMajorAxis = [[function(self, a1: Enum.TableMajorAxis)
	self.props.%s = a1
	return self
end]],
        TerrainFace = [[function(self, a1: Enum.TerrainFace)
	self.props.%s = a1
	return self
end]],
        TextDirection = [[function(self, a1: Enum.TextDirection)
	self.props.%s = a1
	return self
end]],
        TextInputType = [[function(self, a1: Enum.TextInputType)
	self.props.%s = a1
	return self
end]],
        TextTruncate = [[function(self, a1: Enum.TextTruncate)
	self.props.%s = a1
	return self
end]],
        TextXAlignment = [[function(self, a1: Enum.TextXAlignment)
	self.props.%s = a1
	return self
end]],
        TextYAlignment = [[function(self, a1: Enum.TextYAlignment)
	self.props.%s = a1
	return self
end]],
        TextureMode = [[function(self, a1: Enum.TextureMode)
	self.props.%s = a1
	return self
end]],
        TopBottom = [[function(self, a1: Enum.TopBottom)
	self.props.%s = a1
	return self
end]],
        UsageContext = [[function(self, a1: Enum.UsageContext)
	self.props.%s = a1
	return self
end]],
        VelocityConstraintMode = [[function(self, a1: Enum.VelocityConstraintMode)
	self.props.%s = a1
	return self
end]],
        VerticalAlignment = [[function(self, a1: Enum.VerticalAlignment)
	self.props.%s = a1
	return self
end]],
        VerticalScrollBarPosition = [[function(self, a1: Enum.VerticalScrollBarPosition)
	self.props.%s = a1
	return self
end]],
        WrapLayerAutoSkin = [[function(self, a1: Enum.WrapLayerAutoSkin)
	self.props.%s = a1
	return self
end]],
        WrapLayerDebugMode = [[function(self, a1: Enum.WrapLayerDebugMode)
	self.props.%s = a1
	return self
end]],
        WrapTargetDebugMode = [[function(self, a1: Enum.WrapTargetDebugMode)
	self.props.%s = a1
	return self
end]],
        ZIndexBehavior = [[function(self, a1: Enum.ZIndexBehavior)
	self.props.%s = a1
	return self
end]],
    },
    Primitive = {
        bool = [[function(self, a1: boolean)
	self.props.%s = a1
	return self
end]],
        double = [[function(self, a1: number)
	self.props.%s = a1
	return self
end]],
        float = [[function(self, a1: number)
	self.props.%s = a1
	return self
end]],
        int = [[function(self, a1: number)
	self.props.%s = a1
	return self
end]],
        int64 = [[function(self, a1: number)
	self.props.%s = a1
	return self
end]],
        string = [[function(self, a1: string)
	self.props.%s = a1
	return self
end]],
    },
}

local function generate_setter_func_name(m: ApiTypes.Member): string
	return "Set" .. m.Name
end
local function generate_setter_func(m: ApiTypes.Member): string
	assert(m.MemberType == "Property")
	local func_text = VALUETYPE_CTOR_MAP[m.ValueType.Category][m.ValueType.Name]
	local formatter = VALUETYPE_FORMATTERS[m.ValueType.Category][m.ValueType.Name]

	if not formatter or not func_text then
		print("MISSING FORMATTER", m)
	end

	local s = ""
	s ..= string.format("local %s = %s", generate_setter_func_name(m), formatter(func_text, m.Name))
	s ..= "\n"

	return s
end

local function generate_propset(host_class: ApiTypes.Class): string
	local class_name = host_class.Name
	local s = string.format([[
local %* = {
]], class_name)
	
	local function body(c: ApiTypes.Class)
		for _,m in c.Members do
			if not ApiTools.member_is_configurable(m) then
				continue
			end

			if m.MemberType ~= "Property" then
				continue
			end

			s ..= "\t" .. m.Name .. " = " .. generate_setter_func_name(m) .. ",\n"
		end
	end

	while host_class do
		body(host_class)
		host_class = Runtime.ClassLookup[host_class.Superclass]
	end
	
	s ..= "}\n"
	s ..= string.format("%*.__index = %*\n\n", class_name, class_name)
	
	return s
end

local function generate_propset_setters(leaf_classes: { [any]: ApiTypes.Class })
	local generated_setters = { }
	local setter_funcs = ""
	for _, leaf_class in leaf_classes do
		local function setters(c: ApiTypes.Class)
			for _, m in c.Members do
				if m.MemberType ~= "Property" then
					continue
				end
				
				if not ApiTools.member_is_configurable(m) then
					continue
				end
				
				if generated_setters[m.Name] then
					continue
				end

				generated_setters[m.Name] = true
				setter_funcs ..= generate_setter_func(m)
			end
		end

		local host_class = leaf_class
		while host_class do
			setters(host_class)
			host_class = Runtime.ClassLookup[host_class.Superclass]
		end
	end

	return setter_funcs
end

local function generate_propsets()
	local leaf_classes = Runtime.LeafClasses
	
	local header = "--!strict\n--!native\n\n"
	local setter_funcs = generate_propset_setters(leaf_classes)

	local propset_objs = ""
	for i,v in leaf_classes do
		propset_objs ..= generate_propset(v)
	end

	local propset_tbl = "\nlocal PropSets = {\n"

	for i,v in leaf_classes do
		propset_tbl ..= "\t" .. v.Name .. " = " .. v.Name .. ",\n"
	end

        propset_tbl ..= "}\n"

        local propset_ctor = [[local function PropsetCtor(class: string)
        local propset = PropSets[class]
        assert(propset)

        return setmetatable({
                class = class,
                props = { }
        }, propset)
end]]

	local out = header .. "\n"
	out ..= setter_funcs .. "\n"
	out ..= propset_objs .. "\n"
	out ..= propset_tbl .. "\n"
	out ..= propset_ctor .. "\n"

	return out
end

return generate_propsets