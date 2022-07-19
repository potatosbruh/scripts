--hi





local game = game
local GetService = game.GetService
if (not game.IsLoaded(game)) then
    local Loaded = game.Loaded
    Loaded.Wait(Loaded);
end

local _L = {}

_L.start = start or tick();
local Debug = true

do
    local F_A = getgenv().F_A
    if (F_A) then
        local Notify, GetConfig = F_A.Utils.Notify, F_A.GetConfig
        local UserInputService = GetService(game, "UserInputService");
        local CommandBarPrefix = GetConfig().CommandBarPrefix
        local StringKeyCode = UserInputService.GetStringForKeyCode(UserInputService, Enum.KeyCode[CommandBarPrefix]);
        return Notify(nil, "Loaded", "fates admin is already loaded... use 'killscript' to kill", nil),
        Notify(nil, "Your Prefix is", string.format("%s (%s)", StringKeyCode, CommandBarPrefix));
    end
end

--IMPORT [var]
local Services = {
    Workspace = GetService(game, "Workspace");
    UserInputService = GetService(game, "UserInputService");
    ReplicatedStorage = GetService(game, "ReplicatedStorage");
    StarterPlayer = GetService(game, "StarterPlayer");
    StarterPack = GetService(game, "StarterPack");
    StarterGui = GetService(game, "StarterGui");
    TeleportService = GetService(game, "TeleportService");
    CoreGui = GetService(game, "CoreGui");
    TweenService = GetService(game, "TweenService");
    HttpService = GetService(game, "HttpService");
    TextService = GetService(game, "TextService");
    MarketplaceService = GetService(game, "MarketplaceService");
    Chat = GetService(game, "Chat");
    Teams = GetService(game, "Teams");
    SoundService = GetService(game, "SoundService");
    Lighting = GetService(game, "Lighting");
    ScriptContext = GetService(game, "ScriptContext");
    Stats = GetService(game, "Stats");
}

setmetatable(Services, {
    __index = function(Table, Property)
        local Ret, Service = pcall(GetService, game, Property);
        if (Ret) then
            Services[Property] = Service
            return Service
        end
        return nil
    end,
    __mode = "v"
});

local GetChildren, GetDescendants = game.GetChildren, game.GetDescendants
local IsA = game.IsA
local FindFirstChild, FindFirstChildOfClass, FindFirstChildWhichIsA, WaitForChild = 
    game.FindFirstChild,
    game.FindFirstChildOfClass,
    game.FindFirstChildWhichIsA,
    game.WaitForChild

local GetPropertyChangedSignal, Changed = 
    game.GetPropertyChangedSignal,
    game.Changed
    
local Destroy, Clone = game.Destroy, game.Clone

local Heartbeat, Stepped, RenderStepped;
do
    local RunService = Services.RunService;
    Heartbeat, Stepped, RenderStepped =
        RunService.Heartbeat,
        RunService.Stepped,
        RunService.RenderStepped
end

local Players = Services.Players
local GetPlayers = Players.GetPlayers

local JSONEncode, JSONDecode, GenerateGUID = 
    Services.HttpService.JSONEncode, 
    Services.HttpService.JSONDecode,
    Services.HttpService.GenerateGUID

local Camera = Services.Workspace.CurrentCamera

local Tfind, sort, concat, pack, unpack;
do
    local table = table
    Tfind, sort, concat, pack, unpack = 
        table.find, 
        table.sort,
        table.concat,
        table.pack,
        table.unpack
end

local lower, upper, Sfind, split, sub, format, len, match, gmatch, gsub, byte;
do
    local string = string
    lower, upper, Sfind, split, sub, format, len, match, gmatch, gsub, byte = 
        string.lower,
        string.upper,
        string.find,
        string.split, 
        string.sub,
        string.format,
        string.len,
        string.match,
        string.gmatch,
        string.gsub,
        string.byte
end

local random, floor, round, abs, atan, cos, sin, rad;
do
    local math = math
    random, floor, round, abs, atan, cos, sin, rad = 
        math.random,
        math.floor,
        math.round,
        math.abs,
        math.atan,
        math.cos,
        math.sin,
        math.rad
end

local InstanceNew = Instance.new
local CFrameNew = CFrame.new
local Vector3New = Vector3.new

local Inverse, toObjectSpace, components
do
    local CalledCFrameNew = CFrameNew();
    Inverse = CalledCFrameNew.Inverse
    toObjectSpace = CalledCFrameNew.toObjectSpace
    components = CalledCFrameNew.components
end

local Connection = game.Loaded
local CWait = Connection.Wait
local CConnect = Connection.Connect

local Disconnect;
do
    local CalledConnection = CConnect(Connection, function() end);
    Disconnect = CalledConnection.Disconnect
end

local __H = InstanceNew("Humanoid");
local UnequipTools = __H.UnequipTools
local ChangeState = __H.ChangeState
local SetStateEnabled = __H.SetStateEnabled
local GetState = __H.GetState
local GetAccessories = __H.GetAccessories

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local Mouse = LocalPlayer.GetMouse(LocalPlayer);

local CThread;
do
    local wrap = coroutine.wrap
    CThread = function(Func, ...)
        if (type(Func) ~= 'function') then
            return nil
        end
        local Varag = ...
        return function()
            local Success, Ret = pcall(wrap(Func, Varag));
            if (Success) then
                return Ret
            end
            if (Debug) then
                warn("[FA Error]: " .. debug.traceback(Ret));
            end
        end
    end
end

local startsWith = function(str, searchString, rawPos)
    local pos = rawPos or 1
    return searchString == "" and true or sub(str, pos, pos) == searchString
end

local trim = function(str)
    return gsub(str, "^%s*(.-)%s*$", "%1");
end

local tbl_concat = function(...)
    local new = {}
    for i, v in next, {...} do
        for i2, v2 in next, v do
            new[i] = v2
        end
    end
    return new
end

local indexOf = function(tbl, val)
    if (type(tbl) == 'table') then
        for i, v in next, tbl do
            if (v == val) then
                return i
            end
        end
    end
end

local forEach = function(tbl, ret)
    for i, v in next, tbl do
        ret(i, v);
    end
end

local filter = function(tbl, ret)
    if (type(tbl) == 'table') then
        local new = {}
        for i, v in next, tbl do
            if (ret(i, v)) then
                new[#new + 1] = v
            end
        end
        return new
    end
end

local map = function(tbl, ret)
    if (type(tbl) == 'table') then
        local new = {}
        for i, v in next, tbl do
            local Value, Key = ret(i, v);
            new[Key or #new + 1] = Value
        end
        return new
    end
end

local deepsearch;
deepsearch = function(tbl, ret)
    if (type(tbl) == 'table') then
        for i, v in next, tbl do
            if (type(v) == 'table') then
                deepsearch(v, ret);
            end
            ret(i, v);
        end
    end
end

local deepsearchset;
deepsearchset = function(tbl, ret, value)
    if (type(tbl) == 'table') then
        local new = {}
        for i, v in next, tbl do
            new[i] = v
            if (type(v) == 'table') then
                new[i] = deepsearchset(v, ret, value);
            end
            if (ret(i, v)) then
                new[i] = value(i, v);
            end
        end
        return new
    end
end

local flat = function(tbl)
    if (type(tbl) == 'table') then
        local new = {}
        deepsearch(tbl, function(i, v)
            if (type(v) ~= 'table') then
                new[#new + 1] = v
            end
        end)
        return new
    end
end

local flatMap = function(tbl, ret)
    if (type(tbl) == 'table') then
        local new = flat(map(tbl, ret));
        return new
    end
end

local shift = function(tbl)
    if (type(tbl) == 'table') then
        local firstVal = tbl[1]
        tbl = pack(unpack(tbl, 2, #tbl));
        tbl.n = nil
        return tbl
    end
end

local keys = function(tbl)
    if (type(tbl) == 'table') then
        local new = {}
        for i, v in next, tbl do
            new[#new + 1] = i	
        end
        return new
    end
end

local function clone(toClone, shallow)
    if (type(toClone) == 'function' and clonefunction) then
        return clonefunction(toClone);
    end
    local new = {}
    for i, v in pairs(toClone) do
        if (type(v) == 'table' and not shallow) then
            v = clone(v);
        end
        new[i] = v
    end
    return new
end

local setthreadidentity = setthreadidentity or syn_context_set or setthreadcontext or (syn and syn.set_thread_identity)
local getthreadidentity = getthreadidentity or syn_context_get or getthreadcontext or (syn and syn.get_thread_identity)
--END IMPORT [var]



local GetCharacter = GetCharacter or function(Plr)
    return Plr and Plr.Character or LocalPlayer.Character
end

local Utils = {}

--IMPORT [extend]
local Stats = Services.Stats
local ContentProvider = Services.ContentProvider

local firetouchinterest, hookfunction;
do
    local GEnv = getgenv();
    local touched = {}
    firetouchinterest = GEnv.firetouchinterest or function(part1, part2, toggle)
        if (part1 and part2) then
            if (toggle == 0) then
                touched[1] = part1.CFrame
                part1.CFrame = part2.CFrame
            else
                part1.CFrame = touched[1]
                touched[1] = nil
            end
        end
    end
    local newcclosure = newcclosure or function(f)
        return f
    end

    hookfunction = GEnv.hookfunction or function(func, newfunc, applycclosure)
        if (replaceclosure) then
            replaceclosure(func, newfunc);
            return func
        end
        func = applycclosure and newcclosure or newfunc
        return func
    end
end

if (not syn or not syn.protect_gui) then
    local CachedConnections = setmetatable({}, {
        __mode = "v"
    });

    GEnv = getgenv();
    getconnections = function(Connection, FromCache, AddOnConnect)
        local getconnections = GEnv.getconnections
        if (not getconnections) then
            return {}
        end

        local CachedConnection;
        for i, v in next, CachedConnections do
            if (i == Connection) then
                CachedConnection = v
                break;
            end
        end
        if (CachedConnection and FromCache) then
            return CachedConnection
        end

        local Connections = GEnv.getconnections(Connection);
        CachedConnections[Connection] = Connections
        return Connections
    end
end

local getrawmetatable = getrawmetatable or function()
    return setmetatable({}, {});
end

local getnamecallmethod = getnamecallmethod or function()
    return ""
end

local checkcaller = checkcaller or function()
    return false
end

local Hooks = {
    AntiKick = false,
    AntiTeleport = false,
    NoJumpCooldown = false,
}

local mt = getrawmetatable(game);
local OldMetaMethods = {}
setreadonly(mt, false);
for i, v in next, mt do
    OldMetaMethods[i] = v
end
setreadonly(mt, true);
local MetaMethodHooks = {}

local ProtectInstance, SpoofInstance, SpoofProperty;
local pInstanceCount = {0, 0}; -- instancecount, primitivescount
local ProtectedInstances = setmetatable({}, {
    __mode = "v"
});
local FocusedTextBox = nil
do
    local SpoofedInstances = setmetatable({}, {
        __mode = "v"
    });
    local SpoofedProperties = {}
    Hooks.SpoofedProperties = SpoofedProperties

    local otherCheck = function(instance, n)
        if (IsA(instance, "ImageLabel") or IsA(instance, "ImageButton")) then
            ProtectedInstances[#ProtectedInstances + 1] = instance
            return;
        end

        if (IsA(instance, "BasePart")) then
            pInstanceCount[2] = math.max(pInstanceCount[2] + (n or 1), 0);
        end
    end

    ProtectInstance = function(Instance_)
        if (not Tfind(ProtectedInstances, Instance_)) then
            ProtectedInstances[#ProtectedInstances + 1] = Instance_
            local descendants = Instance_:GetDescendants();
            pInstanceCount[1] += 1 + #descendants;
            for i = 1, #descendants do
                otherCheck(descendants[i]);
            end
            local dAdded = Instance_.DescendantAdded:Connect(function(descendant)
                pInstanceCount[1] += 1
                otherCheck(descendant);
            end);
            local dRemoving = Instance_.DescendantRemoving:Connect(function(descendant)
                pInstanceCount[1] = math.max(pInstanceCount[1] - 1, 0);
                otherCheck(descendant, -1);
            end);
            otherCheck(Instance_);

            Instance_.Name = sub(gsub(GenerateGUID(Services.HttpService, false), '-', ''), 1, random(25, 30));
            Instance_.Archivable = false
        end
    end

    SpoofInstance = function(Instance_, Instance2)
        if (not SpoofedInstances[Instance_]) then
            SpoofedInstances[Instance_] = Instance2 and Instance2 or Clone(Instance_);
        end
    end

    UnSpoofInstance = function(Instance_)
        if (SpoofedInstances[Instance_]) then
            SpoofedInstances[Instance_] = nil
        end
    end
    
    local ChangedSpoofedProperties = {}
    SpoofProperty = function(Instance_, Property, NoClone)
        if (SpoofedProperties[Instance_]) then
            local SpoofedPropertiesForInstance = SpoofedProperties[Instance_]
            local Properties = map(SpoofedPropertiesForInstance, function(i, v)
                return v.Property
            end)
            if (not Tfind(Properties, Property)) then
                SpoofedProperties[Instance_][#SpoofedPropertiesForInstance + 1] = {
                    SpoofedProperty = SpoofedPropertiesForInstance[1].SpoofedProperty,
                    Property = Property,
                };
            end
        else
            local Cloned;
            if (not NoClone and IsA(Instance_, "Instance") and not Services[tostring(Instance_)] and Instance_.Archivable) then
                local Success, Ret = pcall(Clone, Instance_);
                if (Success) then
                    Cloned = Ret
                end
            end
            SpoofedProperties[Instance_] = {{
                SpoofedProperty = Cloned and Cloned or {[Property]=Instance_[Property]},
                Property = Property,
            }}
            ChangedSpoofedProperties[Instance_] = {}
        end
    end

    local GetAllParents = function(Instance_, NIV)
        if (typeof(Instance_) == "Instance") then
            local Parents = {}
            local Current = NIV or Instance_
            if (NIV) then
                Parents[#Parents + 1] = Current
            end
            repeat
                local Parent = Current.Parent
                Parents[#Parents + 1] = Parent
                Current = Parent
            until not Current
            return Parents
        end
        return {}
    end

    local Methods = {
        "FindFirstChild",
        "FindFirstChildWhichIsA",
        "FindFirstChildOfClass",
        "IsA"
    }

    local lockedInstances = {};
    setmetatable(lockedInstances, { __mode = "k" });
    local isProtected = function(instance)
        if (lockedInstances[instance]) then
            return true;
        end

        local good2 = pcall(tostring, instance);
        if (not good2) then
            lockedInstances[instance] = true
            return true;
        end

        for i2 = 1, #ProtectedInstances do
            local pInstance = ProtectedInstances[i2]
            if (pInstance == instance) then
                return true;
            end
        end
        return false;
    end

    MetaMethodHooks.Namecall = function(...)
        local __Namecall = OldMetaMethods.__namecall;
        local Args = {...}
        local self = Args[1]
        local Method = getnamecallmethod() or "";

        if (Method ~= "") then
            local Success, result = pcall(OldMetaMethods.__index, self, Method);
            if (not Success or Success and type(result) ~= "function") then
                return __Namecall(...);
            end
        end

        if (Hooks.AntiKick and lower(Method) == "kick") then
            local Player, Message = self, Args[2]
            if (Hooks.AntiKick and Player == LocalPlayer) then
                local Notify = Utils.Notify
                local Context;
                if (setthreadidentity) then
                    Context = getthreadidentity();
                    setthreadidentity(3);
                end
                if (Notify and Context) then
                    Notify(nil, "Attempt to kick", format("attempt to kick %s", (Message and type(Message) == 'number' or type(Message) == 'string') and ": " .. Message or ""));
                    setthreadidentity(Context);
                end
                return
            end
        end

        if (Hooks.AntiTeleport and Method == "Teleport" or Method == "TeleportToPlaceInstance") then
            local Player, PlaceId = self, Args[2]
            if (Hooks.AntiTeleport and Player == LocalPlayer) then
                local Notify = Utils.Notify
                local Context;
                if (setthreadidentity) then
                    Context = getthreadidentity();
                    setthreadidentity(3);
                end
                if (Notify and Context) then
                    Notify(nil, "Attempt to teleport", format("attempt to teleport to place %s", PlaceId and PlaceId or ""));
                    setthreadidentity(Context);
                end
                return
            end
        end

        if (checkcaller()) then
            return __Namecall(...);
        end

        if (Tfind(Methods, Method)) then
            local ReturnedInstance = __Namecall(...);
            if (Tfind(ProtectedInstances, ReturnedInstance)) then
                return Method == "IsA" and false or nil
            end
        end

        -- ik this is horrible but fates admin v3 has a better way of doing hooks
        if (Method == "children" or Method == "GetChildren" or Method ==  "getChildren" or Method == "GetDescendants" or Method == "getDescendants") then
            return filter(__Namecall(...), function(i, instance)
                return not isProtected(instance);
            end);
        end

        if (self == Services.UserInputService and (Method == "GetFocusedTextBox" or Method == "getFocusedTextBox")) then
            local focused = __Namecall(...);
            for i = 1, #ProtectedInstances do
                local ProtectedInstance = ProtectedInstances[i]
                local iden = getthreadidentity();
                setthreadidentity(7);
                local pInstance = Tfind(ProtectedInstances, focused) or focused.IsDescendantOf(focused, ProtectedInstance);
                setthreadidentity(iden);
                if (pInstance) then
                    return nil;
                end
            end
        end

        if (Hooks.NoJumpCooldown and (Method == "GetState" or Method == "GetStateEnabled")) then
            local State = __Namecall(...);
            if (Method == "GetState" and (State == Enum.HumanoidStateType.Jumping or State == "Jumping")) then
                return Enum.HumanoidStateType.RunningNoPhysics
            end
            if (Method == "GetStateEnabled" and (self == Enum.HumanoidStateType.Jumping or self == "Jumping")) then
                return false
            end
        end

        return __Namecall(...);
    end

    local AllowedIndexes = {
        "RootPart",
        "Parent"
    }
    local AllowedNewIndexes = {
        "Jump"
    }
    MetaMethodHooks.Index = function(...)
        local __Index = OldMetaMethods.__index;
        local called = __Index(...);

        if (checkcaller()) then
            return __Index(...);
        end
        local Instance_, Index = ...

        local SanitisedIndex = Index
        if (typeof(Instance_) == 'Instance' and type(Index) == 'string') then
            SanitisedIndex = gsub(sub(Index, 0, 100), "%z.*", "");
        end
        local SpoofedInstance = SpoofedInstances[Instance_]
        local SpoofedPropertiesForInstance = SpoofedProperties[Instance_]

        if (SpoofedInstance) then
            if (Tfind(AllowedIndexes, SanitisedIndex)) then
                return __Index(Instance_, Index);
            end
            return __Index(SpoofedInstance, Index);
        end

        if (SpoofedPropertiesForInstance) then
            for i, SpoofedProperty in next, SpoofedPropertiesForInstance do
                local SanitisedIndex = gsub(SanitisedIndex, "^%l", upper);
                if (SanitisedIndex == SpoofedProperty.Property) then
                    local ClientChangedData = ChangedSpoofedProperties[Instance_][SanitisedIndex]
                    local IndexedSpoofed = __Index(SpoofedProperty.SpoofedProperty, Index);
                    local Indexed = __Index(Instance_, Index);
                    if (ClientChangedData.Caller and ClientChangedData.Value ~= Indexed) then
                        OldMetaMethods.__newindex(SpoofedProperty.SpoofedProperty, Index, Indexed);
                        OldMetaMethods.__newindex(Instance_, Index, ClientChangedData.Value);
                        return Indexed
                    end
                    return IndexedSpoofed
                end
            end
        end

        if (Hooks.NoJumpCooldown and SanitisedIndex == "Jump") then
            if (IsA(Instance_, "Humanoid")) then
                return false
            end
        end

        if (Instance_ == Stats and (SanitisedIndex == "InstanceCount" or SanitisedIndex == "instanceCount")) then
            return called - pInstanceCount[1];
        end

        if (Instance_ == Stats and (SanitisedIndex == "PrimitivesCount" or SanitisedIndex == "primitivesCount")) then
            return called - pInstanceCount[2];
        end

        return called;
    end

    MetaMethodHooks.NewIndex = function(...)
        local __NewIndex = OldMetaMethods.__newindex;
        local __Index = OldMetaMethods.__index;
        local Instance_, Index, Value = ...

        local SpoofedInstance = SpoofedInstances[Instance_]
        local SpoofedPropertiesForInstance = SpoofedProperties[Instance_]

        if (checkcaller()) then
            if (Index == "Parent" and Value) then
                local ProtectedInstance
                for i = 1, #ProtectedInstances do
                    local ProtectedInstance_ = ProtectedInstances[i]
                    if (Instance_ == ProtectedInstance_ or Instance_.IsDescendantOf(Value, ProtectedInstance_)) then
                        ProtectedInstance = true
                    end
                end
                if (ProtectedInstance) then
                    local Parents = GetAllParents(Instance_, Value);
                    local child1 = getconnections(Parents[1].ChildAdded, true);
                    local descendantconnections = {}
                    for i, v in next, child1 do
                        v.Disable(v);
                    end
                    for i = 1, #Parents do
                        local Parent = Parents[i]
                        for i2, v in next, getconnections(Parent.DescendantAdded, true) do
                            v.Disable(v);
                            descendantconnections[#descendantconnections + 1] = v
                        end
                    end
                    local good, Ret = pcall(__NewIndex, ...);
                    for i, v in pairs(descendantconnections) do
                        v:Enable();
                    end
                    for i, v in next, child1 do
                        v.Enable(v);
                    end
                    if (not good) then
                        return __NewIndex(...);
                    end
                    return Ret;
                end
            end
            if (SpoofedInstance or SpoofedPropertiesForInstance) then
                if (SpoofedPropertiesForInstance) then
                    ChangedSpoofedProperties[Instance_][Index] = {
                        Caller = true,
                        BeforeValue = Instance_[Index],
                        Value = Value
                    }
                end
                local Connections = tbl_concat(
                    getconnections(GetPropertyChangedSignal(Instance_, SpoofedPropertiesForInstance and SpoofedPropertiesForInstance.Property or Index), true),
                    getconnections(Instance_.Changed, true),
                    getconnections(game.ItemChanged, true)
                )
                
                if (not next(Connections)) then
                    return __NewIndex(Instance_, Index, Value);
                end
                for i, v in next, Connections do
                    v.Disable(v);
                end
                local Ret = __NewIndex(Instance_, Index, Value);
                for i, v in next, Connections do
                    v.Enable(v);
                end
                return Ret
            end
            return __NewIndex(...);
        end

        local SanitisedIndex = Index
        if (typeof(Instance_) == 'Instance' and type(Index) == 'string') then
            local len = select(2, gsub(Index, "%z", ""));
            if (len > 255) then
                return __Index(...);
            end

            SanitisedIndex = gsub(sub(Index, 0, 100), "%z.*", "");
        end

        if (SpoofedInstance) then
            if (Tfind(AllowedNewIndexes, SanitisedIndex)) then
                return __NewIndex(...);
            end
            return __NewIndex(SpoofedInstance, Index, __Index(SpoofedInstance, Index));
        end

        if (SpoofedPropertiesForInstance) then
            for i, SpoofedProperty in next, SpoofedPropertiesForInstance do
                if (SpoofedProperty.Property == SanitisedIndex and not Tfind(AllowedIndexes, SanitisedIndex)) then
                    ChangedSpoofedProperties[Instance_][SanitisedIndex] = {
                        Caller = false,
                        BeforeValue = Instance_[Index],
                        Value = Value
                    }
                    return __NewIndex(SpoofedProperty.SpoofedProperty, Index, Value);
                end
            end
        end

        return __NewIndex(...);
    end

    local hookmetamethod = hookmetamethod or function(metatable, metamethod, func)
        setreadonly(metatable, false);
        Old = hookfunction(metatable[metamethod], func, true);
        setreadonly(metatable, true);
        return Old
    end

    OldMetaMethods.__index = hookmetamethod(game, "__index", MetaMethodHooks.Index);
    OldMetaMethods.__newindex = hookmetamethod(game, "__newindex", MetaMethodHooks.NewIndex);
    OldMetaMethods.__namecall = hookmetamethod(game, "__namecall", MetaMethodHooks.Namecall);

    Hooks.Destroy = hookfunction(game.Destroy, function(...)
        local instance = ...
        local protected = table.find(ProtectedInstances, instance);
        if (checkcaller() and protected) then
            otherCheck(instance, -1);
            local Parents = GetAllParents(instance);
            for i, v in next, getconnections(Parents[1].ChildRemoved, true) do
                v.Disable(v);
            end
            for i = 1, #Parents do
                local Parent = Parents[i]
                for i2, v in next, getconnections(Parent.DescendantRemoving, true) do
                    v.Disable(v);
                end
            end
            local destroy = Hooks.Destroy(...);
            for i = 1, #Parents do
                local Parent = Parents[i]
                for i2, v in next, getconnections(Parent.DescendantRemoving, true) do
                    v.Enable(v);
                end
            end
            for i, v in next, getconnections(Parents[1].ChildRemoved, true) do
                v.Enable(v);
            end
            table.remove(ProtectedInstances, protected);
            return destroy;
        end
        return Hooks.Destroy(...);
    end);
end

Hooks.OldGetChildren = hookfunction(game.GetChildren, newcclosure(function(...)
    if (not checkcaller()) then
        local Children = Hooks.OldGetChildren(...);
        return filter(Children, function(i, v)
            return not Tfind(ProtectedInstances, v);
        end)
    end
    return Hooks.OldGetChildren(...);
end));

Hooks.OldGetDescendants = hookfunction(game.GetDescendants, newcclosure(function(...)
    if (not checkcaller()) then
        local Descendants = Hooks.OldGetDescendants(...);
        return filter(Descendants, function(i, v)
            local Protected = false
            for i2 = 1, #ProtectedInstances do
                local ProtectedInstance = ProtectedInstances[i2]
                Protected = v and ProtectedInstance == v or v.IsDescendantOf(v, ProtectedInstance)
                if (Protected) then
                    break;
                end
            end
            return not Protected
        end)
    end
    return Hooks.OldGetDescendants(...);
end));

Hooks.FindFirstChild = hookfunction(game.FindFirstChild, newcclosure(function(...)
    if (not checkcaller()) then
        local ReturnedInstance = Hooks.FindFirstChild(...);
        if (ReturnedInstance and Tfind(ProtectedInstances, ReturnedInstance)) then
            return nil
        end
    end
    return Hooks.FindFirstChild(...);
end));
Hooks.FindFirstChildOfClass = hookfunction(game.FindFirstChildOfClass, newcclosure(function(...)
    if (not checkcaller()) then
        local ReturnedInstance = Hooks.FindFirstChildOfClass(...);
        if (ReturnedInstance and Tfind(ProtectedInstances, ReturnedInstance)) then
            return nil
        end
    end
    return Hooks.FindFirstChildOfClass(...);
end));
Hooks.FindFirstChildWhichIsA = hookfunction(game.FindFirstChildWhichIsA, newcclosure(function(...)
    if (not checkcaller()) then
        local ReturnedInstance = Hooks.FindFirstChildWhichIsA(...);
        if (ReturnedInstance and Tfind(ProtectedInstances, ReturnedInstance)) then
            return nil
        end
    end
    return Hooks.FindFirstChildWhichIsA(...);
end));
Hooks.IsA = hookfunction(game.IsA, newcclosure(function(...)
    if (not checkcaller()) then
        local Args = {...}
        local IsACheck = Args[1]
        if (IsACheck) then
            local ProtectedInstance = Tfind(ProtectedInstances, IsACheck);
            if (ProtectedInstance and Args[2]) then
                return false
            end
        end
    end
    return Hooks.IsA(...);
end));

Hooks.OldGetFocusedTextBox = hookfunction(Services.UserInputService.GetFocusedTextBox, newcclosure(function(...)
    if (not checkcaller() and ... == Services.UserInputService) then
        local FocusedTextBox = Hooks.OldGetFocusedTextBox(...);
        local Protected = false
        for i = 1, #ProtectedInstances do
            local ProtectedInstance = ProtectedInstances[i]
            Protected = Tfind(ProtectedInstances, FocusedTextBox) or FocusedTextBox.IsDescendantOf(FocusedTextBox, ProtectedInstance);
        end
        if (Protected) then
            return nil
        end
    end
    return Hooks.OldGetFocusedTextBox(...);
end));

Hooks.OldKick = hookfunction(LocalPlayer.Kick, newcclosure(function(...)
    local Player, Message = ...
    if (Hooks.AntiKick and Player == LocalPlayer) then
        local Notify = Utils.Notify
        local Context;
        if (setthreadidentity) then
            Context = getthreadidentity();
            setthreadidentity(3);
        end
        if (Notify and Context) then
            Notify(nil, "Attempt to kick", format("attempt to kick %s", (Message and type(Message) == 'number' or type(Message) == 'string') and ": " .. Message or ""));
            setthreadidentity(Context)
        end
        return
    end
    return Hooks.OldKick(...);
end))

Hooks.OldTeleportToPlaceInstance = hookfunction(Services.TeleportService.TeleportToPlaceInstance, newcclosure(function(...)
    local Player, PlaceId = ...
    if (Hooks.AntiTeleport and Player == LocalPlayer) then
        local Notify = Utils.Notify
        local Context;
        if (setthreadidentity) then
            Context = getthreadidentity();
            setthreadidentity(3);
        end
        if (Notify and Context) then
            Notify(nil, "Attempt to teleport", format("attempt to teleport to place %s", PlaceId and PlaceId or ""));
            setthreadidentity(Context)
        end
        return
    end
    return Hooks.OldTeleportToPlaceInstance(...);
end))
Hooks.OldTeleport = hookfunction(Services.TeleportService.Teleport, newcclosure(function(...)
    local Player, PlaceId = ...
    if (Hooks.AntiTeleport and Player == LocalPlayer) then
        local Notify = Utils.Notify
        local Context;
        if (setthreadidentity) then
            Context = getthreadidentity();
            setthreadidentity(3);
        end
        if (Notify and Context) then
            Notify(nil, "Attempt to teleport", format("attempt to teleport to place \"%s\"", PlaceId and PlaceId or ""));
            setthreadidentity(Context);
        end
        return
    end
    return Hooks.OldTeleport(...);
end))

Hooks.GetState = hookfunction(GetState, function(...)
    local Humanoid, State = ..., Hooks.GetState(...);
    local Parent, Character = Humanoid.Parent, LocalPlayer.Character
    if (Hooks.NoJumpCooldown and (State == Enum.HumanoidStateType.Jumping or State == "Jumping") and Parent and Character and Parent == Character) then
        return Enum.HumanoidStateType.RunningNoPhysics
    end
    return State
end)

Hooks.GetStateEnabled = hookfunction(__H.GetStateEnabled, function(...)
    local Humanoid, State = ...
    local Ret = Hooks.GetStateEnabled(...);
    local Parent, Character = Humanoid.Parent, LocalPlayer.Character
    if (Hooks.NoJumpCooldown and (State == Enum.HumanoidStateType.Jumping or State == "Jumping") and Parent and Character and Parent == Character) then
        return false
    end
    return Ret
end)
--END IMPORT [extend]



local GetRoot = function(Plr, Char)
    local LCharacter = GetCharacter();
    local Character = Char or GetCharacter(Plr);
    return Plr and Character and (FindFirstChild(Character, "HumanoidRootPart") or FindFirstChild(Character, "Torso") or FindFirstChild(Character, "UpperTorso")) or LCharacter and (FindFirstChild(LCharacter, "HumanoidRootPart") or FindFirstChild(LCharacter, "Torso") or FindFirstChild(LCharacter, "UpperTorso"));
end

local GetHumanoid = function(Plr, Char)
    local LCharacter = GetCharacter();
    local Character = Char or GetCharacter(Plr);
    return Plr and Character and FindFirstChildWhichIsA(Character, "Humanoid") or LCharacter and FindFirstChildWhichIsA(LCharacter, "Humanoid");
end

local GetMagnitude = function(Plr, Char)
    local LRoot = GetRoot();
    local Root = GetRoot(Plr, Char);
    return Plr and Root and (Root.Position - LRoot.Position).magnitude or math.huge
end

local Settings = {
    Prefix = "!",
    CommandBarPrefix = "Semicolon",
    ChatPrediction = false,
    Macros = {},
    Aliases = {},
}
local PluginSettings = {
    PluginsEnabled = true,
    PluginDebug = false,
    DisabledPlugins = {
        ["PluginName"] = true
    },
    SafePlugins = false
}

local WriteConfig = function(Destroy)
    local JSON = JSONEncode(Services.HttpService, Settings);
    local PluginJSON = JSONEncode(Services.HttpService, PluginSettings);
    if (isfolder("fates-admin") and Destroy) then
        delfolder("fates-admin");
        writefile("fates-admin/config.json", JSON);
        writefile("fates/admin/pluings/plugin-conf.json", PluginJSON);
    else
        makefolder("fates-admin");
        makefolder("fates-admin/plugins");
        makefolder("fates-admin/chatlogs");
        writefile("fates-admin/config.json", JSON);
        writefile("fates-admin/plugins/plugin-conf.json", PluginJSON);
    end
end

local GetConfig = function()
    if (isfolder("fates-admin") and isfile("fates-admin/config.json")) then
        return JSONDecode(Services.HttpService, readfile("fates-admin/config.json"));
    else
        WriteConfig();
        return JSONDecode(Services.HttpService, readfile("fates-admin/config.json"));
    end
end

local GetPluginConfig = function()
    if (isfolder("fates-admin") and isfolder("fates-admin/plugins") and isfile("fates-admin/plugins/plugin-conf.json")) then
        local JSON = JSONDecode(Services.HttpService, readfile("fates-admin/plugins/plugin-conf.json"));
        return JSON
    else
        WriteConfig();
        return JSONDecode(Services.HttpService, readfile("fates-admin/plugins/plugin-conf.json"));
    end
end

local SetPluginConfig = function(conf)
    if (isfolder("fates-admin") and isfolder("fates-admin/plugins") and isfile("fates-admin/plugins/plugin-conf.json")) then
        WriteConfig();
    end
    local NewConfig = GetPluginConfig();
    for i, v in next, conf do
        NewConfig[i] = v
    end
    writefile("fates-admin/plugins/plugin-conf.json", JSONEncode(Services.HttpService, NewConfig));
end

local SetConfig = function(conf)
    if (not isfolder("fates-admin") and isfile("fates-admin/config.json")) then
        WriteConfig();
    end
    local NewConfig = GetConfig();
    for i, v in next, conf do
        NewConfig[i] = v
    end
    writefile("fates-admin/config.json", JSONEncode(Services.HttpService, NewConfig));
end

local CurrentConfig = GetConfig();
local Prefix = isfolder and CurrentConfig.Prefix or "!"
local Macros = CurrentConfig.Macros or {}
local AdminUsers = AdminUsers or {}
local Exceptions = Exceptions or {}
local Connections = {
    Players = {}
}
_L.CLI = false
_L.ChatLogsEnabled = true
_L.GlobalChatLogsEnabled = false
_L.HttpLogsEnabled = true

local GetPlayer;
GetPlayer = function(str, noerror)
    local CurrentPlayers = filter(GetPlayers(Players), function(i, v)
        return not Tfind(Exceptions, v);
    end)
    if (not str) then
        return {}
    end
    str = lower(trim(str));
    if (Sfind(str, ",")) then
        return flatMap(split(str, ","), function(i, v)
            return GetPlayer(v, noerror);
        end)
    end

    local Magnitudes = map(CurrentPlayers, function(i, v)
        return {v,(GetRoot(v).CFrame.p - GetRoot().CFrame.p).Magnitude}
    end)

    local PlayerArgs = {
        ["all"] = function()
            return filter(CurrentPlayers, function(i, v) -- removed all arg (but not really) due to commands getting messed up and people getting confused
                return v ~= LocalPlayer
            end)
        end,
        ["others"] = function()
            return filter(CurrentPlayers, function(i, v)
                return v ~= LocalPlayer
            end)
        end,
        ["nearest"] = function()
            sort(Magnitudes, function(a, b)
                return a[2] < b[2]
            end)
            return {Magnitudes[2][1]}
        end,
        ["farthest"] = function()
            sort(Magnitudes, function(a, b)
                return a[2] > b[2]
            end)
            return {Magnitudes[2][1]}
        end,
        ["random"] = function()
            return {CurrentPlayers[random(2, #CurrentPlayers)]}
        end,
        ["allies"] = function()
            local LTeam = LocalPlayer.Team
            return filter(CurrentPlayers, function(i, v)
                return v.Team == LTeam
            end)
        end,
        ["enemies"] = function()
            local LTeam = LocalPlayer.Team
            return filter(CurrentPlayers, function(i, v)
                return v.Team ~= LTeam
            end)
        end,
        ["npcs"] = function()
            local NPCs = {}
            local Descendants = GetDescendants(Workspace);
            local GetPlayerFromCharacter = Players.GetPlayerFromCharacter
            for i = 1, #Descendants do
                local Descendant = Descendants[i]
                local DParent = Descendant.Parent
                if (IsA(Descendant, "Humanoid") and IsA(DParent, "Model") and (FindFirstChild(DParent, "HumanoidRootPart") or FindFirstChild(DParent, "Head")) and GetPlayerFromCharacter(Players, DParent) == nil) then
                    local FakePlr = InstanceNew("Player"); -- so it can be compatible with commands
                    FakePlr.Character = DParent
                    FakePlr.Name = format("%s %s", DParent.Name, "- " .. Descendant.DisplayName);
                    NPCs[#NPCs + 1] = FakePlr
                end
            end
            return NPCs
        end,
        ["me"] = function()
            return {LocalPlayer}
        end
    }

    if (PlayerArgs[str]) then
        return PlayerArgs[str]();
    end

    local Players = filter(CurrentPlayers, function(i, v)
        return (sub(lower(v.Name), 1, #str) == str) or (sub(lower(v.DisplayName), 1, #str) == str);
    end)
    if (not next(Players) and not noerror) then
        Utils.Notify(LocalPlayer, "Fail", format("Couldn't find player %s", str));
    end
    return Players
end

local AddConnection = function(Connection, CEnv, TblOnly)
    if (CEnv) then
        CEnv[#CEnv + 1] = Connection
        if (TblOnly) then
            return Connection
        end
    end
    Connections[#Connections + 1] = Connection
    return Connection
end

local LastCommand = {}


getgenv().farm = false


function autoFarm()
    spawn(function()
        while getgenv().farm == true do
                local Tools = filter(GetDescendants(Services.Workspace), function(i,v) -- line 222 and 26   
        return IsA(v, "Tool") and FindFirstChild(v, "Handle"); -- 60 and 61
    end)
    UnequipTools(GetHumanoid()); -- 157 and 1031
    local ToolAmount = #GetChildren(LocalPlayer.Backpack); -- 59
    for i, v in next, Tools do
        if (v.Handle) then
            firetouchinterest(v.Handle, GetRoot(), 0); --342 to 369
            wait();
            firetouchinterest(v.Handle, GetRoot(), 1);
        end
    end
    wait();
    UnequipTools(GetHumanoid()); -- 157 and 1031
    wait()
    break
        end
    end)
end

function easyTP(placeCFrame)
	local player = game.Players.LocalPlayer;
	if player.Character then
		player.Character.HumanoidRootPart.CFrame = placeCFrame
	end
end

function tpForge()
    easyTP(game:GetService("Workspace").Forging.Part.CFrame)
end

function tpNight()
	easyTP(game:GetService("Workspace")["Night's anvil plate"].Part.CFrame)
end

function tpRiver()
	easyTP(game:GetService("Workspace")["Red dimension"].HeartyFall.Red2.CFrame)
end

function tpUpgrade()
	easyTP(game:GetService("Workspace").upgrader.blood.a.CFrame)
end

function tradeCenter()
	easyTP(game:GetService("Workspace")["Reworked_Trade_Center"].Teleport.CFrame)
end

function darkOrb()
	easyTP(game:GetService("Workspace").orb.Part.CFrame)
end

function uselessHole()
	easyTP(game:GetService("Workspace")["The hole"].Part.CFrame)
end

function trader()
	easyTP(game:GetService("Workspace")["Red Tree"].RedTreePortal.CFrame)
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local Window = Library.CreateLib("World of Trollge", "Synapse")
local Home = Window:NewTab("Home")
local Tab = Window:NewTab("Autos")
local Tab2 = Window:NewTab("TP's")
local Tab3 = Window:NewTab("Kill Bosses")
local Tab5 = Window:NewTab("Others")

local home = Home:NewSection("Home")
local sec1 = Tab:NewSection("Autos")
local sec2 = Tab2:NewSection("TP's")
local sec3 = Tab3:NewSection("Bosses")
local sec5 = Tab5:NewSection("Others")


home:NewLabel("use normal trolls while using this")
home:NewLabel("Credits to fates admin script")
home:NewLabel("Credits to r1ck#6969 for making most of this")



--------------------------------------------------------------------------------------- tab 1

sec1:NewToggle("Auto Farm", "This farms EVERYTHING (self explanatory)", function(state)
        getgenv().farm = state
        while state == true do
            autoFarm()
        wait(.1)
    end
end)

------------------------------------------------- tab 2

sec2:NewButton("Forge", "teleports to the forge", function()
    tpForge()
end)

sec2:NewButton("Heart River", "teleports to the hearty river", function()
	tpRiver()
end)

sec2:NewButton("Upgrader", "teleports to the upgrader", function()
	tpUpgrade()
end)

sec2:NewButton("Trade Center", "teleports to the trade center", function()
	tradeCenter()
end)

sec2:NewButton("Dark Orb Creator", "teleports to the dark orb creator", function()
	darkOrb()
end)

sec2:NewButton("Night Essence Creator", "teleports to the night essence creator", function()
	tpNight()
end)

sec2:NewButton("Useless Hole", "teleports to the useless hole", function()
	uselessHole()
end)

sec2:NewButton("Trader (Tree)", "teleports to the tree trader place", function()
	trader()
end)
---------------------------------------------------------------------------------------------------- tab 3

sec3:NewButton("Kill Night Crawler (only works in private server)", "kills the boss that is in your private server", function()
    if game:GetService("Workspace")["night crawler"].Humanoid then
        game:GetService("Workspace")["night crawler"].Humanoid.Health = 0
    end
end)

sec3:NewButton("Kill Crazy Trollge (only works in private server)", "kills the boss that is in your private server", function()
    if game:GetService("Workspace")["crazy trollge"].Humanoid then
        game:GetService("Workspace")["crazy trollge"].Humanoid.Health = 0
    end
end)

sec3:NewButton("Kill Tech Boss (only works in private server)", "kills the boss that is in your private server", function()
    if game:GetService("Workspace").tech.Humanoid then
        game:GetService("Workspace").tech.Humanoid.Health = 0
    end
end)
---------------------------------------------------------------------- tab 5

sec5:NewKeybind("Hide UI", "KeybindInfo", Enum.KeyCode.M, function()
	Library:ToggleUI()
end)

sec5:NewButton("Fates Admin", "Injects Fates Admin", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"))()
end)

sec5:NewButton("Dark Dex", "Injects Dark Dex", function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/potatosbruh/scripts/main/dex%20cuz%20i%20cant%20find%20online/darkdex.lua', true))()
end)

sec5:NewSlider("Walkspeed", "changes ur walkspeed", 200, 5, function(s) -- 500 (MaxValue) | 0 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

sec5:NewSlider("JumpPower", "changes ur jump power", 500, 25, function(s) -- 500 (MaxValue) | 0 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)
