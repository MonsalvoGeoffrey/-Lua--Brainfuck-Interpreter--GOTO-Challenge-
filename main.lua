-- Data

data_line = {} -- Fill with 0s in the for loop
pointer = 1
code = "+[-->-[>>+>-----<<]<--<---]>-.>>>+.>>..+++[.>]<<<<.+++.------.<<-.>>>>+."--input()
reader = 1
skip_level = 0


-- For loop
from = 1
to = 30000
at = from

::loop_start::
data_line[at] = 0
at = at + 1
if at <= to then goto loop_start end




-- Interpretation

::main_loop::
current = code:sub(reader, reader)





if current == ">" then goto right end
if current == "<" then goto left end
if current == "+" then goto add end
if current == "-" then goto substract end
if current == "," then goto get_input end
if current == "." then goto output end
if current == "[" then goto open_loop end
if current == "]" then goto close_loop end




goto next




::next::

reader = reader + 1
if reader <= #code then goto main_loop end
goto end_program






-- Function
::right::
pointer = pointer + 1
if pointer > 30000 then goto wrap_left end
goto next

::left::
pointer = pointer - 1
if pointer <= 0 then goto wrap_right end
goto next

::add::
data_line[pointer] = data_line[pointer] + 1
if data_line[pointer] > 255 then goto wrap_down end
goto next

::substract::
data_line[pointer] = data_line[pointer] - 1
if data_line[pointer] < 0 then goto wrap_up end
goto next

::get_input::
data_line[pointer] = string.byte(io.read(1))
goto next

::output::
io.write(string.char(data_line[pointer]))
goto next

::open_loop::
if data_line[pointer] == 0 then goto move_forward end
goto next

::close_loop::
if data_line[pointer] > 0 then goto move_backward end
goto next


::wrap_up::
data_line[pointer] = 255
goto next
::wrap_down::
data_line[pointer] = 0
goto next
::wrap_right::
pointer = 30000
goto next
::wrap_left::
pointer = 1
goto next


::move_forward::
skip_level = 1
-- While loop
::while_start_forward::
reader = reader + 1
current = code:sub(reader, reader)
if current == "[" then goto increment_forward end
if current == "]" then goto decrement_forward end
::return_forward::
if skip_level > 0 then goto while_start_forward end


goto next

::increment_forward::
skip_level = skip_level + 1
goto return_forward
::decrement_forward::
skip_level = skip_level - 1
goto return_forward




::move_backward::
skip_level = 1
-- While loop
::while_start_backward::
reader = reader - 1
current = code:sub(reader, reader)
if current == "[" then goto decrement_backward end
if current == "]" then goto increment_backward end
::return_backward::
if skip_level > 0 then goto while_start_backward end
goto next

::increment_backward::
skip_level = skip_level + 1
goto return_backward
::decrement_backward::
skip_level = skip_level - 1
goto return_backward
















::end_program::
