module.exports = function (grunt) {
    grunt.initConfig({
        pkg: grunt.file.readJSON("package.json"),
        settings: grunt.file.readJSON("settings.tfx.json"),
        exec: {
            update: {
                command: "npm up --save-dev",
                stdout: true,
                stderr: true
            },
            publish_task: {
                command: "tfx build tasks upload --token <%= settings.publish.token %> --auth-type pat --task-path ./ExampleTask --service-url <%= settings.serviceUrl %>",
                stdout: true,
                stderr: true
            },
            install_ext: {
                command: "tfx extension install --token <%= settings.publish.token %> --auth-type pat --service-url <%= settings.publish.galleryUrl %> --accounts <%= settings.publish.shareWith %> --publisher <%= settings.publish.publisher %> --extension-id <%= settings.package.id %>",
                stdout: true,
                stderr: true
            },
            unshare_ext: {
                command: "tfx extension unshare --token <%= settings.publish.token %> --auth-type pat --service-url <%= settings.publish.galleryUrl %> --unshare-with <%= settings.publish.shareWith %> --publisher <%= settings.publish.publisher %> --extension-id <%= settings.package.id %>",
                stdout: true,
                stderr: true
            },
            share_ext: {
                command: "tfx extension share --token <%= settings.publish.token %> --auth-type pat --service-url <%= settings.publish.galleryUrl %> --share-with <%= settings.publish.shareWith %> --publisher <%= settings.publish.publisher %> --extension-id <%= settings.package.id %>",
                stdout: true,
                stderr: true
            },
            publish_ext: {
                command: "tfx extension publish --token <%= settings.publish.token %> --auth-type pat --service-url <%= settings.publish.galleryUrl %> --publisher <%= settings.publish.publisher %>",
                stdout: true,
                stderr: true
            },
            package: {
                command: "tfx extension create --manifest-globs <%= settings.package.manifestGlobs %> --extension-id <%= settings.package.id %>",
                stdout: true,
                stderr: true
            }
        },
        jasmine: {
            src: ["scripts/**/*.js"],
            specs: "test/**/*[sS]pec.js",
            helpers: "test/helpers/*.js"
        }
    });

    grunt.loadNpmTasks("grunt-exec");
    grunt.loadNpmTasks("grunt-contrib-copy");
    grunt.loadNpmTasks("grunt-contrib-jasmine");
};