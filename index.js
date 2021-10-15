
const chokidar = require('chokidar');
const luabundle = require('lua-bundler');
const path = require('path');
const fs = require('fs');
const { execFile } = require('child_process');
const { program } = require('commander');

program
  .option('-a, --auto-restart', '테스트플레이 자동재시작')
  .option('-w, --watch', '파일변경감시')
  .option('-h, --help', '도움말')
program.parse(process.argv);

const options = program.opts();



const build = () => {
  const src_server = './src/ServerScripts/index.lua'
  const src_client = './src/Scripts/index.lua'
  const line = () => {
    for (let i = 0; i < 106; i++){
      process.stdout.write('─'); 
    }
    process.stdout.write('\n');
  }

  line()
  if (fs.existsSync(path.resolve(src_server))) {
    luabundle.toFile(path.resolve(src_server), path.resolve('./ServerScripts/___bundle.lua'));
    console.log("\u001b[32m✔ \u001b[33m서버 스크립트 빌드완료. \u001b[0m");
  } else {
    console.error(`${src_server} 파일이 존재하지 않습니다!!!!`);
  }
  
  if (fs.existsSync(path.resolve(src_client))) {
    luabundle.toFile(path.resolve(src_client), path.resolve('./Scripts/___bundle.lua'));
    console.log("\u001b[32m✔ \u001b[34m클라이언트 스크립트 빌드완료. \u001b[0m");
  } else {
    console.error(`${src_client} 파일이 존재하지 않습니다!!!!`)
  }
  line()
  
  // -a command
  if (options.autoRestart) {
    console.log('⏩ 자동 재시작 . . . . . .');
    execFile('./restart_testplay.exe');
  }
}

// -w command
if (options.watch) {
  const watcher = chokidar.watch('./src/', { ignoreInitial: true });
  const date = () => "(\u001b[35m " + new Date().toLocaleTimeString() + " \u001b[0m)"
  
  const changed = [];
  const check = (path) => {
    if (!changed.includes(path)) {
      changed.push(path)
    }
    console.log(`  현재까지 변경된 파일 : ${changed.length} 개 `)
  }
  watcher
    .on('ready', () => {
      console.clear()
      console.log("\u001b[34m  실시간 감시모드를 시작합니다!!\u001b[0m ( 종료하려면 : Ctrl + C )")
    })
    .on('all',(_,path) => {
      check(path)
      console.log("\u001b[34m  실시간 감시모드 실행중 . . . . . . \u001b[0m( 종료하려면 : Ctrl + C )")
    })
    .on('add', (path,stats) => {
      build();
      console.clear()
      console.log(`\u001b[32m✔ [Add] 파일변경을 감지했습니다 : ${path} \u001b[0m - ${ stats.size } byte` , date());
    })
    .on('change', ( path, stats ) => {
      build();
      console.clear()
      console.log(`\u001b[32m✔ [Change] 파일변경을 감지했습니다 : ${path} \u001b[0m - ${ stats.size } byte` , date());
    })
    .on('unlink', path => {
      build();
      console.clear()
      console.log(`\u001b[31m❌ [Unlink] 파일변경을 감지했습니다 : ${path} \u001b[0m` , date());
    })
}

// -h command
if (options.help) {
  const text =
    "\n\
    \u001b[1m사용방법:\u001b[0m\n\
    터미널에 node index.js [ 명령어 ] 입력\n\
    \n\
    \u001b[1m옵션:\u001b[0m\n\
    -w, --watch                     실시간 감시모드입니다. src폴더 내에 변경된 파일을 자동으로 빌드해줍니다.\n\
    -a, --auto-restart              테스트 플레이를 자동으로 재시작 해줍니다.\n\
    "
  console.log(text)
} else {
  build();
}

