# Serverless Kotlin with Fn Project

This post describes how to add additional languages in [Fn Project](https://github.com/fnproject/) and uses Kotlin as an example. If you just want to know how to use Kotlin to write functions on top of Fn, you can skip the next section and go directly to the [Serverless Kotlin](#serverless-kotlin) section below. 

The goal of a Function Development Kit (FDK) is to simplify the development of functions for a given language. For example, the Java FDK allows the development of (Java-based) functions using typical Java tools (ex. Maven for building the function and manage its dependencies, JUnit for testing this function, etc.). The Java FDK also introduces extra capabilities like [Data Binding for function input and output](https://github.com/fnproject/fdk-java/blob/master/docs/DataBinding.md), [Fn Flow](https://github.com/fnproject/flow) support, etc. Fn Project will come with various FDKs: [Java](https://github.com/fnproject/fdk-java), Go, Python, Ruby, Node (experimental) and Rust (experimental).

:exclamation:What is the exact list of FDKs and supoprted langs?:exclamation:

FDKs are very helpful but it is certainly also possible to write functions without a FDK. And given that Fn is using containers, it is also relatively straightforward to add support for new languages. To illustrate this, here is a quick overview that shows how Kotlin support has been added to Fn. 

Languages are supported via the Fn [CLI](https://github.com/fnproject/cli), a Go based application. Each supported language has its own [specific helper](https://github.com/fnproject/cli/tree/master/langs). Those helpers are responsible for generating some boilerplate, i.e. a simple function and its eventual related files like a POM.xml for a Java function, a simple test harness, the function configuration file (func.yaml), etc. Those helpers are registered [here](https://github.com/fnproject/cli/blob/master/langs/base.go#L12-L26).

To add support for a new compiled language, you need to know how to compile this language, how to run the compiled artifact and a little bit of Go to actually write the corresponding Fn language helper.

The [Kotlin helper](https://github.com/fnproject/cli/blob/master/langs/kotlin.go) is pretty straightforward :
* [GenerateBoilerplate()](https://github.com/fnproject/cli/blob/db4334233b35e419ac616a3fb0a41d2e8972c1c6/langs/kotlin.go#L45-L79) will generates the boilerplate function and the simple test harness.

* [BuildFromImage() and RunFromImage()](https://github.com/fnproject/cli/blob/db4334233b35e419ac616a3fb0a41d2e8972c1c6/langs/kotlin.go#L29-L37) specify the Docker images to use. The Build image will be invoked to compile the Kotlin function into a JAR while the Run image will be used to run that JAR. In this particular case, the Kotlin code will be compiled to JavaByte code so we can use the standard Java FDK Docker image. This will give us some nice freebies such as function input and output binding. Those 2 entries will be added to the function configuration file (func.yaml).

* [DockerfileBuildCmds()](https://github.com/fnproject/cli/blob/db4334233b35e419ac616a3fb0a41d2e8972c1c6/langs/kotlin.go#L93-L99) is copying the sources of the function into the (Build) Docker image and add a call to *kotlinc* to compile the function.

* [DockerfileCopyCmds()](https://github.com/fnproject/cli/blob/db4334233b35e419ac616a3fb0a41d2e8972c1c6/langs/kotlin.go#L87-L91) is copying the function JAR into the (Run) Docker image.

* [Cmd()](https://github.com/fnproject/cli/blob/db4334233b35e419ac616a3fb0a41d2e8972c1c6/langs/kotlin.go#L82-L84) specify the entry point of the (Run) Docker image, it is the actual Kotlin function prefixed with its class name.

The rest is really self-explanatory. Browsing [base.go](https://github.com/fnproject/cli/blob/db4334233b35e419ac616a3fb0a41d2e8972c1c6/langs/base.go) might also be useful to grasp how things work. And that's really it! The [Kotlin language helper](https://github.com/fnproject/cli/blob/master/langs/kotlin.go) is really simple as all the (Docker) plumbing is handled by Fn.

## Serverless Kotlin 

All it takes to generate a Kotlin function is to invoke 'fn init' command and specify that you want to use the Kotlin runtime, i.e. that you want to use the Kotlin language helper.

```fn init --runtime kotlin kotfunc```

This will create a simple barebone HelloWorld function with a simple test harness. This function gets some JSON payload and outputs some JSON payload. The input and output coercion is transparently provided by the Java FDK.

```kotlin
class Input ( var name: String = "")
class Response( var message: String = "Hello World" )

fun hello(param: Input): Response {

	var response = Response()

	if (param.name.isNotEmpty()) {
		response.message = "Hello " + param.name
	}

	return response
}
```

The rest is pretty standard. To run your Kotlin function, you just need to pass it some appropriate JSON payload.

```echo '{"name":"Kotlin"}' | fn run kotfunc```

You can test your Kotlin function as you would do with any another function.

```fn test kotfunc```

And obviously, this Kotlin function can be deployed to a Fn Server (```fn deploy```), invoked from a Fn Flow, etc.

PS: Koltin support is, as such, still experimental, i.e. _'not officially supported'_.


