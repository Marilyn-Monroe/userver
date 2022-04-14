#pragma once

/// @file userver/server/request/task_inherited_data.hpp
/// @brief @copybrief server::request::TaskInheritedData

#include <string>

#include <userver/engine/task/inherited_variable.hpp>

USERVER_NAMESPACE_BEGIN

namespace server::request {

/// @brief Per-request data that should be available inside handlers
struct TaskInheritedData final {
  /// The static path of the handler
  const std::string* path;

  /// The method of the request
  const std::string& method;
};

inline engine::TaskInheritedVariable<TaskInheritedData> kTaskInheritedData;

}  // namespace server::request

USERVER_NAMESPACE_END
