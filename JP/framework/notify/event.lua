slot1 = setmetatable
slot2 = string
slot3 = error
slot4 = unpack
slot5 = require("Framework.notify.double-queue")
slot6 = ":"
slot7 = {
	New = function ()
		return uv0({
			stopped = false,
			events = {}
		}, uv1)
	end
}
slot8 = {}
slot9 = {
	__index = slot8
}

slot10 = function()
	return {
		handlers = uv0.New(),
		pre_emits = uv0.New(),
		post_emits = uv0.New(),
		blocked_handlers = {},
		subevents = {}
	}
end

slot11 = function(slot0)
	slot1 = {}
	slot5 = uv1

	for slot5 in uv0.gmatch(slot0, "[^" .. slot5 .. "]+") do
		slot1[#slot1 + 1] = slot5
	end

	return slot1
end

slot12 = function(slot0, slot1)
	slot0.events[slot2[1]] = slot0.events[uv0(slot1)[1]] or uv1()

	for slot7 = 2, #slot2 do
		slot8 = slot3.subevents[slot2[slot7]] or uv1()
		slot3.subevents[slot2[slot7]] = slot8
		slot3 = slot8
	end

	return slot3
end

slot13 = function(slot0, slot1)
	if not slot0.events[uv0(slot1)[1]] then
		return true
	end

	for slot7 = 2, #slot2 do
		if not slot3.subevents[slot2[slot7]] then
			return true
		end

		slot3 = slot8
	end

	return false
end

slot14 = function(slot0, slot1)
	slot3 = 2
	slot4 = slot0.events[uv0(slot1)[1]]

	return function ()
		if not uv0 then
			return
		end

		slot0 = uv0

		if uv1[uv2] then
			uv0 = uv0.subevents[uv1[uv2]]
			uv2 = uv2 + 1
		else
			uv0 = nil
		end

		return slot0
	end
end

slot15 = function(slot0, slot1)
	slot2 = uv0.New()
	slot3 = uv0.New()

	for slot7 in uv1(slot0, slot1) do
		for slot11 in slot7.pre_emits:get_iterator() do
			slot11(slot1)
		end

		slot2:push_back(slot7)
		slot3:push_front(slot7)
	end

	return slot2, slot3
end

slot16 = function(slot0, slot1)
	for slot5 in slot1:get_iterator() do
		for slot9 in slot5.post_emits:get_iterator() do
			slot9(slot0)
		end
	end
end

slot17 = function(slot0, slot1)
	for slot5 in slot1.nodes:get_iterator() do
		for slot9 in slot5.handlers:get_iterator() do
			if slot0.stopped then
				return
			end

			if slot5.blocked_handlers[slot9] == 0 then
				if slot1.accumulator then
					slot1.accumulator(slot9(slot1.event_name, unpackEx(slot1.args)))
				else
					slot9(slot1.event_name, unpackEx(slot1.args))
				end
			end
		end
	end
end

slot8.connect = function(slot0, slot1, slot2)
	slot3 = uv0(slot0, slot1)

	slot3.handlers:push_back(slot2)

	if not slot3.blocked_handlers[slot2] then
		slot3.blocked_handlers[slot2] = 0
	end
end

slot8.disconnect = function(slot0, slot1, slot2)
	if uv0(slot0, slot1) then
		return
	end

	slot3 = uv1(slot0, slot1)

	slot3.handlers:remove(slot2)

	slot3.blocked_handlers[slot2] = nil
end

slot8.chectConnect = function(slot0, slot1)
	return not uv0(slot0, slot1)
end

slot8.block = function(slot0, slot1, slot2)
	if uv0(slot0, slot1) then
		return
	end

	if uv1(slot0, slot1).blocked_handlers[slot2] then
		slot3.blocked_handlers[slot2] = slot4 + 1
	end
end

slot8.unblock = function(slot0, slot1, slot2)
	if uv0(slot0, slot1) then
		return
	end

	if uv1(slot0, slot1).blocked_handlers[slot2] and slot3.blocked_handlers[slot2] > 0 then
		slot3.blocked_handlers[slot2] = slot3.blocked_handlers[slot2] - 1
	end
end

slot8.emit = function(slot0, slot1, ...)
	slot0.stopped = false
	slot2, slot3 = uv0(slot0, slot1)

	uv1(slot0, {
		event_name = slot1,
		nodes = slot2,
		args = packEx(...)
	})
	uv2(slot1, slot3)
end

slot8.emit_with_accumulator = function(slot0, slot1, slot2, ...)
	slot0.stopped = false
	slot3, slot4 = uv0(slot0, slot1)

	uv1(slot0, {
		event_name = slot1,
		nodes = slot3,
		accumulator = slot2,
		args = packEx(...)
	})
	uv2(slot1, slot4)
end

slot8.add_pre_emit = function(slot0, slot1, slot2)
	uv0(slot0, slot1).pre_emits:push_back(slot2)
end

slot8.remove_pre_emit = function(slot0, slot1, slot2)
	if uv0(slot0, slot1) then
		return
	end

	uv1(slot0, slot1).pre_emits:remove(slot2)
end

slot8.add_post_emit = function(slot0, slot1, slot2)
	uv0(slot0, slot1).post_emits:push_front(slot2)
end

slot8.remove_post_emit = function(slot0, slot1, slot2)
	if uv0(slot0, slot1) then
		return
	end

	uv1(slot0, slot1).post_emits:remove(slot2)
end

slot8.stop = function(slot0)
	slot0.stopped = true
end

slot8.clear = function(slot0, slot1)
	if not slot1 then
		slot0.events = {}

		return
	end
end

slot18 = slot7.New()

slot7.get_global_event = function()
	return uv0
end

return slot7
