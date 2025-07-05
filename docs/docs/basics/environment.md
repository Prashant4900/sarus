---
sidebar_position: 4
---

# Environment 

Sarus provides a way to manage different environments (development, production, etc.) through the `sarus.yaml` configuration file. This allows you to define environment-specific settings and behaviors.

## Configuration File

The `sarus.yaml` file can include an `environment` section where you can specify settings for different environments. For example:

```ts title="sarus.yaml"
env:
  default: production

  flavors:
    development: .env
    staging: .env.staging
    production: .env.prod
```

In this example, the `development` environment uses the `.env` file, the `staging` environment uses the `.env.staging` file, and the `production` environment uses the `.env.prod` file.

You can then reference these environment-specific settings in your Sarus application code, allowing you to easily switch between different configurations based on the current environment.

## Accessing Environment Variables

You can access environment variables in your Sarus application using the `SarusEnv` class. For example:

```jsx title="sarus_application.dart"
@override
  Future<void> setup() async {
    try {
      await SarusEnv.load();
    } catch (e) {
      print('Failed to setup dependencies injection: $e');
    }
}
```

This code snippet demonstrates how to load the environment variables defined in your `sarus.yaml` file. The `SarusEnv.load()` method will read the appropriate environment file based on the current environment setting.

## Example Usage

You can use the environment variables in your application code as follows:

```jsx title="greeting/endpoints.dart"
@Endpoint(path: '/greeting')
class GreetingEndpoints extends Endpoints {
  GreetingEndpoints() : super();

  @Get()
  Future<Response> index(Request request) async {
    final flavor = SarusEnv.get('FLAVOR', defaultValue: 'default');

    return Response.ok(
      jsonEncode({
        'message': 'Hello from GreetingEndpoint $flavor',
      }),
    );
  }

  @override
  RouterConfig get router => _$greetingEndpointsRouterConfig(this);
}
```

In this example, the `SarusEnv.get()` method retrieves the value of the `FLAVOR` environment variable, providing a default value if it is not set. This allows you to customize the behavior of your endpoints based on the current environment.

## Conclusion

Using environments in Sarus allows you to manage different configurations for your application easily. By defining environment-specific settings in the `sarus.yaml` file and accessing them through the `SarusEnv` class, you can create flexible and maintainable applications that adapt to different deployment scenarios.
