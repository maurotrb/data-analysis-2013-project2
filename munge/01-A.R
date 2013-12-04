## @knitr invalid_cols
colnames(samsungData) <- gsub('\\(|\\)',"",names(samsungData), perl = TRUE)
colnames(samsungData) <- make.names(names(samsungData))

## @knitr repeated_cols
colnames(samsungData)[303:316] = paste(colnames(samsungData)[303:316],".X",sep="")
colnames(samsungData)[317:330] = paste(colnames(samsungData)[317:330],".Y",sep="")
colnames(samsungData)[331:344] = paste(colnames(samsungData)[331:344],".Z",sep="")
colnames(samsungData)[382:395] = paste(colnames(samsungData)[382:395],".X",sep="")
colnames(samsungData)[396:409] = paste(colnames(samsungData)[396:409],".Y",sep="")
colnames(samsungData)[410:423] = paste(colnames(samsungData)[410:423],".Z",sep="")
colnames(samsungData)[461:474] = paste(colnames(samsungData)[461:474],".X",sep="")
colnames(samsungData)[475:488] = paste(colnames(samsungData)[475:488],".Y",sep="")
colnames(samsungData)[489:502] = paste(colnames(samsungData)[489:502],".Z",sep="")

## @knitr activity_factor
samsungData$activity <- as.factor(samsungData$activity)
