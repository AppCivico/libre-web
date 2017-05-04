# Middleman Custom Tag Helpers
module CustomTagHelpers

	# custom input tag creator
	# USAGE: custom_input fields[:email]
  def custom_input(f)
		return tag :input, {
			type: f.type,
			name: f.name,
			id: f.id || f.name,
			required: f.required || false,
			value: f.value || '',
			class: f.styles || '',
			placeholder: f.label || '',
			readonly: f.readonly || false,
			disabled: f.disabled || false,
			data: f.data || {}
		}
	end

	# custom help block creator
	# USAGE:  custom_helpblock fields[:email]
  def custom_helpblock(f)
		return content_tag :small {|t| return f.help } if f.help
	end


end
