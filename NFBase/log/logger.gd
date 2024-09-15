class_name NFB_Logger
extends RefCounted



const LOG_FILENAME : StringName = &"log.log"



var log_data : NFB_LogData = NFB_LogData.new()
var file : FileAccess = null



func _init(path : String = NFB_DirectoryUtilities.get_executable_directory() + LOG_FILENAME) -> void:
	file = NFB_FileUtilities.open_writeonly_file(path)



func log(message : Variant, level : StringName = NFB_LogData.LEVEL_UNKNOWN) -> void:
	var item : NFB_LogData.LogItem = NFB_LogData.LogItem.new(message, level)
	log_data.log_items.append(item)
	file.store_line(str(item))
	file.flush()
	
	match level:
		NFB_LogData.LEVEL_DEBUG:
			print(message)
			print_stack()
		
		NFB_LogData.LEVEL_WARNING:
			push_warning(message)
		
		NFB_LogData.LEVEL_ERROR:
			push_error(message)
		
		_:
			print(message)



#region functions

func logu(message : Variant) -> void:
	self.log(message, NFB_LogData.LEVEL_UNKNOWN)

func logd(message : Variant) -> void:
	self.log(message, NFB_LogData.LEVEL_DEBUG)

func logi(message : Variant) -> void:
	self.log(message, NFB_LogData.LEVEL_INFO)

func logw(message : Variant) -> void:
	self.log(message, NFB_LogData.LEVEL_WARNING)

func loge(message : Variant) -> void:
	self.log(message, NFB_LogData.LEVEL_ERROR)

#endregion
