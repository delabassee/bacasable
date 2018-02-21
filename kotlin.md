


If you just wan to know how to use Kotlin to write functions on top of Fn, you can skip the next section and go directly to "". Heads-up, it's quite short!

The goal of an FDK is to simplify the development of functions for a given language. For example, the Java FDK allows the development of (Java based) functions using typical Java tools (ex. Maven for building the function and manage its dependencies, JUnit for testing this function). Some FDKs are also adding extra capabilities like Data Binding for function input and output [or is it called 'input and output coercions'?](see https://github.com/fnproject/fdk-java/blob/master/docs/DataBinding.md), support for Fn Flow, etc.


Fn Project comes with various Function Development Kits : Java, Go, Python, Ruby, Node (experimental) and Rust (experimental).

FDKs are very helpfull but it is certainly also possible to write functions without such FDK. And given that Fn is using containers, it is relatively straight forward to add  support for new languages in Fn. To illustrate this, here is a quick overview that shows how I have added Kotlin support in Fn. 

Languages are supported via the Fn CLI (https://github.com/fnproject/cli); each supported language has its own specific helper (https://github.com/fnproject/cli/tree/master/langs). Those helpers are responsible for generating some boilerplate, i.e. a simple function and its eventual related files like a POM.xml for a Java function, a simple test harness, the function configuration file (func.yaml), etc. Helpers are registered here (https://github.com/fnproject/cli/blob/master/langs/base.go#L12-L26)

To add support for a new compiled language, you need to know how to compile this language, how to run the compiled artefact and a little bit of Go to actually write the corresponding Fn language helper.

Here is how I've added Kotlin support in Fn.

The Kotlin helper is pretty straigtforward, see
https://github.com/fnproject/cli/blob/master/langs/kotlin.go

https://github.com/fnproject/cli/blob/db4334233b35e419ac616a3fb0a41d2e8972c1c6/langs/kotlin.go#L45-L79 will generate the boilerplate function and the simple test harness.

https://github.com/fnproject/cli/blob/db4334233b35e419ac616a3fb0a41d2e8972c1c6/langs/kotlin.go#L29-L37 specifies the Docker images to use. The Build image will be invoked to compile the Kotlin function and produce a JAR, the Run image will be used to run that JAR. In this case, the kotlin code will be compiled to JavaByte code so we can use the standard Java FDK Docker image. This will offers some nice freebies such as input and outpout type c  Those entry will be added to the func.yaml configuration.

https://github.com/fnproject/cli/blob/db4334233b35e419ac616a3fb0a41d2e8972c1c6/langs/kotlin.go#L93-L99 is copying the sources of the function into the (Build) Docker image and add a call to kotlinc to compile the functio.

https://github.com/fnproject/cli/blob/db4334233b35e419ac616a3fb0a41d2e8972c1c6/langs/kotlin.go#L87-L91 will copy the JAR into the (Run) Docker image.

https://github.com/fnproject/cli/blob/db4334233b35e419ac616a3fb0a41d2e8972c1c6/langs/kotlin.go#L82-L84 specify the entry point of the Run image, that' the actual Kotlin function.

The rest is really self explanatory.

Serverless Kotlin 
-----------------

All it takes to generate a Kotlin function is to invoke  'fn init' and specify that you want to use the Kotlin runtime.
'fn init --runtime kotlin myFunc'

This will create a simple barebone HelloWorld function with a simple test harness. The function get some json payload and output some json payload. The input and output coercion is leveraging the ....

To run your Kotlin function, you just need to pass it some json payload. 
'cat in.json | fn run myFunc'

To test it, just invoke 'fn test myFunc'

And obviously, this simple Kotlin function can be deployed to a Fn Server ('fn deploy'), invoked from a Fn Flow, etc.

PS: Koltin support is as such experimental (i.e. read 'not officially supported')
PPS: I am not a Kotlin developer!




-----














Create a new helper for your language

cli/langs/base.go






