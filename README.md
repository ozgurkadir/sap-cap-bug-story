# Bug-Story

Bug-Story is a sample project management application developed by SAP Cloud Application Programming Model (CAP)

Contains these features of CAP :

- Authentication & Authorization (XSUAA and approuter )
- Custom actions
- Fiori elements UI's (List Report - Object Page & Overview Page)
- Project "Piper" based simple Jenkins pipeline (Jenkins instance is required)
- Multitarget Application (MTA)



File / Folder | Purpose
---------|----------
`app/` | content for UI frontends go here
`db/` | domain models and data go here
`srv/` | service models and code go here
`package.json` | project metadata and configuration
`readme.md` | this getting started guide

## DEMO

![](demo/bug-story-demo.gif.gif)

## Next Steps...
```sh
- git clone https://github.com/ozgurkadir/bug-story.git
- cd bug-story
- Open a new terminal and run  `cds watch`
- ( in VSCode simply choose _**Terminal** > Run Task > cds watch_ )
- Start adding content, e.g. a [db/schema.cds](db/schema.cds), ...
```

## Deploy to Cloud Foundry Environment
Simply run these commands to deploy your own Cloud Foundry Environment
```sh
mbt build -t ./
cf deploy bug-story_1.0.0.mtar
```

## Learn more...

Learn more at https://cap.cloud.sap/docs/get-started/
