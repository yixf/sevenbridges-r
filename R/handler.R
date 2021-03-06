#' Handler instance
#' 
#' Create Handler instance
#' 
#' Used for parse R markdown and lift into command line interface, dockerfile, docker container and cwl json.
#' 
#' @field dockerfileHandler a function or NULL, how you handle Dockefile, for example, push it to github
#' @filed dockerHandler a function or NULL, how you handle local docker container, for example, push it to dockerhub
#' @filed cwlHandler a function or NULL, how you handle cwl json file or yaml file, for example, push it sevenbridges platform as app.
#' 
#' @return a Handler object
Handler = setRefClass("Handler",
                       fields = list(dockerfileHandler = "functionORNULL",
                                     dockerHandler = "functionORNULL", 
                                     cwlHandler = "functionORNULL"))


gitHandler = function(token = NULL){
    
}

dockerhubHandler = function(token = NULL){
    ## first login as docker hub
    ## then push docker from dockerfile
}

sevendockerHandler = function(token = NULL){
    
}

SevenHandler = function(input = NULL, 
                         token = NULL, 
                         platform = NULL,
                         dockerReg = NULL, # 
                         dockerfile = NULL){
    
    ## CGC handler
    dockerfileHandler = function(){
        message("don't push dockerfile by default")
    }
    
    dockerHandler = function(){
        message("do nothing")
    }
    
    cwlHandler = function(){
        message("do nothing")
    }
    
    Handler(dockerfileHandler = dockerfileHandler,
            dockerHandler = dockerHandler,
            cwlHandler = cwlHandler)
}

## Creat CGC handler
## Create SBG handler

## lift R markdown into everything
lift = function(input = NULL, output_dir = NULL, 
                      shebang = "#!/usr/local/bin/Rscript") {
    
    opt_all_list = liftr::parse_rmd(input)
    
    inl <- IPList(lapply(opt_all_list$rabix$inputs, function(i){
        do.call(sevenbridges::input, i)
    }))
    
    ## insert the script
    docker.fl <- file.path(normalizePath(output_dir), 'Dockerfile')
    message(docker.fl)
    
    ## add script
    write(paste("COPY", basename(normalizePath(tmp)), "/usr/local/bin/"), 
          file = docker.fl, 
          append = TRUE)
    write("RUN mkdir /report/", 
          file = normalizePath(docker.fl), 
          append = TRUE)
    ## add report
    report.file <- file.path(normalizePath(output_dir), basename(input))
    file.copy(input, report.file)
    write(paste("COPY", basename(input), "/report/"), 
          file = docker.fl, 
          append = TRUE)
    
}


