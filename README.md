#copy the podcasts into the content folder.
cp -r ../tomecast-podcasts/* ./content

#copy the metadata.md files into the archetypes folder.
#https://stackoverflow.com/questions/17387721/how-to-move-and-rename-files-based-on-parent-folder-in-linux
#cd ./content && find -type d -exec mv -n -- {}/metadata.json ../archetypes/{}.json \;
#OR
cd ./content && find -type d -exec mv -n -- {}/metadata.json ../data/{}.json \;

#for the content files, make sure that we rename the extension to md, instead of json so that hugo will process them. 
find ./content -type f -name "*.json" -print0 | xargs -0 rename 's/.json$/.md/'


        {{range $key, $val := .Site.Data}}
        {{ end }}
