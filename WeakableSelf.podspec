Pod::Spec.new do |s|
  s.name             = 'WeakableSelf'
  s.version          = '1.1.0'
  s.summary          = 'A Swift micro-framework to easily deal with weak references to self inside closures'

  s.description      = <<-DESC
Closures are one of Swift must-have features, and Swift developers are aware of how tricky they can be when they capture the reference of an external object, especially when this object is self.

To deal with this issue, developers are required to write additional code, using constructs such as [weak self] and guard, and the result looks like the following:

service.call(completion: { [weak self] result in
    guard let self = self else { return }

    // use weak non-optional `self` to handle `result`
})

The purpose of this micro-framework is to provide the developer with a helper function weakify that will allow him to declaratively indicate that he wishes to use a weak non-optional reference to self in closure, and not worry about how this reference is provided.

Using this weakify function, the code above will be transformed into the much more concise:

import WeakableSelf

service.call(completion: weakify { result, strongSelf in
    // use weak non-optional `strongSelf` to handle `result`
})

`weakify` works with closures that take up to 7 arguments.
                       DESC

  s.homepage         = 'https://github.com/vincent-pradeilles/weakable-self'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Vincent Pradeilles' => 'vin.pradeilles+weakableself@gmail.com' }
  s.source           = { :git => 'https://github.com/vincent-pradeilles/weakable-self.git', :tag => s.version.to_s }

  s.swift_version = '4.2'

  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.watchos.deployment_target = "3.0"

  s.framework = 'Foundation'

  s.source_files = 'Sources/**/*.swift'

end
