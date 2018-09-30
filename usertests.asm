
_usertests: formato do arquivo elf32-i386


Desmontagem da seção .text:

00000000 <main>:
  return randstate;
}

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "usertests starting\n");
      11:	68 be 4d 00 00       	push   $0x4dbe
      16:	6a 01                	push   $0x1
      18:	e8 93 3a 00 00       	call   3ab0 <printf>

  if(open("usertests.ran", 0) >= 0){
      1d:	5a                   	pop    %edx
      1e:	59                   	pop    %ecx
      1f:	6a 00                	push   $0x0
      21:	68 d2 4d 00 00       	push   $0x4dd2
      26:	e8 77 39 00 00       	call   39a2 <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	85 c0                	test   %eax,%eax
      30:	78 14                	js     46 <main+0x46>
    printf(1, "already ran user tests -- rebuild fs.img\n");
      32:	83 ec 08             	sub    $0x8,%esp
      35:	68 3c 55 00 00       	push   $0x553c
      3a:	6a 01                	push   $0x1
      3c:	e8 6f 3a 00 00       	call   3ab0 <printf>
    exit();
      41:	e8 1c 39 00 00       	call   3962 <exit>
  }
  close(open("usertests.ran", O_CREATE));
      46:	50                   	push   %eax
      47:	50                   	push   %eax
      48:	68 00 02 00 00       	push   $0x200
      4d:	68 d2 4d 00 00       	push   $0x4dd2
      52:	e8 4b 39 00 00       	call   39a2 <open>
      57:	89 04 24             	mov    %eax,(%esp)
      5a:	e8 2b 39 00 00       	call   398a <close>

  argptest();
      5f:	e8 2c 36 00 00       	call   3690 <argptest>
  createdelete();
      64:	e8 c7 11 00 00       	call   1230 <createdelete>
  linkunlink();
      69:	e8 b2 1a 00 00       	call   1b20 <linkunlink>
  concreate();
      6e:	e8 7d 17 00 00       	call   17f0 <concreate>
  fourfiles();
      73:	e8 b8 0f 00 00       	call   1030 <fourfiles>
  sharedfd();
      78:	e8 f3 0d 00 00       	call   e70 <sharedfd>

  bigargtest();
      7d:	e8 8e 32 00 00       	call   3310 <bigargtest>
  bigwrite();
      82:	e8 b9 23 00 00       	call   2440 <bigwrite>
  bigargtest();
      87:	e8 84 32 00 00       	call   3310 <bigargtest>
  bsstest();
      8c:	e8 0f 32 00 00       	call   32a0 <bsstest>
  sbrktest();
      91:	e8 fa 2c 00 00       	call   2d90 <sbrktest>
  validatetest();
      96:	e8 45 31 00 00       	call   31e0 <validatetest>

  opentest();
      9b:	e8 60 03 00 00       	call   400 <opentest>
  writetest();
      a0:	e8 eb 03 00 00       	call   490 <writetest>
  writetest1();
      a5:	e8 c6 05 00 00       	call   670 <writetest1>
  createtest();
      aa:	e8 91 07 00 00       	call   840 <createtest>

  openiputtest();
      af:	e8 3c 02 00 00       	call   2f0 <openiputtest>
  exitiputtest();
      b4:	e8 47 01 00 00       	call   200 <exitiputtest>
  iputtest();
      b9:	e8 62 00 00 00       	call   120 <iputtest>

  mem();
      be:	e8 dd 0c 00 00       	call   da0 <mem>
  pipe1();
      c3:	e8 58 09 00 00       	call   a20 <pipe1>
  preempt();
      c8:	e8 f3 0a 00 00       	call   bc0 <preempt>
  exitwait();
      cd:	e8 3e 0c 00 00       	call   d10 <exitwait>

  rmdot();
      d2:	e8 59 27 00 00       	call   2830 <rmdot>
  fourteen();
      d7:	e8 14 26 00 00       	call   26f0 <fourteen>
  bigfile();
      dc:	e8 3f 24 00 00       	call   2520 <bigfile>
  subdir();
      e1:	e8 7a 1c 00 00       	call   1d60 <subdir>
  linktest();
      e6:	e8 f5 14 00 00       	call   15e0 <linktest>
  unlinkread();
      eb:	e8 60 13 00 00       	call   1450 <unlinkread>
  dirfile();
      f0:	e8 bb 28 00 00       	call   29b0 <dirfile>
  iref();
      f5:	e8 b6 2a 00 00       	call   2bb0 <iref>
  forktest();
      fa:	e8 d1 2b 00 00       	call   2cd0 <forktest>
  bigdir(); // slow
      ff:	e8 2c 1b 00 00       	call   1c30 <bigdir>

  uio();
     104:	e8 07 35 00 00       	call   3610 <uio>

  exectest();
     109:	e8 c2 08 00 00       	call   9d0 <exectest>

  exit();
     10e:	e8 4f 38 00 00       	call   3962 <exit>
     113:	66 90                	xchg   %ax,%ax
     115:	66 90                	xchg   %ax,%ax
     117:	66 90                	xchg   %ax,%ax
     119:	66 90                	xchg   %ax,%ax
     11b:	66 90                	xchg   %ax,%ax
     11d:	66 90                	xchg   %ax,%ax
     11f:	90                   	nop

00000120 <iputtest>:
int stdout = 1;

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
     120:	55                   	push   %ebp
     121:	89 e5                	mov    %esp,%ebp
     123:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "iput test\n");
     126:	68 64 3e 00 00       	push   $0x3e64
     12b:	ff 35 64 5e 00 00    	pushl  0x5e64
     131:	e8 7a 39 00 00       	call   3ab0 <printf>

  if(mkdir("iputdir") < 0){
     136:	c7 04 24 f7 3d 00 00 	movl   $0x3df7,(%esp)
     13d:	e8 88 38 00 00       	call   39ca <mkdir>
     142:	83 c4 10             	add    $0x10,%esp
     145:	85 c0                	test   %eax,%eax
     147:	78 58                	js     1a1 <iputtest+0x81>
    printf(stdout, "mkdir failed\n");
    exit();
  }
  if(chdir("iputdir") < 0){
     149:	83 ec 0c             	sub    $0xc,%esp
     14c:	68 f7 3d 00 00       	push   $0x3df7
     151:	e8 7c 38 00 00       	call   39d2 <chdir>
     156:	83 c4 10             	add    $0x10,%esp
     159:	85 c0                	test   %eax,%eax
     15b:	0f 88 85 00 00 00    	js     1e6 <iputtest+0xc6>
    printf(stdout, "chdir iputdir failed\n");
    exit();
  }
  if(unlink("../iputdir") < 0){
     161:	83 ec 0c             	sub    $0xc,%esp
     164:	68 f4 3d 00 00       	push   $0x3df4
     169:	e8 44 38 00 00       	call   39b2 <unlink>
     16e:	83 c4 10             	add    $0x10,%esp
     171:	85 c0                	test   %eax,%eax
     173:	78 5a                	js     1cf <iputtest+0xaf>
    printf(stdout, "unlink ../iputdir failed\n");
    exit();
  }
  if(chdir("/") < 0){
     175:	83 ec 0c             	sub    $0xc,%esp
     178:	68 19 3e 00 00       	push   $0x3e19
     17d:	e8 50 38 00 00       	call   39d2 <chdir>
     182:	83 c4 10             	add    $0x10,%esp
     185:	85 c0                	test   %eax,%eax
     187:	78 2f                	js     1b8 <iputtest+0x98>
    printf(stdout, "chdir / failed\n");
    exit();
  }
  printf(stdout, "iput test ok\n");
     189:	83 ec 08             	sub    $0x8,%esp
     18c:	68 9c 3e 00 00       	push   $0x3e9c
     191:	ff 35 64 5e 00 00    	pushl  0x5e64
     197:	e8 14 39 00 00       	call   3ab0 <printf>
}
     19c:	83 c4 10             	add    $0x10,%esp
     19f:	c9                   	leave  
     1a0:	c3                   	ret    
iputtest(void)
{
  printf(stdout, "iput test\n");

  if(mkdir("iputdir") < 0){
    printf(stdout, "mkdir failed\n");
     1a1:	50                   	push   %eax
     1a2:	50                   	push   %eax
     1a3:	68 d0 3d 00 00       	push   $0x3dd0
     1a8:	ff 35 64 5e 00 00    	pushl  0x5e64
     1ae:	e8 fd 38 00 00       	call   3ab0 <printf>
    exit();
     1b3:	e8 aa 37 00 00       	call   3962 <exit>
  if(unlink("../iputdir") < 0){
    printf(stdout, "unlink ../iputdir failed\n");
    exit();
  }
  if(chdir("/") < 0){
    printf(stdout, "chdir / failed\n");
     1b8:	50                   	push   %eax
     1b9:	50                   	push   %eax
     1ba:	68 1b 3e 00 00       	push   $0x3e1b
     1bf:	ff 35 64 5e 00 00    	pushl  0x5e64
     1c5:	e8 e6 38 00 00       	call   3ab0 <printf>
    exit();
     1ca:	e8 93 37 00 00       	call   3962 <exit>
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
    exit();
  }
  if(unlink("../iputdir") < 0){
    printf(stdout, "unlink ../iputdir failed\n");
     1cf:	52                   	push   %edx
     1d0:	52                   	push   %edx
     1d1:	68 ff 3d 00 00       	push   $0x3dff
     1d6:	ff 35 64 5e 00 00    	pushl  0x5e64
     1dc:	e8 cf 38 00 00       	call   3ab0 <printf>
    exit();
     1e1:	e8 7c 37 00 00       	call   3962 <exit>
  if(mkdir("iputdir") < 0){
    printf(stdout, "mkdir failed\n");
    exit();
  }
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
     1e6:	51                   	push   %ecx
     1e7:	51                   	push   %ecx
     1e8:	68 de 3d 00 00       	push   $0x3dde
     1ed:	ff 35 64 5e 00 00    	pushl  0x5e64
     1f3:	e8 b8 38 00 00       	call   3ab0 <printf>
    exit();
     1f8:	e8 65 37 00 00       	call   3962 <exit>
     1fd:	8d 76 00             	lea    0x0(%esi),%esi

00000200 <exitiputtest>:
}

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
     200:	55                   	push   %ebp
     201:	89 e5                	mov    %esp,%ebp
     203:	83 ec 10             	sub    $0x10,%esp
  int pid;

  printf(stdout, "exitiput test\n");
     206:	68 2b 3e 00 00       	push   $0x3e2b
     20b:	ff 35 64 5e 00 00    	pushl  0x5e64
     211:	e8 9a 38 00 00       	call   3ab0 <printf>

  pid = fork(0);
     216:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     21d:	e8 38 37 00 00       	call   395a <fork>
  if(pid < 0){
     222:	83 c4 10             	add    $0x10,%esp
     225:	85 c0                	test   %eax,%eax
     227:	78 7f                	js     2a8 <exitiputtest+0xa8>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
     229:	75 45                	jne    270 <exitiputtest+0x70>
    if(mkdir("iputdir") < 0){
     22b:	83 ec 0c             	sub    $0xc,%esp
     22e:	68 f7 3d 00 00       	push   $0x3df7
     233:	e8 92 37 00 00       	call   39ca <mkdir>
     238:	83 c4 10             	add    $0x10,%esp
     23b:	85 c0                	test   %eax,%eax
     23d:	0f 88 93 00 00 00    	js     2d6 <exitiputtest+0xd6>
      printf(stdout, "mkdir failed\n");
      exit();
    }
    if(chdir("iputdir") < 0){
     243:	83 ec 0c             	sub    $0xc,%esp
     246:	68 f7 3d 00 00       	push   $0x3df7
     24b:	e8 82 37 00 00       	call   39d2 <chdir>
     250:	83 c4 10             	add    $0x10,%esp
     253:	85 c0                	test   %eax,%eax
     255:	78 68                	js     2bf <exitiputtest+0xbf>
      printf(stdout, "child chdir failed\n");
      exit();
    }
    if(unlink("../iputdir") < 0){
     257:	83 ec 0c             	sub    $0xc,%esp
     25a:	68 f4 3d 00 00       	push   $0x3df4
     25f:	e8 4e 37 00 00       	call   39b2 <unlink>
     264:	83 c4 10             	add    $0x10,%esp
     267:	85 c0                	test   %eax,%eax
     269:	78 25                	js     290 <exitiputtest+0x90>
      printf(stdout, "unlink ../iputdir failed\n");
      exit();
    }
    exit();
     26b:	e8 f2 36 00 00       	call   3962 <exit>
  }
  wait();
     270:	e8 f5 36 00 00       	call   396a <wait>
  printf(stdout, "exitiput test ok\n");
     275:	83 ec 08             	sub    $0x8,%esp
     278:	68 4e 3e 00 00       	push   $0x3e4e
     27d:	ff 35 64 5e 00 00    	pushl  0x5e64
     283:	e8 28 38 00 00       	call   3ab0 <printf>
}
     288:	83 c4 10             	add    $0x10,%esp
     28b:	c9                   	leave  
     28c:	c3                   	ret    
     28d:	8d 76 00             	lea    0x0(%esi),%esi
    if(chdir("iputdir") < 0){
      printf(stdout, "child chdir failed\n");
      exit();
    }
    if(unlink("../iputdir") < 0){
      printf(stdout, "unlink ../iputdir failed\n");
     290:	83 ec 08             	sub    $0x8,%esp
     293:	68 ff 3d 00 00       	push   $0x3dff
     298:	ff 35 64 5e 00 00    	pushl  0x5e64
     29e:	e8 0d 38 00 00       	call   3ab0 <printf>
      exit();
     2a3:	e8 ba 36 00 00       	call   3962 <exit>

  printf(stdout, "exitiput test\n");

  pid = fork(0);
  if(pid < 0){
    printf(stdout, "fork failed\n");
     2a8:	51                   	push   %ecx
     2a9:	51                   	push   %ecx
     2aa:	68 11 4d 00 00       	push   $0x4d11
     2af:	ff 35 64 5e 00 00    	pushl  0x5e64
     2b5:	e8 f6 37 00 00       	call   3ab0 <printf>
    exit();
     2ba:	e8 a3 36 00 00       	call   3962 <exit>
    if(mkdir("iputdir") < 0){
      printf(stdout, "mkdir failed\n");
      exit();
    }
    if(chdir("iputdir") < 0){
      printf(stdout, "child chdir failed\n");
     2bf:	50                   	push   %eax
     2c0:	50                   	push   %eax
     2c1:	68 3a 3e 00 00       	push   $0x3e3a
     2c6:	ff 35 64 5e 00 00    	pushl  0x5e64
     2cc:	e8 df 37 00 00       	call   3ab0 <printf>
      exit();
     2d1:	e8 8c 36 00 00       	call   3962 <exit>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
    if(mkdir("iputdir") < 0){
      printf(stdout, "mkdir failed\n");
     2d6:	52                   	push   %edx
     2d7:	52                   	push   %edx
     2d8:	68 d0 3d 00 00       	push   $0x3dd0
     2dd:	ff 35 64 5e 00 00    	pushl  0x5e64
     2e3:	e8 c8 37 00 00       	call   3ab0 <printf>
      exit();
     2e8:	e8 75 36 00 00       	call   3962 <exit>
     2ed:	8d 76 00             	lea    0x0(%esi),%esi

000002f0 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
     2f0:	55                   	push   %ebp
     2f1:	89 e5                	mov    %esp,%ebp
     2f3:	83 ec 10             	sub    $0x10,%esp
  int pid;

  printf(stdout, "openiput test\n");
     2f6:	68 60 3e 00 00       	push   $0x3e60
     2fb:	ff 35 64 5e 00 00    	pushl  0x5e64
     301:	e8 aa 37 00 00       	call   3ab0 <printf>
  if(mkdir("oidir") < 0){
     306:	c7 04 24 6f 3e 00 00 	movl   $0x3e6f,(%esp)
     30d:	e8 b8 36 00 00       	call   39ca <mkdir>
     312:	83 c4 10             	add    $0x10,%esp
     315:	85 c0                	test   %eax,%eax
     317:	0f 88 90 00 00 00    	js     3ad <openiputtest+0xbd>
    printf(stdout, "mkdir oidir failed\n");
    exit();
  }
  pid = fork(0);
     31d:	83 ec 0c             	sub    $0xc,%esp
     320:	6a 00                	push   $0x0
     322:	e8 33 36 00 00       	call   395a <fork>
  if(pid < 0){
     327:	83 c4 10             	add    $0x10,%esp
     32a:	85 c0                	test   %eax,%eax
     32c:	0f 88 92 00 00 00    	js     3c4 <openiputtest+0xd4>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
     332:	75 34                	jne    368 <openiputtest+0x78>
    int fd = open("oidir", O_RDWR);
     334:	83 ec 08             	sub    $0x8,%esp
     337:	6a 02                	push   $0x2
     339:	68 6f 3e 00 00       	push   $0x3e6f
     33e:	e8 5f 36 00 00       	call   39a2 <open>
    if(fd >= 0){
     343:	83 c4 10             	add    $0x10,%esp
     346:	85 c0                	test   %eax,%eax
     348:	78 5e                	js     3a8 <openiputtest+0xb8>
      printf(stdout, "open directory for write succeeded\n");
     34a:	83 ec 08             	sub    $0x8,%esp
     34d:	68 f4 4d 00 00       	push   $0x4df4
     352:	ff 35 64 5e 00 00    	pushl  0x5e64
     358:	e8 53 37 00 00       	call   3ab0 <printf>
      exit();
     35d:	e8 00 36 00 00       	call   3962 <exit>
     362:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    }
    exit();
  }
  sleep(1);
     368:	83 ec 0c             	sub    $0xc,%esp
     36b:	6a 01                	push   $0x1
     36d:	e8 80 36 00 00       	call   39f2 <sleep>
  if(unlink("oidir") != 0){
     372:	c7 04 24 6f 3e 00 00 	movl   $0x3e6f,(%esp)
     379:	e8 34 36 00 00       	call   39b2 <unlink>
     37e:	83 c4 10             	add    $0x10,%esp
     381:	85 c0                	test   %eax,%eax
     383:	75 56                	jne    3db <openiputtest+0xeb>
    printf(stdout, "unlink failed\n");
    exit();
  }
  wait();
     385:	e8 e0 35 00 00       	call   396a <wait>
  printf(stdout, "openiput test ok\n");
     38a:	83 ec 08             	sub    $0x8,%esp
     38d:	68 98 3e 00 00       	push   $0x3e98
     392:	ff 35 64 5e 00 00    	pushl  0x5e64
     398:	e8 13 37 00 00       	call   3ab0 <printf>
}
     39d:	83 c4 10             	add    $0x10,%esp
     3a0:	c9                   	leave  
     3a1:	c3                   	ret    
     3a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    int fd = open("oidir", O_RDWR);
    if(fd >= 0){
      printf(stdout, "open directory for write succeeded\n");
      exit();
    }
    exit();
     3a8:	e8 b5 35 00 00       	call   3962 <exit>
{
  int pid;

  printf(stdout, "openiput test\n");
  if(mkdir("oidir") < 0){
    printf(stdout, "mkdir oidir failed\n");
     3ad:	51                   	push   %ecx
     3ae:	51                   	push   %ecx
     3af:	68 75 3e 00 00       	push   $0x3e75
     3b4:	ff 35 64 5e 00 00    	pushl  0x5e64
     3ba:	e8 f1 36 00 00       	call   3ab0 <printf>
    exit();
     3bf:	e8 9e 35 00 00       	call   3962 <exit>
  }
  pid = fork(0);
  if(pid < 0){
    printf(stdout, "fork failed\n");
     3c4:	52                   	push   %edx
     3c5:	52                   	push   %edx
     3c6:	68 11 4d 00 00       	push   $0x4d11
     3cb:	ff 35 64 5e 00 00    	pushl  0x5e64
     3d1:	e8 da 36 00 00       	call   3ab0 <printf>
    exit();
     3d6:	e8 87 35 00 00       	call   3962 <exit>
    }
    exit();
  }
  sleep(1);
  if(unlink("oidir") != 0){
    printf(stdout, "unlink failed\n");
     3db:	50                   	push   %eax
     3dc:	50                   	push   %eax
     3dd:	68 89 3e 00 00       	push   $0x3e89
     3e2:	ff 35 64 5e 00 00    	pushl  0x5e64
     3e8:	e8 c3 36 00 00       	call   3ab0 <printf>
    exit();
     3ed:	e8 70 35 00 00       	call   3962 <exit>
     3f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000400 <opentest>:

// simple file system tests

void
opentest(void)
{
     400:	55                   	push   %ebp
     401:	89 e5                	mov    %esp,%ebp
     403:	83 ec 10             	sub    $0x10,%esp
  int fd;

  printf(stdout, "open test\n");
     406:	68 aa 3e 00 00       	push   $0x3eaa
     40b:	ff 35 64 5e 00 00    	pushl  0x5e64
     411:	e8 9a 36 00 00       	call   3ab0 <printf>
  fd = open("echo", 0);
     416:	58                   	pop    %eax
     417:	5a                   	pop    %edx
     418:	6a 00                	push   $0x0
     41a:	68 b5 3e 00 00       	push   $0x3eb5
     41f:	e8 7e 35 00 00       	call   39a2 <open>
  if(fd < 0){
     424:	83 c4 10             	add    $0x10,%esp
     427:	85 c0                	test   %eax,%eax
     429:	78 36                	js     461 <opentest+0x61>
    printf(stdout, "open echo failed!\n");
    exit();
  }
  close(fd);
     42b:	83 ec 0c             	sub    $0xc,%esp
     42e:	50                   	push   %eax
     42f:	e8 56 35 00 00       	call   398a <close>
  fd = open("doesnotexist", 0);
     434:	5a                   	pop    %edx
     435:	59                   	pop    %ecx
     436:	6a 00                	push   $0x0
     438:	68 cd 3e 00 00       	push   $0x3ecd
     43d:	e8 60 35 00 00       	call   39a2 <open>
  if(fd >= 0){
     442:	83 c4 10             	add    $0x10,%esp
     445:	85 c0                	test   %eax,%eax
     447:	79 2f                	jns    478 <opentest+0x78>
    printf(stdout, "open doesnotexist succeeded!\n");
    exit();
  }
  printf(stdout, "open test ok\n");
     449:	83 ec 08             	sub    $0x8,%esp
     44c:	68 f8 3e 00 00       	push   $0x3ef8
     451:	ff 35 64 5e 00 00    	pushl  0x5e64
     457:	e8 54 36 00 00       	call   3ab0 <printf>
}
     45c:	83 c4 10             	add    $0x10,%esp
     45f:	c9                   	leave  
     460:	c3                   	ret    
  int fd;

  printf(stdout, "open test\n");
  fd = open("echo", 0);
  if(fd < 0){
    printf(stdout, "open echo failed!\n");
     461:	50                   	push   %eax
     462:	50                   	push   %eax
     463:	68 ba 3e 00 00       	push   $0x3eba
     468:	ff 35 64 5e 00 00    	pushl  0x5e64
     46e:	e8 3d 36 00 00       	call   3ab0 <printf>
    exit();
     473:	e8 ea 34 00 00       	call   3962 <exit>
  }
  close(fd);
  fd = open("doesnotexist", 0);
  if(fd >= 0){
    printf(stdout, "open doesnotexist succeeded!\n");
     478:	50                   	push   %eax
     479:	50                   	push   %eax
     47a:	68 da 3e 00 00       	push   $0x3eda
     47f:	ff 35 64 5e 00 00    	pushl  0x5e64
     485:	e8 26 36 00 00       	call   3ab0 <printf>
    exit();
     48a:	e8 d3 34 00 00       	call   3962 <exit>
     48f:	90                   	nop

00000490 <writetest>:
  printf(stdout, "open test ok\n");
}

void
writetest(void)
{
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	56                   	push   %esi
     494:	53                   	push   %ebx
  int fd;
  int i;

  printf(stdout, "small file test\n");
     495:	83 ec 08             	sub    $0x8,%esp
     498:	68 06 3f 00 00       	push   $0x3f06
     49d:	ff 35 64 5e 00 00    	pushl  0x5e64
     4a3:	e8 08 36 00 00       	call   3ab0 <printf>
  fd = open("small", O_CREATE|O_RDWR);
     4a8:	59                   	pop    %ecx
     4a9:	5b                   	pop    %ebx
     4aa:	68 02 02 00 00       	push   $0x202
     4af:	68 17 3f 00 00       	push   $0x3f17
     4b4:	e8 e9 34 00 00       	call   39a2 <open>
  if(fd >= 0){
     4b9:	83 c4 10             	add    $0x10,%esp
     4bc:	85 c0                	test   %eax,%eax
     4be:	0f 88 8b 01 00 00    	js     64f <writetest+0x1bf>
    printf(stdout, "creat small succeeded; ok\n");
     4c4:	83 ec 08             	sub    $0x8,%esp
     4c7:	89 c6                	mov    %eax,%esi
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     4c9:	31 db                	xor    %ebx,%ebx
  int i;

  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
     4cb:	68 1d 3f 00 00       	push   $0x3f1d
     4d0:	ff 35 64 5e 00 00    	pushl  0x5e64
     4d6:	e8 d5 35 00 00       	call   3ab0 <printf>
     4db:	83 c4 10             	add    $0x10,%esp
     4de:	66 90                	xchg   %ax,%ax
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     4e0:	83 ec 04             	sub    $0x4,%esp
     4e3:	6a 0a                	push   $0xa
     4e5:	68 54 3f 00 00       	push   $0x3f54
     4ea:	56                   	push   %esi
     4eb:	e8 92 34 00 00       	call   3982 <write>
     4f0:	83 c4 10             	add    $0x10,%esp
     4f3:	83 f8 0a             	cmp    $0xa,%eax
     4f6:	0f 85 d9 00 00 00    	jne    5d5 <writetest+0x145>
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit();
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     4fc:	83 ec 04             	sub    $0x4,%esp
     4ff:	6a 0a                	push   $0xa
     501:	68 5f 3f 00 00       	push   $0x3f5f
     506:	56                   	push   %esi
     507:	e8 76 34 00 00       	call   3982 <write>
     50c:	83 c4 10             	add    $0x10,%esp
     50f:	83 f8 0a             	cmp    $0xa,%eax
     512:	0f 85 d6 00 00 00    	jne    5ee <writetest+0x15e>
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     518:	83 c3 01             	add    $0x1,%ebx
     51b:	83 fb 64             	cmp    $0x64,%ebx
     51e:	75 c0                	jne    4e0 <writetest+0x50>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit();
    }
  }
  printf(stdout, "writes ok\n");
     520:	83 ec 08             	sub    $0x8,%esp
     523:	68 6a 3f 00 00       	push   $0x3f6a
     528:	ff 35 64 5e 00 00    	pushl  0x5e64
     52e:	e8 7d 35 00 00       	call   3ab0 <printf>
  close(fd);
     533:	89 34 24             	mov    %esi,(%esp)
     536:	e8 4f 34 00 00       	call   398a <close>
  fd = open("small", O_RDONLY);
     53b:	58                   	pop    %eax
     53c:	5a                   	pop    %edx
     53d:	6a 00                	push   $0x0
     53f:	68 17 3f 00 00       	push   $0x3f17
     544:	e8 59 34 00 00       	call   39a2 <open>
  if(fd >= 0){
     549:	83 c4 10             	add    $0x10,%esp
     54c:	85 c0                	test   %eax,%eax
      exit();
    }
  }
  printf(stdout, "writes ok\n");
  close(fd);
  fd = open("small", O_RDONLY);
     54e:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     550:	0f 88 b1 00 00 00    	js     607 <writetest+0x177>
    printf(stdout, "open small succeeded ok\n");
     556:	83 ec 08             	sub    $0x8,%esp
     559:	68 75 3f 00 00       	push   $0x3f75
     55e:	ff 35 64 5e 00 00    	pushl  0x5e64
     564:	e8 47 35 00 00       	call   3ab0 <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
     569:	83 c4 0c             	add    $0xc,%esp
     56c:	68 d0 07 00 00       	push   $0x7d0
     571:	68 40 86 00 00       	push   $0x8640
     576:	53                   	push   %ebx
     577:	e8 fe 33 00 00       	call   397a <read>
  if(i == 2000){
     57c:	83 c4 10             	add    $0x10,%esp
     57f:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     584:	0f 85 95 00 00 00    	jne    61f <writetest+0x18f>
    printf(stdout, "read succeeded ok\n");
     58a:	83 ec 08             	sub    $0x8,%esp
     58d:	68 a9 3f 00 00       	push   $0x3fa9
     592:	ff 35 64 5e 00 00    	pushl  0x5e64
     598:	e8 13 35 00 00       	call   3ab0 <printf>
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
     59d:	89 1c 24             	mov    %ebx,(%esp)
     5a0:	e8 e5 33 00 00       	call   398a <close>

  if(unlink("small") < 0){
     5a5:	c7 04 24 17 3f 00 00 	movl   $0x3f17,(%esp)
     5ac:	e8 01 34 00 00       	call   39b2 <unlink>
     5b1:	83 c4 10             	add    $0x10,%esp
     5b4:	85 c0                	test   %eax,%eax
     5b6:	78 7f                	js     637 <writetest+0x1a7>
    printf(stdout, "unlink small failed\n");
    exit();
  }
  printf(stdout, "small file test ok\n");
     5b8:	83 ec 08             	sub    $0x8,%esp
     5bb:	68 d1 3f 00 00       	push   $0x3fd1
     5c0:	ff 35 64 5e 00 00    	pushl  0x5e64
     5c6:	e8 e5 34 00 00       	call   3ab0 <printf>
}
     5cb:	83 c4 10             	add    $0x10,%esp
     5ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5d1:	5b                   	pop    %ebx
     5d2:	5e                   	pop    %esi
     5d3:	5d                   	pop    %ebp
     5d4:	c3                   	ret    
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
      printf(stdout, "error: write aa %d new file failed\n", i);
     5d5:	83 ec 04             	sub    $0x4,%esp
     5d8:	53                   	push   %ebx
     5d9:	68 18 4e 00 00       	push   $0x4e18
     5de:	ff 35 64 5e 00 00    	pushl  0x5e64
     5e4:	e8 c7 34 00 00       	call   3ab0 <printf>
      exit();
     5e9:	e8 74 33 00 00       	call   3962 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
     5ee:	83 ec 04             	sub    $0x4,%esp
     5f1:	53                   	push   %ebx
     5f2:	68 3c 4e 00 00       	push   $0x4e3c
     5f7:	ff 35 64 5e 00 00    	pushl  0x5e64
     5fd:	e8 ae 34 00 00       	call   3ab0 <printf>
      exit();
     602:	e8 5b 33 00 00       	call   3962 <exit>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
     607:	83 ec 08             	sub    $0x8,%esp
     60a:	68 8e 3f 00 00       	push   $0x3f8e
     60f:	ff 35 64 5e 00 00    	pushl  0x5e64
     615:	e8 96 34 00 00       	call   3ab0 <printf>
    exit();
     61a:	e8 43 33 00 00       	call   3962 <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
     61f:	83 ec 08             	sub    $0x8,%esp
     622:	68 d5 42 00 00       	push   $0x42d5
     627:	ff 35 64 5e 00 00    	pushl  0x5e64
     62d:	e8 7e 34 00 00       	call   3ab0 <printf>
    exit();
     632:	e8 2b 33 00 00       	call   3962 <exit>
  }
  close(fd);

  if(unlink("small") < 0){
    printf(stdout, "unlink small failed\n");
     637:	83 ec 08             	sub    $0x8,%esp
     63a:	68 bc 3f 00 00       	push   $0x3fbc
     63f:	ff 35 64 5e 00 00    	pushl  0x5e64
     645:	e8 66 34 00 00       	call   3ab0 <printf>
    exit();
     64a:	e8 13 33 00 00       	call   3962 <exit>
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
     64f:	83 ec 08             	sub    $0x8,%esp
     652:	68 38 3f 00 00       	push   $0x3f38
     657:	ff 35 64 5e 00 00    	pushl  0x5e64
     65d:	e8 4e 34 00 00       	call   3ab0 <printf>
    exit();
     662:	e8 fb 32 00 00       	call   3962 <exit>
     667:	89 f6                	mov    %esi,%esi
     669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000670 <writetest1>:
  printf(stdout, "small file test ok\n");
}

void
writetest1(void)
{
     670:	55                   	push   %ebp
     671:	89 e5                	mov    %esp,%ebp
     673:	56                   	push   %esi
     674:	53                   	push   %ebx
  int i, fd, n;

  printf(stdout, "big files test\n");
     675:	83 ec 08             	sub    $0x8,%esp
     678:	68 e5 3f 00 00       	push   $0x3fe5
     67d:	ff 35 64 5e 00 00    	pushl  0x5e64
     683:	e8 28 34 00 00       	call   3ab0 <printf>

  fd = open("big", O_CREATE|O_RDWR);
     688:	59                   	pop    %ecx
     689:	5b                   	pop    %ebx
     68a:	68 02 02 00 00       	push   $0x202
     68f:	68 5f 40 00 00       	push   $0x405f
     694:	e8 09 33 00 00       	call   39a2 <open>
  if(fd < 0){
     699:	83 c4 10             	add    $0x10,%esp
     69c:	85 c0                	test   %eax,%eax
     69e:	0f 88 64 01 00 00    	js     808 <writetest1+0x198>
     6a4:	89 c6                	mov    %eax,%esi
     6a6:	31 db                	xor    %ebx,%ebx
     6a8:	90                   	nop
     6a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
    if(write(fd, buf, 512) != 512){
     6b0:	83 ec 04             	sub    $0x4,%esp
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
     6b3:	89 1d 40 86 00 00    	mov    %ebx,0x8640
    if(write(fd, buf, 512) != 512){
     6b9:	68 00 02 00 00       	push   $0x200
     6be:	68 40 86 00 00       	push   $0x8640
     6c3:	56                   	push   %esi
     6c4:	e8 b9 32 00 00       	call   3982 <write>
     6c9:	83 c4 10             	add    $0x10,%esp
     6cc:	3d 00 02 00 00       	cmp    $0x200,%eax
     6d1:	0f 85 b3 00 00 00    	jne    78a <writetest1+0x11a>
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
     6d7:	83 c3 01             	add    $0x1,%ebx
     6da:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     6e0:	75 ce                	jne    6b0 <writetest1+0x40>
      printf(stdout, "error: write big file failed\n", i);
      exit();
    }
  }

  close(fd);
     6e2:	83 ec 0c             	sub    $0xc,%esp
     6e5:	56                   	push   %esi
     6e6:	e8 9f 32 00 00       	call   398a <close>

  fd = open("big", O_RDONLY);
     6eb:	58                   	pop    %eax
     6ec:	5a                   	pop    %edx
     6ed:	6a 00                	push   $0x0
     6ef:	68 5f 40 00 00       	push   $0x405f
     6f4:	e8 a9 32 00 00       	call   39a2 <open>
  if(fd < 0){
     6f9:	83 c4 10             	add    $0x10,%esp
     6fc:	85 c0                	test   %eax,%eax
    }
  }

  close(fd);

  fd = open("big", O_RDONLY);
     6fe:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     700:	0f 88 ea 00 00 00    	js     7f0 <writetest1+0x180>
     706:	31 db                	xor    %ebx,%ebx
     708:	eb 1d                	jmp    727 <writetest1+0xb7>
     70a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512){
     710:	3d 00 02 00 00       	cmp    $0x200,%eax
     715:	0f 85 9f 00 00 00    	jne    7ba <writetest1+0x14a>
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
     71b:	a1 40 86 00 00       	mov    0x8640,%eax
     720:	39 c3                	cmp    %eax,%ebx
     722:	75 7f                	jne    7a3 <writetest1+0x133>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
     724:	83 c3 01             	add    $0x1,%ebx
    exit();
  }

  n = 0;
  for(;;){
    i = read(fd, buf, 512);
     727:	83 ec 04             	sub    $0x4,%esp
     72a:	68 00 02 00 00       	push   $0x200
     72f:	68 40 86 00 00       	push   $0x8640
     734:	56                   	push   %esi
     735:	e8 40 32 00 00       	call   397a <read>
    if(i == 0){
     73a:	83 c4 10             	add    $0x10,%esp
     73d:	85 c0                	test   %eax,%eax
     73f:	75 cf                	jne    710 <writetest1+0xa0>
      if(n == MAXFILE - 1){
     741:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     747:	0f 84 86 00 00 00    	je     7d3 <writetest1+0x163>
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
  }
  close(fd);
     74d:	83 ec 0c             	sub    $0xc,%esp
     750:	56                   	push   %esi
     751:	e8 34 32 00 00       	call   398a <close>
  if(unlink("big") < 0){
     756:	c7 04 24 5f 40 00 00 	movl   $0x405f,(%esp)
     75d:	e8 50 32 00 00       	call   39b2 <unlink>
     762:	83 c4 10             	add    $0x10,%esp
     765:	85 c0                	test   %eax,%eax
     767:	0f 88 b3 00 00 00    	js     820 <writetest1+0x1b0>
    printf(stdout, "unlink big failed\n");
    exit();
  }
  printf(stdout, "big files ok\n");
     76d:	83 ec 08             	sub    $0x8,%esp
     770:	68 86 40 00 00       	push   $0x4086
     775:	ff 35 64 5e 00 00    	pushl  0x5e64
     77b:	e8 30 33 00 00       	call   3ab0 <printf>
}
     780:	83 c4 10             	add    $0x10,%esp
     783:	8d 65 f8             	lea    -0x8(%ebp),%esp
     786:	5b                   	pop    %ebx
     787:	5e                   	pop    %esi
     788:	5d                   	pop    %ebp
     789:	c3                   	ret    
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
    if(write(fd, buf, 512) != 512){
      printf(stdout, "error: write big file failed\n", i);
     78a:	83 ec 04             	sub    $0x4,%esp
     78d:	53                   	push   %ebx
     78e:	68 0f 40 00 00       	push   $0x400f
     793:	ff 35 64 5e 00 00    	pushl  0x5e64
     799:	e8 12 33 00 00       	call   3ab0 <printf>
      exit();
     79e:	e8 bf 31 00 00       	call   3962 <exit>
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
      printf(stdout, "read content of block %d is %d\n",
     7a3:	50                   	push   %eax
     7a4:	53                   	push   %ebx
     7a5:	68 60 4e 00 00       	push   $0x4e60
     7aa:	ff 35 64 5e 00 00    	pushl  0x5e64
     7b0:	e8 fb 32 00 00       	call   3ab0 <printf>
             n, ((int*)buf)[0]);
      exit();
     7b5:	e8 a8 31 00 00       	call   3962 <exit>
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
     7ba:	83 ec 04             	sub    $0x4,%esp
     7bd:	50                   	push   %eax
     7be:	68 63 40 00 00       	push   $0x4063
     7c3:	ff 35 64 5e 00 00    	pushl  0x5e64
     7c9:	e8 e2 32 00 00       	call   3ab0 <printf>
      exit();
     7ce:	e8 8f 31 00 00       	call   3962 <exit>
  n = 0;
  for(;;){
    i = read(fd, buf, 512);
    if(i == 0){
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
     7d3:	83 ec 04             	sub    $0x4,%esp
     7d6:	68 8b 00 00 00       	push   $0x8b
     7db:	68 46 40 00 00       	push   $0x4046
     7e0:	ff 35 64 5e 00 00    	pushl  0x5e64
     7e6:	e8 c5 32 00 00       	call   3ab0 <printf>
        exit();
     7eb:	e8 72 31 00 00       	call   3962 <exit>

  close(fd);

  fd = open("big", O_RDONLY);
  if(fd < 0){
    printf(stdout, "error: open big failed!\n");
     7f0:	83 ec 08             	sub    $0x8,%esp
     7f3:	68 2d 40 00 00       	push   $0x402d
     7f8:	ff 35 64 5e 00 00    	pushl  0x5e64
     7fe:	e8 ad 32 00 00       	call   3ab0 <printf>
    exit();
     803:	e8 5a 31 00 00       	call   3962 <exit>

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
     808:	83 ec 08             	sub    $0x8,%esp
     80b:	68 f5 3f 00 00       	push   $0x3ff5
     810:	ff 35 64 5e 00 00    	pushl  0x5e64
     816:	e8 95 32 00 00       	call   3ab0 <printf>
    exit();
     81b:	e8 42 31 00 00       	call   3962 <exit>
    }
    n++;
  }
  close(fd);
  if(unlink("big") < 0){
    printf(stdout, "unlink big failed\n");
     820:	83 ec 08             	sub    $0x8,%esp
     823:	68 73 40 00 00       	push   $0x4073
     828:	ff 35 64 5e 00 00    	pushl  0x5e64
     82e:	e8 7d 32 00 00       	call   3ab0 <printf>
    exit();
     833:	e8 2a 31 00 00       	call   3962 <exit>
     838:	90                   	nop
     839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000840 <createtest>:
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
     840:	55                   	push   %ebp
     841:	89 e5                	mov    %esp,%ebp
     843:	53                   	push   %ebx
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
     844:	bb 30 00 00 00       	mov    $0x30,%ebx
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
     849:	83 ec 0c             	sub    $0xc,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     84c:	68 80 4e 00 00       	push   $0x4e80
     851:	ff 35 64 5e 00 00    	pushl  0x5e64
     857:	e8 54 32 00 00       	call   3ab0 <printf>

  name[0] = 'a';
     85c:	c6 05 40 a6 00 00 61 	movb   $0x61,0xa640
  name[2] = '\0';
     863:	c6 05 42 a6 00 00 00 	movb   $0x0,0xa642
     86a:	83 c4 10             	add    $0x10,%esp
     86d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
     870:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
     873:	88 1d 41 a6 00 00    	mov    %bl,0xa641
     879:	83 c3 01             	add    $0x1,%ebx
    fd = open(name, O_CREATE|O_RDWR);
     87c:	68 02 02 00 00       	push   $0x202
     881:	68 40 a6 00 00       	push   $0xa640
     886:	e8 17 31 00 00       	call   39a2 <open>
    close(fd);
     88b:	89 04 24             	mov    %eax,(%esp)
     88e:	e8 f7 30 00 00       	call   398a <close>

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     893:	83 c4 10             	add    $0x10,%esp
     896:	80 fb 64             	cmp    $0x64,%bl
     899:	75 d5                	jne    870 <createtest+0x30>
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
     89b:	c6 05 40 a6 00 00 61 	movb   $0x61,0xa640
  name[2] = '\0';
     8a2:	c6 05 42 a6 00 00 00 	movb   $0x0,0xa642
     8a9:	bb 30 00 00 00       	mov    $0x30,%ebx
     8ae:	66 90                	xchg   %ax,%ax
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
    unlink(name);
     8b0:	83 ec 0c             	sub    $0xc,%esp
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
     8b3:	88 1d 41 a6 00 00    	mov    %bl,0xa641
     8b9:	83 c3 01             	add    $0x1,%ebx
    unlink(name);
     8bc:	68 40 a6 00 00       	push   $0xa640
     8c1:	e8 ec 30 00 00       	call   39b2 <unlink>
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     8c6:	83 c4 10             	add    $0x10,%esp
     8c9:	80 fb 64             	cmp    $0x64,%bl
     8cc:	75 e2                	jne    8b0 <createtest+0x70>
    name[1] = '0' + i;
    unlink(name);
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     8ce:	83 ec 08             	sub    $0x8,%esp
     8d1:	68 a8 4e 00 00       	push   $0x4ea8
     8d6:	ff 35 64 5e 00 00    	pushl  0x5e64
     8dc:	e8 cf 31 00 00       	call   3ab0 <printf>
}
     8e1:	83 c4 10             	add    $0x10,%esp
     8e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8e7:	c9                   	leave  
     8e8:	c3                   	ret    
     8e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008f0 <dirtest>:

void dirtest(void)
{
     8f0:	55                   	push   %ebp
     8f1:	89 e5                	mov    %esp,%ebp
     8f3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "mkdir test\n");
     8f6:	68 94 40 00 00       	push   $0x4094
     8fb:	ff 35 64 5e 00 00    	pushl  0x5e64
     901:	e8 aa 31 00 00       	call   3ab0 <printf>

  if(mkdir("dir0") < 0){
     906:	c7 04 24 a0 40 00 00 	movl   $0x40a0,(%esp)
     90d:	e8 b8 30 00 00       	call   39ca <mkdir>
     912:	83 c4 10             	add    $0x10,%esp
     915:	85 c0                	test   %eax,%eax
     917:	78 58                	js     971 <dirtest+0x81>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0){
     919:	83 ec 0c             	sub    $0xc,%esp
     91c:	68 a0 40 00 00       	push   $0x40a0
     921:	e8 ac 30 00 00       	call   39d2 <chdir>
     926:	83 c4 10             	add    $0x10,%esp
     929:	85 c0                	test   %eax,%eax
     92b:	0f 88 85 00 00 00    	js     9b6 <dirtest+0xc6>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0){
     931:	83 ec 0c             	sub    $0xc,%esp
     934:	68 45 46 00 00       	push   $0x4645
     939:	e8 94 30 00 00       	call   39d2 <chdir>
     93e:	83 c4 10             	add    $0x10,%esp
     941:	85 c0                	test   %eax,%eax
     943:	78 5a                	js     99f <dirtest+0xaf>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0){
     945:	83 ec 0c             	sub    $0xc,%esp
     948:	68 a0 40 00 00       	push   $0x40a0
     94d:	e8 60 30 00 00       	call   39b2 <unlink>
     952:	83 c4 10             	add    $0x10,%esp
     955:	85 c0                	test   %eax,%eax
     957:	78 2f                	js     988 <dirtest+0x98>
    printf(stdout, "unlink dir0 failed\n");
    exit();
  }
  printf(stdout, "mkdir test ok\n");
     959:	83 ec 08             	sub    $0x8,%esp
     95c:	68 dd 40 00 00       	push   $0x40dd
     961:	ff 35 64 5e 00 00    	pushl  0x5e64
     967:	e8 44 31 00 00       	call   3ab0 <printf>
}
     96c:	83 c4 10             	add    $0x10,%esp
     96f:	c9                   	leave  
     970:	c3                   	ret    
void dirtest(void)
{
  printf(stdout, "mkdir test\n");

  if(mkdir("dir0") < 0){
    printf(stdout, "mkdir failed\n");
     971:	50                   	push   %eax
     972:	50                   	push   %eax
     973:	68 d0 3d 00 00       	push   $0x3dd0
     978:	ff 35 64 5e 00 00    	pushl  0x5e64
     97e:	e8 2d 31 00 00       	call   3ab0 <printf>
    exit();
     983:	e8 da 2f 00 00       	call   3962 <exit>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0){
    printf(stdout, "unlink dir0 failed\n");
     988:	50                   	push   %eax
     989:	50                   	push   %eax
     98a:	68 c9 40 00 00       	push   $0x40c9
     98f:	ff 35 64 5e 00 00    	pushl  0x5e64
     995:	e8 16 31 00 00       	call   3ab0 <printf>
    exit();
     99a:	e8 c3 2f 00 00       	call   3962 <exit>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0){
    printf(stdout, "chdir .. failed\n");
     99f:	52                   	push   %edx
     9a0:	52                   	push   %edx
     9a1:	68 b8 40 00 00       	push   $0x40b8
     9a6:	ff 35 64 5e 00 00    	pushl  0x5e64
     9ac:	e8 ff 30 00 00       	call   3ab0 <printf>
    exit();
     9b1:	e8 ac 2f 00 00       	call   3962 <exit>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0){
    printf(stdout, "chdir dir0 failed\n");
     9b6:	51                   	push   %ecx
     9b7:	51                   	push   %ecx
     9b8:	68 a5 40 00 00       	push   $0x40a5
     9bd:	ff 35 64 5e 00 00    	pushl  0x5e64
     9c3:	e8 e8 30 00 00       	call   3ab0 <printf>
    exit();
     9c8:	e8 95 2f 00 00       	call   3962 <exit>
     9cd:	8d 76 00             	lea    0x0(%esi),%esi

000009d0 <exectest>:
  printf(stdout, "mkdir test ok\n");
}

void
exectest(void)
{
     9d0:	55                   	push   %ebp
     9d1:	89 e5                	mov    %esp,%ebp
     9d3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exec test\n");
     9d6:	68 ec 40 00 00       	push   $0x40ec
     9db:	ff 35 64 5e 00 00    	pushl  0x5e64
     9e1:	e8 ca 30 00 00       	call   3ab0 <printf>
  if(exec("echo", echoargv) < 0){
     9e6:	5a                   	pop    %edx
     9e7:	59                   	pop    %ecx
     9e8:	68 68 5e 00 00       	push   $0x5e68
     9ed:	68 b5 3e 00 00       	push   $0x3eb5
     9f2:	e8 a3 2f 00 00       	call   399a <exec>
     9f7:	83 c4 10             	add    $0x10,%esp
     9fa:	85 c0                	test   %eax,%eax
     9fc:	78 02                	js     a00 <exectest+0x30>
    printf(stdout, "exec echo failed\n");
    exit();
  }
}
     9fe:	c9                   	leave  
     9ff:	c3                   	ret    
void
exectest(void)
{
  printf(stdout, "exec test\n");
  if(exec("echo", echoargv) < 0){
    printf(stdout, "exec echo failed\n");
     a00:	50                   	push   %eax
     a01:	50                   	push   %eax
     a02:	68 f7 40 00 00       	push   $0x40f7
     a07:	ff 35 64 5e 00 00    	pushl  0x5e64
     a0d:	e8 9e 30 00 00       	call   3ab0 <printf>
    exit();
     a12:	e8 4b 2f 00 00       	call   3962 <exit>
     a17:	89 f6                	mov    %esi,%esi
     a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a20 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     a20:	55                   	push   %ebp
     a21:	89 e5                	mov    %esp,%ebp
     a23:	57                   	push   %edi
     a24:	56                   	push   %esi
     a25:	53                   	push   %ebx
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     a26:	8d 45 e0             	lea    -0x20(%ebp),%eax

// simple fork and pipe read/write

void
pipe1(void)
{
     a29:	83 ec 38             	sub    $0x38,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     a2c:	50                   	push   %eax
     a2d:	e8 40 2f 00 00       	call   3972 <pipe>
     a32:	83 c4 10             	add    $0x10,%esp
     a35:	85 c0                	test   %eax,%eax
     a37:	0f 85 45 01 00 00    	jne    b82 <pipe1+0x162>
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork(0);
     a3d:	83 ec 0c             	sub    $0xc,%esp
     a40:	6a 00                	push   $0x0
     a42:	e8 13 2f 00 00       	call   395a <fork>
  seq = 0;
  if(pid == 0){
     a47:	83 c4 10             	add    $0x10,%esp
     a4a:	83 f8 00             	cmp    $0x0,%eax
     a4d:	0f 84 8e 00 00 00    	je     ae1 <pipe1+0xc1>
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
  } else if(pid > 0){
     a53:	0f 8e 3d 01 00 00    	jle    b96 <pipe1+0x176>
    close(fds[1]);
     a59:	83 ec 0c             	sub    $0xc,%esp
     a5c:	ff 75 e4             	pushl  -0x1c(%ebp)
    total = 0;
    cc = 1;
     a5f:	bf 01 00 00 00       	mov    $0x1,%edi
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork(0);
  seq = 0;
     a64:	31 db                	xor    %ebx,%ebx
        exit();
      }
    }
    exit();
  } else if(pid > 0){
    close(fds[1]);
     a66:	e8 1f 2f 00 00       	call   398a <close>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     a6b:	83 c4 10             	add    $0x10,%esp
      }
    }
    exit();
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
     a6e:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     a75:	83 ec 04             	sub    $0x4,%esp
     a78:	57                   	push   %edi
     a79:	68 40 86 00 00       	push   $0x8640
     a7e:	ff 75 e0             	pushl  -0x20(%ebp)
     a81:	e8 f4 2e 00 00       	call   397a <read>
     a86:	83 c4 10             	add    $0x10,%esp
     a89:	85 c0                	test   %eax,%eax
     a8b:	0f 8e ab 00 00 00    	jle    b3c <pipe1+0x11c>
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     a91:	89 d9                	mov    %ebx,%ecx
     a93:	8d 34 18             	lea    (%eax,%ebx,1),%esi
     a96:	f7 d9                	neg    %ecx
     a98:	90                   	nop
     a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     aa0:	38 9c 0b 40 86 00 00 	cmp    %bl,0x8640(%ebx,%ecx,1)
     aa7:	8d 53 01             	lea    0x1(%ebx),%edx
     aaa:	75 1b                	jne    ac7 <pipe1+0xa7>
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
     aac:	39 f2                	cmp    %esi,%edx
     aae:	89 d3                	mov    %edx,%ebx
     ab0:	75 ee                	jne    aa0 <pipe1+0x80>
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
      cc = cc * 2;
     ab2:	01 ff                	add    %edi,%edi
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
     ab4:	01 45 d4             	add    %eax,-0x2c(%ebp)
     ab7:	b8 00 20 00 00       	mov    $0x2000,%eax
     abc:	81 ff 00 20 00 00    	cmp    $0x2000,%edi
     ac2:	0f 4f f8             	cmovg  %eax,%edi
     ac5:	eb ae                	jmp    a75 <pipe1+0x55>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
     ac7:	83 ec 08             	sub    $0x8,%esp
     aca:	68 26 41 00 00       	push   $0x4126
     acf:	6a 01                	push   $0x1
     ad1:	e8 da 2f 00 00       	call   3ab0 <printf>
          return;
     ad6:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
}
     ad9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     adc:	5b                   	pop    %ebx
     add:	5e                   	pop    %esi
     ade:	5f                   	pop    %edi
     adf:	5d                   	pop    %ebp
     ae0:	c3                   	ret    
    exit();
  }
  pid = fork(0);
  seq = 0;
  if(pid == 0){
    close(fds[0]);
     ae1:	83 ec 0c             	sub    $0xc,%esp
     ae4:	ff 75 e0             	pushl  -0x20(%ebp)
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork(0);
  seq = 0;
     ae7:	31 f6                	xor    %esi,%esi
  if(pid == 0){
    close(fds[0]);
     ae9:	e8 9c 2e 00 00       	call   398a <close>
     aee:	83 c4 10             	add    $0x10,%esp
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
     af1:	89 f0                	mov    %esi,%eax
     af3:	8d 96 09 04 00 00    	lea    0x409(%esi),%edx

// simple fork and pipe read/write

void
pipe1(void)
{
     af9:	89 f3                	mov    %esi,%ebx
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
     afb:	f7 d8                	neg    %eax
     afd:	8d 76 00             	lea    0x0(%esi),%esi
     b00:	88 9c 18 40 86 00 00 	mov    %bl,0x8640(%eax,%ebx,1)
     b07:	83 c3 01             	add    $0x1,%ebx
  pid = fork(0);
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
     b0a:	39 d3                	cmp    %edx,%ebx
     b0c:	75 f2                	jne    b00 <pipe1+0xe0>
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
     b0e:	83 ec 04             	sub    $0x4,%esp
     b11:	89 de                	mov    %ebx,%esi
     b13:	68 09 04 00 00       	push   $0x409
     b18:	68 40 86 00 00       	push   $0x8640
     b1d:	ff 75 e4             	pushl  -0x1c(%ebp)
     b20:	e8 5d 2e 00 00       	call   3982 <write>
     b25:	83 c4 10             	add    $0x10,%esp
     b28:	3d 09 04 00 00       	cmp    $0x409,%eax
     b2d:	75 7b                	jne    baa <pipe1+0x18a>
  }
  pid = fork(0);
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
     b2f:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     b35:	75 ba                	jne    af1 <pipe1+0xd1>
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
     b37:	e8 26 2e 00 00       	call   3962 <exit>
      total += n;
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
     b3c:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     b43:	75 26                	jne    b6b <pipe1+0x14b>
      printf(1, "pipe1 oops 3 total %d\n", total);
      exit();
    }
    close(fds[0]);
     b45:	83 ec 0c             	sub    $0xc,%esp
     b48:	ff 75 e0             	pushl  -0x20(%ebp)
     b4b:	e8 3a 2e 00 00       	call   398a <close>
    wait();
     b50:	e8 15 2e 00 00       	call   396a <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     b55:	58                   	pop    %eax
     b56:	5a                   	pop    %edx
     b57:	68 4b 41 00 00       	push   $0x414b
     b5c:	6a 01                	push   $0x1
     b5e:	e8 4d 2f 00 00       	call   3ab0 <printf>
     b63:	83 c4 10             	add    $0x10,%esp
     b66:	e9 6e ff ff ff       	jmp    ad9 <pipe1+0xb9>
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
      printf(1, "pipe1 oops 3 total %d\n", total);
     b6b:	83 ec 04             	sub    $0x4,%esp
     b6e:	ff 75 d4             	pushl  -0x2c(%ebp)
     b71:	68 34 41 00 00       	push   $0x4134
     b76:	6a 01                	push   $0x1
     b78:	e8 33 2f 00 00       	call   3ab0 <printf>
      exit();
     b7d:	e8 e0 2d 00 00       	call   3962 <exit>
{
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
     b82:	83 ec 08             	sub    $0x8,%esp
     b85:	68 09 41 00 00       	push   $0x4109
     b8a:	6a 01                	push   $0x1
     b8c:	e8 1f 2f 00 00       	call   3ab0 <printf>
    exit();
     b91:	e8 cc 2d 00 00       	call   3962 <exit>
      exit();
    }
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
     b96:	83 ec 08             	sub    $0x8,%esp
     b99:	68 55 41 00 00       	push   $0x4155
     b9e:	6a 01                	push   $0x1
     ba0:	e8 0b 2f 00 00       	call   3ab0 <printf>
    exit();
     ba5:	e8 b8 2d 00 00       	call   3962 <exit>
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
     baa:	83 ec 08             	sub    $0x8,%esp
     bad:	68 18 41 00 00       	push   $0x4118
     bb2:	6a 01                	push   $0x1
     bb4:	e8 f7 2e 00 00       	call   3ab0 <printf>
        exit();
     bb9:	e8 a4 2d 00 00       	call   3962 <exit>
     bbe:	66 90                	xchg   %ax,%ax

00000bc0 <preempt>:
}

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     bc0:	55                   	push   %ebp
     bc1:	89 e5                	mov    %esp,%ebp
     bc3:	57                   	push   %edi
     bc4:	56                   	push   %esi
     bc5:	53                   	push   %ebx
     bc6:	83 ec 24             	sub    $0x24,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     bc9:	68 64 41 00 00       	push   $0x4164
     bce:	6a 01                	push   $0x1
     bd0:	e8 db 2e 00 00       	call   3ab0 <printf>
  pid1 = fork(0);
     bd5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     bdc:	e8 79 2d 00 00       	call   395a <fork>
  if(pid1 == 0)
     be1:	83 c4 10             	add    $0x10,%esp
     be4:	85 c0                	test   %eax,%eax
     be6:	75 02                	jne    bea <preempt+0x2a>
     be8:	eb fe                	jmp    be8 <preempt+0x28>
    for(;;)
      ;

  pid2 = fork(0);
     bea:	83 ec 0c             	sub    $0xc,%esp
     bed:	89 c7                	mov    %eax,%edi
     bef:	6a 00                	push   $0x0
     bf1:	e8 64 2d 00 00       	call   395a <fork>
  if(pid2 == 0)
     bf6:	83 c4 10             	add    $0x10,%esp
     bf9:	85 c0                	test   %eax,%eax
  pid1 = fork(0);
  if(pid1 == 0)
    for(;;)
      ;

  pid2 = fork(0);
     bfb:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     bfd:	75 02                	jne    c01 <preempt+0x41>
     bff:	eb fe                	jmp    bff <preempt+0x3f>
    for(;;)
      ;

  pipe(pfds);
     c01:	8d 45 e0             	lea    -0x20(%ebp),%eax
     c04:	83 ec 0c             	sub    $0xc,%esp
     c07:	50                   	push   %eax
     c08:	e8 65 2d 00 00       	call   3972 <pipe>
  pid3 = fork(0);
     c0d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     c14:	e8 41 2d 00 00       	call   395a <fork>
  if(pid3 == 0){
     c19:	83 c4 10             	add    $0x10,%esp
     c1c:	85 c0                	test   %eax,%eax
  if(pid2 == 0)
    for(;;)
      ;

  pipe(pfds);
  pid3 = fork(0);
     c1e:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
     c20:	75 47                	jne    c69 <preempt+0xa9>
    close(pfds[0]);
     c22:	83 ec 0c             	sub    $0xc,%esp
     c25:	ff 75 e0             	pushl  -0x20(%ebp)
     c28:	e8 5d 2d 00 00       	call   398a <close>
    if(write(pfds[1], "x", 1) != 1)
     c2d:	83 c4 0c             	add    $0xc,%esp
     c30:	6a 01                	push   $0x1
     c32:	68 29 47 00 00       	push   $0x4729
     c37:	ff 75 e4             	pushl  -0x1c(%ebp)
     c3a:	e8 43 2d 00 00       	call   3982 <write>
     c3f:	83 c4 10             	add    $0x10,%esp
     c42:	83 f8 01             	cmp    $0x1,%eax
     c45:	74 12                	je     c59 <preempt+0x99>
      printf(1, "preempt write error");
     c47:	83 ec 08             	sub    $0x8,%esp
     c4a:	68 6e 41 00 00       	push   $0x416e
     c4f:	6a 01                	push   $0x1
     c51:	e8 5a 2e 00 00       	call   3ab0 <printf>
     c56:	83 c4 10             	add    $0x10,%esp
    close(pfds[1]);
     c59:	83 ec 0c             	sub    $0xc,%esp
     c5c:	ff 75 e4             	pushl  -0x1c(%ebp)
     c5f:	e8 26 2d 00 00       	call   398a <close>
     c64:	83 c4 10             	add    $0x10,%esp
     c67:	eb fe                	jmp    c67 <preempt+0xa7>
    for(;;)
      ;
  }

  close(pfds[1]);
     c69:	83 ec 0c             	sub    $0xc,%esp
     c6c:	ff 75 e4             	pushl  -0x1c(%ebp)
     c6f:	e8 16 2d 00 00       	call   398a <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     c74:	83 c4 0c             	add    $0xc,%esp
     c77:	68 00 20 00 00       	push   $0x2000
     c7c:	68 40 86 00 00       	push   $0x8640
     c81:	ff 75 e0             	pushl  -0x20(%ebp)
     c84:	e8 f1 2c 00 00       	call   397a <read>
     c89:	83 c4 10             	add    $0x10,%esp
     c8c:	83 f8 01             	cmp    $0x1,%eax
     c8f:	74 1a                	je     cab <preempt+0xeb>
    printf(1, "preempt read error");
     c91:	83 ec 08             	sub    $0x8,%esp
     c94:	68 82 41 00 00       	push   $0x4182
     c99:	6a 01                	push   $0x1
     c9b:	e8 10 2e 00 00       	call   3ab0 <printf>
    return;
     ca0:	83 c4 10             	add    $0x10,%esp
  printf(1, "wait... ");
  wait();
  wait();
  wait();
  printf(1, "preempt ok\n");
}
     ca3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ca6:	5b                   	pop    %ebx
     ca7:	5e                   	pop    %esi
     ca8:	5f                   	pop    %edi
     ca9:	5d                   	pop    %ebp
     caa:	c3                   	ret    
  close(pfds[1]);
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    printf(1, "preempt read error");
    return;
  }
  close(pfds[0]);
     cab:	83 ec 0c             	sub    $0xc,%esp
     cae:	ff 75 e0             	pushl  -0x20(%ebp)
     cb1:	e8 d4 2c 00 00       	call   398a <close>
  printf(1, "kill... ");
     cb6:	58                   	pop    %eax
     cb7:	5a                   	pop    %edx
     cb8:	68 95 41 00 00       	push   $0x4195
     cbd:	6a 01                	push   $0x1
     cbf:	e8 ec 2d 00 00       	call   3ab0 <printf>
  kill(pid1);
     cc4:	89 3c 24             	mov    %edi,(%esp)
     cc7:	e8 c6 2c 00 00       	call   3992 <kill>
  kill(pid2);
     ccc:	89 34 24             	mov    %esi,(%esp)
     ccf:	e8 be 2c 00 00       	call   3992 <kill>
  kill(pid3);
     cd4:	89 1c 24             	mov    %ebx,(%esp)
     cd7:	e8 b6 2c 00 00       	call   3992 <kill>
  printf(1, "wait... ");
     cdc:	59                   	pop    %ecx
     cdd:	5b                   	pop    %ebx
     cde:	68 9e 41 00 00       	push   $0x419e
     ce3:	6a 01                	push   $0x1
     ce5:	e8 c6 2d 00 00       	call   3ab0 <printf>
  wait();
     cea:	e8 7b 2c 00 00       	call   396a <wait>
  wait();
     cef:	e8 76 2c 00 00       	call   396a <wait>
  wait();
     cf4:	e8 71 2c 00 00       	call   396a <wait>
  printf(1, "preempt ok\n");
     cf9:	5e                   	pop    %esi
     cfa:	5f                   	pop    %edi
     cfb:	68 a7 41 00 00       	push   $0x41a7
     d00:	6a 01                	push   $0x1
     d02:	e8 a9 2d 00 00       	call   3ab0 <printf>
     d07:	83 c4 10             	add    $0x10,%esp
     d0a:	eb 97                	jmp    ca3 <preempt+0xe3>
     d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000d10 <exitwait>:
}

// try to find any races between exit and wait
void
exitwait(void)
{
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	56                   	push   %esi
     d14:	be 64 00 00 00       	mov    $0x64,%esi
     d19:	53                   	push   %ebx
     d1a:	eb 14                	jmp    d30 <exitwait+0x20>
     d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pid = fork(0);
    if(pid < 0){
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
     d20:	74 77                	je     d99 <exitwait+0x89>
      if(wait() != pid){
     d22:	e8 43 2c 00 00       	call   396a <wait>
     d27:	39 c3                	cmp    %eax,%ebx
     d29:	75 35                	jne    d60 <exitwait+0x50>
void
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
     d2b:	83 ee 01             	sub    $0x1,%esi
     d2e:	74 50                	je     d80 <exitwait+0x70>
    pid = fork(0);
     d30:	83 ec 0c             	sub    $0xc,%esp
     d33:	6a 00                	push   $0x0
     d35:	e8 20 2c 00 00       	call   395a <fork>
    if(pid < 0){
     d3a:	83 c4 10             	add    $0x10,%esp
     d3d:	85 c0                	test   %eax,%eax
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
    pid = fork(0);
     d3f:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     d41:	79 dd                	jns    d20 <exitwait+0x10>
      printf(1, "fork failed\n");
     d43:	83 ec 08             	sub    $0x8,%esp
     d46:	68 11 4d 00 00       	push   $0x4d11
     d4b:	6a 01                	push   $0x1
     d4d:	e8 5e 2d 00 00       	call   3ab0 <printf>
      return;
     d52:	83 c4 10             	add    $0x10,%esp
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     d55:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d58:	5b                   	pop    %ebx
     d59:	5e                   	pop    %esi
     d5a:	5d                   	pop    %ebp
     d5b:	c3                   	ret    
     d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
     d60:	83 ec 08             	sub    $0x8,%esp
     d63:	68 b3 41 00 00       	push   $0x41b3
     d68:	6a 01                	push   $0x1
     d6a:	e8 41 2d 00 00       	call   3ab0 <printf>
        return;
     d6f:	83 c4 10             	add    $0x10,%esp
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     d72:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d75:	5b                   	pop    %ebx
     d76:	5e                   	pop    %esi
     d77:	5d                   	pop    %ebp
     d78:	c3                   	ret    
     d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      }
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
     d80:	83 ec 08             	sub    $0x8,%esp
     d83:	68 c3 41 00 00       	push   $0x41c3
     d88:	6a 01                	push   $0x1
     d8a:	e8 21 2d 00 00       	call   3ab0 <printf>
     d8f:	83 c4 10             	add    $0x10,%esp
}
     d92:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d95:	5b                   	pop    %ebx
     d96:	5e                   	pop    %esi
     d97:	5d                   	pop    %ebp
     d98:	c3                   	ret    
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
        return;
      }
    } else {
      exit();
     d99:	e8 c4 2b 00 00       	call   3962 <exit>
     d9e:	66 90                	xchg   %ax,%ax

00000da0 <mem>:
  printf(1, "exitwait ok\n");
}

void
mem(void)
{
     da0:	55                   	push   %ebp
     da1:	89 e5                	mov    %esp,%ebp
     da3:	57                   	push   %edi
     da4:	56                   	push   %esi
     da5:	53                   	push   %ebx
     da6:	83 ec 14             	sub    $0x14,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
     da9:	68 d0 41 00 00       	push   $0x41d0
     dae:	6a 01                	push   $0x1
     db0:	e8 fb 2c 00 00       	call   3ab0 <printf>
  ppid = getpid();
     db5:	e8 28 2c 00 00       	call   39e2 <getpid>
  if((pid = fork(0)) == 0){
     dba:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
{
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
  ppid = getpid();
     dc1:	89 c6                	mov    %eax,%esi
  if((pid = fork(0)) == 0){
     dc3:	e8 92 2b 00 00       	call   395a <fork>
     dc8:	83 c4 10             	add    $0x10,%esp
     dcb:	85 c0                	test   %eax,%eax
     dcd:	75 71                	jne    e40 <mem+0xa0>
     dcf:	31 db                	xor    %ebx,%ebx
     dd1:	eb 09                	jmp    ddc <mem+0x3c>
     dd3:	90                   	nop
     dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
     dd8:	89 18                	mov    %ebx,(%eax)
     dda:	89 c3                	mov    %eax,%ebx

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork(0)) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
     ddc:	83 ec 0c             	sub    $0xc,%esp
     ddf:	68 11 27 00 00       	push   $0x2711
     de4:	e8 f7 2e 00 00       	call   3ce0 <malloc>
     de9:	83 c4 10             	add    $0x10,%esp
     dec:	85 c0                	test   %eax,%eax
     dee:	75 e8                	jne    dd8 <mem+0x38>
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     df0:	85 db                	test   %ebx,%ebx
     df2:	74 18                	je     e0c <mem+0x6c>
     df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m2 = *(char**)m1;
     df8:	8b 3b                	mov    (%ebx),%edi
      free(m1);
     dfa:	83 ec 0c             	sub    $0xc,%esp
     dfd:	53                   	push   %ebx
     dfe:	89 fb                	mov    %edi,%ebx
     e00:	e8 4b 2e 00 00       	call   3c50 <free>
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     e05:	83 c4 10             	add    $0x10,%esp
     e08:	85 db                	test   %ebx,%ebx
     e0a:	75 ec                	jne    df8 <mem+0x58>
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
     e0c:	83 ec 0c             	sub    $0xc,%esp
     e0f:	68 00 50 00 00       	push   $0x5000
     e14:	e8 c7 2e 00 00       	call   3ce0 <malloc>
    if(m1 == 0){
     e19:	83 c4 10             	add    $0x10,%esp
     e1c:	85 c0                	test   %eax,%eax
     e1e:	74 30                	je     e50 <mem+0xb0>
      printf(1, "couldn't allocate mem?!!\n");
      kill(ppid);
      exit();
    }
    free(m1);
     e20:	83 ec 0c             	sub    $0xc,%esp
     e23:	50                   	push   %eax
     e24:	e8 27 2e 00 00       	call   3c50 <free>
    printf(1, "mem ok\n");
     e29:	58                   	pop    %eax
     e2a:	5a                   	pop    %edx
     e2b:	68 f4 41 00 00       	push   $0x41f4
     e30:	6a 01                	push   $0x1
     e32:	e8 79 2c 00 00       	call   3ab0 <printf>
    exit();
     e37:	e8 26 2b 00 00       	call   3962 <exit>
     e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  } else {
    wait();
  }
}
     e40:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e43:	5b                   	pop    %ebx
     e44:	5e                   	pop    %esi
     e45:	5f                   	pop    %edi
     e46:	5d                   	pop    %ebp
    }
    free(m1);
    printf(1, "mem ok\n");
    exit();
  } else {
    wait();
     e47:	e9 1e 2b 00 00       	jmp    396a <wait>
     e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
    if(m1 == 0){
      printf(1, "couldn't allocate mem?!!\n");
     e50:	83 ec 08             	sub    $0x8,%esp
     e53:	68 da 41 00 00       	push   $0x41da
     e58:	6a 01                	push   $0x1
     e5a:	e8 51 2c 00 00       	call   3ab0 <printf>
      kill(ppid);
     e5f:	89 34 24             	mov    %esi,(%esp)
     e62:	e8 2b 2b 00 00       	call   3992 <kill>
      exit();
     e67:	e8 f6 2a 00 00       	call   3962 <exit>
     e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000e70 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     e70:	55                   	push   %ebp
     e71:	89 e5                	mov    %esp,%ebp
     e73:	57                   	push   %edi
     e74:	56                   	push   %esi
     e75:	53                   	push   %ebx
     e76:	83 ec 34             	sub    $0x34,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
     e79:	68 fc 41 00 00       	push   $0x41fc
     e7e:	6a 01                	push   $0x1
     e80:	e8 2b 2c 00 00       	call   3ab0 <printf>

  unlink("sharedfd");
     e85:	c7 04 24 0b 42 00 00 	movl   $0x420b,(%esp)
     e8c:	e8 21 2b 00 00       	call   39b2 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     e91:	5b                   	pop    %ebx
     e92:	5e                   	pop    %esi
     e93:	68 02 02 00 00       	push   $0x202
     e98:	68 0b 42 00 00       	push   $0x420b
     e9d:	e8 00 2b 00 00       	call   39a2 <open>
  if(fd < 0){
     ea2:	83 c4 10             	add    $0x10,%esp
     ea5:	85 c0                	test   %eax,%eax
     ea7:	0f 88 29 01 00 00    	js     fd6 <sharedfd+0x166>
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork(0);
     ead:	83 ec 0c             	sub    $0xc,%esp
     eb0:	89 c7                	mov    %eax,%edi
  memset(buf, pid==0?'c':'p', sizeof(buf));
     eb2:	8d 75 de             	lea    -0x22(%ebp),%esi
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork(0);
     eb5:	6a 00                	push   $0x0
  memset(buf, pid==0?'c':'p', sizeof(buf));
     eb7:	bb e8 03 00 00       	mov    $0x3e8,%ebx
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork(0);
     ebc:	e8 99 2a 00 00       	call   395a <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
     ec1:	83 c4 0c             	add    $0xc,%esp
     ec4:	83 f8 01             	cmp    $0x1,%eax
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork(0);
     ec7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     eca:	19 c0                	sbb    %eax,%eax
     ecc:	6a 0a                	push   $0xa
     ece:	83 e0 f3             	and    $0xfffffff3,%eax
     ed1:	83 c0 70             	add    $0x70,%eax
     ed4:	50                   	push   %eax
     ed5:	56                   	push   %esi
     ed6:	e8 f5 28 00 00       	call   37d0 <memset>
     edb:	83 c4 10             	add    $0x10,%esp
     ede:	eb 05                	jmp    ee5 <sharedfd+0x75>
  for(i = 0; i < 1000; i++){
     ee0:	83 eb 01             	sub    $0x1,%ebx
     ee3:	74 26                	je     f0b <sharedfd+0x9b>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     ee5:	83 ec 04             	sub    $0x4,%esp
     ee8:	6a 0a                	push   $0xa
     eea:	56                   	push   %esi
     eeb:	57                   	push   %edi
     eec:	e8 91 2a 00 00       	call   3982 <write>
     ef1:	83 c4 10             	add    $0x10,%esp
     ef4:	83 f8 0a             	cmp    $0xa,%eax
     ef7:	74 e7                	je     ee0 <sharedfd+0x70>
      printf(1, "fstests: write sharedfd failed\n");
     ef9:	83 ec 08             	sub    $0x8,%esp
     efc:	68 fc 4e 00 00       	push   $0x4efc
     f01:	6a 01                	push   $0x1
     f03:	e8 a8 2b 00 00       	call   3ab0 <printf>
      break;
     f08:	83 c4 10             	add    $0x10,%esp
    }
  }
  if(pid == 0)
     f0b:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     f0e:	85 c9                	test   %ecx,%ecx
     f10:	0f 84 f4 00 00 00    	je     100a <sharedfd+0x19a>
    exit();
  else
    wait();
     f16:	e8 4f 2a 00 00       	call   396a <wait>
  close(fd);
     f1b:	83 ec 0c             	sub    $0xc,%esp
     f1e:	31 db                	xor    %ebx,%ebx
     f20:	57                   	push   %edi
     f21:	8d 7d e8             	lea    -0x18(%ebp),%edi
     f24:	e8 61 2a 00 00       	call   398a <close>
  fd = open("sharedfd", 0);
     f29:	58                   	pop    %eax
     f2a:	5a                   	pop    %edx
     f2b:	6a 00                	push   $0x0
     f2d:	68 0b 42 00 00       	push   $0x420b
     f32:	e8 6b 2a 00 00       	call   39a2 <open>
  if(fd < 0){
     f37:	83 c4 10             	add    $0x10,%esp
     f3a:	31 d2                	xor    %edx,%edx
     f3c:	85 c0                	test   %eax,%eax
  if(pid == 0)
    exit();
  else
    wait();
  close(fd);
  fd = open("sharedfd", 0);
     f3e:	89 45 d0             	mov    %eax,-0x30(%ebp)
  if(fd < 0){
     f41:	0f 88 a9 00 00 00    	js     ff0 <sharedfd+0x180>
     f47:	89 f6                	mov    %esi,%esi
     f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
     f50:	83 ec 04             	sub    $0x4,%esp
     f53:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     f56:	6a 0a                	push   $0xa
     f58:	56                   	push   %esi
     f59:	ff 75 d0             	pushl  -0x30(%ebp)
     f5c:	e8 19 2a 00 00       	call   397a <read>
     f61:	83 c4 10             	add    $0x10,%esp
     f64:	85 c0                	test   %eax,%eax
     f66:	7e 27                	jle    f8f <sharedfd+0x11f>
     f68:	89 f0                	mov    %esi,%eax
     f6a:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f6d:	eb 13                	jmp    f82 <sharedfd+0x112>
     f6f:	90                   	nop
    for(i = 0; i < sizeof(buf); i++){
      if(buf[i] == 'c')
        nc++;
      if(buf[i] == 'p')
        np++;
     f70:	80 f9 70             	cmp    $0x70,%cl
     f73:	0f 94 c1             	sete   %cl
     f76:	0f b6 c9             	movzbl %cl,%ecx
     f79:	01 cb                	add    %ecx,%ebx
     f7b:	83 c0 01             	add    $0x1,%eax
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
     f7e:	39 c7                	cmp    %eax,%edi
     f80:	74 ce                	je     f50 <sharedfd+0xe0>
      if(buf[i] == 'c')
     f82:	0f b6 08             	movzbl (%eax),%ecx
     f85:	80 f9 63             	cmp    $0x63,%cl
     f88:	75 e6                	jne    f70 <sharedfd+0x100>
        nc++;
     f8a:	83 c2 01             	add    $0x1,%edx
     f8d:	eb ec                	jmp    f7b <sharedfd+0x10b>
      if(buf[i] == 'p')
        np++;
    }
  }
  close(fd);
     f8f:	83 ec 0c             	sub    $0xc,%esp
     f92:	ff 75 d0             	pushl  -0x30(%ebp)
     f95:	e8 f0 29 00 00       	call   398a <close>
  unlink("sharedfd");
     f9a:	c7 04 24 0b 42 00 00 	movl   $0x420b,(%esp)
     fa1:	e8 0c 2a 00 00       	call   39b2 <unlink>
  if(nc == 10000 && np == 10000){
     fa6:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     fa9:	83 c4 10             	add    $0x10,%esp
     fac:	81 fa 10 27 00 00    	cmp    $0x2710,%edx
     fb2:	75 5b                	jne    100f <sharedfd+0x19f>
     fb4:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
     fba:	75 53                	jne    100f <sharedfd+0x19f>
    printf(1, "sharedfd ok\n");
     fbc:	83 ec 08             	sub    $0x8,%esp
     fbf:	68 14 42 00 00       	push   $0x4214
     fc4:	6a 01                	push   $0x1
     fc6:	e8 e5 2a 00 00       	call   3ab0 <printf>
     fcb:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
     fce:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fd1:	5b                   	pop    %ebx
     fd2:	5e                   	pop    %esi
     fd3:	5f                   	pop    %edi
     fd4:	5d                   	pop    %ebp
     fd5:	c3                   	ret    
  printf(1, "sharedfd test\n");

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
     fd6:	83 ec 08             	sub    $0x8,%esp
     fd9:	68 d0 4e 00 00       	push   $0x4ed0
     fde:	6a 01                	push   $0x1
     fe0:	e8 cb 2a 00 00       	call   3ab0 <printf>
    return;
     fe5:	83 c4 10             	add    $0x10,%esp
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
     fe8:	8d 65 f4             	lea    -0xc(%ebp),%esp
     feb:	5b                   	pop    %ebx
     fec:	5e                   	pop    %esi
     fed:	5f                   	pop    %edi
     fee:	5d                   	pop    %ebp
     fef:	c3                   	ret    
  else
    wait();
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
     ff0:	83 ec 08             	sub    $0x8,%esp
     ff3:	68 1c 4f 00 00       	push   $0x4f1c
     ff8:	6a 01                	push   $0x1
     ffa:	e8 b1 2a 00 00       	call   3ab0 <printf>
    return;
     fff:	83 c4 10             	add    $0x10,%esp
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
    1002:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1005:	5b                   	pop    %ebx
    1006:	5e                   	pop    %esi
    1007:	5f                   	pop    %edi
    1008:	5d                   	pop    %ebp
    1009:	c3                   	ret    
      printf(1, "fstests: write sharedfd failed\n");
      break;
    }
  }
  if(pid == 0)
    exit();
    100a:	e8 53 29 00 00       	call   3962 <exit>
  close(fd);
  unlink("sharedfd");
  if(nc == 10000 && np == 10000){
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    100f:	53                   	push   %ebx
    1010:	52                   	push   %edx
    1011:	68 21 42 00 00       	push   $0x4221
    1016:	6a 01                	push   $0x1
    1018:	e8 93 2a 00 00       	call   3ab0 <printf>
    exit();
    101d:	e8 40 29 00 00       	call   3962 <exit>
    1022:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001030 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    1030:	55                   	push   %ebp
    1031:	89 e5                	mov    %esp,%ebp
    1033:	57                   	push   %edi
    1034:	56                   	push   %esi
    1035:	53                   	push   %ebx
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");
    1036:	be 36 42 00 00       	mov    $0x4236,%esi

  for(pi = 0; pi < 4; pi++){
    103b:	31 db                	xor    %ebx,%ebx

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    103d:	83 ec 34             	sub    $0x34,%esp
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    1040:	c7 45 d8 36 42 00 00 	movl   $0x4236,-0x28(%ebp)
    1047:	c7 45 dc 7f 43 00 00 	movl   $0x437f,-0x24(%ebp)
  char *fname;

  printf(1, "fourfiles test\n");
    104e:	68 3c 42 00 00       	push   $0x423c
    1053:	6a 01                	push   $0x1
// time, to test block allocation.
void
fourfiles(void)
{
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    1055:	c7 45 e0 83 43 00 00 	movl   $0x4383,-0x20(%ebp)
    105c:	c7 45 e4 39 42 00 00 	movl   $0x4239,-0x1c(%ebp)
  char *fname;

  printf(1, "fourfiles test\n");
    1063:	e8 48 2a 00 00       	call   3ab0 <printf>
    1068:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    fname = names[pi];
    unlink(fname);
    106b:	83 ec 0c             	sub    $0xc,%esp
    106e:	56                   	push   %esi
    106f:	e8 3e 29 00 00       	call   39b2 <unlink>

    pid = fork(0);
    1074:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    107b:	e8 da 28 00 00       	call   395a <fork>
    if(pid < 0){
    1080:	83 c4 10             	add    $0x10,%esp
    1083:	85 c0                	test   %eax,%eax
    1085:	0f 88 84 01 00 00    	js     120f <fourfiles+0x1df>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
    108b:	0f 84 e4 00 00 00    	je     1175 <fourfiles+0x145>
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");

  for(pi = 0; pi < 4; pi++){
    1091:	83 c3 01             	add    $0x1,%ebx
    1094:	83 fb 04             	cmp    $0x4,%ebx
    1097:	74 06                	je     109f <fourfiles+0x6f>
    1099:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    109d:	eb cc                	jmp    106b <fourfiles+0x3b>
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    wait();
    109f:	e8 c6 28 00 00       	call   396a <wait>
    10a4:	bf 30 00 00 00       	mov    $0x30,%edi
    10a9:	e8 bc 28 00 00       	call   396a <wait>
    10ae:	e8 b7 28 00 00       	call   396a <wait>
    10b3:	e8 b2 28 00 00       	call   396a <wait>
    10b8:	c7 45 d4 36 42 00 00 	movl   $0x4236,-0x2c(%ebp)
  }

  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    10bf:	83 ec 08             	sub    $0x8,%esp
    total = 0;
    10c2:	31 db                	xor    %ebx,%ebx
    wait();
  }

  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    10c4:	6a 00                	push   $0x0
    10c6:	ff 75 d4             	pushl  -0x2c(%ebp)
    10c9:	e8 d4 28 00 00       	call   39a2 <open>
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
    10ce:	83 c4 10             	add    $0x10,%esp
    wait();
  }

  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    10d1:	89 c6                	mov    %eax,%esi
    10d3:	90                   	nop
    10d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
    10d8:	83 ec 04             	sub    $0x4,%esp
    10db:	68 00 20 00 00       	push   $0x2000
    10e0:	68 40 86 00 00       	push   $0x8640
    10e5:	56                   	push   %esi
    10e6:	e8 8f 28 00 00       	call   397a <read>
    10eb:	83 c4 10             	add    $0x10,%esp
    10ee:	85 c0                	test   %eax,%eax
    10f0:	7e 1c                	jle    110e <fourfiles+0xde>
    10f2:	31 d2                	xor    %edx,%edx
    10f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
    10f8:	0f be 8a 40 86 00 00 	movsbl 0x8640(%edx),%ecx
    10ff:	39 cf                	cmp    %ecx,%edi
    1101:	75 5e                	jne    1161 <fourfiles+0x131>
  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
    1103:	83 c2 01             	add    $0x1,%edx
    1106:	39 d0                	cmp    %edx,%eax
    1108:	75 ee                	jne    10f8 <fourfiles+0xc8>
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
          exit();
        }
      }
      total += n;
    110a:	01 c3                	add    %eax,%ebx
    110c:	eb ca                	jmp    10d8 <fourfiles+0xa8>
    }
    close(fd);
    110e:	83 ec 0c             	sub    $0xc,%esp
    1111:	56                   	push   %esi
    1112:	e8 73 28 00 00       	call   398a <close>
    if(total != 12*500){
    1117:	83 c4 10             	add    $0x10,%esp
    111a:	81 fb 70 17 00 00    	cmp    $0x1770,%ebx
    1120:	0f 85 d4 00 00 00    	jne    11fa <fourfiles+0x1ca>
      printf(1, "wrong length %d\n", total);
      exit();
    }
    unlink(fname);
    1126:	83 ec 0c             	sub    $0xc,%esp
    1129:	ff 75 d4             	pushl  -0x2c(%ebp)
    112c:	83 c7 01             	add    $0x1,%edi
    112f:	e8 7e 28 00 00       	call   39b2 <unlink>

  for(pi = 0; pi < 4; pi++){
    wait();
  }

  for(i = 0; i < 2; i++){
    1134:	83 c4 10             	add    $0x10,%esp
    1137:	83 ff 32             	cmp    $0x32,%edi
    113a:	75 1a                	jne    1156 <fourfiles+0x126>
      exit();
    }
    unlink(fname);
  }

  printf(1, "fourfiles ok\n");
    113c:	83 ec 08             	sub    $0x8,%esp
    113f:	68 7a 42 00 00       	push   $0x427a
    1144:	6a 01                	push   $0x1
    1146:	e8 65 29 00 00       	call   3ab0 <printf>
}
    114b:	83 c4 10             	add    $0x10,%esp
    114e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1151:	5b                   	pop    %ebx
    1152:	5e                   	pop    %esi
    1153:	5f                   	pop    %edi
    1154:	5d                   	pop    %ebp
    1155:	c3                   	ret    
    1156:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1159:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    115c:	e9 5e ff ff ff       	jmp    10bf <fourfiles+0x8f>
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
    1161:	83 ec 08             	sub    $0x8,%esp
    1164:	68 5d 42 00 00       	push   $0x425d
    1169:	6a 01                	push   $0x1
    116b:	e8 40 29 00 00       	call   3ab0 <printf>
          exit();
    1170:	e8 ed 27 00 00       	call   3962 <exit>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
    1175:	83 ec 08             	sub    $0x8,%esp
    1178:	68 02 02 00 00       	push   $0x202
    117d:	56                   	push   %esi
    117e:	e8 1f 28 00 00       	call   39a2 <open>
      if(fd < 0){
    1183:	83 c4 10             	add    $0x10,%esp
    1186:	85 c0                	test   %eax,%eax
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
    1188:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    118a:	78 5a                	js     11e6 <fourfiles+0x1b6>
        printf(1, "create failed\n");
        exit();
      }

      memset(buf, '0'+pi, 512);
    118c:	83 ec 04             	sub    $0x4,%esp
    118f:	83 c3 30             	add    $0x30,%ebx
    1192:	68 00 02 00 00       	push   $0x200
    1197:	53                   	push   %ebx
    1198:	bb 0c 00 00 00       	mov    $0xc,%ebx
    119d:	68 40 86 00 00       	push   $0x8640
    11a2:	e8 29 26 00 00       	call   37d0 <memset>
    11a7:	83 c4 10             	add    $0x10,%esp
      for(i = 0; i < 12; i++){
        if((n = write(fd, buf, 500)) != 500){
    11aa:	83 ec 04             	sub    $0x4,%esp
    11ad:	68 f4 01 00 00       	push   $0x1f4
    11b2:	68 40 86 00 00       	push   $0x8640
    11b7:	56                   	push   %esi
    11b8:	e8 c5 27 00 00       	call   3982 <write>
    11bd:	83 c4 10             	add    $0x10,%esp
    11c0:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    11c5:	75 0a                	jne    11d1 <fourfiles+0x1a1>
        printf(1, "create failed\n");
        exit();
      }

      memset(buf, '0'+pi, 512);
      for(i = 0; i < 12; i++){
    11c7:	83 eb 01             	sub    $0x1,%ebx
    11ca:	75 de                	jne    11aa <fourfiles+0x17a>
        if((n = write(fd, buf, 500)) != 500){
          printf(1, "write failed %d\n", n);
          exit();
        }
      }
      exit();
    11cc:	e8 91 27 00 00       	call   3962 <exit>
      }

      memset(buf, '0'+pi, 512);
      for(i = 0; i < 12; i++){
        if((n = write(fd, buf, 500)) != 500){
          printf(1, "write failed %d\n", n);
    11d1:	83 ec 04             	sub    $0x4,%esp
    11d4:	50                   	push   %eax
    11d5:	68 4c 42 00 00       	push   $0x424c
    11da:	6a 01                	push   $0x1
    11dc:	e8 cf 28 00 00       	call   3ab0 <printf>
          exit();
    11e1:	e8 7c 27 00 00       	call   3962 <exit>
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "create failed\n");
    11e6:	83 ec 08             	sub    $0x8,%esp
    11e9:	68 d7 44 00 00       	push   $0x44d7
    11ee:	6a 01                	push   $0x1
    11f0:	e8 bb 28 00 00       	call   3ab0 <printf>
        exit();
    11f5:	e8 68 27 00 00       	call   3962 <exit>
      }
      total += n;
    }
    close(fd);
    if(total != 12*500){
      printf(1, "wrong length %d\n", total);
    11fa:	83 ec 04             	sub    $0x4,%esp
    11fd:	53                   	push   %ebx
    11fe:	68 69 42 00 00       	push   $0x4269
    1203:	6a 01                	push   $0x1
    1205:	e8 a6 28 00 00       	call   3ab0 <printf>
      exit();
    120a:	e8 53 27 00 00       	call   3962 <exit>
    fname = names[pi];
    unlink(fname);

    pid = fork(0);
    if(pid < 0){
      printf(1, "fork failed\n");
    120f:	83 ec 08             	sub    $0x8,%esp
    1212:	68 11 4d 00 00       	push   $0x4d11
    1217:	6a 01                	push   $0x1
    1219:	e8 92 28 00 00       	call   3ab0 <printf>
      exit();
    121e:	e8 3f 27 00 00       	call   3962 <exit>
    1223:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001230 <createdelete>:
}

// four processes create and delete different files in same directory
void
createdelete(void)
{
    1230:	55                   	push   %ebp
    1231:	89 e5                	mov    %esp,%ebp
    1233:	57                   	push   %edi
    1234:	56                   	push   %esi
    1235:	53                   	push   %ebx
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    1236:	31 db                	xor    %ebx,%ebx
}

// four processes create and delete different files in same directory
void
createdelete(void)
{
    1238:	83 ec 44             	sub    $0x44,%esp
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
    123b:	68 88 42 00 00       	push   $0x4288
    1240:	6a 01                	push   $0x1
    1242:	e8 69 28 00 00       	call   3ab0 <printf>
    1247:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    pid = fork(0);
    124a:	83 ec 0c             	sub    $0xc,%esp
    124d:	6a 00                	push   $0x0
    124f:	e8 06 27 00 00       	call   395a <fork>
    if(pid < 0){
    1254:	83 c4 10             	add    $0x10,%esp
    1257:	85 c0                	test   %eax,%eax
    1259:	0f 88 b7 01 00 00    	js     1416 <createdelete+0x1e6>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
    125f:	0f 84 f6 00 00 00    	je     135b <createdelete+0x12b>
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    1265:	83 c3 01             	add    $0x1,%ebx
    1268:	83 fb 04             	cmp    $0x4,%ebx
    126b:	75 dd                	jne    124a <createdelete+0x1a>
    126d:	8d 7d c8             	lea    -0x38(%ebp),%edi
  for(pi = 0; pi < 4; pi++){
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    1270:	31 f6                	xor    %esi,%esi
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    wait();
    1272:	e8 f3 26 00 00       	call   396a <wait>
    1277:	e8 ee 26 00 00       	call   396a <wait>
    127c:	e8 e9 26 00 00       	call   396a <wait>
    1281:	e8 e4 26 00 00       	call   396a <wait>
  }

  name[0] = name[1] = name[2] = 0;
    1286:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    128a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1290:	8d 46 30             	lea    0x30(%esi),%eax
    1293:	83 fe 09             	cmp    $0x9,%esi
      exit();
    }

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
    1296:	bb 70 00 00 00       	mov    $0x70,%ebx
    129b:	0f 9f c2             	setg   %dl
    129e:	85 f6                	test   %esi,%esi
    12a0:	88 45 c7             	mov    %al,-0x39(%ebp)
    12a3:	0f 94 c0             	sete   %al
    12a6:	09 c2                	or     %eax,%edx
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit();
      } else if((i >= 1 && i < N/2) && fd >= 0){
    12a8:	8d 46 ff             	lea    -0x1(%esi),%eax
    12ab:	88 55 c6             	mov    %dl,-0x3a(%ebp)
    12ae:	89 45 c0             	mov    %eax,-0x40(%ebp)

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
    12b1:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
      fd = open(name, 0);
    12b5:	83 ec 08             	sub    $0x8,%esp
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
    12b8:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
      fd = open(name, 0);
    12bb:	6a 00                	push   $0x0
    12bd:	57                   	push   %edi

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
    12be:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    12c1:	e8 dc 26 00 00       	call   39a2 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    12c6:	89 c1                	mov    %eax,%ecx
    12c8:	83 c4 10             	add    $0x10,%esp
    12cb:	c1 e9 1f             	shr    $0x1f,%ecx
    12ce:	84 c9                	test   %cl,%cl
    12d0:	74 0a                	je     12dc <createdelete+0xac>
    12d2:	80 7d c6 00          	cmpb   $0x0,-0x3a(%ebp)
    12d6:	0f 85 11 01 00 00    	jne    13ed <createdelete+0x1bd>
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit();
      } else if((i >= 1 && i < N/2) && fd >= 0){
    12dc:	83 7d c0 08          	cmpl   $0x8,-0x40(%ebp)
    12e0:	0f 86 44 01 00 00    	jbe    142a <createdelete+0x1fa>
        printf(1, "oops createdelete %s did exist\n", name);
        exit();
      }
      if(fd >= 0)
    12e6:	85 c0                	test   %eax,%eax
    12e8:	78 0c                	js     12f6 <createdelete+0xc6>
        close(fd);
    12ea:	83 ec 0c             	sub    $0xc,%esp
    12ed:	50                   	push   %eax
    12ee:	e8 97 26 00 00       	call   398a <close>
    12f3:	83 c4 10             	add    $0x10,%esp
    12f6:	83 c3 01             	add    $0x1,%ebx
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    12f9:	80 fb 74             	cmp    $0x74,%bl
    12fc:	75 b3                	jne    12b1 <createdelete+0x81>
  for(pi = 0; pi < 4; pi++){
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    12fe:	83 c6 01             	add    $0x1,%esi
    1301:	83 fe 14             	cmp    $0x14,%esi
    1304:	75 8a                	jne    1290 <createdelete+0x60>
    1306:	be 70 00 00 00       	mov    $0x70,%esi
    130b:	90                   	nop
    130c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1310:	8d 46 c0             	lea    -0x40(%esi),%eax
    1313:	bb 04 00 00 00       	mov    $0x4,%ebx
    1318:	88 45 c7             	mov    %al,-0x39(%ebp)
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
    131b:	89 f0                	mov    %esi,%eax
      name[1] = '0' + i;
      unlink(name);
    131d:	83 ec 0c             	sub    $0xc,%esp
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
    1320:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    1323:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
      unlink(name);
    1327:	57                   	push   %edi
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
      name[1] = '0' + i;
    1328:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    132b:	e8 82 26 00 00       	call   39b2 <unlink>
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    1330:	83 c4 10             	add    $0x10,%esp
    1333:	83 eb 01             	sub    $0x1,%ebx
    1336:	75 e3                	jne    131b <createdelete+0xeb>
    1338:	83 c6 01             	add    $0x1,%esi
      if(fd >= 0)
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    133b:	89 f0                	mov    %esi,%eax
    133d:	3c 84                	cmp    $0x84,%al
    133f:	75 cf                	jne    1310 <createdelete+0xe0>
      name[1] = '0' + i;
      unlink(name);
    }
  }

  printf(1, "createdelete ok\n");
    1341:	83 ec 08             	sub    $0x8,%esp
    1344:	68 9b 42 00 00       	push   $0x429b
    1349:	6a 01                	push   $0x1
    134b:	e8 60 27 00 00       	call   3ab0 <printf>
}
    1350:	83 c4 10             	add    $0x10,%esp
    1353:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1356:	5b                   	pop    %ebx
    1357:	5e                   	pop    %esi
    1358:	5f                   	pop    %edi
    1359:	5d                   	pop    %ebp
    135a:	c3                   	ret    
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
      name[0] = 'p' + pi;
    135b:	83 c3 70             	add    $0x70,%ebx
      name[2] = '\0';
    135e:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1362:	be 01 00 00 00       	mov    $0x1,%esi
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
      name[0] = 'p' + pi;
    1367:	88 5d c8             	mov    %bl,-0x38(%ebp)
    136a:	8d 7d c8             	lea    -0x38(%ebp),%edi
      name[2] = '\0';
    136d:	31 db                	xor    %ebx,%ebx
    136f:	eb 12                	jmp    1383 <createdelete+0x153>
    1371:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(i = 0; i < N; i++){
    1378:	83 fe 14             	cmp    $0x14,%esi
    137b:	74 6b                	je     13e8 <createdelete+0x1b8>
    137d:	83 c3 01             	add    $0x1,%ebx
    1380:	83 c6 01             	add    $0x1,%esi
        name[1] = '0' + i;
        fd = open(name, O_CREATE | O_RDWR);
    1383:	83 ec 08             	sub    $0x8,%esp

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
    1386:	8d 43 30             	lea    0x30(%ebx),%eax
        fd = open(name, O_CREATE | O_RDWR);
    1389:	68 02 02 00 00       	push   $0x202
    138e:	57                   	push   %edi

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
    138f:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    1392:	e8 0b 26 00 00       	call   39a2 <open>
        if(fd < 0){
    1397:	83 c4 10             	add    $0x10,%esp
    139a:	85 c0                	test   %eax,%eax
    139c:	78 64                	js     1402 <createdelete+0x1d2>
          printf(1, "create failed\n");
          exit();
        }
        close(fd);
    139e:	83 ec 0c             	sub    $0xc,%esp
    13a1:	50                   	push   %eax
    13a2:	e8 e3 25 00 00       	call   398a <close>
        if(i > 0 && (i % 2 ) == 0){
    13a7:	83 c4 10             	add    $0x10,%esp
    13aa:	85 db                	test   %ebx,%ebx
    13ac:	74 cf                	je     137d <createdelete+0x14d>
    13ae:	f6 c3 01             	test   $0x1,%bl
    13b1:	75 c5                	jne    1378 <createdelete+0x148>
          name[1] = '0' + (i / 2);
          if(unlink(name) < 0){
    13b3:	83 ec 0c             	sub    $0xc,%esp
          printf(1, "create failed\n");
          exit();
        }
        close(fd);
        if(i > 0 && (i % 2 ) == 0){
          name[1] = '0' + (i / 2);
    13b6:	89 d8                	mov    %ebx,%eax
    13b8:	d1 f8                	sar    %eax
          if(unlink(name) < 0){
    13ba:	57                   	push   %edi
          printf(1, "create failed\n");
          exit();
        }
        close(fd);
        if(i > 0 && (i % 2 ) == 0){
          name[1] = '0' + (i / 2);
    13bb:	83 c0 30             	add    $0x30,%eax
    13be:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    13c1:	e8 ec 25 00 00       	call   39b2 <unlink>
    13c6:	83 c4 10             	add    $0x10,%esp
    13c9:	85 c0                	test   %eax,%eax
    13cb:	79 ab                	jns    1378 <createdelete+0x148>
            printf(1, "unlink failed\n");
    13cd:	83 ec 08             	sub    $0x8,%esp
    13d0:	68 89 3e 00 00       	push   $0x3e89
    13d5:	6a 01                	push   $0x1
    13d7:	e8 d4 26 00 00       	call   3ab0 <printf>
            exit();
    13dc:	e8 81 25 00 00       	call   3962 <exit>
    13e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
          }
        }
      }
      exit();
    13e8:	e8 75 25 00 00       	call   3962 <exit>
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
    13ed:	83 ec 04             	sub    $0x4,%esp
    13f0:	57                   	push   %edi
    13f1:	68 48 4f 00 00       	push   $0x4f48
    13f6:	6a 01                	push   $0x1
    13f8:	e8 b3 26 00 00       	call   3ab0 <printf>
        exit();
    13fd:	e8 60 25 00 00       	call   3962 <exit>
      name[2] = '\0';
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
        fd = open(name, O_CREATE | O_RDWR);
        if(fd < 0){
          printf(1, "create failed\n");
    1402:	83 ec 08             	sub    $0x8,%esp
    1405:	68 d7 44 00 00       	push   $0x44d7
    140a:	6a 01                	push   $0x1
    140c:	e8 9f 26 00 00       	call   3ab0 <printf>
          exit();
    1411:	e8 4c 25 00 00       	call   3962 <exit>
  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    pid = fork(0);
    if(pid < 0){
      printf(1, "fork failed\n");
    1416:	83 ec 08             	sub    $0x8,%esp
    1419:	68 11 4d 00 00       	push   $0x4d11
    141e:	6a 01                	push   $0x1
    1420:	e8 8b 26 00 00       	call   3ab0 <printf>
      exit();
    1425:	e8 38 25 00 00       	call   3962 <exit>
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit();
      } else if((i >= 1 && i < N/2) && fd >= 0){
    142a:	85 c0                	test   %eax,%eax
    142c:	0f 88 c4 fe ff ff    	js     12f6 <createdelete+0xc6>
        printf(1, "oops createdelete %s did exist\n", name);
    1432:	83 ec 04             	sub    $0x4,%esp
    1435:	57                   	push   %edi
    1436:	68 6c 4f 00 00       	push   $0x4f6c
    143b:	6a 01                	push   $0x1
    143d:	e8 6e 26 00 00       	call   3ab0 <printf>
        exit();
    1442:	e8 1b 25 00 00       	call   3962 <exit>
    1447:	89 f6                	mov    %esi,%esi
    1449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001450 <unlinkread>:
}

// can I unlink a file and still read it?
void
unlinkread(void)
{
    1450:	55                   	push   %ebp
    1451:	89 e5                	mov    %esp,%ebp
    1453:	56                   	push   %esi
    1454:	53                   	push   %ebx
  int fd, fd1;

  printf(1, "unlinkread test\n");
    1455:	83 ec 08             	sub    $0x8,%esp
    1458:	68 ac 42 00 00       	push   $0x42ac
    145d:	6a 01                	push   $0x1
    145f:	e8 4c 26 00 00       	call   3ab0 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1464:	5b                   	pop    %ebx
    1465:	5e                   	pop    %esi
    1466:	68 02 02 00 00       	push   $0x202
    146b:	68 bd 42 00 00       	push   $0x42bd
    1470:	e8 2d 25 00 00       	call   39a2 <open>
  if(fd < 0){
    1475:	83 c4 10             	add    $0x10,%esp
    1478:	85 c0                	test   %eax,%eax
    147a:	0f 88 e6 00 00 00    	js     1566 <unlinkread+0x116>
    printf(1, "create unlinkread failed\n");
    exit();
  }
  write(fd, "hello", 5);
    1480:	83 ec 04             	sub    $0x4,%esp
    1483:	89 c3                	mov    %eax,%ebx
    1485:	6a 05                	push   $0x5
    1487:	68 e2 42 00 00       	push   $0x42e2
    148c:	50                   	push   %eax
    148d:	e8 f0 24 00 00       	call   3982 <write>
  close(fd);
    1492:	89 1c 24             	mov    %ebx,(%esp)
    1495:	e8 f0 24 00 00       	call   398a <close>

  fd = open("unlinkread", O_RDWR);
    149a:	58                   	pop    %eax
    149b:	5a                   	pop    %edx
    149c:	6a 02                	push   $0x2
    149e:	68 bd 42 00 00       	push   $0x42bd
    14a3:	e8 fa 24 00 00       	call   39a2 <open>
  if(fd < 0){
    14a8:	83 c4 10             	add    $0x10,%esp
    14ab:	85 c0                	test   %eax,%eax
    exit();
  }
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
    14ad:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    14af:	0f 88 10 01 00 00    	js     15c5 <unlinkread+0x175>
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    14b5:	83 ec 0c             	sub    $0xc,%esp
    14b8:	68 bd 42 00 00       	push   $0x42bd
    14bd:	e8 f0 24 00 00       	call   39b2 <unlink>
    14c2:	83 c4 10             	add    $0x10,%esp
    14c5:	85 c0                	test   %eax,%eax
    14c7:	0f 85 e5 00 00 00    	jne    15b2 <unlinkread+0x162>
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    14cd:	83 ec 08             	sub    $0x8,%esp
    14d0:	68 02 02 00 00       	push   $0x202
    14d5:	68 bd 42 00 00       	push   $0x42bd
    14da:	e8 c3 24 00 00       	call   39a2 <open>
  write(fd1, "yyy", 3);
    14df:	83 c4 0c             	add    $0xc,%esp
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    14e2:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    14e4:	6a 03                	push   $0x3
    14e6:	68 1a 43 00 00       	push   $0x431a
    14eb:	50                   	push   %eax
    14ec:	e8 91 24 00 00       	call   3982 <write>
  close(fd1);
    14f1:	89 34 24             	mov    %esi,(%esp)
    14f4:	e8 91 24 00 00       	call   398a <close>

  if(read(fd, buf, sizeof(buf)) != 5){
    14f9:	83 c4 0c             	add    $0xc,%esp
    14fc:	68 00 20 00 00       	push   $0x2000
    1501:	68 40 86 00 00       	push   $0x8640
    1506:	53                   	push   %ebx
    1507:	e8 6e 24 00 00       	call   397a <read>
    150c:	83 c4 10             	add    $0x10,%esp
    150f:	83 f8 05             	cmp    $0x5,%eax
    1512:	0f 85 87 00 00 00    	jne    159f <unlinkread+0x14f>
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    1518:	80 3d 40 86 00 00 68 	cmpb   $0x68,0x8640
    151f:	75 6b                	jne    158c <unlinkread+0x13c>
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    1521:	83 ec 04             	sub    $0x4,%esp
    1524:	6a 0a                	push   $0xa
    1526:	68 40 86 00 00       	push   $0x8640
    152b:	53                   	push   %ebx
    152c:	e8 51 24 00 00       	call   3982 <write>
    1531:	83 c4 10             	add    $0x10,%esp
    1534:	83 f8 0a             	cmp    $0xa,%eax
    1537:	75 40                	jne    1579 <unlinkread+0x129>
    printf(1, "unlinkread write failed\n");
    exit();
  }
  close(fd);
    1539:	83 ec 0c             	sub    $0xc,%esp
    153c:	53                   	push   %ebx
    153d:	e8 48 24 00 00       	call   398a <close>
  unlink("unlinkread");
    1542:	c7 04 24 bd 42 00 00 	movl   $0x42bd,(%esp)
    1549:	e8 64 24 00 00       	call   39b2 <unlink>
  printf(1, "unlinkread ok\n");
    154e:	58                   	pop    %eax
    154f:	5a                   	pop    %edx
    1550:	68 65 43 00 00       	push   $0x4365
    1555:	6a 01                	push   $0x1
    1557:	e8 54 25 00 00       	call   3ab0 <printf>
}
    155c:	83 c4 10             	add    $0x10,%esp
    155f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1562:	5b                   	pop    %ebx
    1563:	5e                   	pop    %esi
    1564:	5d                   	pop    %ebp
    1565:	c3                   	ret    
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create unlinkread failed\n");
    1566:	51                   	push   %ecx
    1567:	51                   	push   %ecx
    1568:	68 c8 42 00 00       	push   $0x42c8
    156d:	6a 01                	push   $0x1
    156f:	e8 3c 25 00 00       	call   3ab0 <printf>
    exit();
    1574:	e8 e9 23 00 00       	call   3962 <exit>
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    printf(1, "unlinkread write failed\n");
    1579:	51                   	push   %ecx
    157a:	51                   	push   %ecx
    157b:	68 4c 43 00 00       	push   $0x434c
    1580:	6a 01                	push   $0x1
    1582:	e8 29 25 00 00       	call   3ab0 <printf>
    exit();
    1587:	e8 d6 23 00 00       	call   3962 <exit>
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    158c:	53                   	push   %ebx
    158d:	53                   	push   %ebx
    158e:	68 35 43 00 00       	push   $0x4335
    1593:	6a 01                	push   $0x1
    1595:	e8 16 25 00 00       	call   3ab0 <printf>
    exit();
    159a:	e8 c3 23 00 00       	call   3962 <exit>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
  write(fd1, "yyy", 3);
  close(fd1);

  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    159f:	56                   	push   %esi
    15a0:	56                   	push   %esi
    15a1:	68 1e 43 00 00       	push   $0x431e
    15a6:	6a 01                	push   $0x1
    15a8:	e8 03 25 00 00       	call   3ab0 <printf>
    exit();
    15ad:	e8 b0 23 00 00       	call   3962 <exit>
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    15b2:	50                   	push   %eax
    15b3:	50                   	push   %eax
    15b4:	68 00 43 00 00       	push   $0x4300
    15b9:	6a 01                	push   $0x1
    15bb:	e8 f0 24 00 00       	call   3ab0 <printf>
    exit();
    15c0:	e8 9d 23 00 00       	call   3962 <exit>
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    15c5:	50                   	push   %eax
    15c6:	50                   	push   %eax
    15c7:	68 e8 42 00 00       	push   $0x42e8
    15cc:	6a 01                	push   $0x1
    15ce:	e8 dd 24 00 00       	call   3ab0 <printf>
    exit();
    15d3:	e8 8a 23 00 00       	call   3962 <exit>
    15d8:	90                   	nop
    15d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000015e0 <linktest>:
  printf(1, "unlinkread ok\n");
}

void
linktest(void)
{
    15e0:	55                   	push   %ebp
    15e1:	89 e5                	mov    %esp,%ebp
    15e3:	53                   	push   %ebx
    15e4:	83 ec 0c             	sub    $0xc,%esp
  int fd;

  printf(1, "linktest\n");
    15e7:	68 74 43 00 00       	push   $0x4374
    15ec:	6a 01                	push   $0x1
    15ee:	e8 bd 24 00 00       	call   3ab0 <printf>

  unlink("lf1");
    15f3:	c7 04 24 7e 43 00 00 	movl   $0x437e,(%esp)
    15fa:	e8 b3 23 00 00       	call   39b2 <unlink>
  unlink("lf2");
    15ff:	c7 04 24 82 43 00 00 	movl   $0x4382,(%esp)
    1606:	e8 a7 23 00 00       	call   39b2 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    160b:	58                   	pop    %eax
    160c:	5a                   	pop    %edx
    160d:	68 02 02 00 00       	push   $0x202
    1612:	68 7e 43 00 00       	push   $0x437e
    1617:	e8 86 23 00 00       	call   39a2 <open>
  if(fd < 0){
    161c:	83 c4 10             	add    $0x10,%esp
    161f:	85 c0                	test   %eax,%eax
    1621:	0f 88 1e 01 00 00    	js     1745 <linktest+0x165>
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    1627:	83 ec 04             	sub    $0x4,%esp
    162a:	89 c3                	mov    %eax,%ebx
    162c:	6a 05                	push   $0x5
    162e:	68 e2 42 00 00       	push   $0x42e2
    1633:	50                   	push   %eax
    1634:	e8 49 23 00 00       	call   3982 <write>
    1639:	83 c4 10             	add    $0x10,%esp
    163c:	83 f8 05             	cmp    $0x5,%eax
    163f:	0f 85 98 01 00 00    	jne    17dd <linktest+0x1fd>
    printf(1, "write lf1 failed\n");
    exit();
  }
  close(fd);
    1645:	83 ec 0c             	sub    $0xc,%esp
    1648:	53                   	push   %ebx
    1649:	e8 3c 23 00 00       	call   398a <close>

  if(link("lf1", "lf2") < 0){
    164e:	5b                   	pop    %ebx
    164f:	58                   	pop    %eax
    1650:	68 82 43 00 00       	push   $0x4382
    1655:	68 7e 43 00 00       	push   $0x437e
    165a:	e8 63 23 00 00       	call   39c2 <link>
    165f:	83 c4 10             	add    $0x10,%esp
    1662:	85 c0                	test   %eax,%eax
    1664:	0f 88 60 01 00 00    	js     17ca <linktest+0x1ea>
    printf(1, "link lf1 lf2 failed\n");
    exit();
  }
  unlink("lf1");
    166a:	83 ec 0c             	sub    $0xc,%esp
    166d:	68 7e 43 00 00       	push   $0x437e
    1672:	e8 3b 23 00 00       	call   39b2 <unlink>

  if(open("lf1", 0) >= 0){
    1677:	58                   	pop    %eax
    1678:	5a                   	pop    %edx
    1679:	6a 00                	push   $0x0
    167b:	68 7e 43 00 00       	push   $0x437e
    1680:	e8 1d 23 00 00       	call   39a2 <open>
    1685:	83 c4 10             	add    $0x10,%esp
    1688:	85 c0                	test   %eax,%eax
    168a:	0f 89 27 01 00 00    	jns    17b7 <linktest+0x1d7>
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    1690:	83 ec 08             	sub    $0x8,%esp
    1693:	6a 00                	push   $0x0
    1695:	68 82 43 00 00       	push   $0x4382
    169a:	e8 03 23 00 00       	call   39a2 <open>
  if(fd < 0){
    169f:	83 c4 10             	add    $0x10,%esp
    16a2:	85 c0                	test   %eax,%eax
  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    16a4:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    16a6:	0f 88 f8 00 00 00    	js     17a4 <linktest+0x1c4>
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    16ac:	83 ec 04             	sub    $0x4,%esp
    16af:	68 00 20 00 00       	push   $0x2000
    16b4:	68 40 86 00 00       	push   $0x8640
    16b9:	50                   	push   %eax
    16ba:	e8 bb 22 00 00       	call   397a <read>
    16bf:	83 c4 10             	add    $0x10,%esp
    16c2:	83 f8 05             	cmp    $0x5,%eax
    16c5:	0f 85 c6 00 00 00    	jne    1791 <linktest+0x1b1>
    printf(1, "read lf2 failed\n");
    exit();
  }
  close(fd);
    16cb:	83 ec 0c             	sub    $0xc,%esp
    16ce:	53                   	push   %ebx
    16cf:	e8 b6 22 00 00       	call   398a <close>

  if(link("lf2", "lf2") >= 0){
    16d4:	58                   	pop    %eax
    16d5:	5a                   	pop    %edx
    16d6:	68 82 43 00 00       	push   $0x4382
    16db:	68 82 43 00 00       	push   $0x4382
    16e0:	e8 dd 22 00 00       	call   39c2 <link>
    16e5:	83 c4 10             	add    $0x10,%esp
    16e8:	85 c0                	test   %eax,%eax
    16ea:	0f 89 8e 00 00 00    	jns    177e <linktest+0x19e>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    exit();
  }

  unlink("lf2");
    16f0:	83 ec 0c             	sub    $0xc,%esp
    16f3:	68 82 43 00 00       	push   $0x4382
    16f8:	e8 b5 22 00 00       	call   39b2 <unlink>
  if(link("lf2", "lf1") >= 0){
    16fd:	59                   	pop    %ecx
    16fe:	5b                   	pop    %ebx
    16ff:	68 7e 43 00 00       	push   $0x437e
    1704:	68 82 43 00 00       	push   $0x4382
    1709:	e8 b4 22 00 00       	call   39c2 <link>
    170e:	83 c4 10             	add    $0x10,%esp
    1711:	85 c0                	test   %eax,%eax
    1713:	79 56                	jns    176b <linktest+0x18b>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    1715:	83 ec 08             	sub    $0x8,%esp
    1718:	68 7e 43 00 00       	push   $0x437e
    171d:	68 46 46 00 00       	push   $0x4646
    1722:	e8 9b 22 00 00       	call   39c2 <link>
    1727:	83 c4 10             	add    $0x10,%esp
    172a:	85 c0                	test   %eax,%eax
    172c:	79 2a                	jns    1758 <linktest+0x178>
    printf(1, "link . lf1 succeeded! oops\n");
    exit();
  }

  printf(1, "linktest ok\n");
    172e:	83 ec 08             	sub    $0x8,%esp
    1731:	68 1c 44 00 00       	push   $0x441c
    1736:	6a 01                	push   $0x1
    1738:	e8 73 23 00 00       	call   3ab0 <printf>
}
    173d:	83 c4 10             	add    $0x10,%esp
    1740:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1743:	c9                   	leave  
    1744:	c3                   	ret    
  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    1745:	50                   	push   %eax
    1746:	50                   	push   %eax
    1747:	68 86 43 00 00       	push   $0x4386
    174c:	6a 01                	push   $0x1
    174e:	e8 5d 23 00 00       	call   3ab0 <printf>
    exit();
    1753:	e8 0a 22 00 00       	call   3962 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    printf(1, "link . lf1 succeeded! oops\n");
    1758:	50                   	push   %eax
    1759:	50                   	push   %eax
    175a:	68 00 44 00 00       	push   $0x4400
    175f:	6a 01                	push   $0x1
    1761:	e8 4a 23 00 00       	call   3ab0 <printf>
    exit();
    1766:	e8 f7 21 00 00       	call   3962 <exit>
    exit();
  }

  unlink("lf2");
  if(link("lf2", "lf1") >= 0){
    printf(1, "link non-existant succeeded! oops\n");
    176b:	52                   	push   %edx
    176c:	52                   	push   %edx
    176d:	68 b4 4f 00 00       	push   $0x4fb4
    1772:	6a 01                	push   $0x1
    1774:	e8 37 23 00 00       	call   3ab0 <printf>
    exit();
    1779:	e8 e4 21 00 00       	call   3962 <exit>
    exit();
  }
  close(fd);

  if(link("lf2", "lf2") >= 0){
    printf(1, "link lf2 lf2 succeeded! oops\n");
    177e:	50                   	push   %eax
    177f:	50                   	push   %eax
    1780:	68 e2 43 00 00       	push   $0x43e2
    1785:	6a 01                	push   $0x1
    1787:	e8 24 23 00 00       	call   3ab0 <printf>
    exit();
    178c:	e8 d1 21 00 00       	call   3962 <exit>
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "read lf2 failed\n");
    1791:	51                   	push   %ecx
    1792:	51                   	push   %ecx
    1793:	68 d1 43 00 00       	push   $0x43d1
    1798:	6a 01                	push   $0x1
    179a:	e8 11 23 00 00       	call   3ab0 <printf>
    exit();
    179f:	e8 be 21 00 00       	call   3962 <exit>
    exit();
  }

  fd = open("lf2", 0);
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    17a4:	53                   	push   %ebx
    17a5:	53                   	push   %ebx
    17a6:	68 c0 43 00 00       	push   $0x43c0
    17ab:	6a 01                	push   $0x1
    17ad:	e8 fe 22 00 00       	call   3ab0 <printf>
    exit();
    17b2:	e8 ab 21 00 00       	call   3962 <exit>
    exit();
  }
  unlink("lf1");

  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    17b7:	50                   	push   %eax
    17b8:	50                   	push   %eax
    17b9:	68 8c 4f 00 00       	push   $0x4f8c
    17be:	6a 01                	push   $0x1
    17c0:	e8 eb 22 00 00       	call   3ab0 <printf>
    exit();
    17c5:	e8 98 21 00 00       	call   3962 <exit>
    exit();
  }
  close(fd);

  if(link("lf1", "lf2") < 0){
    printf(1, "link lf1 lf2 failed\n");
    17ca:	51                   	push   %ecx
    17cb:	51                   	push   %ecx
    17cc:	68 ab 43 00 00       	push   $0x43ab
    17d1:	6a 01                	push   $0x1
    17d3:	e8 d8 22 00 00       	call   3ab0 <printf>
    exit();
    17d8:	e8 85 21 00 00       	call   3962 <exit>
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    printf(1, "write lf1 failed\n");
    17dd:	50                   	push   %eax
    17de:	50                   	push   %eax
    17df:	68 99 43 00 00       	push   $0x4399
    17e4:	6a 01                	push   $0x1
    17e6:	e8 c5 22 00 00       	call   3ab0 <printf>
    exit();
    17eb:	e8 72 21 00 00       	call   3962 <exit>

000017f0 <concreate>:
}

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    17f0:	55                   	push   %ebp
    17f1:	89 e5                	mov    %esp,%ebp
    17f3:	57                   	push   %edi
    17f4:	56                   	push   %esi
    17f5:	53                   	push   %ebx
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    17f6:	31 f6                	xor    %esi,%esi
    17f8:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    file[1] = '0' + i;
    unlink(file);
    pid = fork(0);
    if(pid && (i % 3) == 1){
    17fb:	bf 56 55 55 55       	mov    $0x55555556,%edi
}

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    1800:	83 ec 64             	sub    $0x64,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    1803:	68 29 44 00 00       	push   $0x4429
    1808:	6a 01                	push   $0x1
    180a:	e8 a1 22 00 00       	call   3ab0 <printf>
  file[0] = 'C';
    180f:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
  file[2] = '\0';
    1813:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
    1817:	83 c4 10             	add    $0x10,%esp
    181a:	eb 51                	jmp    186d <concreate+0x7d>
    181c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork(0);
    if(pid && (i % 3) == 1){
    1820:	89 f0                	mov    %esi,%eax
    1822:	89 f1                	mov    %esi,%ecx
    1824:	f7 ef                	imul   %edi
    1826:	89 f0                	mov    %esi,%eax
    1828:	c1 f8 1f             	sar    $0x1f,%eax
    182b:	29 c2                	sub    %eax,%edx
    182d:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1830:	29 c1                	sub    %eax,%ecx
    1832:	83 f9 01             	cmp    $0x1,%ecx
    1835:	0f 84 c5 00 00 00    	je     1900 <concreate+0x110>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    183b:	83 ec 08             	sub    $0x8,%esp
    183e:	68 02 02 00 00       	push   $0x202
    1843:	53                   	push   %ebx
    1844:	e8 59 21 00 00       	call   39a2 <open>
      if(fd < 0){
    1849:	83 c4 10             	add    $0x10,%esp
    184c:	85 c0                	test   %eax,%eax
    184e:	78 74                	js     18c4 <concreate+0xd4>
        printf(1, "concreate create %s failed\n", file);
        exit();
      }
      close(fd);
    1850:	83 ec 0c             	sub    $0xc,%esp
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    1853:	83 c6 01             	add    $0x1,%esi
      fd = open(file, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "concreate create %s failed\n", file);
        exit();
      }
      close(fd);
    1856:	50                   	push   %eax
    1857:	e8 2e 21 00 00       	call   398a <close>
    185c:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
      exit();
    else
      wait();
    185f:	e8 06 21 00 00       	call   396a <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    1864:	83 fe 28             	cmp    $0x28,%esi
    1867:	0f 84 bb 00 00 00    	je     1928 <concreate+0x138>
    file[1] = '0' + i;
    unlink(file);
    186d:	83 ec 0c             	sub    $0xc,%esp

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    1870:	8d 46 30             	lea    0x30(%esi),%eax
    unlink(file);
    1873:	53                   	push   %ebx

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    1874:	88 45 ae             	mov    %al,-0x52(%ebp)
    unlink(file);
    1877:	e8 36 21 00 00       	call   39b2 <unlink>
    pid = fork(0);
    187c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1883:	e8 d2 20 00 00       	call   395a <fork>
    if(pid && (i % 3) == 1){
    1888:	83 c4 10             	add    $0x10,%esp
    188b:	85 c0                	test   %eax,%eax
    188d:	75 91                	jne    1820 <concreate+0x30>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
    188f:	89 f0                	mov    %esi,%eax
    1891:	ba 67 66 66 66       	mov    $0x66666667,%edx
    1896:	f7 ea                	imul   %edx
    1898:	89 f0                	mov    %esi,%eax
    189a:	c1 f8 1f             	sar    $0x1f,%eax
    189d:	d1 fa                	sar    %edx
    189f:	29 c2                	sub    %eax,%edx
    18a1:	8d 04 92             	lea    (%edx,%edx,4),%eax
    18a4:	29 c6                	sub    %eax,%esi
    18a6:	83 fe 01             	cmp    $0x1,%esi
    18a9:	74 35                	je     18e0 <concreate+0xf0>
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    18ab:	83 ec 08             	sub    $0x8,%esp
    18ae:	68 02 02 00 00       	push   $0x202
    18b3:	53                   	push   %ebx
    18b4:	e8 e9 20 00 00       	call   39a2 <open>
      if(fd < 0){
    18b9:	83 c4 10             	add    $0x10,%esp
    18bc:	85 c0                	test   %eax,%eax
    18be:	0f 89 4b 02 00 00    	jns    1b0f <concreate+0x31f>
        printf(1, "concreate create %s failed\n", file);
    18c4:	83 ec 04             	sub    $0x4,%esp
    18c7:	53                   	push   %ebx
    18c8:	68 3c 44 00 00       	push   $0x443c
    18cd:	6a 01                	push   $0x1
    18cf:	e8 dc 21 00 00       	call   3ab0 <printf>
        exit();
    18d4:	e8 89 20 00 00       	call   3962 <exit>
    18d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    unlink(file);
    pid = fork(0);
    if(pid && (i % 3) == 1){
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    18e0:	83 ec 08             	sub    $0x8,%esp
    18e3:	53                   	push   %ebx
    18e4:	68 39 44 00 00       	push   $0x4439
    18e9:	e8 d4 20 00 00       	call   39c2 <link>
    18ee:	83 c4 10             	add    $0x10,%esp
        exit();
      }
      close(fd);
    }
    if(pid == 0)
      exit();
    18f1:	e8 6c 20 00 00       	call   3962 <exit>
    18f6:	8d 76 00             	lea    0x0(%esi),%esi
    18f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork(0);
    if(pid && (i % 3) == 1){
      link("C0", file);
    1900:	83 ec 08             	sub    $0x8,%esp
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    1903:	83 c6 01             	add    $0x1,%esi
    file[1] = '0' + i;
    unlink(file);
    pid = fork(0);
    if(pid && (i % 3) == 1){
      link("C0", file);
    1906:	53                   	push   %ebx
    1907:	68 39 44 00 00       	push   $0x4439
    190c:	e8 b1 20 00 00       	call   39c2 <link>
    1911:	83 c4 10             	add    $0x10,%esp
      close(fd);
    }
    if(pid == 0)
      exit();
    else
      wait();
    1914:	e8 51 20 00 00       	call   396a <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    1919:	83 fe 28             	cmp    $0x28,%esi
    191c:	0f 85 4b ff ff ff    	jne    186d <concreate+0x7d>
    1922:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
    else
      wait();
  }

  memset(fa, 0, sizeof(fa));
    1928:	8d 45 c0             	lea    -0x40(%ebp),%eax
    192b:	83 ec 04             	sub    $0x4,%esp
    192e:	8d 7d b0             	lea    -0x50(%ebp),%edi
    1931:	6a 28                	push   $0x28
    1933:	6a 00                	push   $0x0
    1935:	50                   	push   %eax
    1936:	e8 95 1e 00 00       	call   37d0 <memset>
  fd = open(".", 0);
    193b:	59                   	pop    %ecx
    193c:	5e                   	pop    %esi
    193d:	6a 00                	push   $0x0
    193f:	68 46 46 00 00       	push   $0x4646
    1944:	e8 59 20 00 00       	call   39a2 <open>
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    1949:	83 c4 10             	add    $0x10,%esp
    else
      wait();
  }

  memset(fa, 0, sizeof(fa));
  fd = open(".", 0);
    194c:	89 c6                	mov    %eax,%esi
  n = 0;
    194e:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    1955:	8d 76 00             	lea    0x0(%esi),%esi
  while(read(fd, &de, sizeof(de)) > 0){
    1958:	83 ec 04             	sub    $0x4,%esp
    195b:	6a 10                	push   $0x10
    195d:	57                   	push   %edi
    195e:	56                   	push   %esi
    195f:	e8 16 20 00 00       	call   397a <read>
    1964:	83 c4 10             	add    $0x10,%esp
    1967:	85 c0                	test   %eax,%eax
    1969:	7e 3d                	jle    19a8 <concreate+0x1b8>
    if(de.inum == 0)
    196b:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1970:	74 e6                	je     1958 <concreate+0x168>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    1972:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    1976:	75 e0                	jne    1958 <concreate+0x168>
    1978:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    197c:	75 da                	jne    1958 <concreate+0x168>
      i = de.name[1] - '0';
    197e:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    1982:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    1985:	83 f8 27             	cmp    $0x27,%eax
    1988:	0f 87 69 01 00 00    	ja     1af7 <concreate+0x307>
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
    198e:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    1993:	0f 85 46 01 00 00    	jne    1adf <concreate+0x2ef>
        printf(1, "concreate duplicate file %s\n", de.name);
        exit();
      }
      fa[i] = 1;
    1999:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
      n++;
    199e:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
    19a2:	eb b4                	jmp    1958 <concreate+0x168>
    19a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }
  close(fd);
    19a8:	83 ec 0c             	sub    $0xc,%esp
    19ab:	56                   	push   %esi
    19ac:	e8 d9 1f 00 00       	call   398a <close>

  if(n != 40){
    19b1:	83 c4 10             	add    $0x10,%esp
    19b4:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    19b8:	0f 85 0d 01 00 00    	jne    1acb <concreate+0x2db>
    19be:	31 f6                	xor    %esi,%esi
    19c0:	eb 70                	jmp    1a32 <concreate+0x242>
    19c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(pid < 0){
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
       ((i % 3) == 1 && pid != 0)){
    19c8:	83 fa 01             	cmp    $0x1,%edx
    19cb:	0f 85 a1 00 00 00    	jne    1a72 <concreate+0x282>
      close(open(file, 0));
    19d1:	83 ec 08             	sub    $0x8,%esp
    19d4:	6a 00                	push   $0x0
    19d6:	53                   	push   %ebx
    19d7:	e8 c6 1f 00 00       	call   39a2 <open>
    19dc:	89 04 24             	mov    %eax,(%esp)
    19df:	e8 a6 1f 00 00       	call   398a <close>
      close(open(file, 0));
    19e4:	58                   	pop    %eax
    19e5:	5a                   	pop    %edx
    19e6:	6a 00                	push   $0x0
    19e8:	53                   	push   %ebx
    19e9:	e8 b4 1f 00 00       	call   39a2 <open>
    19ee:	89 04 24             	mov    %eax,(%esp)
    19f1:	e8 94 1f 00 00       	call   398a <close>
      close(open(file, 0));
    19f6:	59                   	pop    %ecx
    19f7:	58                   	pop    %eax
    19f8:	6a 00                	push   $0x0
    19fa:	53                   	push   %ebx
    19fb:	e8 a2 1f 00 00       	call   39a2 <open>
    1a00:	89 04 24             	mov    %eax,(%esp)
    1a03:	e8 82 1f 00 00       	call   398a <close>
      close(open(file, 0));
    1a08:	58                   	pop    %eax
    1a09:	5a                   	pop    %edx
    1a0a:	6a 00                	push   $0x0
    1a0c:	53                   	push   %ebx
    1a0d:	e8 90 1f 00 00       	call   39a2 <open>
    1a12:	89 04 24             	mov    %eax,(%esp)
    1a15:	e8 70 1f 00 00       	call   398a <close>
    1a1a:	83 c4 10             	add    $0x10,%esp
      unlink(file);
      unlink(file);
      unlink(file);
      unlink(file);
    }
    if(pid == 0)
    1a1d:	85 ff                	test   %edi,%edi
    1a1f:	0f 84 cc fe ff ff    	je     18f1 <concreate+0x101>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    1a25:	83 c6 01             	add    $0x1,%esi
      unlink(file);
    }
    if(pid == 0)
      exit();
    else
      wait();
    1a28:	e8 3d 1f 00 00       	call   396a <wait>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    1a2d:	83 fe 28             	cmp    $0x28,%esi
    1a30:	74 6e                	je     1aa0 <concreate+0x2b0>
    file[1] = '0' + i;
    pid = fork(0);
    1a32:	83 ec 0c             	sub    $0xc,%esp
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    1a35:	8d 46 30             	lea    0x30(%esi),%eax
    pid = fork(0);
    1a38:	6a 00                	push   $0x0
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    1a3a:	88 45 ae             	mov    %al,-0x52(%ebp)
    pid = fork(0);
    1a3d:	e8 18 1f 00 00       	call   395a <fork>
    if(pid < 0){
    1a42:	83 c4 10             	add    $0x10,%esp
    1a45:	85 c0                	test   %eax,%eax
    exit();
  }

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork(0);
    1a47:	89 c7                	mov    %eax,%edi
    if(pid < 0){
    1a49:	78 6c                	js     1ab7 <concreate+0x2c7>
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    1a4b:	b8 56 55 55 55       	mov    $0x55555556,%eax
    1a50:	f7 ee                	imul   %esi
    1a52:	89 f0                	mov    %esi,%eax
    1a54:	c1 f8 1f             	sar    $0x1f,%eax
    1a57:	29 c2                	sub    %eax,%edx
    1a59:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1a5c:	89 f2                	mov    %esi,%edx
    1a5e:	29 c2                	sub    %eax,%edx
    1a60:	89 f8                	mov    %edi,%eax
    1a62:	09 d0                	or     %edx,%eax
    1a64:	0f 84 67 ff ff ff    	je     19d1 <concreate+0x1e1>
       ((i % 3) == 1 && pid != 0)){
    1a6a:	85 ff                	test   %edi,%edi
    1a6c:	0f 85 56 ff ff ff    	jne    19c8 <concreate+0x1d8>
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
    } else {
      unlink(file);
    1a72:	83 ec 0c             	sub    $0xc,%esp
    1a75:	53                   	push   %ebx
    1a76:	e8 37 1f 00 00       	call   39b2 <unlink>
      unlink(file);
    1a7b:	89 1c 24             	mov    %ebx,(%esp)
    1a7e:	e8 2f 1f 00 00       	call   39b2 <unlink>
      unlink(file);
    1a83:	89 1c 24             	mov    %ebx,(%esp)
    1a86:	e8 27 1f 00 00       	call   39b2 <unlink>
      unlink(file);
    1a8b:	89 1c 24             	mov    %ebx,(%esp)
    1a8e:	e8 1f 1f 00 00       	call   39b2 <unlink>
    1a93:	83 c4 10             	add    $0x10,%esp
    1a96:	eb 85                	jmp    1a1d <concreate+0x22d>
    1a98:	90                   	nop
    1a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      exit();
    else
      wait();
  }

  printf(1, "concreate ok\n");
    1aa0:	83 ec 08             	sub    $0x8,%esp
    1aa3:	68 8e 44 00 00       	push   $0x448e
    1aa8:	6a 01                	push   $0x1
    1aaa:	e8 01 20 00 00       	call   3ab0 <printf>
}
    1aaf:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1ab2:	5b                   	pop    %ebx
    1ab3:	5e                   	pop    %esi
    1ab4:	5f                   	pop    %edi
    1ab5:	5d                   	pop    %ebp
    1ab6:	c3                   	ret    

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork(0);
    if(pid < 0){
      printf(1, "fork failed\n");
    1ab7:	83 ec 08             	sub    $0x8,%esp
    1aba:	68 11 4d 00 00       	push   $0x4d11
    1abf:	6a 01                	push   $0x1
    1ac1:	e8 ea 1f 00 00       	call   3ab0 <printf>
      exit();
    1ac6:	e8 97 1e 00 00       	call   3962 <exit>
    }
  }
  close(fd);

  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    1acb:	83 ec 08             	sub    $0x8,%esp
    1ace:	68 d8 4f 00 00       	push   $0x4fd8
    1ad3:	6a 01                	push   $0x1
    1ad5:	e8 d6 1f 00 00       	call   3ab0 <printf>
    exit();
    1ada:	e8 83 1e 00 00       	call   3962 <exit>
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
        printf(1, "concreate duplicate file %s\n", de.name);
    1adf:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1ae2:	83 ec 04             	sub    $0x4,%esp
    1ae5:	50                   	push   %eax
    1ae6:	68 71 44 00 00       	push   $0x4471
    1aeb:	6a 01                	push   $0x1
    1aed:	e8 be 1f 00 00       	call   3ab0 <printf>
        exit();
    1af2:	e8 6b 1e 00 00       	call   3962 <exit>
    if(de.inum == 0)
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
    1af7:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1afa:	83 ec 04             	sub    $0x4,%esp
    1afd:	50                   	push   %eax
    1afe:	68 58 44 00 00       	push   $0x4458
    1b03:	6a 01                	push   $0x1
    1b05:	e8 a6 1f 00 00       	call   3ab0 <printf>
        exit();
    1b0a:	e8 53 1e 00 00       	call   3962 <exit>
      fd = open(file, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "concreate create %s failed\n", file);
        exit();
      }
      close(fd);
    1b0f:	83 ec 0c             	sub    $0xc,%esp
    1b12:	50                   	push   %eax
    1b13:	e8 72 1e 00 00       	call   398a <close>
    1b18:	83 c4 10             	add    $0x10,%esp
    1b1b:	e9 d1 fd ff ff       	jmp    18f1 <concreate+0x101>

00001b20 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1b20:	55                   	push   %ebp
    1b21:	89 e5                	mov    %esp,%ebp
    1b23:	57                   	push   %edi
    1b24:	56                   	push   %esi
    1b25:	53                   	push   %ebx
    1b26:	83 ec 24             	sub    $0x24,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    1b29:	68 9c 44 00 00       	push   $0x449c
    1b2e:	6a 01                	push   $0x1
    1b30:	e8 7b 1f 00 00       	call   3ab0 <printf>

  unlink("x");
    1b35:	c7 04 24 29 47 00 00 	movl   $0x4729,(%esp)
    1b3c:	e8 71 1e 00 00       	call   39b2 <unlink>
  pid = fork(0);
    1b41:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1b48:	e8 0d 1e 00 00       	call   395a <fork>
  if(pid < 0){
    1b4d:	83 c4 10             	add    $0x10,%esp
    1b50:	85 c0                	test   %eax,%eax
  int pid, i;

  printf(1, "linkunlink test\n");

  unlink("x");
  pid = fork(0);
    1b52:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    1b55:	0f 88 b7 00 00 00    	js     1c12 <linkunlink+0xf2>
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
    1b5b:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1b5f:	bb 64 00 00 00       	mov    $0x64,%ebx
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
    1b64:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
  if(pid < 0){
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
    1b69:	19 ff                	sbb    %edi,%edi
    1b6b:	83 e7 60             	and    $0x60,%edi
    1b6e:	83 c7 01             	add    $0x1,%edi
    1b71:	eb 1f                	jmp    1b92 <linkunlink+0x72>
    1b73:	90                   	nop
    1b74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
      close(open("x", O_RDWR | O_CREATE));
    } else if((x % 3) == 1){
    1b78:	83 fa 01             	cmp    $0x1,%edx
    1b7b:	74 7b                	je     1bf8 <linkunlink+0xd8>
      link("cat", "x");
    } else {
      unlink("x");
    1b7d:	83 ec 0c             	sub    $0xc,%esp
    1b80:	68 29 47 00 00       	push   $0x4729
    1b85:	e8 28 1e 00 00       	call   39b2 <unlink>
    1b8a:	83 c4 10             	add    $0x10,%esp
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    1b8d:	83 eb 01             	sub    $0x1,%ebx
    1b90:	74 3d                	je     1bcf <linkunlink+0xaf>
    x = x * 1103515245 + 12345;
    1b92:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    1b98:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    if((x % 3) == 0){
    1b9e:	89 f8                	mov    %edi,%eax
    1ba0:	f7 e6                	mul    %esi
    1ba2:	d1 ea                	shr    %edx
    1ba4:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1ba7:	89 fa                	mov    %edi,%edx
    1ba9:	29 c2                	sub    %eax,%edx
    1bab:	75 cb                	jne    1b78 <linkunlink+0x58>
      close(open("x", O_RDWR | O_CREATE));
    1bad:	83 ec 08             	sub    $0x8,%esp
    1bb0:	68 02 02 00 00       	push   $0x202
    1bb5:	68 29 47 00 00       	push   $0x4729
    1bba:	e8 e3 1d 00 00       	call   39a2 <open>
    1bbf:	89 04 24             	mov    %eax,(%esp)
    1bc2:	e8 c3 1d 00 00       	call   398a <close>
    1bc7:	83 c4 10             	add    $0x10,%esp
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    1bca:	83 eb 01             	sub    $0x1,%ebx
    1bcd:	75 c3                	jne    1b92 <linkunlink+0x72>
    } else {
      unlink("x");
    }
  }

  if(pid)
    1bcf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bd2:	85 c0                	test   %eax,%eax
    1bd4:	74 50                	je     1c26 <linkunlink+0x106>
    wait();
    1bd6:	e8 8f 1d 00 00       	call   396a <wait>
  else
    exit();

  printf(1, "linkunlink ok\n");
    1bdb:	83 ec 08             	sub    $0x8,%esp
    1bde:	68 b1 44 00 00       	push   $0x44b1
    1be3:	6a 01                	push   $0x1
    1be5:	e8 c6 1e 00 00       	call   3ab0 <printf>
}
    1bea:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1bed:	5b                   	pop    %ebx
    1bee:	5e                   	pop    %esi
    1bef:	5f                   	pop    %edi
    1bf0:	5d                   	pop    %ebp
    1bf1:	c3                   	ret    
    1bf2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
      close(open("x", O_RDWR | O_CREATE));
    } else if((x % 3) == 1){
      link("cat", "x");
    1bf8:	83 ec 08             	sub    $0x8,%esp
    1bfb:	68 29 47 00 00       	push   $0x4729
    1c00:	68 ad 44 00 00       	push   $0x44ad
    1c05:	e8 b8 1d 00 00       	call   39c2 <link>
    1c0a:	83 c4 10             	add    $0x10,%esp
    1c0d:	e9 7b ff ff ff       	jmp    1b8d <linkunlink+0x6d>
  printf(1, "linkunlink test\n");

  unlink("x");
  pid = fork(0);
  if(pid < 0){
    printf(1, "fork failed\n");
    1c12:	83 ec 08             	sub    $0x8,%esp
    1c15:	68 11 4d 00 00       	push   $0x4d11
    1c1a:	6a 01                	push   $0x1
    1c1c:	e8 8f 1e 00 00       	call   3ab0 <printf>
    exit();
    1c21:	e8 3c 1d 00 00       	call   3962 <exit>
  }

  if(pid)
    wait();
  else
    exit();
    1c26:	e8 37 1d 00 00       	call   3962 <exit>
    1c2b:	90                   	nop
    1c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001c30 <bigdir>:
}

// directory that uses indirect blocks
void
bigdir(void)
{
    1c30:	55                   	push   %ebp
    1c31:	89 e5                	mov    %esp,%ebp
    1c33:	56                   	push   %esi
    1c34:	53                   	push   %ebx
    1c35:	83 ec 18             	sub    $0x18,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1c38:	68 c0 44 00 00       	push   $0x44c0
    1c3d:	6a 01                	push   $0x1
    1c3f:	e8 6c 1e 00 00       	call   3ab0 <printf>
  unlink("bd");
    1c44:	c7 04 24 cd 44 00 00 	movl   $0x44cd,(%esp)
    1c4b:	e8 62 1d 00 00       	call   39b2 <unlink>

  fd = open("bd", O_CREATE);
    1c50:	58                   	pop    %eax
    1c51:	5a                   	pop    %edx
    1c52:	68 00 02 00 00       	push   $0x200
    1c57:	68 cd 44 00 00       	push   $0x44cd
    1c5c:	e8 41 1d 00 00       	call   39a2 <open>
  if(fd < 0){
    1c61:	83 c4 10             	add    $0x10,%esp
    1c64:	85 c0                	test   %eax,%eax
    1c66:	0f 88 de 00 00 00    	js     1d4a <bigdir+0x11a>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);
    1c6c:	83 ec 0c             	sub    $0xc,%esp
    1c6f:	8d 75 ee             	lea    -0x12(%ebp),%esi

  for(i = 0; i < 500; i++){
    1c72:	31 db                	xor    %ebx,%ebx
  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);
    1c74:	50                   	push   %eax
    1c75:	e8 10 1d 00 00       	call   398a <close>
    1c7a:	83 c4 10             	add    $0x10,%esp
    1c7d:	8d 76 00             	lea    0x0(%esi),%esi

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1c80:	89 d8                	mov    %ebx,%eax
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
    1c82:	83 ec 08             	sub    $0x8,%esp
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    1c85:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    1c89:	c1 f8 06             	sar    $0x6,%eax
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
    1c8c:	56                   	push   %esi
    1c8d:	68 cd 44 00 00       	push   $0x44cd
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1c92:	83 c0 30             	add    $0x30,%eax
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    1c95:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1c99:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    1c9c:	89 d8                	mov    %ebx,%eax
    1c9e:	83 e0 3f             	and    $0x3f,%eax
    1ca1:	83 c0 30             	add    $0x30,%eax
    1ca4:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    if(link("bd", name) != 0){
    1ca7:	e8 16 1d 00 00       	call   39c2 <link>
    1cac:	83 c4 10             	add    $0x10,%esp
    1caf:	85 c0                	test   %eax,%eax
    1cb1:	75 6f                	jne    1d22 <bigdir+0xf2>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    1cb3:	83 c3 01             	add    $0x1,%ebx
    1cb6:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1cbc:	75 c2                	jne    1c80 <bigdir+0x50>
      printf(1, "bigdir link failed\n");
      exit();
    }
  }

  unlink("bd");
    1cbe:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < 500; i++){
    1cc1:	31 db                	xor    %ebx,%ebx
      printf(1, "bigdir link failed\n");
      exit();
    }
  }

  unlink("bd");
    1cc3:	68 cd 44 00 00       	push   $0x44cd
    1cc8:	e8 e5 1c 00 00       	call   39b2 <unlink>
    1ccd:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1cd0:	89 d8                	mov    %ebx,%eax
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
    1cd2:	83 ec 0c             	sub    $0xc,%esp
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    1cd5:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    1cd9:	c1 f8 06             	sar    $0x6,%eax
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
    1cdc:	56                   	push   %esi
  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    1cdd:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1ce1:	83 c0 30             	add    $0x30,%eax
    1ce4:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    1ce7:	89 d8                	mov    %ebx,%eax
    1ce9:	83 e0 3f             	and    $0x3f,%eax
    1cec:	83 c0 30             	add    $0x30,%eax
    1cef:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    if(unlink(name) != 0){
    1cf2:	e8 bb 1c 00 00       	call   39b2 <unlink>
    1cf7:	83 c4 10             	add    $0x10,%esp
    1cfa:	85 c0                	test   %eax,%eax
    1cfc:	75 38                	jne    1d36 <bigdir+0x106>
      exit();
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    1cfe:	83 c3 01             	add    $0x1,%ebx
    1d01:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1d07:	75 c7                	jne    1cd0 <bigdir+0xa0>
      printf(1, "bigdir unlink failed");
      exit();
    }
  }

  printf(1, "bigdir ok\n");
    1d09:	83 ec 08             	sub    $0x8,%esp
    1d0c:	68 0f 45 00 00       	push   $0x450f
    1d11:	6a 01                	push   $0x1
    1d13:	e8 98 1d 00 00       	call   3ab0 <printf>
}
    1d18:	83 c4 10             	add    $0x10,%esp
    1d1b:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1d1e:	5b                   	pop    %ebx
    1d1f:	5e                   	pop    %esi
    1d20:	5d                   	pop    %ebp
    1d21:	c3                   	ret    
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
      printf(1, "bigdir link failed\n");
    1d22:	83 ec 08             	sub    $0x8,%esp
    1d25:	68 e6 44 00 00       	push   $0x44e6
    1d2a:	6a 01                	push   $0x1
    1d2c:	e8 7f 1d 00 00       	call   3ab0 <printf>
      exit();
    1d31:	e8 2c 1c 00 00       	call   3962 <exit>
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
      printf(1, "bigdir unlink failed");
    1d36:	83 ec 08             	sub    $0x8,%esp
    1d39:	68 fa 44 00 00       	push   $0x44fa
    1d3e:	6a 01                	push   $0x1
    1d40:	e8 6b 1d 00 00       	call   3ab0 <printf>
      exit();
    1d45:	e8 18 1c 00 00       	call   3962 <exit>
  printf(1, "bigdir test\n");
  unlink("bd");

  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf(1, "bigdir create failed\n");
    1d4a:	83 ec 08             	sub    $0x8,%esp
    1d4d:	68 d0 44 00 00       	push   $0x44d0
    1d52:	6a 01                	push   $0x1
    1d54:	e8 57 1d 00 00       	call   3ab0 <printf>
    exit();
    1d59:	e8 04 1c 00 00       	call   3962 <exit>
    1d5e:	66 90                	xchg   %ax,%ax

00001d60 <subdir>:
  printf(1, "bigdir ok\n");
}

void
subdir(void)
{
    1d60:	55                   	push   %ebp
    1d61:	89 e5                	mov    %esp,%ebp
    1d63:	53                   	push   %ebx
    1d64:	83 ec 0c             	sub    $0xc,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    1d67:	68 1a 45 00 00       	push   $0x451a
    1d6c:	6a 01                	push   $0x1
    1d6e:	e8 3d 1d 00 00       	call   3ab0 <printf>

  unlink("ff");
    1d73:	c7 04 24 a3 45 00 00 	movl   $0x45a3,(%esp)
    1d7a:	e8 33 1c 00 00       	call   39b2 <unlink>
  if(mkdir("dd") != 0){
    1d7f:	c7 04 24 40 46 00 00 	movl   $0x4640,(%esp)
    1d86:	e8 3f 1c 00 00       	call   39ca <mkdir>
    1d8b:	83 c4 10             	add    $0x10,%esp
    1d8e:	85 c0                	test   %eax,%eax
    1d90:	0f 85 b3 05 00 00    	jne    2349 <subdir+0x5e9>
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d96:	83 ec 08             	sub    $0x8,%esp
    1d99:	68 02 02 00 00       	push   $0x202
    1d9e:	68 79 45 00 00       	push   $0x4579
    1da3:	e8 fa 1b 00 00       	call   39a2 <open>
  if(fd < 0){
    1da8:	83 c4 10             	add    $0x10,%esp
    1dab:	85 c0                	test   %eax,%eax
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1dad:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1daf:	0f 88 81 05 00 00    	js     2336 <subdir+0x5d6>
    printf(1, "create dd/ff failed\n");
    exit();
  }
  write(fd, "ff", 2);
    1db5:	83 ec 04             	sub    $0x4,%esp
    1db8:	6a 02                	push   $0x2
    1dba:	68 a3 45 00 00       	push   $0x45a3
    1dbf:	50                   	push   %eax
    1dc0:	e8 bd 1b 00 00       	call   3982 <write>
  close(fd);
    1dc5:	89 1c 24             	mov    %ebx,(%esp)
    1dc8:	e8 bd 1b 00 00       	call   398a <close>

  if(unlink("dd") >= 0){
    1dcd:	c7 04 24 40 46 00 00 	movl   $0x4640,(%esp)
    1dd4:	e8 d9 1b 00 00       	call   39b2 <unlink>
    1dd9:	83 c4 10             	add    $0x10,%esp
    1ddc:	85 c0                	test   %eax,%eax
    1dde:	0f 89 3f 05 00 00    	jns    2323 <subdir+0x5c3>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    1de4:	83 ec 0c             	sub    $0xc,%esp
    1de7:	68 54 45 00 00       	push   $0x4554
    1dec:	e8 d9 1b 00 00       	call   39ca <mkdir>
    1df1:	83 c4 10             	add    $0x10,%esp
    1df4:	85 c0                	test   %eax,%eax
    1df6:	0f 85 14 05 00 00    	jne    2310 <subdir+0x5b0>
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1dfc:	83 ec 08             	sub    $0x8,%esp
    1dff:	68 02 02 00 00       	push   $0x202
    1e04:	68 76 45 00 00       	push   $0x4576
    1e09:	e8 94 1b 00 00       	call   39a2 <open>
  if(fd < 0){
    1e0e:	83 c4 10             	add    $0x10,%esp
    1e11:	85 c0                	test   %eax,%eax
  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1e13:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1e15:	0f 88 24 04 00 00    	js     223f <subdir+0x4df>
    printf(1, "create dd/dd/ff failed\n");
    exit();
  }
  write(fd, "FF", 2);
    1e1b:	83 ec 04             	sub    $0x4,%esp
    1e1e:	6a 02                	push   $0x2
    1e20:	68 97 45 00 00       	push   $0x4597
    1e25:	50                   	push   %eax
    1e26:	e8 57 1b 00 00       	call   3982 <write>
  close(fd);
    1e2b:	89 1c 24             	mov    %ebx,(%esp)
    1e2e:	e8 57 1b 00 00       	call   398a <close>

  fd = open("dd/dd/../ff", 0);
    1e33:	58                   	pop    %eax
    1e34:	5a                   	pop    %edx
    1e35:	6a 00                	push   $0x0
    1e37:	68 9a 45 00 00       	push   $0x459a
    1e3c:	e8 61 1b 00 00       	call   39a2 <open>
  if(fd < 0){
    1e41:	83 c4 10             	add    $0x10,%esp
    1e44:	85 c0                	test   %eax,%eax
    exit();
  }
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
    1e46:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1e48:	0f 88 de 03 00 00    	js     222c <subdir+0x4cc>
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
    1e4e:	83 ec 04             	sub    $0x4,%esp
    1e51:	68 00 20 00 00       	push   $0x2000
    1e56:	68 40 86 00 00       	push   $0x8640
    1e5b:	50                   	push   %eax
    1e5c:	e8 19 1b 00 00       	call   397a <read>
  if(cc != 2 || buf[0] != 'f'){
    1e61:	83 c4 10             	add    $0x10,%esp
    1e64:	83 f8 02             	cmp    $0x2,%eax
    1e67:	0f 85 3a 03 00 00    	jne    21a7 <subdir+0x447>
    1e6d:	80 3d 40 86 00 00 66 	cmpb   $0x66,0x8640
    1e74:	0f 85 2d 03 00 00    	jne    21a7 <subdir+0x447>
    printf(1, "dd/dd/../ff wrong content\n");
    exit();
  }
  close(fd);
    1e7a:	83 ec 0c             	sub    $0xc,%esp
    1e7d:	53                   	push   %ebx
    1e7e:	e8 07 1b 00 00       	call   398a <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1e83:	5b                   	pop    %ebx
    1e84:	58                   	pop    %eax
    1e85:	68 da 45 00 00       	push   $0x45da
    1e8a:	68 76 45 00 00       	push   $0x4576
    1e8f:	e8 2e 1b 00 00       	call   39c2 <link>
    1e94:	83 c4 10             	add    $0x10,%esp
    1e97:	85 c0                	test   %eax,%eax
    1e99:	0f 85 c6 03 00 00    	jne    2265 <subdir+0x505>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit();
  }

  if(unlink("dd/dd/ff") != 0){
    1e9f:	83 ec 0c             	sub    $0xc,%esp
    1ea2:	68 76 45 00 00       	push   $0x4576
    1ea7:	e8 06 1b 00 00       	call   39b2 <unlink>
    1eac:	83 c4 10             	add    $0x10,%esp
    1eaf:	85 c0                	test   %eax,%eax
    1eb1:	0f 85 16 03 00 00    	jne    21cd <subdir+0x46d>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1eb7:	83 ec 08             	sub    $0x8,%esp
    1eba:	6a 00                	push   $0x0
    1ebc:	68 76 45 00 00       	push   $0x4576
    1ec1:	e8 dc 1a 00 00       	call   39a2 <open>
    1ec6:	83 c4 10             	add    $0x10,%esp
    1ec9:	85 c0                	test   %eax,%eax
    1ecb:	0f 89 2c 04 00 00    	jns    22fd <subdir+0x59d>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    1ed1:	83 ec 0c             	sub    $0xc,%esp
    1ed4:	68 40 46 00 00       	push   $0x4640
    1ed9:	e8 f4 1a 00 00       	call   39d2 <chdir>
    1ede:	83 c4 10             	add    $0x10,%esp
    1ee1:	85 c0                	test   %eax,%eax
    1ee3:	0f 85 01 04 00 00    	jne    22ea <subdir+0x58a>
    printf(1, "chdir dd failed\n");
    exit();
  }
  if(chdir("dd/../../dd") != 0){
    1ee9:	83 ec 0c             	sub    $0xc,%esp
    1eec:	68 0e 46 00 00       	push   $0x460e
    1ef1:	e8 dc 1a 00 00       	call   39d2 <chdir>
    1ef6:	83 c4 10             	add    $0x10,%esp
    1ef9:	85 c0                	test   %eax,%eax
    1efb:	0f 85 b9 02 00 00    	jne    21ba <subdir+0x45a>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("dd/../../../dd") != 0){
    1f01:	83 ec 0c             	sub    $0xc,%esp
    1f04:	68 34 46 00 00       	push   $0x4634
    1f09:	e8 c4 1a 00 00       	call   39d2 <chdir>
    1f0e:	83 c4 10             	add    $0x10,%esp
    1f11:	85 c0                	test   %eax,%eax
    1f13:	0f 85 a1 02 00 00    	jne    21ba <subdir+0x45a>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    1f19:	83 ec 0c             	sub    $0xc,%esp
    1f1c:	68 43 46 00 00       	push   $0x4643
    1f21:	e8 ac 1a 00 00       	call   39d2 <chdir>
    1f26:	83 c4 10             	add    $0x10,%esp
    1f29:	85 c0                	test   %eax,%eax
    1f2b:	0f 85 21 03 00 00    	jne    2252 <subdir+0x4f2>
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    1f31:	83 ec 08             	sub    $0x8,%esp
    1f34:	6a 00                	push   $0x0
    1f36:	68 da 45 00 00       	push   $0x45da
    1f3b:	e8 62 1a 00 00       	call   39a2 <open>
  if(fd < 0){
    1f40:	83 c4 10             	add    $0x10,%esp
    1f43:	85 c0                	test   %eax,%eax
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    1f45:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1f47:	0f 88 e0 04 00 00    	js     242d <subdir+0x6cd>
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    1f4d:	83 ec 04             	sub    $0x4,%esp
    1f50:	68 00 20 00 00       	push   $0x2000
    1f55:	68 40 86 00 00       	push   $0x8640
    1f5a:	50                   	push   %eax
    1f5b:	e8 1a 1a 00 00       	call   397a <read>
    1f60:	83 c4 10             	add    $0x10,%esp
    1f63:	83 f8 02             	cmp    $0x2,%eax
    1f66:	0f 85 ae 04 00 00    	jne    241a <subdir+0x6ba>
    printf(1, "read dd/dd/ffff wrong len\n");
    exit();
  }
  close(fd);
    1f6c:	83 ec 0c             	sub    $0xc,%esp
    1f6f:	53                   	push   %ebx
    1f70:	e8 15 1a 00 00       	call   398a <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1f75:	59                   	pop    %ecx
    1f76:	5b                   	pop    %ebx
    1f77:	6a 00                	push   $0x0
    1f79:	68 76 45 00 00       	push   $0x4576
    1f7e:	e8 1f 1a 00 00       	call   39a2 <open>
    1f83:	83 c4 10             	add    $0x10,%esp
    1f86:	85 c0                	test   %eax,%eax
    1f88:	0f 89 65 02 00 00    	jns    21f3 <subdir+0x493>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1f8e:	83 ec 08             	sub    $0x8,%esp
    1f91:	68 02 02 00 00       	push   $0x202
    1f96:	68 8e 46 00 00       	push   $0x468e
    1f9b:	e8 02 1a 00 00       	call   39a2 <open>
    1fa0:	83 c4 10             	add    $0x10,%esp
    1fa3:	85 c0                	test   %eax,%eax
    1fa5:	0f 89 35 02 00 00    	jns    21e0 <subdir+0x480>
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1fab:	83 ec 08             	sub    $0x8,%esp
    1fae:	68 02 02 00 00       	push   $0x202
    1fb3:	68 b3 46 00 00       	push   $0x46b3
    1fb8:	e8 e5 19 00 00       	call   39a2 <open>
    1fbd:	83 c4 10             	add    $0x10,%esp
    1fc0:	85 c0                	test   %eax,%eax
    1fc2:	0f 89 0f 03 00 00    	jns    22d7 <subdir+0x577>
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    1fc8:	83 ec 08             	sub    $0x8,%esp
    1fcb:	68 00 02 00 00       	push   $0x200
    1fd0:	68 40 46 00 00       	push   $0x4640
    1fd5:	e8 c8 19 00 00       	call   39a2 <open>
    1fda:	83 c4 10             	add    $0x10,%esp
    1fdd:	85 c0                	test   %eax,%eax
    1fdf:	0f 89 df 02 00 00    	jns    22c4 <subdir+0x564>
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    1fe5:	83 ec 08             	sub    $0x8,%esp
    1fe8:	6a 02                	push   $0x2
    1fea:	68 40 46 00 00       	push   $0x4640
    1fef:	e8 ae 19 00 00       	call   39a2 <open>
    1ff4:	83 c4 10             	add    $0x10,%esp
    1ff7:	85 c0                	test   %eax,%eax
    1ff9:	0f 89 b2 02 00 00    	jns    22b1 <subdir+0x551>
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    1fff:	83 ec 08             	sub    $0x8,%esp
    2002:	6a 01                	push   $0x1
    2004:	68 40 46 00 00       	push   $0x4640
    2009:	e8 94 19 00 00       	call   39a2 <open>
    200e:	83 c4 10             	add    $0x10,%esp
    2011:	85 c0                	test   %eax,%eax
    2013:	0f 89 85 02 00 00    	jns    229e <subdir+0x53e>
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2019:	83 ec 08             	sub    $0x8,%esp
    201c:	68 22 47 00 00       	push   $0x4722
    2021:	68 8e 46 00 00       	push   $0x468e
    2026:	e8 97 19 00 00       	call   39c2 <link>
    202b:	83 c4 10             	add    $0x10,%esp
    202e:	85 c0                	test   %eax,%eax
    2030:	0f 84 55 02 00 00    	je     228b <subdir+0x52b>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2036:	83 ec 08             	sub    $0x8,%esp
    2039:	68 22 47 00 00       	push   $0x4722
    203e:	68 b3 46 00 00       	push   $0x46b3
    2043:	e8 7a 19 00 00       	call   39c2 <link>
    2048:	83 c4 10             	add    $0x10,%esp
    204b:	85 c0                	test   %eax,%eax
    204d:	0f 84 25 02 00 00    	je     2278 <subdir+0x518>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2053:	83 ec 08             	sub    $0x8,%esp
    2056:	68 da 45 00 00       	push   $0x45da
    205b:	68 79 45 00 00       	push   $0x4579
    2060:	e8 5d 19 00 00       	call   39c2 <link>
    2065:	83 c4 10             	add    $0x10,%esp
    2068:	85 c0                	test   %eax,%eax
    206a:	0f 84 a9 01 00 00    	je     2219 <subdir+0x4b9>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    2070:	83 ec 0c             	sub    $0xc,%esp
    2073:	68 8e 46 00 00       	push   $0x468e
    2078:	e8 4d 19 00 00       	call   39ca <mkdir>
    207d:	83 c4 10             	add    $0x10,%esp
    2080:	85 c0                	test   %eax,%eax
    2082:	0f 84 7e 01 00 00    	je     2206 <subdir+0x4a6>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    2088:	83 ec 0c             	sub    $0xc,%esp
    208b:	68 b3 46 00 00       	push   $0x46b3
    2090:	e8 35 19 00 00       	call   39ca <mkdir>
    2095:	83 c4 10             	add    $0x10,%esp
    2098:	85 c0                	test   %eax,%eax
    209a:	0f 84 67 03 00 00    	je     2407 <subdir+0x6a7>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    20a0:	83 ec 0c             	sub    $0xc,%esp
    20a3:	68 da 45 00 00       	push   $0x45da
    20a8:	e8 1d 19 00 00       	call   39ca <mkdir>
    20ad:	83 c4 10             	add    $0x10,%esp
    20b0:	85 c0                	test   %eax,%eax
    20b2:	0f 84 3c 03 00 00    	je     23f4 <subdir+0x694>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    20b8:	83 ec 0c             	sub    $0xc,%esp
    20bb:	68 b3 46 00 00       	push   $0x46b3
    20c0:	e8 ed 18 00 00       	call   39b2 <unlink>
    20c5:	83 c4 10             	add    $0x10,%esp
    20c8:	85 c0                	test   %eax,%eax
    20ca:	0f 84 11 03 00 00    	je     23e1 <subdir+0x681>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    20d0:	83 ec 0c             	sub    $0xc,%esp
    20d3:	68 8e 46 00 00       	push   $0x468e
    20d8:	e8 d5 18 00 00       	call   39b2 <unlink>
    20dd:	83 c4 10             	add    $0x10,%esp
    20e0:	85 c0                	test   %eax,%eax
    20e2:	0f 84 e6 02 00 00    	je     23ce <subdir+0x66e>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    20e8:	83 ec 0c             	sub    $0xc,%esp
    20eb:	68 79 45 00 00       	push   $0x4579
    20f0:	e8 dd 18 00 00       	call   39d2 <chdir>
    20f5:	83 c4 10             	add    $0x10,%esp
    20f8:	85 c0                	test   %eax,%eax
    20fa:	0f 84 bb 02 00 00    	je     23bb <subdir+0x65b>
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    2100:	83 ec 0c             	sub    $0xc,%esp
    2103:	68 25 47 00 00       	push   $0x4725
    2108:	e8 c5 18 00 00       	call   39d2 <chdir>
    210d:	83 c4 10             	add    $0x10,%esp
    2110:	85 c0                	test   %eax,%eax
    2112:	0f 84 90 02 00 00    	je     23a8 <subdir+0x648>
    printf(1, "chdir dd/xx succeeded!\n");
    exit();
  }

  if(unlink("dd/dd/ffff") != 0){
    2118:	83 ec 0c             	sub    $0xc,%esp
    211b:	68 da 45 00 00       	push   $0x45da
    2120:	e8 8d 18 00 00       	call   39b2 <unlink>
    2125:	83 c4 10             	add    $0x10,%esp
    2128:	85 c0                	test   %eax,%eax
    212a:	0f 85 9d 00 00 00    	jne    21cd <subdir+0x46d>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    2130:	83 ec 0c             	sub    $0xc,%esp
    2133:	68 79 45 00 00       	push   $0x4579
    2138:	e8 75 18 00 00       	call   39b2 <unlink>
    213d:	83 c4 10             	add    $0x10,%esp
    2140:	85 c0                	test   %eax,%eax
    2142:	0f 85 4d 02 00 00    	jne    2395 <subdir+0x635>
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    2148:	83 ec 0c             	sub    $0xc,%esp
    214b:	68 40 46 00 00       	push   $0x4640
    2150:	e8 5d 18 00 00       	call   39b2 <unlink>
    2155:	83 c4 10             	add    $0x10,%esp
    2158:	85 c0                	test   %eax,%eax
    215a:	0f 84 22 02 00 00    	je     2382 <subdir+0x622>
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    2160:	83 ec 0c             	sub    $0xc,%esp
    2163:	68 55 45 00 00       	push   $0x4555
    2168:	e8 45 18 00 00       	call   39b2 <unlink>
    216d:	83 c4 10             	add    $0x10,%esp
    2170:	85 c0                	test   %eax,%eax
    2172:	0f 88 f7 01 00 00    	js     236f <subdir+0x60f>
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    2178:	83 ec 0c             	sub    $0xc,%esp
    217b:	68 40 46 00 00       	push   $0x4640
    2180:	e8 2d 18 00 00       	call   39b2 <unlink>
    2185:	83 c4 10             	add    $0x10,%esp
    2188:	85 c0                	test   %eax,%eax
    218a:	0f 88 cc 01 00 00    	js     235c <subdir+0x5fc>
    printf(1, "unlink dd failed\n");
    exit();
  }

  printf(1, "subdir ok\n");
    2190:	83 ec 08             	sub    $0x8,%esp
    2193:	68 22 48 00 00       	push   $0x4822
    2198:	6a 01                	push   $0x1
    219a:	e8 11 19 00 00       	call   3ab0 <printf>
}
    219f:	83 c4 10             	add    $0x10,%esp
    21a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    21a5:	c9                   	leave  
    21a6:	c3                   	ret    
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
  if(cc != 2 || buf[0] != 'f'){
    printf(1, "dd/dd/../ff wrong content\n");
    21a7:	50                   	push   %eax
    21a8:	50                   	push   %eax
    21a9:	68 bf 45 00 00       	push   $0x45bf
    21ae:	6a 01                	push   $0x1
    21b0:	e8 fb 18 00 00       	call   3ab0 <printf>
    exit();
    21b5:	e8 a8 17 00 00       	call   3962 <exit>
  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    exit();
  }
  if(chdir("dd/../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    21ba:	50                   	push   %eax
    21bb:	50                   	push   %eax
    21bc:	68 1a 46 00 00       	push   $0x461a
    21c1:	6a 01                	push   $0x1
    21c3:	e8 e8 18 00 00       	call   3ab0 <printf>
    exit();
    21c8:	e8 95 17 00 00       	call   3962 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit();
  }

  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    21cd:	52                   	push   %edx
    21ce:	52                   	push   %edx
    21cf:	68 e5 45 00 00       	push   $0x45e5
    21d4:	6a 01                	push   $0x1
    21d6:	e8 d5 18 00 00       	call   3ab0 <printf>
    exit();
    21db:	e8 82 17 00 00       	call   3962 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    21e0:	50                   	push   %eax
    21e1:	50                   	push   %eax
    21e2:	68 97 46 00 00       	push   $0x4697
    21e7:	6a 01                	push   $0x1
    21e9:	e8 c2 18 00 00       	call   3ab0 <printf>
    exit();
    21ee:	e8 6f 17 00 00       	call   3962 <exit>
    exit();
  }
  close(fd);

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    21f3:	52                   	push   %edx
    21f4:	52                   	push   %edx
    21f5:	68 7c 50 00 00       	push   $0x507c
    21fa:	6a 01                	push   $0x1
    21fc:	e8 af 18 00 00       	call   3ab0 <printf>
    exit();
    2201:	e8 5c 17 00 00       	call   3962 <exit>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    2206:	52                   	push   %edx
    2207:	52                   	push   %edx
    2208:	68 2b 47 00 00       	push   $0x472b
    220d:	6a 01                	push   $0x1
    220f:	e8 9c 18 00 00       	call   3ab0 <printf>
    exit();
    2214:	e8 49 17 00 00       	call   3962 <exit>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    2219:	51                   	push   %ecx
    221a:	51                   	push   %ecx
    221b:	68 ec 50 00 00       	push   $0x50ec
    2220:	6a 01                	push   $0x1
    2222:	e8 89 18 00 00       	call   3ab0 <printf>
    exit();
    2227:	e8 36 17 00 00       	call   3962 <exit>
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/../ff failed\n");
    222c:	50                   	push   %eax
    222d:	50                   	push   %eax
    222e:	68 a6 45 00 00       	push   $0x45a6
    2233:	6a 01                	push   $0x1
    2235:	e8 76 18 00 00       	call   3ab0 <printf>
    exit();
    223a:	e8 23 17 00 00       	call   3962 <exit>
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/dd/ff failed\n");
    223f:	51                   	push   %ecx
    2240:	51                   	push   %ecx
    2241:	68 7f 45 00 00       	push   $0x457f
    2246:	6a 01                	push   $0x1
    2248:	e8 63 18 00 00       	call   3ab0 <printf>
    exit();
    224d:	e8 10 17 00 00       	call   3962 <exit>
  if(chdir("dd/../../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    2252:	50                   	push   %eax
    2253:	50                   	push   %eax
    2254:	68 48 46 00 00       	push   $0x4648
    2259:	6a 01                	push   $0x1
    225b:	e8 50 18 00 00       	call   3ab0 <printf>
    exit();
    2260:	e8 fd 16 00 00       	call   3962 <exit>
    exit();
  }
  close(fd);

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    2265:	51                   	push   %ecx
    2266:	51                   	push   %ecx
    2267:	68 34 50 00 00       	push   $0x5034
    226c:	6a 01                	push   $0x1
    226e:	e8 3d 18 00 00       	call   3ab0 <printf>
    exit();
    2273:	e8 ea 16 00 00       	call   3962 <exit>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    2278:	53                   	push   %ebx
    2279:	53                   	push   %ebx
    227a:	68 c8 50 00 00       	push   $0x50c8
    227f:	6a 01                	push   $0x1
    2281:	e8 2a 18 00 00       	call   3ab0 <printf>
    exit();
    2286:	e8 d7 16 00 00       	call   3962 <exit>
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    228b:	50                   	push   %eax
    228c:	50                   	push   %eax
    228d:	68 a4 50 00 00       	push   $0x50a4
    2292:	6a 01                	push   $0x1
    2294:	e8 17 18 00 00       	call   3ab0 <printf>
    exit();
    2299:	e8 c4 16 00 00       	call   3962 <exit>
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    229e:	50                   	push   %eax
    229f:	50                   	push   %eax
    22a0:	68 07 47 00 00       	push   $0x4707
    22a5:	6a 01                	push   $0x1
    22a7:	e8 04 18 00 00       	call   3ab0 <printf>
    exit();
    22ac:	e8 b1 16 00 00       	call   3962 <exit>
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    22b1:	50                   	push   %eax
    22b2:	50                   	push   %eax
    22b3:	68 ee 46 00 00       	push   $0x46ee
    22b8:	6a 01                	push   $0x1
    22ba:	e8 f1 17 00 00       	call   3ab0 <printf>
    exit();
    22bf:	e8 9e 16 00 00       	call   3962 <exit>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    22c4:	50                   	push   %eax
    22c5:	50                   	push   %eax
    22c6:	68 d8 46 00 00       	push   $0x46d8
    22cb:	6a 01                	push   $0x1
    22cd:	e8 de 17 00 00       	call   3ab0 <printf>
    exit();
    22d2:	e8 8b 16 00 00       	call   3962 <exit>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    22d7:	50                   	push   %eax
    22d8:	50                   	push   %eax
    22d9:	68 bc 46 00 00       	push   $0x46bc
    22de:	6a 01                	push   $0x1
    22e0:	e8 cb 17 00 00       	call   3ab0 <printf>
    exit();
    22e5:	e8 78 16 00 00       	call   3962 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    22ea:	50                   	push   %eax
    22eb:	50                   	push   %eax
    22ec:	68 fd 45 00 00       	push   $0x45fd
    22f1:	6a 01                	push   $0x1
    22f3:	e8 b8 17 00 00       	call   3ab0 <printf>
    exit();
    22f8:	e8 65 16 00 00       	call   3962 <exit>
  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    22fd:	50                   	push   %eax
    22fe:	50                   	push   %eax
    22ff:	68 58 50 00 00       	push   $0x5058
    2304:	6a 01                	push   $0x1
    2306:	e8 a5 17 00 00       	call   3ab0 <printf>
    exit();
    230b:	e8 52 16 00 00       	call   3962 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    2310:	53                   	push   %ebx
    2311:	53                   	push   %ebx
    2312:	68 5b 45 00 00       	push   $0x455b
    2317:	6a 01                	push   $0x1
    2319:	e8 92 17 00 00       	call   3ab0 <printf>
    exit();
    231e:	e8 3f 16 00 00       	call   3962 <exit>
  }
  write(fd, "ff", 2);
  close(fd);

  if(unlink("dd") >= 0){
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    2323:	50                   	push   %eax
    2324:	50                   	push   %eax
    2325:	68 0c 50 00 00       	push   $0x500c
    232a:	6a 01                	push   $0x1
    232c:	e8 7f 17 00 00       	call   3ab0 <printf>
    exit();
    2331:	e8 2c 16 00 00       	call   3962 <exit>
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/ff failed\n");
    2336:	50                   	push   %eax
    2337:	50                   	push   %eax
    2338:	68 3f 45 00 00       	push   $0x453f
    233d:	6a 01                	push   $0x1
    233f:	e8 6c 17 00 00       	call   3ab0 <printf>
    exit();
    2344:	e8 19 16 00 00       	call   3962 <exit>

  printf(1, "subdir test\n");

  unlink("ff");
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    2349:	50                   	push   %eax
    234a:	50                   	push   %eax
    234b:	68 27 45 00 00       	push   $0x4527
    2350:	6a 01                	push   $0x1
    2352:	e8 59 17 00 00       	call   3ab0 <printf>
    exit();
    2357:	e8 06 16 00 00       	call   3962 <exit>
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    printf(1, "unlink dd failed\n");
    235c:	50                   	push   %eax
    235d:	50                   	push   %eax
    235e:	68 10 48 00 00       	push   $0x4810
    2363:	6a 01                	push   $0x1
    2365:	e8 46 17 00 00       	call   3ab0 <printf>
    exit();
    236a:	e8 f3 15 00 00       	call   3962 <exit>
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    236f:	52                   	push   %edx
    2370:	52                   	push   %edx
    2371:	68 fb 47 00 00       	push   $0x47fb
    2376:	6a 01                	push   $0x1
    2378:	e8 33 17 00 00       	call   3ab0 <printf>
    exit();
    237d:	e8 e0 15 00 00       	call   3962 <exit>
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    2382:	51                   	push   %ecx
    2383:	51                   	push   %ecx
    2384:	68 10 51 00 00       	push   $0x5110
    2389:	6a 01                	push   $0x1
    238b:	e8 20 17 00 00       	call   3ab0 <printf>
    exit();
    2390:	e8 cd 15 00 00       	call   3962 <exit>
  if(unlink("dd/dd/ffff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    2395:	53                   	push   %ebx
    2396:	53                   	push   %ebx
    2397:	68 e6 47 00 00       	push   $0x47e6
    239c:	6a 01                	push   $0x1
    239e:	e8 0d 17 00 00       	call   3ab0 <printf>
    exit();
    23a3:	e8 ba 15 00 00       	call   3962 <exit>
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    printf(1, "chdir dd/xx succeeded!\n");
    23a8:	50                   	push   %eax
    23a9:	50                   	push   %eax
    23aa:	68 ce 47 00 00       	push   $0x47ce
    23af:	6a 01                	push   $0x1
    23b1:	e8 fa 16 00 00       	call   3ab0 <printf>
    exit();
    23b6:	e8 a7 15 00 00       	call   3962 <exit>
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    23bb:	50                   	push   %eax
    23bc:	50                   	push   %eax
    23bd:	68 b6 47 00 00       	push   $0x47b6
    23c2:	6a 01                	push   $0x1
    23c4:	e8 e7 16 00 00       	call   3ab0 <printf>
    exit();
    23c9:	e8 94 15 00 00       	call   3962 <exit>
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    23ce:	50                   	push   %eax
    23cf:	50                   	push   %eax
    23d0:	68 9a 47 00 00       	push   $0x479a
    23d5:	6a 01                	push   $0x1
    23d7:	e8 d4 16 00 00       	call   3ab0 <printf>
    exit();
    23dc:	e8 81 15 00 00       	call   3962 <exit>
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    23e1:	50                   	push   %eax
    23e2:	50                   	push   %eax
    23e3:	68 7e 47 00 00       	push   $0x477e
    23e8:	6a 01                	push   $0x1
    23ea:	e8 c1 16 00 00       	call   3ab0 <printf>
    exit();
    23ef:	e8 6e 15 00 00       	call   3962 <exit>
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    23f4:	50                   	push   %eax
    23f5:	50                   	push   %eax
    23f6:	68 61 47 00 00       	push   $0x4761
    23fb:	6a 01                	push   $0x1
    23fd:	e8 ae 16 00 00       	call   3ab0 <printf>
    exit();
    2402:	e8 5b 15 00 00       	call   3962 <exit>
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    2407:	50                   	push   %eax
    2408:	50                   	push   %eax
    2409:	68 46 47 00 00       	push   $0x4746
    240e:	6a 01                	push   $0x1
    2410:	e8 9b 16 00 00       	call   3ab0 <printf>
    exit();
    2415:	e8 48 15 00 00       	call   3962 <exit>
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    printf(1, "read dd/dd/ffff wrong len\n");
    241a:	50                   	push   %eax
    241b:	50                   	push   %eax
    241c:	68 73 46 00 00       	push   $0x4673
    2421:	6a 01                	push   $0x1
    2423:	e8 88 16 00 00       	call   3ab0 <printf>
    exit();
    2428:	e8 35 15 00 00       	call   3962 <exit>
    exit();
  }

  fd = open("dd/dd/ffff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    242d:	50                   	push   %eax
    242e:	50                   	push   %eax
    242f:	68 5b 46 00 00       	push   $0x465b
    2434:	6a 01                	push   $0x1
    2436:	e8 75 16 00 00       	call   3ab0 <printf>
    exit();
    243b:	e8 22 15 00 00       	call   3962 <exit>

00002440 <bigwrite>:
}

// test writes that are larger than the log.
void
bigwrite(void)
{
    2440:	55                   	push   %ebp
    2441:	89 e5                	mov    %esp,%ebp
    2443:	56                   	push   %esi
    2444:	53                   	push   %ebx
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    2445:	bb f3 01 00 00       	mov    $0x1f3,%ebx
void
bigwrite(void)
{
  int fd, sz;

  printf(1, "bigwrite test\n");
    244a:	83 ec 08             	sub    $0x8,%esp
    244d:	68 2d 48 00 00       	push   $0x482d
    2452:	6a 01                	push   $0x1
    2454:	e8 57 16 00 00       	call   3ab0 <printf>

  unlink("bigwrite");
    2459:	c7 04 24 3c 48 00 00 	movl   $0x483c,(%esp)
    2460:	e8 4d 15 00 00       	call   39b2 <unlink>
    2465:	83 c4 10             	add    $0x10,%esp
    2468:	90                   	nop
    2469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2470:	83 ec 08             	sub    $0x8,%esp
    2473:	68 02 02 00 00       	push   $0x202
    2478:	68 3c 48 00 00       	push   $0x483c
    247d:	e8 20 15 00 00       	call   39a2 <open>
    if(fd < 0){
    2482:	83 c4 10             	add    $0x10,%esp
    2485:	85 c0                	test   %eax,%eax

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2487:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    2489:	78 7e                	js     2509 <bigwrite+0xc9>
      printf(1, "cannot create bigwrite\n");
      exit();
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
    248b:	83 ec 04             	sub    $0x4,%esp
    248e:	53                   	push   %ebx
    248f:	68 40 86 00 00       	push   $0x8640
    2494:	50                   	push   %eax
    2495:	e8 e8 14 00 00       	call   3982 <write>
      if(cc != sz){
    249a:	83 c4 10             	add    $0x10,%esp
    249d:	39 c3                	cmp    %eax,%ebx
    249f:	75 55                	jne    24f6 <bigwrite+0xb6>
      printf(1, "cannot create bigwrite\n");
      exit();
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
    24a1:	83 ec 04             	sub    $0x4,%esp
    24a4:	53                   	push   %ebx
    24a5:	68 40 86 00 00       	push   $0x8640
    24aa:	56                   	push   %esi
    24ab:	e8 d2 14 00 00       	call   3982 <write>
      if(cc != sz){
    24b0:	83 c4 10             	add    $0x10,%esp
    24b3:	39 c3                	cmp    %eax,%ebx
    24b5:	75 3f                	jne    24f6 <bigwrite+0xb6>
        printf(1, "write(%d) ret %d\n", sz, cc);
        exit();
      }
    }
    close(fd);
    24b7:	83 ec 0c             	sub    $0xc,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    24ba:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
        exit();
      }
    }
    close(fd);
    24c0:	56                   	push   %esi
    24c1:	e8 c4 14 00 00       	call   398a <close>
    unlink("bigwrite");
    24c6:	c7 04 24 3c 48 00 00 	movl   $0x483c,(%esp)
    24cd:	e8 e0 14 00 00       	call   39b2 <unlink>
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    24d2:	83 c4 10             	add    $0x10,%esp
    24d5:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    24db:	75 93                	jne    2470 <bigwrite+0x30>
    }
    close(fd);
    unlink("bigwrite");
  }

  printf(1, "bigwrite ok\n");
    24dd:	83 ec 08             	sub    $0x8,%esp
    24e0:	68 6f 48 00 00       	push   $0x486f
    24e5:	6a 01                	push   $0x1
    24e7:	e8 c4 15 00 00       	call   3ab0 <printf>
}
    24ec:	83 c4 10             	add    $0x10,%esp
    24ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
    24f2:	5b                   	pop    %ebx
    24f3:	5e                   	pop    %esi
    24f4:	5d                   	pop    %ebp
    24f5:	c3                   	ret    
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
    24f6:	50                   	push   %eax
    24f7:	53                   	push   %ebx
    24f8:	68 5d 48 00 00       	push   $0x485d
    24fd:	6a 01                	push   $0x1
    24ff:	e8 ac 15 00 00       	call   3ab0 <printf>
        exit();
    2504:	e8 59 14 00 00       	call   3962 <exit>

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
    if(fd < 0){
      printf(1, "cannot create bigwrite\n");
    2509:	83 ec 08             	sub    $0x8,%esp
    250c:	68 45 48 00 00       	push   $0x4845
    2511:	6a 01                	push   $0x1
    2513:	e8 98 15 00 00       	call   3ab0 <printf>
      exit();
    2518:	e8 45 14 00 00       	call   3962 <exit>
    251d:	8d 76 00             	lea    0x0(%esi),%esi

00002520 <bigfile>:
  printf(1, "bigwrite ok\n");
}

void
bigfile(void)
{
    2520:	55                   	push   %ebp
    2521:	89 e5                	mov    %esp,%ebp
    2523:	57                   	push   %edi
    2524:	56                   	push   %esi
    2525:	53                   	push   %ebx
    2526:	83 ec 14             	sub    $0x14,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    2529:	68 7c 48 00 00       	push   $0x487c
    252e:	6a 01                	push   $0x1
    2530:	e8 7b 15 00 00       	call   3ab0 <printf>

  unlink("bigfile");
    2535:	c7 04 24 98 48 00 00 	movl   $0x4898,(%esp)
    253c:	e8 71 14 00 00       	call   39b2 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    2541:	5e                   	pop    %esi
    2542:	5f                   	pop    %edi
    2543:	68 02 02 00 00       	push   $0x202
    2548:	68 98 48 00 00       	push   $0x4898
    254d:	e8 50 14 00 00       	call   39a2 <open>
  if(fd < 0){
    2552:	83 c4 10             	add    $0x10,%esp
    2555:	85 c0                	test   %eax,%eax
    2557:	0f 88 5f 01 00 00    	js     26bc <bigfile+0x19c>
    255d:	89 c6                	mov    %eax,%esi
    255f:	31 db                	xor    %ebx,%ebx
    2561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    2568:	83 ec 04             	sub    $0x4,%esp
    256b:	68 58 02 00 00       	push   $0x258
    2570:	53                   	push   %ebx
    2571:	68 40 86 00 00       	push   $0x8640
    2576:	e8 55 12 00 00       	call   37d0 <memset>
    if(write(fd, buf, 600) != 600){
    257b:	83 c4 0c             	add    $0xc,%esp
    257e:	68 58 02 00 00       	push   $0x258
    2583:	68 40 86 00 00       	push   $0x8640
    2588:	56                   	push   %esi
    2589:	e8 f4 13 00 00       	call   3982 <write>
    258e:	83 c4 10             	add    $0x10,%esp
    2591:	3d 58 02 00 00       	cmp    $0x258,%eax
    2596:	0f 85 f8 00 00 00    	jne    2694 <bigfile+0x174>
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    259c:	83 c3 01             	add    $0x1,%ebx
    259f:	83 fb 14             	cmp    $0x14,%ebx
    25a2:	75 c4                	jne    2568 <bigfile+0x48>
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
      exit();
    }
  }
  close(fd);
    25a4:	83 ec 0c             	sub    $0xc,%esp
    25a7:	56                   	push   %esi
    25a8:	e8 dd 13 00 00       	call   398a <close>

  fd = open("bigfile", 0);
    25ad:	59                   	pop    %ecx
    25ae:	5b                   	pop    %ebx
    25af:	6a 00                	push   $0x0
    25b1:	68 98 48 00 00       	push   $0x4898
    25b6:	e8 e7 13 00 00       	call   39a2 <open>
  if(fd < 0){
    25bb:	83 c4 10             	add    $0x10,%esp
    25be:	85 c0                	test   %eax,%eax
      exit();
    }
  }
  close(fd);

  fd = open("bigfile", 0);
    25c0:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    25c2:	0f 88 e0 00 00 00    	js     26a8 <bigfile+0x188>
    25c8:	31 db                	xor    %ebx,%ebx
    25ca:	31 ff                	xor    %edi,%edi
    25cc:	eb 30                	jmp    25fe <bigfile+0xde>
    25ce:	66 90                	xchg   %ax,%ax
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
    25d0:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    25d5:	0f 85 91 00 00 00    	jne    266c <bigfile+0x14c>
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    25db:	0f be 05 40 86 00 00 	movsbl 0x8640,%eax
    25e2:	89 fa                	mov    %edi,%edx
    25e4:	d1 fa                	sar    %edx
    25e6:	39 d0                	cmp    %edx,%eax
    25e8:	75 6e                	jne    2658 <bigfile+0x138>
    25ea:	0f be 15 6b 87 00 00 	movsbl 0x876b,%edx
    25f1:	39 d0                	cmp    %edx,%eax
    25f3:	75 63                	jne    2658 <bigfile+0x138>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
    25f5:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    exit();
  }
  total = 0;
  for(i = 0; ; i++){
    25fb:	83 c7 01             	add    $0x1,%edi
    cc = read(fd, buf, 300);
    25fe:	83 ec 04             	sub    $0x4,%esp
    2601:	68 2c 01 00 00       	push   $0x12c
    2606:	68 40 86 00 00       	push   $0x8640
    260b:	56                   	push   %esi
    260c:	e8 69 13 00 00       	call   397a <read>
    if(cc < 0){
    2611:	83 c4 10             	add    $0x10,%esp
    2614:	85 c0                	test   %eax,%eax
    2616:	78 68                	js     2680 <bigfile+0x160>
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
    2618:	75 b6                	jne    25d0 <bigfile+0xb0>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
  }
  close(fd);
    261a:	83 ec 0c             	sub    $0xc,%esp
    261d:	56                   	push   %esi
    261e:	e8 67 13 00 00       	call   398a <close>
  if(total != 20*600){
    2623:	83 c4 10             	add    $0x10,%esp
    2626:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    262c:	0f 85 9e 00 00 00    	jne    26d0 <bigfile+0x1b0>
    printf(1, "read bigfile wrong total\n");
    exit();
  }
  unlink("bigfile");
    2632:	83 ec 0c             	sub    $0xc,%esp
    2635:	68 98 48 00 00       	push   $0x4898
    263a:	e8 73 13 00 00       	call   39b2 <unlink>

  printf(1, "bigfile test ok\n");
    263f:	58                   	pop    %eax
    2640:	5a                   	pop    %edx
    2641:	68 27 49 00 00       	push   $0x4927
    2646:	6a 01                	push   $0x1
    2648:	e8 63 14 00 00       	call   3ab0 <printf>
}
    264d:	83 c4 10             	add    $0x10,%esp
    2650:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2653:	5b                   	pop    %ebx
    2654:	5e                   	pop    %esi
    2655:	5f                   	pop    %edi
    2656:	5d                   	pop    %ebp
    2657:	c3                   	ret    
    if(cc != 300){
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
      printf(1, "read bigfile wrong data\n");
    2658:	83 ec 08             	sub    $0x8,%esp
    265b:	68 f4 48 00 00       	push   $0x48f4
    2660:	6a 01                	push   $0x1
    2662:	e8 49 14 00 00       	call   3ab0 <printf>
      exit();
    2667:	e8 f6 12 00 00       	call   3962 <exit>
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
      printf(1, "short read bigfile\n");
    266c:	83 ec 08             	sub    $0x8,%esp
    266f:	68 e0 48 00 00       	push   $0x48e0
    2674:	6a 01                	push   $0x1
    2676:	e8 35 14 00 00       	call   3ab0 <printf>
      exit();
    267b:	e8 e2 12 00 00       	call   3962 <exit>
  }
  total = 0;
  for(i = 0; ; i++){
    cc = read(fd, buf, 300);
    if(cc < 0){
      printf(1, "read bigfile failed\n");
    2680:	83 ec 08             	sub    $0x8,%esp
    2683:	68 cb 48 00 00       	push   $0x48cb
    2688:	6a 01                	push   $0x1
    268a:	e8 21 14 00 00       	call   3ab0 <printf>
      exit();
    268f:	e8 ce 12 00 00       	call   3962 <exit>
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
    2694:	83 ec 08             	sub    $0x8,%esp
    2697:	68 a0 48 00 00       	push   $0x48a0
    269c:	6a 01                	push   $0x1
    269e:	e8 0d 14 00 00       	call   3ab0 <printf>
      exit();
    26a3:	e8 ba 12 00 00       	call   3962 <exit>
  }
  close(fd);

  fd = open("bigfile", 0);
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    26a8:	83 ec 08             	sub    $0x8,%esp
    26ab:	68 b6 48 00 00       	push   $0x48b6
    26b0:	6a 01                	push   $0x1
    26b2:	e8 f9 13 00 00       	call   3ab0 <printf>
    exit();
    26b7:	e8 a6 12 00 00       	call   3962 <exit>
  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    26bc:	83 ec 08             	sub    $0x8,%esp
    26bf:	68 8a 48 00 00       	push   $0x488a
    26c4:	6a 01                	push   $0x1
    26c6:	e8 e5 13 00 00       	call   3ab0 <printf>
    exit();
    26cb:	e8 92 12 00 00       	call   3962 <exit>
    }
    total += cc;
  }
  close(fd);
  if(total != 20*600){
    printf(1, "read bigfile wrong total\n");
    26d0:	83 ec 08             	sub    $0x8,%esp
    26d3:	68 0d 49 00 00       	push   $0x490d
    26d8:	6a 01                	push   $0x1
    26da:	e8 d1 13 00 00       	call   3ab0 <printf>
    exit();
    26df:	e8 7e 12 00 00       	call   3962 <exit>
    26e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    26ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000026f0 <fourteen>:
  printf(1, "bigfile test ok\n");
}

void
fourteen(void)
{
    26f0:	55                   	push   %ebp
    26f1:	89 e5                	mov    %esp,%ebp
    26f3:	83 ec 10             	sub    $0x10,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    26f6:	68 38 49 00 00       	push   $0x4938
    26fb:	6a 01                	push   $0x1
    26fd:	e8 ae 13 00 00       	call   3ab0 <printf>

  if(mkdir("12345678901234") != 0){
    2702:	c7 04 24 73 49 00 00 	movl   $0x4973,(%esp)
    2709:	e8 bc 12 00 00       	call   39ca <mkdir>
    270e:	83 c4 10             	add    $0x10,%esp
    2711:	85 c0                	test   %eax,%eax
    2713:	0f 85 97 00 00 00    	jne    27b0 <fourteen+0xc0>
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    2719:	83 ec 0c             	sub    $0xc,%esp
    271c:	68 30 51 00 00       	push   $0x5130
    2721:	e8 a4 12 00 00       	call   39ca <mkdir>
    2726:	83 c4 10             	add    $0x10,%esp
    2729:	85 c0                	test   %eax,%eax
    272b:	0f 85 de 00 00 00    	jne    280f <fourteen+0x11f>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2731:	83 ec 08             	sub    $0x8,%esp
    2734:	68 00 02 00 00       	push   $0x200
    2739:	68 80 51 00 00       	push   $0x5180
    273e:	e8 5f 12 00 00       	call   39a2 <open>
  if(fd < 0){
    2743:	83 c4 10             	add    $0x10,%esp
    2746:	85 c0                	test   %eax,%eax
    2748:	0f 88 ae 00 00 00    	js     27fc <fourteen+0x10c>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    exit();
  }
  close(fd);
    274e:	83 ec 0c             	sub    $0xc,%esp
    2751:	50                   	push   %eax
    2752:	e8 33 12 00 00       	call   398a <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2757:	58                   	pop    %eax
    2758:	5a                   	pop    %edx
    2759:	6a 00                	push   $0x0
    275b:	68 f0 51 00 00       	push   $0x51f0
    2760:	e8 3d 12 00 00       	call   39a2 <open>
  if(fd < 0){
    2765:	83 c4 10             	add    $0x10,%esp
    2768:	85 c0                	test   %eax,%eax
    276a:	78 7d                	js     27e9 <fourteen+0xf9>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    exit();
  }
  close(fd);
    276c:	83 ec 0c             	sub    $0xc,%esp
    276f:	50                   	push   %eax
    2770:	e8 15 12 00 00       	call   398a <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    2775:	c7 04 24 64 49 00 00 	movl   $0x4964,(%esp)
    277c:	e8 49 12 00 00       	call   39ca <mkdir>
    2781:	83 c4 10             	add    $0x10,%esp
    2784:	85 c0                	test   %eax,%eax
    2786:	74 4e                	je     27d6 <fourteen+0xe6>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    2788:	83 ec 0c             	sub    $0xc,%esp
    278b:	68 8c 52 00 00       	push   $0x528c
    2790:	e8 35 12 00 00       	call   39ca <mkdir>
    2795:	83 c4 10             	add    $0x10,%esp
    2798:	85 c0                	test   %eax,%eax
    279a:	74 27                	je     27c3 <fourteen+0xd3>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    exit();
  }

  printf(1, "fourteen ok\n");
    279c:	83 ec 08             	sub    $0x8,%esp
    279f:	68 82 49 00 00       	push   $0x4982
    27a4:	6a 01                	push   $0x1
    27a6:	e8 05 13 00 00       	call   3ab0 <printf>
}
    27ab:	83 c4 10             	add    $0x10,%esp
    27ae:	c9                   	leave  
    27af:	c3                   	ret    

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");

  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    27b0:	50                   	push   %eax
    27b1:	50                   	push   %eax
    27b2:	68 47 49 00 00       	push   $0x4947
    27b7:	6a 01                	push   $0x1
    27b9:	e8 f2 12 00 00       	call   3ab0 <printf>
    exit();
    27be:	e8 9f 11 00 00       	call   3962 <exit>
  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    27c3:	50                   	push   %eax
    27c4:	50                   	push   %eax
    27c5:	68 ac 52 00 00       	push   $0x52ac
    27ca:	6a 01                	push   $0x1
    27cc:	e8 df 12 00 00       	call   3ab0 <printf>
    exit();
    27d1:	e8 8c 11 00 00       	call   3962 <exit>
    exit();
  }
  close(fd);

  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    27d6:	52                   	push   %edx
    27d7:	52                   	push   %edx
    27d8:	68 5c 52 00 00       	push   $0x525c
    27dd:	6a 01                	push   $0x1
    27df:	e8 cc 12 00 00       	call   3ab0 <printf>
    exit();
    27e4:	e8 79 11 00 00       	call   3962 <exit>
    exit();
  }
  close(fd);
  fd = open("12345678901234/12345678901234/12345678901234", 0);
  if(fd < 0){
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    27e9:	51                   	push   %ecx
    27ea:	51                   	push   %ecx
    27eb:	68 20 52 00 00       	push   $0x5220
    27f0:	6a 01                	push   $0x1
    27f2:	e8 b9 12 00 00       	call   3ab0 <printf>
    exit();
    27f7:	e8 66 11 00 00       	call   3962 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
  if(fd < 0){
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    27fc:	51                   	push   %ecx
    27fd:	51                   	push   %ecx
    27fe:	68 b0 51 00 00       	push   $0x51b0
    2803:	6a 01                	push   $0x1
    2805:	e8 a6 12 00 00       	call   3ab0 <printf>
    exit();
    280a:	e8 53 11 00 00       	call   3962 <exit>
  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    280f:	50                   	push   %eax
    2810:	50                   	push   %eax
    2811:	68 50 51 00 00       	push   $0x5150
    2816:	6a 01                	push   $0x1
    2818:	e8 93 12 00 00       	call   3ab0 <printf>
    exit();
    281d:	e8 40 11 00 00       	call   3962 <exit>
    2822:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002830 <rmdot>:
  printf(1, "fourteen ok\n");
}

void
rmdot(void)
{
    2830:	55                   	push   %ebp
    2831:	89 e5                	mov    %esp,%ebp
    2833:	83 ec 10             	sub    $0x10,%esp
  printf(1, "rmdot test\n");
    2836:	68 8f 49 00 00       	push   $0x498f
    283b:	6a 01                	push   $0x1
    283d:	e8 6e 12 00 00       	call   3ab0 <printf>
  if(mkdir("dots") != 0){
    2842:	c7 04 24 9b 49 00 00 	movl   $0x499b,(%esp)
    2849:	e8 7c 11 00 00       	call   39ca <mkdir>
    284e:	83 c4 10             	add    $0x10,%esp
    2851:	85 c0                	test   %eax,%eax
    2853:	0f 85 b0 00 00 00    	jne    2909 <rmdot+0xd9>
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
    2859:	83 ec 0c             	sub    $0xc,%esp
    285c:	68 9b 49 00 00       	push   $0x499b
    2861:	e8 6c 11 00 00       	call   39d2 <chdir>
    2866:	83 c4 10             	add    $0x10,%esp
    2869:	85 c0                	test   %eax,%eax
    286b:	0f 85 1d 01 00 00    	jne    298e <rmdot+0x15e>
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    2871:	83 ec 0c             	sub    $0xc,%esp
    2874:	68 46 46 00 00       	push   $0x4646
    2879:	e8 34 11 00 00       	call   39b2 <unlink>
    287e:	83 c4 10             	add    $0x10,%esp
    2881:	85 c0                	test   %eax,%eax
    2883:	0f 84 f2 00 00 00    	je     297b <rmdot+0x14b>
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    2889:	83 ec 0c             	sub    $0xc,%esp
    288c:	68 45 46 00 00       	push   $0x4645
    2891:	e8 1c 11 00 00       	call   39b2 <unlink>
    2896:	83 c4 10             	add    $0x10,%esp
    2899:	85 c0                	test   %eax,%eax
    289b:	0f 84 c7 00 00 00    	je     2968 <rmdot+0x138>
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    28a1:	83 ec 0c             	sub    $0xc,%esp
    28a4:	68 19 3e 00 00       	push   $0x3e19
    28a9:	e8 24 11 00 00       	call   39d2 <chdir>
    28ae:	83 c4 10             	add    $0x10,%esp
    28b1:	85 c0                	test   %eax,%eax
    28b3:	0f 85 9c 00 00 00    	jne    2955 <rmdot+0x125>
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
    28b9:	83 ec 0c             	sub    $0xc,%esp
    28bc:	68 e3 49 00 00       	push   $0x49e3
    28c1:	e8 ec 10 00 00       	call   39b2 <unlink>
    28c6:	83 c4 10             	add    $0x10,%esp
    28c9:	85 c0                	test   %eax,%eax
    28cb:	74 75                	je     2942 <rmdot+0x112>
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    28cd:	83 ec 0c             	sub    $0xc,%esp
    28d0:	68 01 4a 00 00       	push   $0x4a01
    28d5:	e8 d8 10 00 00       	call   39b2 <unlink>
    28da:	83 c4 10             	add    $0x10,%esp
    28dd:	85 c0                	test   %eax,%eax
    28df:	74 4e                	je     292f <rmdot+0xff>
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    28e1:	83 ec 0c             	sub    $0xc,%esp
    28e4:	68 9b 49 00 00       	push   $0x499b
    28e9:	e8 c4 10 00 00       	call   39b2 <unlink>
    28ee:	83 c4 10             	add    $0x10,%esp
    28f1:	85 c0                	test   %eax,%eax
    28f3:	75 27                	jne    291c <rmdot+0xec>
    printf(1, "unlink dots failed!\n");
    exit();
  }
  printf(1, "rmdot ok\n");
    28f5:	83 ec 08             	sub    $0x8,%esp
    28f8:	68 36 4a 00 00       	push   $0x4a36
    28fd:	6a 01                	push   $0x1
    28ff:	e8 ac 11 00 00       	call   3ab0 <printf>
}
    2904:	83 c4 10             	add    $0x10,%esp
    2907:	c9                   	leave  
    2908:	c3                   	ret    
void
rmdot(void)
{
  printf(1, "rmdot test\n");
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    2909:	50                   	push   %eax
    290a:	50                   	push   %eax
    290b:	68 a0 49 00 00       	push   $0x49a0
    2910:	6a 01                	push   $0x1
    2912:	e8 99 11 00 00       	call   3ab0 <printf>
    exit();
    2917:	e8 46 10 00 00       	call   3962 <exit>
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    printf(1, "unlink dots failed!\n");
    291c:	50                   	push   %eax
    291d:	50                   	push   %eax
    291e:	68 21 4a 00 00       	push   $0x4a21
    2923:	6a 01                	push   $0x1
    2925:	e8 86 11 00 00       	call   3ab0 <printf>
    exit();
    292a:	e8 33 10 00 00       	call   3962 <exit>
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    292f:	52                   	push   %edx
    2930:	52                   	push   %edx
    2931:	68 09 4a 00 00       	push   $0x4a09
    2936:	6a 01                	push   $0x1
    2938:	e8 73 11 00 00       	call   3ab0 <printf>
    exit();
    293d:	e8 20 10 00 00       	call   3962 <exit>
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    2942:	51                   	push   %ecx
    2943:	51                   	push   %ecx
    2944:	68 ea 49 00 00       	push   $0x49ea
    2949:	6a 01                	push   $0x1
    294b:	e8 60 11 00 00       	call   3ab0 <printf>
    exit();
    2950:	e8 0d 10 00 00       	call   3962 <exit>
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    2955:	50                   	push   %eax
    2956:	50                   	push   %eax
    2957:	68 1b 3e 00 00       	push   $0x3e1b
    295c:	6a 01                	push   $0x1
    295e:	e8 4d 11 00 00       	call   3ab0 <printf>
    exit();
    2963:	e8 fa 0f 00 00       	call   3962 <exit>
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    2968:	50                   	push   %eax
    2969:	50                   	push   %eax
    296a:	68 d4 49 00 00       	push   $0x49d4
    296f:	6a 01                	push   $0x1
    2971:	e8 3a 11 00 00       	call   3ab0 <printf>
    exit();
    2976:	e8 e7 0f 00 00       	call   3962 <exit>
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    297b:	50                   	push   %eax
    297c:	50                   	push   %eax
    297d:	68 c6 49 00 00       	push   $0x49c6
    2982:	6a 01                	push   $0x1
    2984:	e8 27 11 00 00       	call   3ab0 <printf>
    exit();
    2989:	e8 d4 0f 00 00       	call   3962 <exit>
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    298e:	50                   	push   %eax
    298f:	50                   	push   %eax
    2990:	68 b3 49 00 00       	push   $0x49b3
    2995:	6a 01                	push   $0x1
    2997:	e8 14 11 00 00       	call   3ab0 <printf>
    exit();
    299c:	e8 c1 0f 00 00       	call   3962 <exit>
    29a1:	eb 0d                	jmp    29b0 <dirfile>
    29a3:	90                   	nop
    29a4:	90                   	nop
    29a5:	90                   	nop
    29a6:	90                   	nop
    29a7:	90                   	nop
    29a8:	90                   	nop
    29a9:	90                   	nop
    29aa:	90                   	nop
    29ab:	90                   	nop
    29ac:	90                   	nop
    29ad:	90                   	nop
    29ae:	90                   	nop
    29af:	90                   	nop

000029b0 <dirfile>:
  printf(1, "rmdot ok\n");
}

void
dirfile(void)
{
    29b0:	55                   	push   %ebp
    29b1:	89 e5                	mov    %esp,%ebp
    29b3:	53                   	push   %ebx
    29b4:	83 ec 0c             	sub    $0xc,%esp
  int fd;

  printf(1, "dir vs file\n");
    29b7:	68 40 4a 00 00       	push   $0x4a40
    29bc:	6a 01                	push   $0x1
    29be:	e8 ed 10 00 00       	call   3ab0 <printf>

  fd = open("dirfile", O_CREATE);
    29c3:	59                   	pop    %ecx
    29c4:	5b                   	pop    %ebx
    29c5:	68 00 02 00 00       	push   $0x200
    29ca:	68 4d 4a 00 00       	push   $0x4a4d
    29cf:	e8 ce 0f 00 00       	call   39a2 <open>
  if(fd < 0){
    29d4:	83 c4 10             	add    $0x10,%esp
    29d7:	85 c0                	test   %eax,%eax
    29d9:	0f 88 43 01 00 00    	js     2b22 <dirfile+0x172>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
    29df:	83 ec 0c             	sub    $0xc,%esp
    29e2:	50                   	push   %eax
    29e3:	e8 a2 0f 00 00       	call   398a <close>
  if(chdir("dirfile") == 0){
    29e8:	c7 04 24 4d 4a 00 00 	movl   $0x4a4d,(%esp)
    29ef:	e8 de 0f 00 00       	call   39d2 <chdir>
    29f4:	83 c4 10             	add    $0x10,%esp
    29f7:	85 c0                	test   %eax,%eax
    29f9:	0f 84 10 01 00 00    	je     2b0f <dirfile+0x15f>
    printf(1, "chdir dirfile succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", 0);
    29ff:	83 ec 08             	sub    $0x8,%esp
    2a02:	6a 00                	push   $0x0
    2a04:	68 86 4a 00 00       	push   $0x4a86
    2a09:	e8 94 0f 00 00       	call   39a2 <open>
  if(fd >= 0){
    2a0e:	83 c4 10             	add    $0x10,%esp
    2a11:	85 c0                	test   %eax,%eax
    2a13:	0f 89 e3 00 00 00    	jns    2afc <dirfile+0x14c>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", O_CREATE);
    2a19:	83 ec 08             	sub    $0x8,%esp
    2a1c:	68 00 02 00 00       	push   $0x200
    2a21:	68 86 4a 00 00       	push   $0x4a86
    2a26:	e8 77 0f 00 00       	call   39a2 <open>
  if(fd >= 0){
    2a2b:	83 c4 10             	add    $0x10,%esp
    2a2e:	85 c0                	test   %eax,%eax
    2a30:	0f 89 c6 00 00 00    	jns    2afc <dirfile+0x14c>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    2a36:	83 ec 0c             	sub    $0xc,%esp
    2a39:	68 86 4a 00 00       	push   $0x4a86
    2a3e:	e8 87 0f 00 00       	call   39ca <mkdir>
    2a43:	83 c4 10             	add    $0x10,%esp
    2a46:	85 c0                	test   %eax,%eax
    2a48:	0f 84 46 01 00 00    	je     2b94 <dirfile+0x1e4>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
    2a4e:	83 ec 0c             	sub    $0xc,%esp
    2a51:	68 86 4a 00 00       	push   $0x4a86
    2a56:	e8 57 0f 00 00       	call   39b2 <unlink>
    2a5b:	83 c4 10             	add    $0x10,%esp
    2a5e:	85 c0                	test   %eax,%eax
    2a60:	0f 84 1b 01 00 00    	je     2b81 <dirfile+0x1d1>
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
    2a66:	83 ec 08             	sub    $0x8,%esp
    2a69:	68 86 4a 00 00       	push   $0x4a86
    2a6e:	68 ea 4a 00 00       	push   $0x4aea
    2a73:	e8 4a 0f 00 00       	call   39c2 <link>
    2a78:	83 c4 10             	add    $0x10,%esp
    2a7b:	85 c0                	test   %eax,%eax
    2a7d:	0f 84 eb 00 00 00    	je     2b6e <dirfile+0x1be>
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
    2a83:	83 ec 0c             	sub    $0xc,%esp
    2a86:	68 4d 4a 00 00       	push   $0x4a4d
    2a8b:	e8 22 0f 00 00       	call   39b2 <unlink>
    2a90:	83 c4 10             	add    $0x10,%esp
    2a93:	85 c0                	test   %eax,%eax
    2a95:	0f 85 c0 00 00 00    	jne    2b5b <dirfile+0x1ab>
    printf(1, "unlink dirfile failed!\n");
    exit();
  }

  fd = open(".", O_RDWR);
    2a9b:	83 ec 08             	sub    $0x8,%esp
    2a9e:	6a 02                	push   $0x2
    2aa0:	68 46 46 00 00       	push   $0x4646
    2aa5:	e8 f8 0e 00 00       	call   39a2 <open>
  if(fd >= 0){
    2aaa:	83 c4 10             	add    $0x10,%esp
    2aad:	85 c0                	test   %eax,%eax
    2aaf:	0f 89 93 00 00 00    	jns    2b48 <dirfile+0x198>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
    2ab5:	83 ec 08             	sub    $0x8,%esp
    2ab8:	6a 00                	push   $0x0
    2aba:	68 46 46 00 00       	push   $0x4646
    2abf:	e8 de 0e 00 00       	call   39a2 <open>
  if(write(fd, "x", 1) > 0){
    2ac4:	83 c4 0c             	add    $0xc,%esp
  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
    2ac7:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    2ac9:	6a 01                	push   $0x1
    2acb:	68 29 47 00 00       	push   $0x4729
    2ad0:	50                   	push   %eax
    2ad1:	e8 ac 0e 00 00       	call   3982 <write>
    2ad6:	83 c4 10             	add    $0x10,%esp
    2ad9:	85 c0                	test   %eax,%eax
    2adb:	7f 58                	jg     2b35 <dirfile+0x185>
    printf(1, "write . succeeded!\n");
    exit();
  }
  close(fd);
    2add:	83 ec 0c             	sub    $0xc,%esp
    2ae0:	53                   	push   %ebx
    2ae1:	e8 a4 0e 00 00       	call   398a <close>

  printf(1, "dir vs file OK\n");
    2ae6:	58                   	pop    %eax
    2ae7:	5a                   	pop    %edx
    2ae8:	68 1d 4b 00 00       	push   $0x4b1d
    2aed:	6a 01                	push   $0x1
    2aef:	e8 bc 0f 00 00       	call   3ab0 <printf>
}
    2af4:	83 c4 10             	add    $0x10,%esp
    2af7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2afa:	c9                   	leave  
    2afb:	c3                   	ret    
    printf(1, "chdir dirfile succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", 0);
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    2afc:	50                   	push   %eax
    2afd:	50                   	push   %eax
    2afe:	68 91 4a 00 00       	push   $0x4a91
    2b03:	6a 01                	push   $0x1
    2b05:	e8 a6 0f 00 00       	call   3ab0 <printf>
    exit();
    2b0a:	e8 53 0e 00 00       	call   3962 <exit>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
  if(chdir("dirfile") == 0){
    printf(1, "chdir dirfile succeeded!\n");
    2b0f:	50                   	push   %eax
    2b10:	50                   	push   %eax
    2b11:	68 6c 4a 00 00       	push   $0x4a6c
    2b16:	6a 01                	push   $0x1
    2b18:	e8 93 0f 00 00       	call   3ab0 <printf>
    exit();
    2b1d:	e8 40 0e 00 00       	call   3962 <exit>

  printf(1, "dir vs file\n");

  fd = open("dirfile", O_CREATE);
  if(fd < 0){
    printf(1, "create dirfile failed\n");
    2b22:	52                   	push   %edx
    2b23:	52                   	push   %edx
    2b24:	68 55 4a 00 00       	push   $0x4a55
    2b29:	6a 01                	push   $0x1
    2b2b:	e8 80 0f 00 00       	call   3ab0 <printf>
    exit();
    2b30:	e8 2d 0e 00 00       	call   3962 <exit>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
  if(write(fd, "x", 1) > 0){
    printf(1, "write . succeeded!\n");
    2b35:	51                   	push   %ecx
    2b36:	51                   	push   %ecx
    2b37:	68 09 4b 00 00       	push   $0x4b09
    2b3c:	6a 01                	push   $0x1
    2b3e:	e8 6d 0f 00 00       	call   3ab0 <printf>
    exit();
    2b43:	e8 1a 0e 00 00       	call   3962 <exit>
    exit();
  }

  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    2b48:	53                   	push   %ebx
    2b49:	53                   	push   %ebx
    2b4a:	68 00 53 00 00       	push   $0x5300
    2b4f:	6a 01                	push   $0x1
    2b51:	e8 5a 0f 00 00       	call   3ab0 <printf>
    exit();
    2b56:	e8 07 0e 00 00       	call   3962 <exit>
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
    printf(1, "unlink dirfile failed!\n");
    2b5b:	50                   	push   %eax
    2b5c:	50                   	push   %eax
    2b5d:	68 f1 4a 00 00       	push   $0x4af1
    2b62:	6a 01                	push   $0x1
    2b64:	e8 47 0f 00 00       	call   3ab0 <printf>
    exit();
    2b69:	e8 f4 0d 00 00       	call   3962 <exit>
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    2b6e:	50                   	push   %eax
    2b6f:	50                   	push   %eax
    2b70:	68 e0 52 00 00       	push   $0x52e0
    2b75:	6a 01                	push   $0x1
    2b77:	e8 34 0f 00 00       	call   3ab0 <printf>
    exit();
    2b7c:	e8 e1 0d 00 00       	call   3962 <exit>
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    2b81:	50                   	push   %eax
    2b82:	50                   	push   %eax
    2b83:	68 cc 4a 00 00       	push   $0x4acc
    2b88:	6a 01                	push   $0x1
    2b8a:	e8 21 0f 00 00       	call   3ab0 <printf>
    exit();
    2b8f:	e8 ce 0d 00 00       	call   3962 <exit>
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2b94:	50                   	push   %eax
    2b95:	50                   	push   %eax
    2b96:	68 af 4a 00 00       	push   $0x4aaf
    2b9b:	6a 01                	push   $0x1
    2b9d:	e8 0e 0f 00 00       	call   3ab0 <printf>
    exit();
    2ba2:	e8 bb 0d 00 00       	call   3962 <exit>
    2ba7:	89 f6                	mov    %esi,%esi
    2ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002bb0 <iref>:
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2bb0:	55                   	push   %ebp
    2bb1:	89 e5                	mov    %esp,%ebp
    2bb3:	53                   	push   %ebx
  int i, fd;

  printf(1, "empty file name\n");
    2bb4:	bb 33 00 00 00       	mov    $0x33,%ebx
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2bb9:	83 ec 0c             	sub    $0xc,%esp
  int i, fd;

  printf(1, "empty file name\n");
    2bbc:	68 2d 4b 00 00       	push   $0x4b2d
    2bc1:	6a 01                	push   $0x1
    2bc3:	e8 e8 0e 00 00       	call   3ab0 <printf>
    2bc8:	83 c4 10             	add    $0x10,%esp
    2bcb:	90                   	nop
    2bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
    2bd0:	83 ec 0c             	sub    $0xc,%esp
    2bd3:	68 3e 4b 00 00       	push   $0x4b3e
    2bd8:	e8 ed 0d 00 00       	call   39ca <mkdir>
    2bdd:	83 c4 10             	add    $0x10,%esp
    2be0:	85 c0                	test   %eax,%eax
    2be2:	0f 85 bb 00 00 00    	jne    2ca3 <iref+0xf3>
      printf(1, "mkdir irefd failed\n");
      exit();
    }
    if(chdir("irefd") != 0){
    2be8:	83 ec 0c             	sub    $0xc,%esp
    2beb:	68 3e 4b 00 00       	push   $0x4b3e
    2bf0:	e8 dd 0d 00 00       	call   39d2 <chdir>
    2bf5:	83 c4 10             	add    $0x10,%esp
    2bf8:	85 c0                	test   %eax,%eax
    2bfa:	0f 85 b7 00 00 00    	jne    2cb7 <iref+0x107>
      printf(1, "chdir irefd failed\n");
      exit();
    }

    mkdir("");
    2c00:	83 ec 0c             	sub    $0xc,%esp
    2c03:	68 f3 41 00 00       	push   $0x41f3
    2c08:	e8 bd 0d 00 00       	call   39ca <mkdir>
    link("README", "");
    2c0d:	59                   	pop    %ecx
    2c0e:	58                   	pop    %eax
    2c0f:	68 f3 41 00 00       	push   $0x41f3
    2c14:	68 ea 4a 00 00       	push   $0x4aea
    2c19:	e8 a4 0d 00 00       	call   39c2 <link>
    fd = open("", O_CREATE);
    2c1e:	58                   	pop    %eax
    2c1f:	5a                   	pop    %edx
    2c20:	68 00 02 00 00       	push   $0x200
    2c25:	68 f3 41 00 00       	push   $0x41f3
    2c2a:	e8 73 0d 00 00       	call   39a2 <open>
    if(fd >= 0)
    2c2f:	83 c4 10             	add    $0x10,%esp
    2c32:	85 c0                	test   %eax,%eax
    2c34:	78 0c                	js     2c42 <iref+0x92>
      close(fd);
    2c36:	83 ec 0c             	sub    $0xc,%esp
    2c39:	50                   	push   %eax
    2c3a:	e8 4b 0d 00 00       	call   398a <close>
    2c3f:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    2c42:	83 ec 08             	sub    $0x8,%esp
    2c45:	68 00 02 00 00       	push   $0x200
    2c4a:	68 28 47 00 00       	push   $0x4728
    2c4f:	e8 4e 0d 00 00       	call   39a2 <open>
    if(fd >= 0)
    2c54:	83 c4 10             	add    $0x10,%esp
    2c57:	85 c0                	test   %eax,%eax
    2c59:	78 0c                	js     2c67 <iref+0xb7>
      close(fd);
    2c5b:	83 ec 0c             	sub    $0xc,%esp
    2c5e:	50                   	push   %eax
    2c5f:	e8 26 0d 00 00       	call   398a <close>
    2c64:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    2c67:	83 ec 0c             	sub    $0xc,%esp
    2c6a:	68 28 47 00 00       	push   $0x4728
    2c6f:	e8 3e 0d 00 00       	call   39b2 <unlink>
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2c74:	83 c4 10             	add    $0x10,%esp
    2c77:	83 eb 01             	sub    $0x1,%ebx
    2c7a:	0f 85 50 ff ff ff    	jne    2bd0 <iref+0x20>
    if(fd >= 0)
      close(fd);
    unlink("xx");
  }

  chdir("/");
    2c80:	83 ec 0c             	sub    $0xc,%esp
    2c83:	68 19 3e 00 00       	push   $0x3e19
    2c88:	e8 45 0d 00 00       	call   39d2 <chdir>
  printf(1, "empty file name OK\n");
    2c8d:	58                   	pop    %eax
    2c8e:	5a                   	pop    %edx
    2c8f:	68 6c 4b 00 00       	push   $0x4b6c
    2c94:	6a 01                	push   $0x1
    2c96:	e8 15 0e 00 00       	call   3ab0 <printf>
}
    2c9b:	83 c4 10             	add    $0x10,%esp
    2c9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2ca1:	c9                   	leave  
    2ca2:	c3                   	ret    
  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
      printf(1, "mkdir irefd failed\n");
    2ca3:	83 ec 08             	sub    $0x8,%esp
    2ca6:	68 44 4b 00 00       	push   $0x4b44
    2cab:	6a 01                	push   $0x1
    2cad:	e8 fe 0d 00 00       	call   3ab0 <printf>
      exit();
    2cb2:	e8 ab 0c 00 00       	call   3962 <exit>
    }
    if(chdir("irefd") != 0){
      printf(1, "chdir irefd failed\n");
    2cb7:	83 ec 08             	sub    $0x8,%esp
    2cba:	68 58 4b 00 00       	push   $0x4b58
    2cbf:	6a 01                	push   $0x1
    2cc1:	e8 ea 0d 00 00       	call   3ab0 <printf>
      exit();
    2cc6:	e8 97 0c 00 00       	call   3962 <exit>
    2ccb:	90                   	nop
    2ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00002cd0 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    2cd0:	55                   	push   %ebp
    2cd1:	89 e5                	mov    %esp,%ebp
    2cd3:	53                   	push   %ebx
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
    2cd4:	31 db                	xor    %ebx,%ebx
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    2cd6:	83 ec 0c             	sub    $0xc,%esp
  int n, pid;

  printf(1, "fork test\n");
    2cd9:	68 80 4b 00 00       	push   $0x4b80
    2cde:	6a 01                	push   $0x1
    2ce0:	e8 cb 0d 00 00       	call   3ab0 <printf>
    2ce5:	83 c4 10             	add    $0x10,%esp
    2ce8:	eb 13                	jmp    2cfd <forktest+0x2d>
    2cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(n=0; n<1000; n++){
    pid = fork(0);
    if(pid < 0)
      break;
    if(pid == 0)
    2cf0:	74 6a                	je     2d5c <forktest+0x8c>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
    2cf2:	83 c3 01             	add    $0x1,%ebx
    2cf5:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2cfb:	74 4b                	je     2d48 <forktest+0x78>
    pid = fork(0);
    2cfd:	83 ec 0c             	sub    $0xc,%esp
    2d00:	6a 00                	push   $0x0
    2d02:	e8 53 0c 00 00       	call   395a <fork>
    if(pid < 0)
    2d07:	83 c4 10             	add    $0x10,%esp
    2d0a:	85 c0                	test   %eax,%eax
    2d0c:	79 e2                	jns    2cf0 <forktest+0x20>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }

  for(; n > 0; n--){
    2d0e:	85 db                	test   %ebx,%ebx
    2d10:	74 14                	je     2d26 <forktest+0x56>
    2d12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(wait() < 0){
    2d18:	e8 4d 0c 00 00       	call   396a <wait>
    2d1d:	85 c0                	test   %eax,%eax
    2d1f:	78 40                	js     2d61 <forktest+0x91>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }

  for(; n > 0; n--){
    2d21:	83 eb 01             	sub    $0x1,%ebx
    2d24:	75 f2                	jne    2d18 <forktest+0x48>
      printf(1, "wait stopped early\n");
      exit();
    }
  }

  if(wait() != -1){
    2d26:	e8 3f 0c 00 00       	call   396a <wait>
    2d2b:	83 f8 ff             	cmp    $0xffffffff,%eax
    2d2e:	75 45                	jne    2d75 <forktest+0xa5>
    printf(1, "wait got too many\n");
    exit();
  }

  printf(1, "fork test OK\n");
    2d30:	83 ec 08             	sub    $0x8,%esp
    2d33:	68 b2 4b 00 00       	push   $0x4bb2
    2d38:	6a 01                	push   $0x1
    2d3a:	e8 71 0d 00 00       	call   3ab0 <printf>
}
    2d3f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2d42:	c9                   	leave  
    2d43:	c3                   	ret    
    2d44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid == 0)
      exit();
  }

  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    2d48:	83 ec 08             	sub    $0x8,%esp
    2d4b:	68 20 53 00 00       	push   $0x5320
    2d50:	6a 01                	push   $0x1
    2d52:	e8 59 0d 00 00       	call   3ab0 <printf>
    exit();
    2d57:	e8 06 0c 00 00       	call   3962 <exit>
  for(n=0; n<1000; n++){
    pid = fork(0);
    if(pid < 0)
      break;
    if(pid == 0)
      exit();
    2d5c:	e8 01 0c 00 00       	call   3962 <exit>
    exit();
  }

  for(; n > 0; n--){
    if(wait() < 0){
      printf(1, "wait stopped early\n");
    2d61:	83 ec 08             	sub    $0x8,%esp
    2d64:	68 8b 4b 00 00       	push   $0x4b8b
    2d69:	6a 01                	push   $0x1
    2d6b:	e8 40 0d 00 00       	call   3ab0 <printf>
      exit();
    2d70:	e8 ed 0b 00 00       	call   3962 <exit>
    }
  }

  if(wait() != -1){
    printf(1, "wait got too many\n");
    2d75:	83 ec 08             	sub    $0x8,%esp
    2d78:	68 9f 4b 00 00       	push   $0x4b9f
    2d7d:	6a 01                	push   $0x1
    2d7f:	e8 2c 0d 00 00       	call   3ab0 <printf>
    exit();
    2d84:	e8 d9 0b 00 00       	call   3962 <exit>
    2d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00002d90 <sbrktest>:
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
    2d90:	55                   	push   %ebp
    2d91:	89 e5                	mov    %esp,%ebp
    2d93:	57                   	push   %edi
    2d94:	56                   	push   %esi
    2d95:	53                   	push   %ebx
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    2d96:	31 ff                	xor    %edi,%edi
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
    2d98:	83 ec 64             	sub    $0x64,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    2d9b:	68 c0 4b 00 00       	push   $0x4bc0
    2da0:	ff 35 64 5e 00 00    	pushl  0x5e64
    2da6:	e8 05 0d 00 00       	call   3ab0 <printf>
  oldbrk = sbrk(0);
    2dab:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2db2:	e8 33 0c 00 00       	call   39ea <sbrk>

  // can one sbrk() less than a page?
  a = sbrk(0);
    2db7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
  oldbrk = sbrk(0);
    2dbe:	89 45 a4             	mov    %eax,-0x5c(%ebp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    2dc1:	e8 24 0c 00 00       	call   39ea <sbrk>
    2dc6:	83 c4 10             	add    $0x10,%esp
    2dc9:	89 c3                	mov    %eax,%ebx
    2dcb:	90                   	nop
    2dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int i;
  for(i = 0; i < 5000; i++){
    b = sbrk(1);
    2dd0:	83 ec 0c             	sub    $0xc,%esp
    2dd3:	6a 01                	push   $0x1
    2dd5:	e8 10 0c 00 00       	call   39ea <sbrk>
    if(b != a){
    2dda:	83 c4 10             	add    $0x10,%esp
    2ddd:	39 d8                	cmp    %ebx,%eax
    2ddf:	0f 85 9d 02 00 00    	jne    3082 <sbrktest+0x2f2>
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    2de5:	83 c7 01             	add    $0x1,%edi
    b = sbrk(1);
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
      exit();
    }
    *b = 1;
    2de8:	c6 03 01             	movb   $0x1,(%ebx)
    a = b + 1;
    2deb:	83 c3 01             	add    $0x1,%ebx
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    2dee:	81 ff 88 13 00 00    	cmp    $0x1388,%edi
    2df4:	75 da                	jne    2dd0 <sbrktest+0x40>
      exit();
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork(0);
    2df6:	83 ec 0c             	sub    $0xc,%esp
    2df9:	6a 00                	push   $0x0
    2dfb:	e8 5a 0b 00 00       	call   395a <fork>
  if(pid < 0){
    2e00:	83 c4 10             	add    $0x10,%esp
    2e03:	85 c0                	test   %eax,%eax
      exit();
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork(0);
    2e05:	89 c7                	mov    %eax,%edi
  if(pid < 0){
    2e07:	0f 88 a3 03 00 00    	js     31b0 <sbrktest+0x420>
    printf(stdout, "sbrk test fork failed\n");
    exit();
  }
  c = sbrk(1);
    2e0d:	83 ec 0c             	sub    $0xc,%esp
  c = sbrk(1);
  if(c != a + 1){
    2e10:	83 c3 01             	add    $0x1,%ebx
  pid = fork(0);
  if(pid < 0){
    printf(stdout, "sbrk test fork failed\n");
    exit();
  }
  c = sbrk(1);
    2e13:	6a 01                	push   $0x1
    2e15:	e8 d0 0b 00 00       	call   39ea <sbrk>
  c = sbrk(1);
    2e1a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e21:	e8 c4 0b 00 00       	call   39ea <sbrk>
  if(c != a + 1){
    2e26:	83 c4 10             	add    $0x10,%esp
    2e29:	39 d8                	cmp    %ebx,%eax
    2e2b:	0f 85 67 03 00 00    	jne    3198 <sbrktest+0x408>
    printf(stdout, "sbrk test failed post-fork\n");
    exit();
  }
  if(pid == 0)
    2e31:	85 ff                	test   %edi,%edi
    2e33:	0f 84 5a 03 00 00    	je     3193 <sbrktest+0x403>
    exit();
  wait();
    2e39:	e8 2c 0b 00 00       	call   396a <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    2e3e:	83 ec 0c             	sub    $0xc,%esp
    2e41:	6a 00                	push   $0x0
    2e43:	e8 a2 0b 00 00       	call   39ea <sbrk>
    2e48:	89 c3                	mov    %eax,%ebx
  amt = (BIG) - (uint)a;
  p = sbrk(amt);
    2e4a:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2e4f:	29 d8                	sub    %ebx,%eax
    2e51:	89 04 24             	mov    %eax,(%esp)
    2e54:	e8 91 0b 00 00       	call   39ea <sbrk>
  if (p != a) {
    2e59:	83 c4 10             	add    $0x10,%esp
    2e5c:	39 c3                	cmp    %eax,%ebx
    2e5e:	0f 85 17 03 00 00    	jne    317b <sbrktest+0x3eb>
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;

  // can one de-allocate?
  a = sbrk(0);
    2e64:	83 ec 0c             	sub    $0xc,%esp
  if (p != a) {
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    exit();
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;
    2e67:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff

  // can one de-allocate?
  a = sbrk(0);
    2e6e:	6a 00                	push   $0x0
    2e70:	e8 75 0b 00 00       	call   39ea <sbrk>
  c = sbrk(-4096);
    2e75:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;

  // can one de-allocate?
  a = sbrk(0);
    2e7c:	89 c3                	mov    %eax,%ebx
  c = sbrk(-4096);
    2e7e:	e8 67 0b 00 00       	call   39ea <sbrk>
  if(c == (char*)0xffffffff){
    2e83:	83 c4 10             	add    $0x10,%esp
    2e86:	83 f8 ff             	cmp    $0xffffffff,%eax
    2e89:	0f 84 d4 02 00 00    	je     3163 <sbrktest+0x3d3>
    printf(stdout, "sbrk could not deallocate\n");
    exit();
  }
  c = sbrk(0);
    2e8f:	83 ec 0c             	sub    $0xc,%esp
    2e92:	6a 00                	push   $0x0
    2e94:	e8 51 0b 00 00       	call   39ea <sbrk>
  if(c != a - 4096){
    2e99:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
    2e9f:	83 c4 10             	add    $0x10,%esp
    2ea2:	39 d0                	cmp    %edx,%eax
    2ea4:	0f 85 a2 02 00 00    	jne    314c <sbrktest+0x3bc>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
    2eaa:	83 ec 0c             	sub    $0xc,%esp
    2ead:	6a 00                	push   $0x0
    2eaf:	e8 36 0b 00 00       	call   39ea <sbrk>
    2eb4:	89 c3                	mov    %eax,%ebx
  c = sbrk(4096);
    2eb6:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    2ebd:	e8 28 0b 00 00       	call   39ea <sbrk>
  if(c != a || sbrk(0) != a + 4096){
    2ec2:	83 c4 10             	add    $0x10,%esp
    2ec5:	39 c3                	cmp    %eax,%ebx
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
    2ec7:	89 c7                	mov    %eax,%edi
  if(c != a || sbrk(0) != a + 4096){
    2ec9:	0f 85 66 02 00 00    	jne    3135 <sbrktest+0x3a5>
    2ecf:	83 ec 0c             	sub    $0xc,%esp
    2ed2:	6a 00                	push   $0x0
    2ed4:	e8 11 0b 00 00       	call   39ea <sbrk>
    2ed9:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    2edf:	83 c4 10             	add    $0x10,%esp
    2ee2:	39 d0                	cmp    %edx,%eax
    2ee4:	0f 85 4b 02 00 00    	jne    3135 <sbrktest+0x3a5>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit();
  }
  if(*lastaddr == 99){
    2eea:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    2ef1:	0f 84 26 02 00 00    	je     311d <sbrktest+0x38d>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit();
  }

  a = sbrk(0);
    2ef7:	83 ec 0c             	sub    $0xc,%esp
    2efa:	6a 00                	push   $0x0
    2efc:	e8 e9 0a 00 00       	call   39ea <sbrk>
  c = sbrk(-(sbrk(0) - oldbrk));
    2f01:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit();
  }

  a = sbrk(0);
    2f08:	89 c3                	mov    %eax,%ebx
  c = sbrk(-(sbrk(0) - oldbrk));
    2f0a:	e8 db 0a 00 00       	call   39ea <sbrk>
    2f0f:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
    2f12:	29 c1                	sub    %eax,%ecx
    2f14:	89 0c 24             	mov    %ecx,(%esp)
    2f17:	e8 ce 0a 00 00       	call   39ea <sbrk>
  if(c != a){
    2f1c:	83 c4 10             	add    $0x10,%esp
    2f1f:	39 c3                	cmp    %eax,%ebx
    2f21:	0f 85 df 01 00 00    	jne    3106 <sbrktest+0x376>
    2f27:	bb 00 00 00 80       	mov    $0x80000000,%ebx
    2f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    ppid = getpid();
    2f30:	e8 ad 0a 00 00       	call   39e2 <getpid>
    pid = fork(0);
    2f35:	83 ec 0c             	sub    $0xc,%esp
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    ppid = getpid();
    2f38:	89 c7                	mov    %eax,%edi
    pid = fork(0);
    2f3a:	6a 00                	push   $0x0
    2f3c:	e8 19 0a 00 00       	call   395a <fork>
    if(pid < 0){
    2f41:	83 c4 10             	add    $0x10,%esp
    2f44:	85 c0                	test   %eax,%eax
    2f46:	0f 88 a2 01 00 00    	js     30ee <sbrktest+0x35e>
      printf(stdout, "fork failed\n");
      exit();
    }
    if(pid == 0){
    2f4c:	0f 84 7a 01 00 00    	je     30cc <sbrktest+0x33c>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2f52:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
      kill(ppid);
      exit();
    }
    wait();
    2f58:	e8 0d 0a 00 00       	call   396a <wait>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2f5d:	81 fb 80 84 1e 80    	cmp    $0x801e8480,%ebx
    2f63:	75 cb                	jne    2f30 <sbrktest+0x1a0>
    wait();
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    2f65:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2f68:	83 ec 0c             	sub    $0xc,%esp
    2f6b:	50                   	push   %eax
    2f6c:	e8 01 0a 00 00       	call   3972 <pipe>
    2f71:	83 c4 10             	add    $0x10,%esp
    2f74:	85 c0                	test   %eax,%eax
    2f76:	0f 85 3c 01 00 00    	jne    30b8 <sbrktest+0x328>
    2f7c:	8d 5d c0             	lea    -0x40(%ebp),%ebx
    2f7f:	8d 7d e8             	lea    -0x18(%ebp),%edi
    2f82:	89 de                	mov    %ebx,%esi
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork(0)) == 0){
    2f84:	83 ec 0c             	sub    $0xc,%esp
    2f87:	6a 00                	push   $0x0
    2f89:	e8 cc 09 00 00       	call   395a <fork>
    2f8e:	83 c4 10             	add    $0x10,%esp
    2f91:	85 c0                	test   %eax,%eax
    2f93:	89 06                	mov    %eax,(%esi)
    2f95:	0f 84 a1 00 00 00    	je     303c <sbrktest+0x2ac>
      sbrk(BIG - (uint)sbrk(0));
      write(fds[1], "x", 1);
      // sit around until killed
      for(;;) sleep(1000);
    }
    if(pids[i] != -1)
    2f9b:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f9e:	74 14                	je     2fb4 <sbrktest+0x224>
      read(fds[0], &scratch, 1);
    2fa0:	8d 45 b7             	lea    -0x49(%ebp),%eax
    2fa3:	83 ec 04             	sub    $0x4,%esp
    2fa6:	6a 01                	push   $0x1
    2fa8:	50                   	push   %eax
    2fa9:	ff 75 b8             	pushl  -0x48(%ebp)
    2fac:	e8 c9 09 00 00       	call   397a <read>
    2fb1:	83 c4 10             	add    $0x10,%esp
    2fb4:	83 c6 04             	add    $0x4,%esi
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2fb7:	39 f7                	cmp    %esi,%edi
    2fb9:	75 c9                	jne    2f84 <sbrktest+0x1f4>
    if(pids[i] != -1)
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    2fbb:	83 ec 0c             	sub    $0xc,%esp
    2fbe:	68 00 10 00 00       	push   $0x1000
    2fc3:	e8 22 0a 00 00       	call   39ea <sbrk>
    2fc8:	83 c4 10             	add    $0x10,%esp
    2fcb:	89 c6                	mov    %eax,%esi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if(pids[i] == -1)
    2fcd:	8b 03                	mov    (%ebx),%eax
    2fcf:	83 f8 ff             	cmp    $0xffffffff,%eax
    2fd2:	74 11                	je     2fe5 <sbrktest+0x255>
      continue;
    kill(pids[i]);
    2fd4:	83 ec 0c             	sub    $0xc,%esp
    2fd7:	50                   	push   %eax
    2fd8:	e8 b5 09 00 00       	call   3992 <kill>
    wait();
    2fdd:	e8 88 09 00 00       	call   396a <wait>
    2fe2:	83 c4 10             	add    $0x10,%esp
    2fe5:	83 c3 04             	add    $0x4,%ebx
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2fe8:	39 fb                	cmp    %edi,%ebx
    2fea:	75 e1                	jne    2fcd <sbrktest+0x23d>
    if(pids[i] == -1)
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff){
    2fec:	83 fe ff             	cmp    $0xffffffff,%esi
    2fef:	0f 84 ab 00 00 00    	je     30a0 <sbrktest+0x310>
    printf(stdout, "failed sbrk leaked memory\n");
    exit();
  }

  if(sbrk(0) > oldbrk)
    2ff5:	83 ec 0c             	sub    $0xc,%esp
    2ff8:	6a 00                	push   $0x0
    2ffa:	e8 eb 09 00 00       	call   39ea <sbrk>
    2fff:	83 c4 10             	add    $0x10,%esp
    3002:	39 45 a4             	cmp    %eax,-0x5c(%ebp)
    3005:	73 1a                	jae    3021 <sbrktest+0x291>
    sbrk(-(sbrk(0) - oldbrk));
    3007:	83 ec 0c             	sub    $0xc,%esp
    300a:	6a 00                	push   $0x0
    300c:	e8 d9 09 00 00       	call   39ea <sbrk>
    3011:	8b 75 a4             	mov    -0x5c(%ebp),%esi
    3014:	29 c6                	sub    %eax,%esi
    3016:	89 34 24             	mov    %esi,(%esp)
    3019:	e8 cc 09 00 00       	call   39ea <sbrk>
    301e:	83 c4 10             	add    $0x10,%esp

  printf(stdout, "sbrk test OK\n");
    3021:	83 ec 08             	sub    $0x8,%esp
    3024:	68 68 4c 00 00       	push   $0x4c68
    3029:	ff 35 64 5e 00 00    	pushl  0x5e64
    302f:	e8 7c 0a 00 00       	call   3ab0 <printf>
}
    3034:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3037:	5b                   	pop    %ebx
    3038:	5e                   	pop    %esi
    3039:	5f                   	pop    %edi
    303a:	5d                   	pop    %ebp
    303b:	c3                   	ret    
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork(0)) == 0){
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    303c:	83 ec 0c             	sub    $0xc,%esp
    303f:	6a 00                	push   $0x0
    3041:	e8 a4 09 00 00       	call   39ea <sbrk>
    3046:	ba 00 00 40 06       	mov    $0x6400000,%edx
    304b:	29 c2                	sub    %eax,%edx
    304d:	89 14 24             	mov    %edx,(%esp)
    3050:	e8 95 09 00 00       	call   39ea <sbrk>
      write(fds[1], "x", 1);
    3055:	83 c4 0c             	add    $0xc,%esp
    3058:	6a 01                	push   $0x1
    305a:	68 29 47 00 00       	push   $0x4729
    305f:	ff 75 bc             	pushl  -0x44(%ebp)
    3062:	e8 1b 09 00 00       	call   3982 <write>
    3067:	83 c4 10             	add    $0x10,%esp
    306a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      // sit around until killed
      for(;;) sleep(1000);
    3070:	83 ec 0c             	sub    $0xc,%esp
    3073:	68 e8 03 00 00       	push   $0x3e8
    3078:	e8 75 09 00 00       	call   39f2 <sleep>
    307d:	83 c4 10             	add    $0x10,%esp
    3080:	eb ee                	jmp    3070 <sbrktest+0x2e0>
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    b = sbrk(1);
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    3082:	83 ec 0c             	sub    $0xc,%esp
    3085:	50                   	push   %eax
    3086:	53                   	push   %ebx
    3087:	57                   	push   %edi
    3088:	68 cb 4b 00 00       	push   $0x4bcb
    308d:	ff 35 64 5e 00 00    	pushl  0x5e64
    3093:	e8 18 0a 00 00       	call   3ab0 <printf>
      exit();
    3098:	83 c4 20             	add    $0x20,%esp
    309b:	e8 c2 08 00 00       	call   3962 <exit>
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff){
    printf(stdout, "failed sbrk leaked memory\n");
    30a0:	83 ec 08             	sub    $0x8,%esp
    30a3:	68 4d 4c 00 00       	push   $0x4c4d
    30a8:	ff 35 64 5e 00 00    	pushl  0x5e64
    30ae:	e8 fd 09 00 00       	call   3ab0 <printf>
    exit();
    30b3:	e8 aa 08 00 00       	call   3962 <exit>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    30b8:	83 ec 08             	sub    $0x8,%esp
    30bb:	68 09 41 00 00       	push   $0x4109
    30c0:	6a 01                	push   $0x1
    30c2:	e8 e9 09 00 00       	call   3ab0 <printf>
    exit();
    30c7:	e8 96 08 00 00       	call   3962 <exit>
    if(pid < 0){
      printf(stdout, "fork failed\n");
      exit();
    }
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
    30cc:	0f be 03             	movsbl (%ebx),%eax
    30cf:	50                   	push   %eax
    30d0:	53                   	push   %ebx
    30d1:	68 34 4c 00 00       	push   $0x4c34
    30d6:	ff 35 64 5e 00 00    	pushl  0x5e64
    30dc:	e8 cf 09 00 00       	call   3ab0 <printf>
      kill(ppid);
    30e1:	89 3c 24             	mov    %edi,(%esp)
    30e4:	e8 a9 08 00 00       	call   3992 <kill>
      exit();
    30e9:	e8 74 08 00 00       	call   3962 <exit>
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    ppid = getpid();
    pid = fork(0);
    if(pid < 0){
      printf(stdout, "fork failed\n");
    30ee:	83 ec 08             	sub    $0x8,%esp
    30f1:	68 11 4d 00 00       	push   $0x4d11
    30f6:	ff 35 64 5e 00 00    	pushl  0x5e64
    30fc:	e8 af 09 00 00       	call   3ab0 <printf>
      exit();
    3101:	e8 5c 08 00 00       	call   3962 <exit>
  }

  a = sbrk(0);
  c = sbrk(-(sbrk(0) - oldbrk));
  if(c != a){
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    3106:	50                   	push   %eax
    3107:	53                   	push   %ebx
    3108:	68 14 54 00 00       	push   $0x5414
    310d:	ff 35 64 5e 00 00    	pushl  0x5e64
    3113:	e8 98 09 00 00       	call   3ab0 <printf>
    exit();
    3118:	e8 45 08 00 00       	call   3962 <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit();
  }
  if(*lastaddr == 99){
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    311d:	83 ec 08             	sub    $0x8,%esp
    3120:	68 e4 53 00 00       	push   $0x53e4
    3125:	ff 35 64 5e 00 00    	pushl  0x5e64
    312b:	e8 80 09 00 00       	call   3ab0 <printf>
    exit();
    3130:	e8 2d 08 00 00       	call   3962 <exit>

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
  if(c != a || sbrk(0) != a + 4096){
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    3135:	57                   	push   %edi
    3136:	53                   	push   %ebx
    3137:	68 bc 53 00 00       	push   $0x53bc
    313c:	ff 35 64 5e 00 00    	pushl  0x5e64
    3142:	e8 69 09 00 00       	call   3ab0 <printf>
    exit();
    3147:	e8 16 08 00 00       	call   3962 <exit>
    printf(stdout, "sbrk could not deallocate\n");
    exit();
  }
  c = sbrk(0);
  if(c != a - 4096){
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    314c:	50                   	push   %eax
    314d:	53                   	push   %ebx
    314e:	68 84 53 00 00       	push   $0x5384
    3153:	ff 35 64 5e 00 00    	pushl  0x5e64
    3159:	e8 52 09 00 00       	call   3ab0 <printf>
    exit();
    315e:	e8 ff 07 00 00       	call   3962 <exit>

  // can one de-allocate?
  a = sbrk(0);
  c = sbrk(-4096);
  if(c == (char*)0xffffffff){
    printf(stdout, "sbrk could not deallocate\n");
    3163:	83 ec 08             	sub    $0x8,%esp
    3166:	68 19 4c 00 00       	push   $0x4c19
    316b:	ff 35 64 5e 00 00    	pushl  0x5e64
    3171:	e8 3a 09 00 00       	call   3ab0 <printf>
    exit();
    3176:	e8 e7 07 00 00       	call   3962 <exit>
#define BIG (100*1024*1024)
  a = sbrk(0);
  amt = (BIG) - (uint)a;
  p = sbrk(amt);
  if (p != a) {
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    317b:	83 ec 08             	sub    $0x8,%esp
    317e:	68 44 53 00 00       	push   $0x5344
    3183:	ff 35 64 5e 00 00    	pushl  0x5e64
    3189:	e8 22 09 00 00       	call   3ab0 <printf>
    exit();
    318e:	e8 cf 07 00 00       	call   3962 <exit>
  if(c != a + 1){
    printf(stdout, "sbrk test failed post-fork\n");
    exit();
  }
  if(pid == 0)
    exit();
    3193:	e8 ca 07 00 00       	call   3962 <exit>
    exit();
  }
  c = sbrk(1);
  c = sbrk(1);
  if(c != a + 1){
    printf(stdout, "sbrk test failed post-fork\n");
    3198:	83 ec 08             	sub    $0x8,%esp
    319b:	68 fd 4b 00 00       	push   $0x4bfd
    31a0:	ff 35 64 5e 00 00    	pushl  0x5e64
    31a6:	e8 05 09 00 00       	call   3ab0 <printf>
    exit();
    31ab:	e8 b2 07 00 00       	call   3962 <exit>
    *b = 1;
    a = b + 1;
  }
  pid = fork(0);
  if(pid < 0){
    printf(stdout, "sbrk test fork failed\n");
    31b0:	83 ec 08             	sub    $0x8,%esp
    31b3:	68 e6 4b 00 00       	push   $0x4be6
    31b8:	ff 35 64 5e 00 00    	pushl  0x5e64
    31be:	e8 ed 08 00 00       	call   3ab0 <printf>
    exit();
    31c3:	e8 9a 07 00 00       	call   3962 <exit>
    31c8:	90                   	nop
    31c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000031d0 <validateint>:
  printf(stdout, "sbrk test OK\n");
}

void
validateint(int *p)
{
    31d0:	55                   	push   %ebp
    31d1:	89 e5                	mov    %esp,%ebp
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    31d3:	5d                   	pop    %ebp
    31d4:	c3                   	ret    
    31d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    31d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000031e0 <validatetest>:

void
validatetest(void)
{
    31e0:	55                   	push   %ebp
    31e1:	89 e5                	mov    %esp,%ebp
    31e3:	56                   	push   %esi
    31e4:	53                   	push   %ebx
  uint p;

  printf(stdout, "validate test\n");
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    31e5:	31 db                	xor    %ebx,%ebx
validatetest(void)
{
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    31e7:	83 ec 08             	sub    $0x8,%esp
    31ea:	68 76 4c 00 00       	push   $0x4c76
    31ef:	ff 35 64 5e 00 00    	pushl  0x5e64
    31f5:	e8 b6 08 00 00       	call   3ab0 <printf>
    31fa:	83 c4 10             	add    $0x10,%esp
    31fd:	8d 76 00             	lea    0x0(%esi),%esi
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    if((pid = fork(0)) == 0){
    3200:	83 ec 0c             	sub    $0xc,%esp
    3203:	6a 00                	push   $0x0
    3205:	e8 50 07 00 00       	call   395a <fork>
    320a:	83 c4 10             	add    $0x10,%esp
    320d:	85 c0                	test   %eax,%eax
    320f:	89 c6                	mov    %eax,%esi
    3211:	74 63                	je     3276 <validatetest+0x96>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit();
    }
    sleep(0);
    3213:	83 ec 0c             	sub    $0xc,%esp
    3216:	6a 00                	push   $0x0
    3218:	e8 d5 07 00 00       	call   39f2 <sleep>
    sleep(0);
    321d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3224:	e8 c9 07 00 00       	call   39f2 <sleep>
    kill(pid);
    3229:	89 34 24             	mov    %esi,(%esp)
    322c:	e8 61 07 00 00       	call   3992 <kill>
    wait();
    3231:	e8 34 07 00 00       	call   396a <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    3236:	58                   	pop    %eax
    3237:	5a                   	pop    %edx
    3238:	53                   	push   %ebx
    3239:	68 85 4c 00 00       	push   $0x4c85
    323e:	e8 7f 07 00 00       	call   39c2 <link>
    3243:	83 c4 10             	add    $0x10,%esp
    3246:	83 f8 ff             	cmp    $0xffffffff,%eax
    3249:	75 30                	jne    327b <validatetest+0x9b>
  uint p;

  printf(stdout, "validate test\n");
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    324b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    3251:	81 fb 00 40 11 00    	cmp    $0x114000,%ebx
    3257:	75 a7                	jne    3200 <validatetest+0x20>
      printf(stdout, "link should not succeed\n");
      exit();
    }
  }

  printf(stdout, "validate ok\n");
    3259:	83 ec 08             	sub    $0x8,%esp
    325c:	68 a9 4c 00 00       	push   $0x4ca9
    3261:	ff 35 64 5e 00 00    	pushl  0x5e64
    3267:	e8 44 08 00 00       	call   3ab0 <printf>
}
    326c:	83 c4 10             	add    $0x10,%esp
    326f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3272:	5b                   	pop    %ebx
    3273:	5e                   	pop    %esi
    3274:	5d                   	pop    %ebp
    3275:	c3                   	ret    

  for(p = 0; p <= (uint)hi; p += 4096){
    if((pid = fork(0)) == 0){
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit();
    3276:	e8 e7 06 00 00       	call   3962 <exit>
    kill(pid);
    wait();

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
      printf(stdout, "link should not succeed\n");
    327b:	83 ec 08             	sub    $0x8,%esp
    327e:	68 90 4c 00 00       	push   $0x4c90
    3283:	ff 35 64 5e 00 00    	pushl  0x5e64
    3289:	e8 22 08 00 00       	call   3ab0 <printf>
      exit();
    328e:	e8 cf 06 00 00       	call   3962 <exit>
    3293:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000032a0 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    32a0:	55                   	push   %ebp
    32a1:	89 e5                	mov    %esp,%ebp
    32a3:	83 ec 10             	sub    $0x10,%esp
  int i;

  printf(stdout, "bss test\n");
    32a6:	68 b6 4c 00 00       	push   $0x4cb6
    32ab:	ff 35 64 5e 00 00    	pushl  0x5e64
    32b1:	e8 fa 07 00 00       	call   3ab0 <printf>
  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
    32b6:	83 c4 10             	add    $0x10,%esp
    32b9:	80 3d 20 5f 00 00 00 	cmpb   $0x0,0x5f20
    32c0:	75 35                	jne    32f7 <bsstest+0x57>
    32c2:	b8 21 5f 00 00       	mov    $0x5f21,%eax
    32c7:	89 f6                	mov    %esi,%esi
    32c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    32d0:	80 38 00             	cmpb   $0x0,(%eax)
    32d3:	75 22                	jne    32f7 <bsstest+0x57>
    32d5:	83 c0 01             	add    $0x1,%eax
bsstest(void)
{
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    32d8:	3d 30 86 00 00       	cmp    $0x8630,%eax
    32dd:	75 f1                	jne    32d0 <bsstest+0x30>
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
      exit();
    }
  }
  printf(stdout, "bss test ok\n");
    32df:	83 ec 08             	sub    $0x8,%esp
    32e2:	68 d1 4c 00 00       	push   $0x4cd1
    32e7:	ff 35 64 5e 00 00    	pushl  0x5e64
    32ed:	e8 be 07 00 00       	call   3ab0 <printf>
}
    32f2:	83 c4 10             	add    $0x10,%esp
    32f5:	c9                   	leave  
    32f6:	c3                   	ret    
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
    32f7:	83 ec 08             	sub    $0x8,%esp
    32fa:	68 c0 4c 00 00       	push   $0x4cc0
    32ff:	ff 35 64 5e 00 00    	pushl  0x5e64
    3305:	e8 a6 07 00 00       	call   3ab0 <printf>
      exit();
    330a:	e8 53 06 00 00       	call   3962 <exit>
    330f:	90                   	nop

00003310 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    3310:	55                   	push   %ebp
    3311:	89 e5                	mov    %esp,%ebp
    3313:	83 ec 14             	sub    $0x14,%esp
  int pid, fd;

  unlink("bigarg-ok");
    3316:	68 de 4c 00 00       	push   $0x4cde
    331b:	e8 92 06 00 00       	call   39b2 <unlink>
  pid = fork(0);
    3320:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3327:	e8 2e 06 00 00       	call   395a <fork>
  if(pid == 0){
    332c:	83 c4 10             	add    $0x10,%esp
    332f:	85 c0                	test   %eax,%eax
    3331:	74 3f                	je     3372 <bigargtest+0x62>
    exec("echo", args);
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit();
  } else if(pid < 0){
    3333:	0f 88 cb 00 00 00    	js     3404 <bigargtest+0xf4>
    printf(stdout, "bigargtest: fork failed\n");
    exit();
  }
  wait();
    3339:	e8 2c 06 00 00       	call   396a <wait>
  fd = open("bigarg-ok", 0);
    333e:	83 ec 08             	sub    $0x8,%esp
    3341:	6a 00                	push   $0x0
    3343:	68 de 4c 00 00       	push   $0x4cde
    3348:	e8 55 06 00 00       	call   39a2 <open>
  if(fd < 0){
    334d:	83 c4 10             	add    $0x10,%esp
    3350:	85 c0                	test   %eax,%eax
    3352:	0f 88 95 00 00 00    	js     33ed <bigargtest+0xdd>
    printf(stdout, "bigarg test failed!\n");
    exit();
  }
  close(fd);
    3358:	83 ec 0c             	sub    $0xc,%esp
    335b:	50                   	push   %eax
    335c:	e8 29 06 00 00       	call   398a <close>
  unlink("bigarg-ok");
    3361:	c7 04 24 de 4c 00 00 	movl   $0x4cde,(%esp)
    3368:	e8 45 06 00 00       	call   39b2 <unlink>
}
    336d:	83 c4 10             	add    $0x10,%esp
    3370:	c9                   	leave  
    3371:	c3                   	ret    
    3372:	b8 80 5e 00 00       	mov    $0x5e80,%eax
    3377:	89 f6                	mov    %esi,%esi
    3379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  pid = fork(0);
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    3380:	c7 00 38 54 00 00    	movl   $0x5438,(%eax)
    3386:	83 c0 04             	add    $0x4,%eax
  unlink("bigarg-ok");
  pid = fork(0);
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    3389:	3d fc 5e 00 00       	cmp    $0x5efc,%eax
    338e:	75 f0                	jne    3380 <bigargtest+0x70>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    printf(stdout, "bigarg test\n");
    3390:	51                   	push   %ecx
    3391:	51                   	push   %ecx
    3392:	68 e8 4c 00 00       	push   $0x4ce8
    3397:	ff 35 64 5e 00 00    	pushl  0x5e64
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    339d:	c7 05 fc 5e 00 00 00 	movl   $0x0,0x5efc
    33a4:	00 00 00 
    printf(stdout, "bigarg test\n");
    33a7:	e8 04 07 00 00       	call   3ab0 <printf>
    exec("echo", args);
    33ac:	58                   	pop    %eax
    33ad:	5a                   	pop    %edx
    33ae:	68 80 5e 00 00       	push   $0x5e80
    33b3:	68 b5 3e 00 00       	push   $0x3eb5
    33b8:	e8 dd 05 00 00       	call   399a <exec>
    printf(stdout, "bigarg test ok\n");
    33bd:	59                   	pop    %ecx
    33be:	58                   	pop    %eax
    33bf:	68 f5 4c 00 00       	push   $0x4cf5
    33c4:	ff 35 64 5e 00 00    	pushl  0x5e64
    33ca:	e8 e1 06 00 00       	call   3ab0 <printf>
    fd = open("bigarg-ok", O_CREATE);
    33cf:	58                   	pop    %eax
    33d0:	5a                   	pop    %edx
    33d1:	68 00 02 00 00       	push   $0x200
    33d6:	68 de 4c 00 00       	push   $0x4cde
    33db:	e8 c2 05 00 00       	call   39a2 <open>
    close(fd);
    33e0:	89 04 24             	mov    %eax,(%esp)
    33e3:	e8 a2 05 00 00       	call   398a <close>
    exit();
    33e8:	e8 75 05 00 00       	call   3962 <exit>
    exit();
  }
  wait();
  fd = open("bigarg-ok", 0);
  if(fd < 0){
    printf(stdout, "bigarg test failed!\n");
    33ed:	50                   	push   %eax
    33ee:	50                   	push   %eax
    33ef:	68 1e 4d 00 00       	push   $0x4d1e
    33f4:	ff 35 64 5e 00 00    	pushl  0x5e64
    33fa:	e8 b1 06 00 00       	call   3ab0 <printf>
    exit();
    33ff:	e8 5e 05 00 00       	call   3962 <exit>
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit();
  } else if(pid < 0){
    printf(stdout, "bigargtest: fork failed\n");
    3404:	52                   	push   %edx
    3405:	52                   	push   %edx
    3406:	68 05 4d 00 00       	push   $0x4d05
    340b:	ff 35 64 5e 00 00    	pushl  0x5e64
    3411:	e8 9a 06 00 00       	call   3ab0 <printf>
    exit();
    3416:	e8 47 05 00 00       	call   3962 <exit>
    341b:	90                   	nop
    341c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003420 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    3420:	55                   	push   %ebp
    3421:	89 e5                	mov    %esp,%ebp
    3423:	57                   	push   %edi
    3424:	56                   	push   %esi
    3425:	53                   	push   %ebx
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    3426:	31 db                	xor    %ebx,%ebx

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    3428:	83 ec 54             	sub    $0x54,%esp
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");
    342b:	68 33 4d 00 00       	push   $0x4d33
    3430:	6a 01                	push   $0x1
    3432:	e8 79 06 00 00       	call   3ab0 <printf>
    3437:	83 c4 10             	add    $0x10,%esp
    343a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    3440:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    3445:	89 de                	mov    %ebx,%esi
    name[2] = '0' + (nfiles % 1000) / 100;
    3447:	89 d9                	mov    %ebx,%ecx
  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    3449:	f7 eb                	imul   %ebx
    344b:	c1 fe 1f             	sar    $0x1f,%esi
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    344e:	89 df                	mov    %ebx,%edi
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    3450:	83 ec 04             	sub    $0x4,%esp

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    3453:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    3457:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    345b:	c1 fa 06             	sar    $0x6,%edx
    345e:	29 f2                	sub    %esi,%edx
    3460:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    3463:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    3469:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    346c:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3471:	29 d1                	sub    %edx,%ecx
    3473:	f7 e9                	imul   %ecx
    3475:	c1 f9 1f             	sar    $0x1f,%ecx
    name[3] = '0' + (nfiles % 100) / 10;
    3478:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    347d:	c1 fa 05             	sar    $0x5,%edx
    3480:	29 ca                	sub    %ecx,%edx
    name[3] = '0' + (nfiles % 100) / 10;
    3482:	b9 67 66 66 66       	mov    $0x66666667,%ecx

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    3487:	83 c2 30             	add    $0x30,%edx
    348a:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    348d:	f7 eb                	imul   %ebx
    348f:	c1 fa 05             	sar    $0x5,%edx
    3492:	29 f2                	sub    %esi,%edx
    3494:	6b d2 64             	imul   $0x64,%edx,%edx
    3497:	29 d7                	sub    %edx,%edi
    3499:	89 f8                	mov    %edi,%eax
    349b:	c1 ff 1f             	sar    $0x1f,%edi
    349e:	f7 e9                	imul   %ecx
    name[4] = '0' + (nfiles % 10);
    34a0:	89 d8                	mov    %ebx,%eax
  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    34a2:	c1 fa 02             	sar    $0x2,%edx
    34a5:	29 fa                	sub    %edi,%edx
    34a7:	83 c2 30             	add    $0x30,%edx
    34aa:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    34ad:	f7 e9                	imul   %ecx
    34af:	89 d9                	mov    %ebx,%ecx
    34b1:	c1 fa 02             	sar    $0x2,%edx
    34b4:	29 f2                	sub    %esi,%edx
    34b6:	8d 04 92             	lea    (%edx,%edx,4),%eax
    34b9:	01 c0                	add    %eax,%eax
    34bb:	29 c1                	sub    %eax,%ecx
    34bd:	89 c8                	mov    %ecx,%eax
    34bf:	83 c0 30             	add    $0x30,%eax
    34c2:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    34c5:	8d 45 a8             	lea    -0x58(%ebp),%eax
    34c8:	50                   	push   %eax
    34c9:	68 40 4d 00 00       	push   $0x4d40
    34ce:	6a 01                	push   $0x1
    34d0:	e8 db 05 00 00       	call   3ab0 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    34d5:	58                   	pop    %eax
    34d6:	8d 45 a8             	lea    -0x58(%ebp),%eax
    34d9:	5a                   	pop    %edx
    34da:	68 02 02 00 00       	push   $0x202
    34df:	50                   	push   %eax
    34e0:	e8 bd 04 00 00       	call   39a2 <open>
    if(fd < 0){
    34e5:	83 c4 10             	add    $0x10,%esp
    34e8:	85 c0                	test   %eax,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    int fd = open(name, O_CREATE|O_RDWR);
    34ea:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    34ec:	78 50                	js     353e <fsfull+0x11e>
    34ee:	31 f6                	xor    %esi,%esi
    34f0:	eb 08                	jmp    34fa <fsfull+0xda>
    34f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
      if(cc < 512)
        break;
      total += cc;
    34f8:	01 c6                	add    %eax,%esi
      printf(1, "open %s failed\n", name);
      break;
    }
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
    34fa:	83 ec 04             	sub    $0x4,%esp
    34fd:	68 00 02 00 00       	push   $0x200
    3502:	68 40 86 00 00       	push   $0x8640
    3507:	57                   	push   %edi
    3508:	e8 75 04 00 00       	call   3982 <write>
      if(cc < 512)
    350d:	83 c4 10             	add    $0x10,%esp
    3510:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    3515:	7f e1                	jg     34f8 <fsfull+0xd8>
        break;
      total += cc;
      fsblocks++;
    }
    printf(1, "wrote %d bytes\n", total);
    3517:	83 ec 04             	sub    $0x4,%esp
    351a:	56                   	push   %esi
    351b:	68 5c 4d 00 00       	push   $0x4d5c
    3520:	6a 01                	push   $0x1
    3522:	e8 89 05 00 00       	call   3ab0 <printf>
    close(fd);
    3527:	89 3c 24             	mov    %edi,(%esp)
    352a:	e8 5b 04 00 00       	call   398a <close>
    if(total == 0)
    352f:	83 c4 10             	add    $0x10,%esp
    3532:	85 f6                	test   %esi,%esi
    3534:	74 22                	je     3558 <fsfull+0x138>
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    3536:	83 c3 01             	add    $0x1,%ebx
    }
    printf(1, "wrote %d bytes\n", total);
    close(fd);
    if(total == 0)
      break;
  }
    3539:	e9 02 ff ff ff       	jmp    3440 <fsfull+0x20>
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    int fd = open(name, O_CREATE|O_RDWR);
    if(fd < 0){
      printf(1, "open %s failed\n", name);
    353e:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3541:	83 ec 04             	sub    $0x4,%esp
    3544:	50                   	push   %eax
    3545:	68 4c 4d 00 00       	push   $0x4d4c
    354a:	6a 01                	push   $0x1
    354c:	e8 5f 05 00 00       	call   3ab0 <printf>
      break;
    3551:	83 c4 10             	add    $0x10,%esp
    3554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    3558:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    355d:	89 de                	mov    %ebx,%esi
    name[2] = '0' + (nfiles % 1000) / 100;
    355f:	89 d9                	mov    %ebx,%ecx
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    3561:	f7 eb                	imul   %ebx
    3563:	c1 fe 1f             	sar    $0x1f,%esi
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    3566:	89 df                	mov    %ebx,%edi
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    unlink(name);
    3568:	83 ec 0c             	sub    $0xc,%esp
      break;
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    356b:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    356f:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    3573:	c1 fa 06             	sar    $0x6,%edx
    3576:	29 f2                	sub    %esi,%edx
    3578:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    357b:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    3581:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3584:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3589:	29 d1                	sub    %edx,%ecx
    358b:	f7 e9                	imul   %ecx
    358d:	c1 f9 1f             	sar    $0x1f,%ecx
    name[3] = '0' + (nfiles % 100) / 10;
    3590:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    3595:	c1 fa 05             	sar    $0x5,%edx
    3598:	29 ca                	sub    %ecx,%edx
    name[3] = '0' + (nfiles % 100) / 10;
    359a:	b9 67 66 66 66       	mov    $0x66666667,%ecx

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    359f:	83 c2 30             	add    $0x30,%edx
    35a2:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    35a5:	f7 eb                	imul   %ebx
    35a7:	c1 fa 05             	sar    $0x5,%edx
    35aa:	29 f2                	sub    %esi,%edx
    35ac:	6b d2 64             	imul   $0x64,%edx,%edx
    35af:	29 d7                	sub    %edx,%edi
    35b1:	89 f8                	mov    %edi,%eax
    35b3:	c1 ff 1f             	sar    $0x1f,%edi
    35b6:	f7 e9                	imul   %ecx
    name[4] = '0' + (nfiles % 10);
    35b8:	89 d8                	mov    %ebx,%eax
  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    35ba:	c1 fa 02             	sar    $0x2,%edx
    35bd:	29 fa                	sub    %edi,%edx
    35bf:	83 c2 30             	add    $0x30,%edx
    35c2:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    35c5:	f7 e9                	imul   %ecx
    35c7:	89 d9                	mov    %ebx,%ecx
    name[5] = '\0';
    unlink(name);
    nfiles--;
    35c9:	83 eb 01             	sub    $0x1,%ebx
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    35cc:	c1 fa 02             	sar    $0x2,%edx
    35cf:	29 f2                	sub    %esi,%edx
    35d1:	8d 04 92             	lea    (%edx,%edx,4),%eax
    35d4:	01 c0                	add    %eax,%eax
    35d6:	29 c1                	sub    %eax,%ecx
    35d8:	89 c8                	mov    %ecx,%eax
    35da:	83 c0 30             	add    $0x30,%eax
    35dd:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    unlink(name);
    35e0:	8d 45 a8             	lea    -0x58(%ebp),%eax
    35e3:	50                   	push   %eax
    35e4:	e8 c9 03 00 00       	call   39b2 <unlink>
    close(fd);
    if(total == 0)
      break;
  }

  while(nfiles >= 0){
    35e9:	83 c4 10             	add    $0x10,%esp
    35ec:	83 fb ff             	cmp    $0xffffffff,%ebx
    35ef:	0f 85 63 ff ff ff    	jne    3558 <fsfull+0x138>
    name[5] = '\0';
    unlink(name);
    nfiles--;
  }

  printf(1, "fsfull test finished\n");
    35f5:	83 ec 08             	sub    $0x8,%esp
    35f8:	68 6c 4d 00 00       	push   $0x4d6c
    35fd:	6a 01                	push   $0x1
    35ff:	e8 ac 04 00 00       	call   3ab0 <printf>
}
    3604:	83 c4 10             	add    $0x10,%esp
    3607:	8d 65 f4             	lea    -0xc(%ebp),%esp
    360a:	5b                   	pop    %ebx
    360b:	5e                   	pop    %esi
    360c:	5f                   	pop    %edi
    360d:	5d                   	pop    %ebp
    360e:	c3                   	ret    
    360f:	90                   	nop

00003610 <uio>:

void
uio()
{
    3610:	55                   	push   %ebp
    3611:	89 e5                	mov    %esp,%ebp
    3613:	83 ec 10             	sub    $0x10,%esp

  ushort port = 0;
  uchar val = 0;
  int pid;

  printf(1, "uio test\n");
    3616:	68 82 4d 00 00       	push   $0x4d82
    361b:	6a 01                	push   $0x1
    361d:	e8 8e 04 00 00       	call   3ab0 <printf>
  pid = fork(0);
    3622:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3629:	e8 2c 03 00 00       	call   395a <fork>
  if(pid == 0){
    362e:	83 c4 10             	add    $0x10,%esp
    3631:	85 c0                	test   %eax,%eax
    3633:	74 1b                	je     3650 <uio+0x40>
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    printf(1, "uio: uio succeeded; test FAILED\n");
    exit();
  } else if(pid < 0){
    3635:	78 3d                	js     3674 <uio+0x64>
    printf (1, "fork failed\n");
    exit();
  }
  wait();
    3637:	e8 2e 03 00 00       	call   396a <wait>
  printf(1, "uio test done\n");
    363c:	83 ec 08             	sub    $0x8,%esp
    363f:	68 8c 4d 00 00       	push   $0x4d8c
    3644:	6a 01                	push   $0x1
    3646:	e8 65 04 00 00       	call   3ab0 <printf>
}
    364b:	83 c4 10             	add    $0x10,%esp
    364e:	c9                   	leave  
    364f:	c3                   	ret    
  pid = fork(0);
  if(pid == 0){
    port = RTC_ADDR;
    val = 0x09;  /* year */
    /* http://wiki.osdev.org/Inline_Assembly/Examples */
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    3650:	ba 70 00 00 00       	mov    $0x70,%edx
    3655:	b8 09 00 00 00       	mov    $0x9,%eax
    365a:	ee                   	out    %al,(%dx)
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    365b:	ba 71 00 00 00       	mov    $0x71,%edx
    3660:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    3661:	52                   	push   %edx
    3662:	52                   	push   %edx
    3663:	68 18 55 00 00       	push   $0x5518
    3668:	6a 01                	push   $0x1
    366a:	e8 41 04 00 00       	call   3ab0 <printf>
    exit();
    366f:	e8 ee 02 00 00       	call   3962 <exit>
  } else if(pid < 0){
    printf (1, "fork failed\n");
    3674:	50                   	push   %eax
    3675:	50                   	push   %eax
    3676:	68 11 4d 00 00       	push   $0x4d11
    367b:	6a 01                	push   $0x1
    367d:	e8 2e 04 00 00       	call   3ab0 <printf>
    exit();
    3682:	e8 db 02 00 00       	call   3962 <exit>
    3687:	89 f6                	mov    %esi,%esi
    3689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003690 <argptest>:
  wait();
  printf(1, "uio test done\n");
}

void argptest()
{
    3690:	55                   	push   %ebp
    3691:	89 e5                	mov    %esp,%ebp
    3693:	53                   	push   %ebx
    3694:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  fd = open("init", O_RDONLY);
    3697:	6a 00                	push   $0x0
    3699:	68 9b 4d 00 00       	push   $0x4d9b
    369e:	e8 ff 02 00 00       	call   39a2 <open>
  if (fd < 0) {
    36a3:	83 c4 10             	add    $0x10,%esp
    36a6:	85 c0                	test   %eax,%eax
    36a8:	78 39                	js     36e3 <argptest+0x53>
    printf(2, "open failed\n");
    exit();
  }
  read(fd, sbrk(0) - 1, -1);
    36aa:	83 ec 0c             	sub    $0xc,%esp
    36ad:	89 c3                	mov    %eax,%ebx
    36af:	6a 00                	push   $0x0
    36b1:	e8 34 03 00 00       	call   39ea <sbrk>
    36b6:	83 c4 0c             	add    $0xc,%esp
    36b9:	83 e8 01             	sub    $0x1,%eax
    36bc:	6a ff                	push   $0xffffffff
    36be:	50                   	push   %eax
    36bf:	53                   	push   %ebx
    36c0:	e8 b5 02 00 00       	call   397a <read>
  close(fd);
    36c5:	89 1c 24             	mov    %ebx,(%esp)
    36c8:	e8 bd 02 00 00       	call   398a <close>
  printf(1, "arg test passed\n");
    36cd:	58                   	pop    %eax
    36ce:	5a                   	pop    %edx
    36cf:	68 ad 4d 00 00       	push   $0x4dad
    36d4:	6a 01                	push   $0x1
    36d6:	e8 d5 03 00 00       	call   3ab0 <printf>
}
    36db:	83 c4 10             	add    $0x10,%esp
    36de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    36e1:	c9                   	leave  
    36e2:	c3                   	ret    
void argptest()
{
  int fd;
  fd = open("init", O_RDONLY);
  if (fd < 0) {
    printf(2, "open failed\n");
    36e3:	51                   	push   %ecx
    36e4:	51                   	push   %ecx
    36e5:	68 a0 4d 00 00       	push   $0x4da0
    36ea:	6a 02                	push   $0x2
    36ec:	e8 bf 03 00 00       	call   3ab0 <printf>
    exit();
    36f1:	e8 6c 02 00 00       	call   3962 <exit>
    36f6:	8d 76 00             	lea    0x0(%esi),%esi
    36f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003700 <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
  randstate = randstate * 1664525 + 1013904223;
    3700:	69 05 60 5e 00 00 0d 	imul   $0x19660d,0x5e60,%eax
    3707:	66 19 00 
}

unsigned long randstate = 1;
unsigned int
rand()
{
    370a:	55                   	push   %ebp
    370b:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
  return randstate;
}
    370d:	5d                   	pop    %ebp

unsigned long randstate = 1;
unsigned int
rand()
{
  randstate = randstate * 1664525 + 1013904223;
    370e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3713:	a3 60 5e 00 00       	mov    %eax,0x5e60
  return randstate;
}
    3718:	c3                   	ret    
    3719:	66 90                	xchg   %ax,%ax
    371b:	66 90                	xchg   %ax,%ax
    371d:	66 90                	xchg   %ax,%ax
    371f:	90                   	nop

00003720 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3720:	55                   	push   %ebp
    3721:	89 e5                	mov    %esp,%ebp
    3723:	53                   	push   %ebx
    3724:	8b 45 08             	mov    0x8(%ebp),%eax
    3727:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    372a:	89 c2                	mov    %eax,%edx
    372c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3730:	83 c1 01             	add    $0x1,%ecx
    3733:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    3737:	83 c2 01             	add    $0x1,%edx
    373a:	84 db                	test   %bl,%bl
    373c:	88 5a ff             	mov    %bl,-0x1(%edx)
    373f:	75 ef                	jne    3730 <strcpy+0x10>
    ;
  return os;
}
    3741:	5b                   	pop    %ebx
    3742:	5d                   	pop    %ebp
    3743:	c3                   	ret    
    3744:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    374a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00003750 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3750:	55                   	push   %ebp
    3751:	89 e5                	mov    %esp,%ebp
    3753:	56                   	push   %esi
    3754:	53                   	push   %ebx
    3755:	8b 55 08             	mov    0x8(%ebp),%edx
    3758:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    375b:	0f b6 02             	movzbl (%edx),%eax
    375e:	0f b6 19             	movzbl (%ecx),%ebx
    3761:	84 c0                	test   %al,%al
    3763:	75 1e                	jne    3783 <strcmp+0x33>
    3765:	eb 29                	jmp    3790 <strcmp+0x40>
    3767:	89 f6                	mov    %esi,%esi
    3769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    3770:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    3773:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    3776:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    3779:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    377d:	84 c0                	test   %al,%al
    377f:	74 0f                	je     3790 <strcmp+0x40>
    3781:	89 f1                	mov    %esi,%ecx
    3783:	38 d8                	cmp    %bl,%al
    3785:	74 e9                	je     3770 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    3787:	29 d8                	sub    %ebx,%eax
}
    3789:	5b                   	pop    %ebx
    378a:	5e                   	pop    %esi
    378b:	5d                   	pop    %ebp
    378c:	c3                   	ret    
    378d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    3790:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
    3792:	29 d8                	sub    %ebx,%eax
}
    3794:	5b                   	pop    %ebx
    3795:	5e                   	pop    %esi
    3796:	5d                   	pop    %ebp
    3797:	c3                   	ret    
    3798:	90                   	nop
    3799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000037a0 <strlen>:

uint
strlen(const char *s)
{
    37a0:	55                   	push   %ebp
    37a1:	89 e5                	mov    %esp,%ebp
    37a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    37a6:	80 39 00             	cmpb   $0x0,(%ecx)
    37a9:	74 12                	je     37bd <strlen+0x1d>
    37ab:	31 d2                	xor    %edx,%edx
    37ad:	8d 76 00             	lea    0x0(%esi),%esi
    37b0:	83 c2 01             	add    $0x1,%edx
    37b3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    37b7:	89 d0                	mov    %edx,%eax
    37b9:	75 f5                	jne    37b0 <strlen+0x10>
    ;
  return n;
}
    37bb:	5d                   	pop    %ebp
    37bc:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    37bd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
    37bf:	5d                   	pop    %ebp
    37c0:	c3                   	ret    
    37c1:	eb 0d                	jmp    37d0 <memset>
    37c3:	90                   	nop
    37c4:	90                   	nop
    37c5:	90                   	nop
    37c6:	90                   	nop
    37c7:	90                   	nop
    37c8:	90                   	nop
    37c9:	90                   	nop
    37ca:	90                   	nop
    37cb:	90                   	nop
    37cc:	90                   	nop
    37cd:	90                   	nop
    37ce:	90                   	nop
    37cf:	90                   	nop

000037d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    37d0:	55                   	push   %ebp
    37d1:	89 e5                	mov    %esp,%ebp
    37d3:	57                   	push   %edi
    37d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    37d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    37da:	8b 45 0c             	mov    0xc(%ebp),%eax
    37dd:	89 d7                	mov    %edx,%edi
    37df:	fc                   	cld    
    37e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    37e2:	89 d0                	mov    %edx,%eax
    37e4:	5f                   	pop    %edi
    37e5:	5d                   	pop    %ebp
    37e6:	c3                   	ret    
    37e7:	89 f6                	mov    %esi,%esi
    37e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000037f0 <strchr>:

char*
strchr(const char *s, char c)
{
    37f0:	55                   	push   %ebp
    37f1:	89 e5                	mov    %esp,%ebp
    37f3:	53                   	push   %ebx
    37f4:	8b 45 08             	mov    0x8(%ebp),%eax
    37f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    37fa:	0f b6 10             	movzbl (%eax),%edx
    37fd:	84 d2                	test   %dl,%dl
    37ff:	74 1d                	je     381e <strchr+0x2e>
    if(*s == c)
    3801:	38 d3                	cmp    %dl,%bl
    3803:	89 d9                	mov    %ebx,%ecx
    3805:	75 0d                	jne    3814 <strchr+0x24>
    3807:	eb 17                	jmp    3820 <strchr+0x30>
    3809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3810:	38 ca                	cmp    %cl,%dl
    3812:	74 0c                	je     3820 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    3814:	83 c0 01             	add    $0x1,%eax
    3817:	0f b6 10             	movzbl (%eax),%edx
    381a:	84 d2                	test   %dl,%dl
    381c:	75 f2                	jne    3810 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
    381e:	31 c0                	xor    %eax,%eax
}
    3820:	5b                   	pop    %ebx
    3821:	5d                   	pop    %ebp
    3822:	c3                   	ret    
    3823:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003830 <gets>:

char*
gets(char *buf, int max)
{
    3830:	55                   	push   %ebp
    3831:	89 e5                	mov    %esp,%ebp
    3833:	57                   	push   %edi
    3834:	56                   	push   %esi
    3835:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3836:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
    3838:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
    383b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    383e:	eb 29                	jmp    3869 <gets+0x39>
    cc = read(0, &c, 1);
    3840:	83 ec 04             	sub    $0x4,%esp
    3843:	6a 01                	push   $0x1
    3845:	57                   	push   %edi
    3846:	6a 00                	push   $0x0
    3848:	e8 2d 01 00 00       	call   397a <read>
    if(cc < 1)
    384d:	83 c4 10             	add    $0x10,%esp
    3850:	85 c0                	test   %eax,%eax
    3852:	7e 1d                	jle    3871 <gets+0x41>
      break;
    buf[i++] = c;
    3854:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3858:	8b 55 08             	mov    0x8(%ebp),%edx
    385b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
    385d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    385f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    3863:	74 1b                	je     3880 <gets+0x50>
    3865:	3c 0d                	cmp    $0xd,%al
    3867:	74 17                	je     3880 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3869:	8d 5e 01             	lea    0x1(%esi),%ebx
    386c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    386f:	7c cf                	jl     3840 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    3871:	8b 45 08             	mov    0x8(%ebp),%eax
    3874:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    3878:	8d 65 f4             	lea    -0xc(%ebp),%esp
    387b:	5b                   	pop    %ebx
    387c:	5e                   	pop    %esi
    387d:	5f                   	pop    %edi
    387e:	5d                   	pop    %ebp
    387f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    3880:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3883:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    3885:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    3889:	8d 65 f4             	lea    -0xc(%ebp),%esp
    388c:	5b                   	pop    %ebx
    388d:	5e                   	pop    %esi
    388e:	5f                   	pop    %edi
    388f:	5d                   	pop    %ebp
    3890:	c3                   	ret    
    3891:	eb 0d                	jmp    38a0 <stat>
    3893:	90                   	nop
    3894:	90                   	nop
    3895:	90                   	nop
    3896:	90                   	nop
    3897:	90                   	nop
    3898:	90                   	nop
    3899:	90                   	nop
    389a:	90                   	nop
    389b:	90                   	nop
    389c:	90                   	nop
    389d:	90                   	nop
    389e:	90                   	nop
    389f:	90                   	nop

000038a0 <stat>:

int
stat(const char *n, struct stat *st)
{
    38a0:	55                   	push   %ebp
    38a1:	89 e5                	mov    %esp,%ebp
    38a3:	56                   	push   %esi
    38a4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    38a5:	83 ec 08             	sub    $0x8,%esp
    38a8:	6a 00                	push   $0x0
    38aa:	ff 75 08             	pushl  0x8(%ebp)
    38ad:	e8 f0 00 00 00       	call   39a2 <open>
  if(fd < 0)
    38b2:	83 c4 10             	add    $0x10,%esp
    38b5:	85 c0                	test   %eax,%eax
    38b7:	78 27                	js     38e0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    38b9:	83 ec 08             	sub    $0x8,%esp
    38bc:	ff 75 0c             	pushl  0xc(%ebp)
    38bf:	89 c3                	mov    %eax,%ebx
    38c1:	50                   	push   %eax
    38c2:	e8 f3 00 00 00       	call   39ba <fstat>
    38c7:	89 c6                	mov    %eax,%esi
  close(fd);
    38c9:	89 1c 24             	mov    %ebx,(%esp)
    38cc:	e8 b9 00 00 00       	call   398a <close>
  return r;
    38d1:	83 c4 10             	add    $0x10,%esp
    38d4:	89 f0                	mov    %esi,%eax
}
    38d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
    38d9:	5b                   	pop    %ebx
    38da:	5e                   	pop    %esi
    38db:	5d                   	pop    %ebp
    38dc:	c3                   	ret    
    38dd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
    38e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    38e5:	eb ef                	jmp    38d6 <stat+0x36>
    38e7:	89 f6                	mov    %esi,%esi
    38e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000038f0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    38f0:	55                   	push   %ebp
    38f1:	89 e5                	mov    %esp,%ebp
    38f3:	53                   	push   %ebx
    38f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    38f7:	0f be 11             	movsbl (%ecx),%edx
    38fa:	8d 42 d0             	lea    -0x30(%edx),%eax
    38fd:	3c 09                	cmp    $0x9,%al
    38ff:	b8 00 00 00 00       	mov    $0x0,%eax
    3904:	77 1f                	ja     3925 <atoi+0x35>
    3906:	8d 76 00             	lea    0x0(%esi),%esi
    3909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    3910:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3913:	83 c1 01             	add    $0x1,%ecx
    3916:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    391a:	0f be 11             	movsbl (%ecx),%edx
    391d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    3920:	80 fb 09             	cmp    $0x9,%bl
    3923:	76 eb                	jbe    3910 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
    3925:	5b                   	pop    %ebx
    3926:	5d                   	pop    %ebp
    3927:	c3                   	ret    
    3928:	90                   	nop
    3929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003930 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3930:	55                   	push   %ebp
    3931:	89 e5                	mov    %esp,%ebp
    3933:	56                   	push   %esi
    3934:	53                   	push   %ebx
    3935:	8b 5d 10             	mov    0x10(%ebp),%ebx
    3938:	8b 45 08             	mov    0x8(%ebp),%eax
    393b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    393e:	85 db                	test   %ebx,%ebx
    3940:	7e 14                	jle    3956 <memmove+0x26>
    3942:	31 d2                	xor    %edx,%edx
    3944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    3948:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    394c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    394f:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3952:	39 da                	cmp    %ebx,%edx
    3954:	75 f2                	jne    3948 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    3956:	5b                   	pop    %ebx
    3957:	5e                   	pop    %esi
    3958:	5d                   	pop    %ebp
    3959:	c3                   	ret    

0000395a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    395a:	b8 01 00 00 00       	mov    $0x1,%eax
    395f:	cd 40                	int    $0x40
    3961:	c3                   	ret    

00003962 <exit>:
SYSCALL(exit)
    3962:	b8 02 00 00 00       	mov    $0x2,%eax
    3967:	cd 40                	int    $0x40
    3969:	c3                   	ret    

0000396a <wait>:
SYSCALL(wait)
    396a:	b8 03 00 00 00       	mov    $0x3,%eax
    396f:	cd 40                	int    $0x40
    3971:	c3                   	ret    

00003972 <pipe>:
SYSCALL(pipe)
    3972:	b8 04 00 00 00       	mov    $0x4,%eax
    3977:	cd 40                	int    $0x40
    3979:	c3                   	ret    

0000397a <read>:
SYSCALL(read)
    397a:	b8 05 00 00 00       	mov    $0x5,%eax
    397f:	cd 40                	int    $0x40
    3981:	c3                   	ret    

00003982 <write>:
SYSCALL(write)
    3982:	b8 10 00 00 00       	mov    $0x10,%eax
    3987:	cd 40                	int    $0x40
    3989:	c3                   	ret    

0000398a <close>:
SYSCALL(close)
    398a:	b8 15 00 00 00       	mov    $0x15,%eax
    398f:	cd 40                	int    $0x40
    3991:	c3                   	ret    

00003992 <kill>:
SYSCALL(kill)
    3992:	b8 06 00 00 00       	mov    $0x6,%eax
    3997:	cd 40                	int    $0x40
    3999:	c3                   	ret    

0000399a <exec>:
SYSCALL(exec)
    399a:	b8 07 00 00 00       	mov    $0x7,%eax
    399f:	cd 40                	int    $0x40
    39a1:	c3                   	ret    

000039a2 <open>:
SYSCALL(open)
    39a2:	b8 0f 00 00 00       	mov    $0xf,%eax
    39a7:	cd 40                	int    $0x40
    39a9:	c3                   	ret    

000039aa <mknod>:
SYSCALL(mknod)
    39aa:	b8 11 00 00 00       	mov    $0x11,%eax
    39af:	cd 40                	int    $0x40
    39b1:	c3                   	ret    

000039b2 <unlink>:
SYSCALL(unlink)
    39b2:	b8 12 00 00 00       	mov    $0x12,%eax
    39b7:	cd 40                	int    $0x40
    39b9:	c3                   	ret    

000039ba <fstat>:
SYSCALL(fstat)
    39ba:	b8 08 00 00 00       	mov    $0x8,%eax
    39bf:	cd 40                	int    $0x40
    39c1:	c3                   	ret    

000039c2 <link>:
SYSCALL(link)
    39c2:	b8 13 00 00 00       	mov    $0x13,%eax
    39c7:	cd 40                	int    $0x40
    39c9:	c3                   	ret    

000039ca <mkdir>:
SYSCALL(mkdir)
    39ca:	b8 14 00 00 00       	mov    $0x14,%eax
    39cf:	cd 40                	int    $0x40
    39d1:	c3                   	ret    

000039d2 <chdir>:
SYSCALL(chdir)
    39d2:	b8 09 00 00 00       	mov    $0x9,%eax
    39d7:	cd 40                	int    $0x40
    39d9:	c3                   	ret    

000039da <dup>:
SYSCALL(dup)
    39da:	b8 0a 00 00 00       	mov    $0xa,%eax
    39df:	cd 40                	int    $0x40
    39e1:	c3                   	ret    

000039e2 <getpid>:
SYSCALL(getpid)
    39e2:	b8 0b 00 00 00       	mov    $0xb,%eax
    39e7:	cd 40                	int    $0x40
    39e9:	c3                   	ret    

000039ea <sbrk>:
SYSCALL(sbrk)
    39ea:	b8 0c 00 00 00       	mov    $0xc,%eax
    39ef:	cd 40                	int    $0x40
    39f1:	c3                   	ret    

000039f2 <sleep>:
SYSCALL(sleep)
    39f2:	b8 0d 00 00 00       	mov    $0xd,%eax
    39f7:	cd 40                	int    $0x40
    39f9:	c3                   	ret    

000039fa <uptime>:
SYSCALL(uptime)
    39fa:	b8 0e 00 00 00       	mov    $0xe,%eax
    39ff:	cd 40                	int    $0x40
    3a01:	c3                   	ret    

00003a02 <lottery>:
    3a02:	b8 16 00 00 00       	mov    $0x16,%eax
    3a07:	cd 40                	int    $0x40
    3a09:	c3                   	ret    
    3a0a:	66 90                	xchg   %ax,%ax
    3a0c:	66 90                	xchg   %ax,%ax
    3a0e:	66 90                	xchg   %ax,%ax

00003a10 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3a10:	55                   	push   %ebp
    3a11:	89 e5                	mov    %esp,%ebp
    3a13:	57                   	push   %edi
    3a14:	56                   	push   %esi
    3a15:	53                   	push   %ebx
    3a16:	89 c6                	mov    %eax,%esi
    3a18:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3a1b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3a1e:	85 db                	test   %ebx,%ebx
    3a20:	74 7e                	je     3aa0 <printint+0x90>
    3a22:	89 d0                	mov    %edx,%eax
    3a24:	c1 e8 1f             	shr    $0x1f,%eax
    3a27:	84 c0                	test   %al,%al
    3a29:	74 75                	je     3aa0 <printint+0x90>
    neg = 1;
    x = -xx;
    3a2b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    3a2d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
    3a34:	f7 d8                	neg    %eax
    3a36:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    3a39:	31 ff                	xor    %edi,%edi
    3a3b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    3a3e:	89 ce                	mov    %ecx,%esi
    3a40:	eb 08                	jmp    3a4a <printint+0x3a>
    3a42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    3a48:	89 cf                	mov    %ecx,%edi
    3a4a:	31 d2                	xor    %edx,%edx
    3a4c:	8d 4f 01             	lea    0x1(%edi),%ecx
    3a4f:	f7 f6                	div    %esi
    3a51:	0f b6 92 70 55 00 00 	movzbl 0x5570(%edx),%edx
  }while((x /= base) != 0);
    3a58:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    3a5a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
    3a5d:	75 e9                	jne    3a48 <printint+0x38>
  if(neg)
    3a5f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    3a62:	8b 75 c0             	mov    -0x40(%ebp),%esi
    3a65:	85 c0                	test   %eax,%eax
    3a67:	74 08                	je     3a71 <printint+0x61>
    buf[i++] = '-';
    3a69:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
    3a6e:	8d 4f 02             	lea    0x2(%edi),%ecx
    3a71:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
    3a75:	8d 76 00             	lea    0x0(%esi),%esi
    3a78:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3a7b:	83 ec 04             	sub    $0x4,%esp
    3a7e:	83 ef 01             	sub    $0x1,%edi
    3a81:	6a 01                	push   $0x1
    3a83:	53                   	push   %ebx
    3a84:	56                   	push   %esi
    3a85:	88 45 d7             	mov    %al,-0x29(%ebp)
    3a88:	e8 f5 fe ff ff       	call   3982 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    3a8d:	83 c4 10             	add    $0x10,%esp
    3a90:	39 df                	cmp    %ebx,%edi
    3a92:	75 e4                	jne    3a78 <printint+0x68>
    putc(fd, buf[i]);
}
    3a94:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3a97:	5b                   	pop    %ebx
    3a98:	5e                   	pop    %esi
    3a99:	5f                   	pop    %edi
    3a9a:	5d                   	pop    %ebp
    3a9b:	c3                   	ret    
    3a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    3aa0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    3aa2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    3aa9:	eb 8b                	jmp    3a36 <printint+0x26>
    3aab:	90                   	nop
    3aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003ab0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3ab0:	55                   	push   %ebp
    3ab1:	89 e5                	mov    %esp,%ebp
    3ab3:	57                   	push   %edi
    3ab4:	56                   	push   %esi
    3ab5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3ab6:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3ab9:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3abc:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3abf:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3ac2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3ac5:	0f b6 1e             	movzbl (%esi),%ebx
    3ac8:	83 c6 01             	add    $0x1,%esi
    3acb:	84 db                	test   %bl,%bl
    3acd:	0f 84 b0 00 00 00    	je     3b83 <printf+0xd3>
    3ad3:	31 d2                	xor    %edx,%edx
    3ad5:	eb 39                	jmp    3b10 <printf+0x60>
    3ad7:	89 f6                	mov    %esi,%esi
    3ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    3ae0:	83 f8 25             	cmp    $0x25,%eax
    3ae3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    3ae6:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    3aeb:	74 18                	je     3b05 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3aed:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    3af0:	83 ec 04             	sub    $0x4,%esp
    3af3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    3af6:	6a 01                	push   $0x1
    3af8:	50                   	push   %eax
    3af9:	57                   	push   %edi
    3afa:	e8 83 fe ff ff       	call   3982 <write>
    3aff:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    3b02:	83 c4 10             	add    $0x10,%esp
    3b05:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3b08:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    3b0c:	84 db                	test   %bl,%bl
    3b0e:	74 73                	je     3b83 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
    3b10:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    3b12:	0f be cb             	movsbl %bl,%ecx
    3b15:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    3b18:	74 c6                	je     3ae0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    3b1a:	83 fa 25             	cmp    $0x25,%edx
    3b1d:	75 e6                	jne    3b05 <printf+0x55>
      if(c == 'd'){
    3b1f:	83 f8 64             	cmp    $0x64,%eax
    3b22:	0f 84 f8 00 00 00    	je     3c20 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    3b28:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    3b2e:	83 f9 70             	cmp    $0x70,%ecx
    3b31:	74 5d                	je     3b90 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    3b33:	83 f8 73             	cmp    $0x73,%eax
    3b36:	0f 84 84 00 00 00    	je     3bc0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3b3c:	83 f8 63             	cmp    $0x63,%eax
    3b3f:	0f 84 ea 00 00 00    	je     3c2f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    3b45:	83 f8 25             	cmp    $0x25,%eax
    3b48:	0f 84 c2 00 00 00    	je     3c10 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3b4e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    3b51:	83 ec 04             	sub    $0x4,%esp
    3b54:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    3b58:	6a 01                	push   $0x1
    3b5a:	50                   	push   %eax
    3b5b:	57                   	push   %edi
    3b5c:	e8 21 fe ff ff       	call   3982 <write>
    3b61:	83 c4 0c             	add    $0xc,%esp
    3b64:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    3b67:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    3b6a:	6a 01                	push   $0x1
    3b6c:	50                   	push   %eax
    3b6d:	57                   	push   %edi
    3b6e:	83 c6 01             	add    $0x1,%esi
    3b71:	e8 0c fe ff ff       	call   3982 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3b76:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3b7a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3b7d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3b7f:	84 db                	test   %bl,%bl
    3b81:	75 8d                	jne    3b10 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3b83:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3b86:	5b                   	pop    %ebx
    3b87:	5e                   	pop    %esi
    3b88:	5f                   	pop    %edi
    3b89:	5d                   	pop    %ebp
    3b8a:	c3                   	ret    
    3b8b:	90                   	nop
    3b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    3b90:	83 ec 0c             	sub    $0xc,%esp
    3b93:	b9 10 00 00 00       	mov    $0x10,%ecx
    3b98:	6a 00                	push   $0x0
    3b9a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    3b9d:	89 f8                	mov    %edi,%eax
    3b9f:	8b 13                	mov    (%ebx),%edx
    3ba1:	e8 6a fe ff ff       	call   3a10 <printint>
        ap++;
    3ba6:	89 d8                	mov    %ebx,%eax
    3ba8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3bab:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
    3bad:	83 c0 04             	add    $0x4,%eax
    3bb0:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3bb3:	e9 4d ff ff ff       	jmp    3b05 <printf+0x55>
    3bb8:	90                   	nop
    3bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    3bc0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3bc3:	8b 18                	mov    (%eax),%ebx
        ap++;
    3bc5:	83 c0 04             	add    $0x4,%eax
    3bc8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
    3bcb:	b8 68 55 00 00       	mov    $0x5568,%eax
    3bd0:	85 db                	test   %ebx,%ebx
    3bd2:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
    3bd5:	0f b6 03             	movzbl (%ebx),%eax
    3bd8:	84 c0                	test   %al,%al
    3bda:	74 23                	je     3bff <printf+0x14f>
    3bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3be0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3be3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    3be6:	83 ec 04             	sub    $0x4,%esp
    3be9:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    3beb:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3bee:	50                   	push   %eax
    3bef:	57                   	push   %edi
    3bf0:	e8 8d fd ff ff       	call   3982 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    3bf5:	0f b6 03             	movzbl (%ebx),%eax
    3bf8:	83 c4 10             	add    $0x10,%esp
    3bfb:	84 c0                	test   %al,%al
    3bfd:	75 e1                	jne    3be0 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3bff:	31 d2                	xor    %edx,%edx
    3c01:	e9 ff fe ff ff       	jmp    3b05 <printf+0x55>
    3c06:	8d 76 00             	lea    0x0(%esi),%esi
    3c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3c10:	83 ec 04             	sub    $0x4,%esp
    3c13:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    3c16:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    3c19:	6a 01                	push   $0x1
    3c1b:	e9 4c ff ff ff       	jmp    3b6c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    3c20:	83 ec 0c             	sub    $0xc,%esp
    3c23:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3c28:	6a 01                	push   $0x1
    3c2a:	e9 6b ff ff ff       	jmp    3b9a <printf+0xea>
    3c2f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3c32:	83 ec 04             	sub    $0x4,%esp
    3c35:	8b 03                	mov    (%ebx),%eax
    3c37:	6a 01                	push   $0x1
    3c39:	88 45 e4             	mov    %al,-0x1c(%ebp)
    3c3c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    3c3f:	50                   	push   %eax
    3c40:	57                   	push   %edi
    3c41:	e8 3c fd ff ff       	call   3982 <write>
    3c46:	e9 5b ff ff ff       	jmp    3ba6 <printf+0xf6>
    3c4b:	66 90                	xchg   %ax,%ax
    3c4d:	66 90                	xchg   %ax,%ax
    3c4f:	90                   	nop

00003c50 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3c50:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3c51:	a1 00 5f 00 00       	mov    0x5f00,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    3c56:	89 e5                	mov    %esp,%ebp
    3c58:	57                   	push   %edi
    3c59:	56                   	push   %esi
    3c5a:	53                   	push   %ebx
    3c5b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3c5e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3c60:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3c63:	39 c8                	cmp    %ecx,%eax
    3c65:	73 19                	jae    3c80 <free+0x30>
    3c67:	89 f6                	mov    %esi,%esi
    3c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    3c70:	39 d1                	cmp    %edx,%ecx
    3c72:	72 1c                	jb     3c90 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3c74:	39 d0                	cmp    %edx,%eax
    3c76:	73 18                	jae    3c90 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
    3c78:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3c7a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3c7c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3c7e:	72 f0                	jb     3c70 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3c80:	39 d0                	cmp    %edx,%eax
    3c82:	72 f4                	jb     3c78 <free+0x28>
    3c84:	39 d1                	cmp    %edx,%ecx
    3c86:	73 f0                	jae    3c78 <free+0x28>
    3c88:	90                   	nop
    3c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
    3c90:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3c93:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3c96:	39 d7                	cmp    %edx,%edi
    3c98:	74 19                	je     3cb3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    3c9a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    3c9d:	8b 50 04             	mov    0x4(%eax),%edx
    3ca0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3ca3:	39 f1                	cmp    %esi,%ecx
    3ca5:	74 23                	je     3cca <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    3ca7:	89 08                	mov    %ecx,(%eax)
  freep = p;
    3ca9:	a3 00 5f 00 00       	mov    %eax,0x5f00
}
    3cae:	5b                   	pop    %ebx
    3caf:	5e                   	pop    %esi
    3cb0:	5f                   	pop    %edi
    3cb1:	5d                   	pop    %ebp
    3cb2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    3cb3:	03 72 04             	add    0x4(%edx),%esi
    3cb6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3cb9:	8b 10                	mov    (%eax),%edx
    3cbb:	8b 12                	mov    (%edx),%edx
    3cbd:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    3cc0:	8b 50 04             	mov    0x4(%eax),%edx
    3cc3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3cc6:	39 f1                	cmp    %esi,%ecx
    3cc8:	75 dd                	jne    3ca7 <free+0x57>
    p->s.size += bp->s.size;
    3cca:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    3ccd:	a3 00 5f 00 00       	mov    %eax,0x5f00
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    3cd2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    3cd5:	8b 53 f8             	mov    -0x8(%ebx),%edx
    3cd8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    3cda:	5b                   	pop    %ebx
    3cdb:	5e                   	pop    %esi
    3cdc:	5f                   	pop    %edi
    3cdd:	5d                   	pop    %ebp
    3cde:	c3                   	ret    
    3cdf:	90                   	nop

00003ce0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3ce0:	55                   	push   %ebp
    3ce1:	89 e5                	mov    %esp,%ebp
    3ce3:	57                   	push   %edi
    3ce4:	56                   	push   %esi
    3ce5:	53                   	push   %ebx
    3ce6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3ce9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    3cec:	8b 15 00 5f 00 00    	mov    0x5f00,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3cf2:	8d 78 07             	lea    0x7(%eax),%edi
    3cf5:	c1 ef 03             	shr    $0x3,%edi
    3cf8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    3cfb:	85 d2                	test   %edx,%edx
    3cfd:	0f 84 a3 00 00 00    	je     3da6 <malloc+0xc6>
    3d03:	8b 02                	mov    (%edx),%eax
    3d05:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    3d08:	39 cf                	cmp    %ecx,%edi
    3d0a:	76 74                	jbe    3d80 <malloc+0xa0>
    3d0c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    3d12:	be 00 10 00 00       	mov    $0x1000,%esi
    3d17:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
    3d1e:	0f 43 f7             	cmovae %edi,%esi
    3d21:	ba 00 80 00 00       	mov    $0x8000,%edx
    3d26:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
    3d2c:	0f 46 da             	cmovbe %edx,%ebx
    3d2f:	eb 10                	jmp    3d41 <malloc+0x61>
    3d31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3d38:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    3d3a:	8b 48 04             	mov    0x4(%eax),%ecx
    3d3d:	39 cf                	cmp    %ecx,%edi
    3d3f:	76 3f                	jbe    3d80 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3d41:	39 05 00 5f 00 00    	cmp    %eax,0x5f00
    3d47:	89 c2                	mov    %eax,%edx
    3d49:	75 ed                	jne    3d38 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    3d4b:	83 ec 0c             	sub    $0xc,%esp
    3d4e:	53                   	push   %ebx
    3d4f:	e8 96 fc ff ff       	call   39ea <sbrk>
  if(p == (char*)-1)
    3d54:	83 c4 10             	add    $0x10,%esp
    3d57:	83 f8 ff             	cmp    $0xffffffff,%eax
    3d5a:	74 1c                	je     3d78 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    3d5c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
    3d5f:	83 ec 0c             	sub    $0xc,%esp
    3d62:	83 c0 08             	add    $0x8,%eax
    3d65:	50                   	push   %eax
    3d66:	e8 e5 fe ff ff       	call   3c50 <free>
  return freep;
    3d6b:	8b 15 00 5f 00 00    	mov    0x5f00,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    3d71:	83 c4 10             	add    $0x10,%esp
    3d74:	85 d2                	test   %edx,%edx
    3d76:	75 c0                	jne    3d38 <malloc+0x58>
        return 0;
    3d78:	31 c0                	xor    %eax,%eax
    3d7a:	eb 1c                	jmp    3d98 <malloc+0xb8>
    3d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    3d80:	39 cf                	cmp    %ecx,%edi
    3d82:	74 1c                	je     3da0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    3d84:	29 f9                	sub    %edi,%ecx
    3d86:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    3d89:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    3d8c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
    3d8f:	89 15 00 5f 00 00    	mov    %edx,0x5f00
      return (void*)(p + 1);
    3d95:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    3d98:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3d9b:	5b                   	pop    %ebx
    3d9c:	5e                   	pop    %esi
    3d9d:	5f                   	pop    %edi
    3d9e:	5d                   	pop    %ebp
    3d9f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    3da0:	8b 08                	mov    (%eax),%ecx
    3da2:	89 0a                	mov    %ecx,(%edx)
    3da4:	eb e9                	jmp    3d8f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    3da6:	c7 05 00 5f 00 00 04 	movl   $0x5f04,0x5f00
    3dad:	5f 00 00 
    3db0:	c7 05 04 5f 00 00 04 	movl   $0x5f04,0x5f04
    3db7:	5f 00 00 
    base.s.size = 0;
    3dba:	b8 04 5f 00 00       	mov    $0x5f04,%eax
    3dbf:	c7 05 08 5f 00 00 00 	movl   $0x0,0x5f08
    3dc6:	00 00 00 
    3dc9:	e9 3e ff ff ff       	jmp    3d0c <malloc+0x2c>
