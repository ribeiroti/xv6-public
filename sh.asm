
_sh: formato do arquivo elf32-i386


Desmontagem da seção .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 04             	sub    $0x4,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
      11:	eb 0a                	jmp    1d <main+0x1d>
      13:	90                   	nop
      14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
      18:	83 f8 02             	cmp    $0x2,%eax
      1b:	7f 70                	jg     8d <main+0x8d>
  while((fd = open("console", O_RDWR)) >= 0){
      1d:	83 ec 08             	sub    $0x8,%esp
      20:	6a 02                	push   $0x2
      22:	68 99 12 00 00       	push   $0x1299
      27:	e8 66 0d 00 00       	call   d92 <open>
      2c:	83 c4 10             	add    $0x10,%esp
      2f:	85 c0                	test   %eax,%eax
      31:	79 e5                	jns    18 <main+0x18>
      33:	eb 2e                	jmp    63 <main+0x63>
      35:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      38:	80 3d c2 18 00 00 20 	cmpb   $0x20,0x18c2
      3f:	0f 84 7d 00 00 00    	je     c2 <main+0xc2>
      45:	8d 76 00             	lea    0x0(%esi),%esi
int
fork1(int tickets)
{
  int pid;

  pid = fork(tickets);
      48:	83 ec 0c             	sub    $0xc,%esp
      4b:	6a 08                	push   $0x8
      4d:	e8 f8 0c 00 00       	call   d4a <fork>
  if(pid == -1)
      52:	83 c4 10             	add    $0x10,%esp
      55:	83 f8 ff             	cmp    $0xffffffff,%eax
      58:	74 46                	je     a0 <main+0xa0>
    if(fork1(NTICKETS) == 0)
      5a:	85 c0                	test   %eax,%eax
      5c:	74 4f                	je     ad <main+0xad>
    wait();
      5e:	e8 f7 0c 00 00       	call   d5a <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
      63:	83 ec 08             	sub    $0x8,%esp
      66:	6a 64                	push   $0x64
      68:	68 c0 18 00 00       	push   $0x18c0
      6d:	e8 9e 00 00 00       	call   110 <getcmd>
      72:	83 c4 10             	add    $0x10,%esp
      75:	85 c0                	test   %eax,%eax
      77:	78 22                	js     9b <main+0x9b>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      79:	80 3d c0 18 00 00 63 	cmpb   $0x63,0x18c0
      80:	75 c6                	jne    48 <main+0x48>
      82:	80 3d c1 18 00 00 64 	cmpb   $0x64,0x18c1
      89:	75 bd                	jne    48 <main+0x48>
      8b:	eb ab                	jmp    38 <main+0x38>
      close(fd);
      8d:	83 ec 0c             	sub    $0xc,%esp
      90:	50                   	push   %eax
      91:	e8 e4 0c 00 00       	call   d7a <close>
      break;
      96:	83 c4 10             	add    $0x10,%esp
      99:	eb c8                	jmp    63 <main+0x63>
  exit();
      9b:	e8 b2 0c 00 00       	call   d52 <exit>
    panic("fork");
      a0:	83 ec 0c             	sub    $0xc,%esp
      a3:	68 22 12 00 00       	push   $0x1222
      a8:	e8 b3 00 00 00       	call   160 <panic>
      runcmd(parsecmd(buf));
      ad:	83 ec 0c             	sub    $0xc,%esp
      b0:	68 c0 18 00 00       	push   $0x18c0
      b5:	e8 d6 09 00 00       	call   a90 <parsecmd>
      ba:	89 04 24             	mov    %eax,(%esp)
      bd:	e8 be 00 00 00       	call   180 <runcmd>
      buf[strlen(buf)-1] = 0;  // chop \n
      c2:	83 ec 0c             	sub    $0xc,%esp
      c5:	68 c0 18 00 00       	push   $0x18c0
      ca:	e8 b1 0a 00 00       	call   b80 <strlen>
      if(chdir(buf+3) < 0)
      cf:	c7 04 24 c3 18 00 00 	movl   $0x18c3,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      d6:	c6 80 bf 18 00 00 00 	movb   $0x0,0x18bf(%eax)
      if(chdir(buf+3) < 0)
      dd:	e8 e0 0c 00 00       	call   dc2 <chdir>
      e2:	83 c4 10             	add    $0x10,%esp
      e5:	85 c0                	test   %eax,%eax
      e7:	0f 89 76 ff ff ff    	jns    63 <main+0x63>
        printf(2, "cannot cd %s\n", buf+3);
      ed:	50                   	push   %eax
      ee:	68 c3 18 00 00       	push   $0x18c3
      f3:	68 a1 12 00 00       	push   $0x12a1
      f8:	6a 02                	push   $0x2
      fa:	e8 a1 0d 00 00       	call   ea0 <printf>
      ff:	83 c4 10             	add    $0x10,%esp
     102:	e9 5c ff ff ff       	jmp    63 <main+0x63>
     107:	66 90                	xchg   %ax,%ax
     109:	66 90                	xchg   %ax,%ax
     10b:	66 90                	xchg   %ax,%ax
     10d:	66 90                	xchg   %ax,%ax
     10f:	90                   	nop

00000110 <getcmd>:
{
     110:	55                   	push   %ebp
     111:	89 e5                	mov    %esp,%ebp
     113:	56                   	push   %esi
     114:	53                   	push   %ebx
     115:	8b 75 0c             	mov    0xc(%ebp),%esi
     118:	8b 5d 08             	mov    0x8(%ebp),%ebx
  printf(2, "$ ");
     11b:	83 ec 08             	sub    $0x8,%esp
     11e:	68 f8 11 00 00       	push   $0x11f8
     123:	6a 02                	push   $0x2
     125:	e8 76 0d 00 00       	call   ea0 <printf>
  memset(buf, 0, nbuf);
     12a:	83 c4 0c             	add    $0xc,%esp
     12d:	56                   	push   %esi
     12e:	6a 00                	push   $0x0
     130:	53                   	push   %ebx
     131:	e8 7a 0a 00 00       	call   bb0 <memset>
  gets(buf, nbuf);
     136:	58                   	pop    %eax
     137:	5a                   	pop    %edx
     138:	56                   	push   %esi
     139:	53                   	push   %ebx
     13a:	e8 d1 0a 00 00       	call   c10 <gets>
  if(buf[0] == 0) // EOF
     13f:	83 c4 10             	add    $0x10,%esp
     142:	31 c0                	xor    %eax,%eax
     144:	80 3b 00             	cmpb   $0x0,(%ebx)
     147:	0f 94 c0             	sete   %al
}
     14a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(buf[0] == 0) // EOF
     14d:	f7 d8                	neg    %eax
}
     14f:	5b                   	pop    %ebx
     150:	5e                   	pop    %esi
     151:	5d                   	pop    %ebp
     152:	c3                   	ret    
     153:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000160 <panic>:
{
     160:	55                   	push   %ebp
     161:	89 e5                	mov    %esp,%ebp
     163:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     166:	ff 75 08             	pushl  0x8(%ebp)
     169:	68 95 12 00 00       	push   $0x1295
     16e:	6a 02                	push   $0x2
     170:	e8 2b 0d 00 00       	call   ea0 <printf>
  exit();
     175:	e8 d8 0b 00 00       	call   d52 <exit>
     17a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000180 <runcmd>:
{
     180:	55                   	push   %ebp
     181:	89 e5                	mov    %esp,%ebp
     183:	53                   	push   %ebx
     184:	83 ec 14             	sub    $0x14,%esp
     187:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     18a:	85 db                	test   %ebx,%ebx
     18c:	74 3a                	je     1c8 <runcmd+0x48>
  switch(cmd->type){
     18e:	83 3b 05             	cmpl   $0x5,(%ebx)
     191:	0f 87 26 01 00 00    	ja     2bd <runcmd+0x13d>
     197:	8b 03                	mov    (%ebx),%eax
     199:	ff 24 85 b0 12 00 00 	jmp    *0x12b0(,%eax,4)
    if(ecmd->argv[0] == 0)
     1a0:	8b 43 04             	mov    0x4(%ebx),%eax
     1a3:	85 c0                	test   %eax,%eax
     1a5:	74 21                	je     1c8 <runcmd+0x48>
    exec(ecmd->argv[0], ecmd->argv);
     1a7:	52                   	push   %edx
     1a8:	52                   	push   %edx
     1a9:	8d 53 04             	lea    0x4(%ebx),%edx
     1ac:	52                   	push   %edx
     1ad:	50                   	push   %eax
     1ae:	e8 d7 0b 00 00       	call   d8a <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     1b3:	83 c4 0c             	add    $0xc,%esp
     1b6:	ff 73 04             	pushl  0x4(%ebx)
     1b9:	68 02 12 00 00       	push   $0x1202
     1be:	6a 02                	push   $0x2
     1c0:	e8 db 0c 00 00       	call   ea0 <printf>
    break;
     1c5:	83 c4 10             	add    $0x10,%esp
    exit();
     1c8:	e8 85 0b 00 00       	call   d52 <exit>
  pid = fork(tickets);
     1cd:	83 ec 0c             	sub    $0xc,%esp
     1d0:	6a 08                	push   $0x8
     1d2:	e8 73 0b 00 00       	call   d4a <fork>
  if(pid == -1)
     1d7:	83 c4 10             	add    $0x10,%esp
     1da:	83 f8 ff             	cmp    $0xffffffff,%eax
     1dd:	0f 84 e7 00 00 00    	je     2ca <runcmd+0x14a>
    if(fork1(NTICKETS) == 0)
     1e3:	85 c0                	test   %eax,%eax
     1e5:	75 e1                	jne    1c8 <runcmd+0x48>
      runcmd(bcmd->cmd);
     1e7:	83 ec 0c             	sub    $0xc,%esp
     1ea:	ff 73 04             	pushl  0x4(%ebx)
     1ed:	e8 8e ff ff ff       	call   180 <runcmd>
    close(rcmd->fd);
     1f2:	83 ec 0c             	sub    $0xc,%esp
     1f5:	ff 73 14             	pushl  0x14(%ebx)
     1f8:	e8 7d 0b 00 00       	call   d7a <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     1fd:	59                   	pop    %ecx
     1fe:	58                   	pop    %eax
     1ff:	ff 73 10             	pushl  0x10(%ebx)
     202:	ff 73 08             	pushl  0x8(%ebx)
     205:	e8 88 0b 00 00       	call   d92 <open>
     20a:	83 c4 10             	add    $0x10,%esp
     20d:	85 c0                	test   %eax,%eax
     20f:	79 d6                	jns    1e7 <runcmd+0x67>
      printf(2, "open %s failed\n", rcmd->file);
     211:	52                   	push   %edx
     212:	ff 73 08             	pushl  0x8(%ebx)
     215:	68 12 12 00 00       	push   $0x1212
     21a:	6a 02                	push   $0x2
     21c:	e8 7f 0c 00 00       	call   ea0 <printf>
      exit();
     221:	e8 2c 0b 00 00       	call   d52 <exit>
    if(pipe(p) < 0)
     226:	8d 45 f0             	lea    -0x10(%ebp),%eax
     229:	83 ec 0c             	sub    $0xc,%esp
     22c:	50                   	push   %eax
     22d:	e8 30 0b 00 00       	call   d62 <pipe>
     232:	83 c4 10             	add    $0x10,%esp
     235:	85 c0                	test   %eax,%eax
     237:	0f 88 c8 00 00 00    	js     305 <runcmd+0x185>
  pid = fork(tickets);
     23d:	83 ec 0c             	sub    $0xc,%esp
     240:	6a 08                	push   $0x8
     242:	e8 03 0b 00 00       	call   d4a <fork>
  if(pid == -1)
     247:	83 c4 10             	add    $0x10,%esp
     24a:	83 f8 ff             	cmp    $0xffffffff,%eax
     24d:	74 7b                	je     2ca <runcmd+0x14a>
    if(fork1(NTICKETS) == 0){
     24f:	85 c0                	test   %eax,%eax
     251:	0f 84 bb 00 00 00    	je     312 <runcmd+0x192>
  pid = fork(tickets);
     257:	83 ec 0c             	sub    $0xc,%esp
     25a:	6a 08                	push   $0x8
     25c:	e8 e9 0a 00 00       	call   d4a <fork>
  if(pid == -1)
     261:	83 c4 10             	add    $0x10,%esp
     264:	83 f8 ff             	cmp    $0xffffffff,%eax
     267:	74 61                	je     2ca <runcmd+0x14a>
    if(fork1(NTICKETS) == 0){
     269:	85 c0                	test   %eax,%eax
     26b:	74 6a                	je     2d7 <runcmd+0x157>
    close(p[0]);
     26d:	83 ec 0c             	sub    $0xc,%esp
     270:	ff 75 f0             	pushl  -0x10(%ebp)
     273:	e8 02 0b 00 00       	call   d7a <close>
    close(p[1]);
     278:	58                   	pop    %eax
     279:	ff 75 f4             	pushl  -0xc(%ebp)
     27c:	e8 f9 0a 00 00       	call   d7a <close>
    wait();
     281:	e8 d4 0a 00 00       	call   d5a <wait>
    wait();
     286:	e8 cf 0a 00 00       	call   d5a <wait>
    break;
     28b:	83 c4 10             	add    $0x10,%esp
     28e:	e9 35 ff ff ff       	jmp    1c8 <runcmd+0x48>
  pid = fork(tickets);
     293:	83 ec 0c             	sub    $0xc,%esp
     296:	6a 08                	push   $0x8
     298:	e8 ad 0a 00 00       	call   d4a <fork>
  if(pid == -1)
     29d:	83 c4 10             	add    $0x10,%esp
     2a0:	83 f8 ff             	cmp    $0xffffffff,%eax
     2a3:	74 25                	je     2ca <runcmd+0x14a>
    if(fork1(NTICKETS) == 0)
     2a5:	85 c0                	test   %eax,%eax
     2a7:	0f 84 3a ff ff ff    	je     1e7 <runcmd+0x67>
    wait();
     2ad:	e8 a8 0a 00 00       	call   d5a <wait>
    runcmd(lcmd->right);
     2b2:	83 ec 0c             	sub    $0xc,%esp
     2b5:	ff 73 08             	pushl  0x8(%ebx)
     2b8:	e8 c3 fe ff ff       	call   180 <runcmd>
    panic("runcmd");
     2bd:	83 ec 0c             	sub    $0xc,%esp
     2c0:	68 fb 11 00 00       	push   $0x11fb
     2c5:	e8 96 fe ff ff       	call   160 <panic>
    panic("fork");
     2ca:	83 ec 0c             	sub    $0xc,%esp
     2cd:	68 22 12 00 00       	push   $0x1222
     2d2:	e8 89 fe ff ff       	call   160 <panic>
      close(0);
     2d7:	83 ec 0c             	sub    $0xc,%esp
     2da:	6a 00                	push   $0x0
     2dc:	e8 99 0a 00 00       	call   d7a <close>
      dup(p[0]);
     2e1:	5a                   	pop    %edx
     2e2:	ff 75 f0             	pushl  -0x10(%ebp)
     2e5:	e8 e0 0a 00 00       	call   dca <dup>
      close(p[0]);
     2ea:	59                   	pop    %ecx
     2eb:	ff 75 f0             	pushl  -0x10(%ebp)
     2ee:	e8 87 0a 00 00       	call   d7a <close>
      close(p[1]);
     2f3:	58                   	pop    %eax
     2f4:	ff 75 f4             	pushl  -0xc(%ebp)
     2f7:	e8 7e 0a 00 00       	call   d7a <close>
      runcmd(pcmd->right);
     2fc:	58                   	pop    %eax
     2fd:	ff 73 08             	pushl  0x8(%ebx)
     300:	e8 7b fe ff ff       	call   180 <runcmd>
      panic("pipe");
     305:	83 ec 0c             	sub    $0xc,%esp
     308:	68 27 12 00 00       	push   $0x1227
     30d:	e8 4e fe ff ff       	call   160 <panic>
      close(1);
     312:	83 ec 0c             	sub    $0xc,%esp
     315:	6a 01                	push   $0x1
     317:	e8 5e 0a 00 00       	call   d7a <close>
      dup(p[1]);
     31c:	58                   	pop    %eax
     31d:	ff 75 f4             	pushl  -0xc(%ebp)
     320:	e8 a5 0a 00 00       	call   dca <dup>
      close(p[0]);
     325:	58                   	pop    %eax
     326:	ff 75 f0             	pushl  -0x10(%ebp)
     329:	e8 4c 0a 00 00       	call   d7a <close>
      close(p[1]);
     32e:	58                   	pop    %eax
     32f:	ff 75 f4             	pushl  -0xc(%ebp)
     332:	e8 43 0a 00 00       	call   d7a <close>
      runcmd(pcmd->left);
     337:	58                   	pop    %eax
     338:	ff 73 04             	pushl  0x4(%ebx)
     33b:	e8 40 fe ff ff       	call   180 <runcmd>

00000340 <fork1>:
{
     340:	55                   	push   %ebp
     341:	89 e5                	mov    %esp,%ebp
     343:	83 ec 14             	sub    $0x14,%esp
  pid = fork(tickets);
     346:	ff 75 08             	pushl  0x8(%ebp)
     349:	e8 fc 09 00 00       	call   d4a <fork>
  if(pid == -1)
     34e:	83 c4 10             	add    $0x10,%esp
     351:	83 f8 ff             	cmp    $0xffffffff,%eax
     354:	74 02                	je     358 <fork1+0x18>
  return pid;
}
     356:	c9                   	leave  
     357:	c3                   	ret    
    panic("fork");
     358:	83 ec 0c             	sub    $0xc,%esp
     35b:	68 22 12 00 00       	push   $0x1222
     360:	e8 fb fd ff ff       	call   160 <panic>
     365:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000370 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     370:	55                   	push   %ebp
     371:	89 e5                	mov    %esp,%ebp
     373:	53                   	push   %ebx
     374:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     377:	6a 54                	push   $0x54
     379:	e8 82 0d 00 00       	call   1100 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     37e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     381:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     383:	6a 54                	push   $0x54
     385:	6a 00                	push   $0x0
     387:	50                   	push   %eax
     388:	e8 23 08 00 00       	call   bb0 <memset>
  cmd->type = EXEC;
     38d:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     393:	89 d8                	mov    %ebx,%eax
     395:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     398:	c9                   	leave  
     399:	c3                   	ret    
     39a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003a0 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     3a0:	55                   	push   %ebp
     3a1:	89 e5                	mov    %esp,%ebp
     3a3:	53                   	push   %ebx
     3a4:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3a7:	6a 18                	push   $0x18
     3a9:	e8 52 0d 00 00       	call   1100 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3ae:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     3b1:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3b3:	6a 18                	push   $0x18
     3b5:	6a 00                	push   $0x0
     3b7:	50                   	push   %eax
     3b8:	e8 f3 07 00 00       	call   bb0 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     3bd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     3c0:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     3c6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     3c9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3cc:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     3cf:	8b 45 10             	mov    0x10(%ebp),%eax
     3d2:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     3d5:	8b 45 14             	mov    0x14(%ebp),%eax
     3d8:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     3db:	8b 45 18             	mov    0x18(%ebp),%eax
     3de:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     3e1:	89 d8                	mov    %ebx,%eax
     3e3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3e6:	c9                   	leave  
     3e7:	c3                   	ret    
     3e8:	90                   	nop
     3e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003f0 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     3f0:	55                   	push   %ebp
     3f1:	89 e5                	mov    %esp,%ebp
     3f3:	53                   	push   %ebx
     3f4:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3f7:	6a 0c                	push   $0xc
     3f9:	e8 02 0d 00 00       	call   1100 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3fe:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     401:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     403:	6a 0c                	push   $0xc
     405:	6a 00                	push   $0x0
     407:	50                   	push   %eax
     408:	e8 a3 07 00 00       	call   bb0 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     40d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     410:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     416:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     419:	8b 45 0c             	mov    0xc(%ebp),%eax
     41c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     41f:	89 d8                	mov    %ebx,%eax
     421:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     424:	c9                   	leave  
     425:	c3                   	ret    
     426:	8d 76 00             	lea    0x0(%esi),%esi
     429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000430 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     430:	55                   	push   %ebp
     431:	89 e5                	mov    %esp,%ebp
     433:	53                   	push   %ebx
     434:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     437:	6a 0c                	push   $0xc
     439:	e8 c2 0c 00 00       	call   1100 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     43e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     441:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     443:	6a 0c                	push   $0xc
     445:	6a 00                	push   $0x0
     447:	50                   	push   %eax
     448:	e8 63 07 00 00       	call   bb0 <memset>
  cmd->type = LIST;
  cmd->left = left;
     44d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     450:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     456:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     459:	8b 45 0c             	mov    0xc(%ebp),%eax
     45c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     45f:	89 d8                	mov    %ebx,%eax
     461:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     464:	c9                   	leave  
     465:	c3                   	ret    
     466:	8d 76 00             	lea    0x0(%esi),%esi
     469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000470 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     470:	55                   	push   %ebp
     471:	89 e5                	mov    %esp,%ebp
     473:	53                   	push   %ebx
     474:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     477:	6a 08                	push   $0x8
     479:	e8 82 0c 00 00       	call   1100 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     47e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     481:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     483:	6a 08                	push   $0x8
     485:	6a 00                	push   $0x0
     487:	50                   	push   %eax
     488:	e8 23 07 00 00       	call   bb0 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     48d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     490:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     496:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     499:	89 d8                	mov    %ebx,%eax
     49b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     49e:	c9                   	leave  
     49f:	c3                   	ret    

000004a0 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     4a0:	55                   	push   %ebp
     4a1:	89 e5                	mov    %esp,%ebp
     4a3:	57                   	push   %edi
     4a4:	56                   	push   %esi
     4a5:	53                   	push   %ebx
     4a6:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     4a9:	8b 45 08             	mov    0x8(%ebp),%eax
{
     4ac:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     4af:	8b 7d 10             	mov    0x10(%ebp),%edi
  s = *ps;
     4b2:	8b 30                	mov    (%eax),%esi
  while(s < es && strchr(whitespace, *s))
     4b4:	39 de                	cmp    %ebx,%esi
     4b6:	72 0f                	jb     4c7 <gettoken+0x27>
     4b8:	eb 25                	jmp    4df <gettoken+0x3f>
     4ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     4c0:	83 c6 01             	add    $0x1,%esi
  while(s < es && strchr(whitespace, *s))
     4c3:	39 f3                	cmp    %esi,%ebx
     4c5:	74 18                	je     4df <gettoken+0x3f>
     4c7:	0f be 06             	movsbl (%esi),%eax
     4ca:	83 ec 08             	sub    $0x8,%esp
     4cd:	50                   	push   %eax
     4ce:	68 ac 18 00 00       	push   $0x18ac
     4d3:	e8 f8 06 00 00       	call   bd0 <strchr>
     4d8:	83 c4 10             	add    $0x10,%esp
     4db:	85 c0                	test   %eax,%eax
     4dd:	75 e1                	jne    4c0 <gettoken+0x20>
  if(q)
     4df:	85 ff                	test   %edi,%edi
     4e1:	74 02                	je     4e5 <gettoken+0x45>
    *q = s;
     4e3:	89 37                	mov    %esi,(%edi)
  ret = *s;
     4e5:	0f be 06             	movsbl (%esi),%eax
  switch(*s){
     4e8:	3c 29                	cmp    $0x29,%al
     4ea:	7f 54                	jg     540 <gettoken+0xa0>
     4ec:	3c 28                	cmp    $0x28,%al
     4ee:	0f 8d c8 00 00 00    	jge    5bc <gettoken+0x11c>
     4f4:	31 ff                	xor    %edi,%edi
     4f6:	84 c0                	test   %al,%al
     4f8:	0f 85 d2 00 00 00    	jne    5d0 <gettoken+0x130>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     4fe:	8b 55 14             	mov    0x14(%ebp),%edx
     501:	85 d2                	test   %edx,%edx
     503:	74 05                	je     50a <gettoken+0x6a>
    *eq = s;
     505:	8b 45 14             	mov    0x14(%ebp),%eax
     508:	89 30                	mov    %esi,(%eax)

  while(s < es && strchr(whitespace, *s))
     50a:	39 de                	cmp    %ebx,%esi
     50c:	72 09                	jb     517 <gettoken+0x77>
     50e:	eb 1f                	jmp    52f <gettoken+0x8f>
    s++;
     510:	83 c6 01             	add    $0x1,%esi
  while(s < es && strchr(whitespace, *s))
     513:	39 f3                	cmp    %esi,%ebx
     515:	74 18                	je     52f <gettoken+0x8f>
     517:	0f be 06             	movsbl (%esi),%eax
     51a:	83 ec 08             	sub    $0x8,%esp
     51d:	50                   	push   %eax
     51e:	68 ac 18 00 00       	push   $0x18ac
     523:	e8 a8 06 00 00       	call   bd0 <strchr>
     528:	83 c4 10             	add    $0x10,%esp
     52b:	85 c0                	test   %eax,%eax
     52d:	75 e1                	jne    510 <gettoken+0x70>
  *ps = s;
     52f:	8b 45 08             	mov    0x8(%ebp),%eax
     532:	89 30                	mov    %esi,(%eax)
  return ret;
}
     534:	8d 65 f4             	lea    -0xc(%ebp),%esp
     537:	89 f8                	mov    %edi,%eax
     539:	5b                   	pop    %ebx
     53a:	5e                   	pop    %esi
     53b:	5f                   	pop    %edi
     53c:	5d                   	pop    %ebp
     53d:	c3                   	ret    
     53e:	66 90                	xchg   %ax,%ax
  switch(*s){
     540:	3c 3e                	cmp    $0x3e,%al
     542:	75 1c                	jne    560 <gettoken+0xc0>
    if(*s == '>'){
     544:	80 7e 01 3e          	cmpb   $0x3e,0x1(%esi)
    s++;
     548:	8d 46 01             	lea    0x1(%esi),%eax
    if(*s == '>'){
     54b:	0f 84 a4 00 00 00    	je     5f5 <gettoken+0x155>
    s++;
     551:	89 c6                	mov    %eax,%esi
     553:	bf 3e 00 00 00       	mov    $0x3e,%edi
     558:	eb a4                	jmp    4fe <gettoken+0x5e>
     55a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  switch(*s){
     560:	7f 56                	jg     5b8 <gettoken+0x118>
     562:	8d 48 c5             	lea    -0x3b(%eax),%ecx
     565:	80 f9 01             	cmp    $0x1,%cl
     568:	76 52                	jbe    5bc <gettoken+0x11c>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     56a:	39 f3                	cmp    %esi,%ebx
     56c:	77 24                	ja     592 <gettoken+0xf2>
     56e:	eb 70                	jmp    5e0 <gettoken+0x140>
     570:	0f be 06             	movsbl (%esi),%eax
     573:	83 ec 08             	sub    $0x8,%esp
     576:	50                   	push   %eax
     577:	68 a4 18 00 00       	push   $0x18a4
     57c:	e8 4f 06 00 00       	call   bd0 <strchr>
     581:	83 c4 10             	add    $0x10,%esp
     584:	85 c0                	test   %eax,%eax
     586:	75 1f                	jne    5a7 <gettoken+0x107>
      s++;
     588:	83 c6 01             	add    $0x1,%esi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     58b:	39 f3                	cmp    %esi,%ebx
     58d:	74 51                	je     5e0 <gettoken+0x140>
     58f:	0f be 06             	movsbl (%esi),%eax
     592:	83 ec 08             	sub    $0x8,%esp
     595:	50                   	push   %eax
     596:	68 ac 18 00 00       	push   $0x18ac
     59b:	e8 30 06 00 00       	call   bd0 <strchr>
     5a0:	83 c4 10             	add    $0x10,%esp
     5a3:	85 c0                	test   %eax,%eax
     5a5:	74 c9                	je     570 <gettoken+0xd0>
    ret = 'a';
     5a7:	bf 61 00 00 00       	mov    $0x61,%edi
     5ac:	e9 4d ff ff ff       	jmp    4fe <gettoken+0x5e>
     5b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     5b8:	3c 7c                	cmp    $0x7c,%al
     5ba:	75 ae                	jne    56a <gettoken+0xca>
  ret = *s;
     5bc:	0f be f8             	movsbl %al,%edi
    s++;
     5bf:	83 c6 01             	add    $0x1,%esi
    break;
     5c2:	e9 37 ff ff ff       	jmp    4fe <gettoken+0x5e>
     5c7:	89 f6                	mov    %esi,%esi
     5c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  switch(*s){
     5d0:	3c 26                	cmp    $0x26,%al
     5d2:	75 96                	jne    56a <gettoken+0xca>
     5d4:	eb e6                	jmp    5bc <gettoken+0x11c>
     5d6:	8d 76 00             	lea    0x0(%esi),%esi
     5d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(eq)
     5e0:	8b 45 14             	mov    0x14(%ebp),%eax
     5e3:	bf 61 00 00 00       	mov    $0x61,%edi
     5e8:	85 c0                	test   %eax,%eax
     5ea:	0f 85 15 ff ff ff    	jne    505 <gettoken+0x65>
     5f0:	e9 3a ff ff ff       	jmp    52f <gettoken+0x8f>
      s++;
     5f5:	83 c6 02             	add    $0x2,%esi
      ret = '+';
     5f8:	bf 2b 00 00 00       	mov    $0x2b,%edi
     5fd:	e9 fc fe ff ff       	jmp    4fe <gettoken+0x5e>
     602:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000610 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     610:	55                   	push   %ebp
     611:	89 e5                	mov    %esp,%ebp
     613:	57                   	push   %edi
     614:	56                   	push   %esi
     615:	53                   	push   %ebx
     616:	83 ec 0c             	sub    $0xc,%esp
     619:	8b 7d 08             	mov    0x8(%ebp),%edi
     61c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     61f:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     621:	39 f3                	cmp    %esi,%ebx
     623:	72 12                	jb     637 <peek+0x27>
     625:	eb 28                	jmp    64f <peek+0x3f>
     627:	89 f6                	mov    %esi,%esi
     629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    s++;
     630:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     633:	39 de                	cmp    %ebx,%esi
     635:	74 18                	je     64f <peek+0x3f>
     637:	0f be 03             	movsbl (%ebx),%eax
     63a:	83 ec 08             	sub    $0x8,%esp
     63d:	50                   	push   %eax
     63e:	68 ac 18 00 00       	push   $0x18ac
     643:	e8 88 05 00 00       	call   bd0 <strchr>
     648:	83 c4 10             	add    $0x10,%esp
     64b:	85 c0                	test   %eax,%eax
     64d:	75 e1                	jne    630 <peek+0x20>
  *ps = s;
     64f:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     651:	0f be 13             	movsbl (%ebx),%edx
     654:	31 c0                	xor    %eax,%eax
     656:	84 d2                	test   %dl,%dl
     658:	74 17                	je     671 <peek+0x61>
     65a:	83 ec 08             	sub    $0x8,%esp
     65d:	52                   	push   %edx
     65e:	ff 75 10             	pushl  0x10(%ebp)
     661:	e8 6a 05 00 00       	call   bd0 <strchr>
     666:	83 c4 10             	add    $0x10,%esp
     669:	85 c0                	test   %eax,%eax
     66b:	0f 95 c0             	setne  %al
     66e:	0f b6 c0             	movzbl %al,%eax
}
     671:	8d 65 f4             	lea    -0xc(%ebp),%esp
     674:	5b                   	pop    %ebx
     675:	5e                   	pop    %esi
     676:	5f                   	pop    %edi
     677:	5d                   	pop    %ebp
     678:	c3                   	ret    
     679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000680 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     680:	55                   	push   %ebp
     681:	89 e5                	mov    %esp,%ebp
     683:	57                   	push   %edi
     684:	56                   	push   %esi
     685:	53                   	push   %ebx
     686:	83 ec 1c             	sub    $0x1c,%esp
     689:	8b 75 0c             	mov    0xc(%ebp),%esi
     68c:	8b 5d 10             	mov    0x10(%ebp),%ebx
     68f:	90                   	nop
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     690:	83 ec 04             	sub    $0x4,%esp
     693:	68 49 12 00 00       	push   $0x1249
     698:	53                   	push   %ebx
     699:	56                   	push   %esi
     69a:	e8 71 ff ff ff       	call   610 <peek>
     69f:	83 c4 10             	add    $0x10,%esp
     6a2:	85 c0                	test   %eax,%eax
     6a4:	74 6a                	je     710 <parseredirs+0x90>
    tok = gettoken(ps, es, 0, 0);
     6a6:	6a 00                	push   $0x0
     6a8:	6a 00                	push   $0x0
     6aa:	53                   	push   %ebx
     6ab:	56                   	push   %esi
     6ac:	e8 ef fd ff ff       	call   4a0 <gettoken>
     6b1:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     6b3:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     6b6:	50                   	push   %eax
     6b7:	8d 45 e0             	lea    -0x20(%ebp),%eax
     6ba:	50                   	push   %eax
     6bb:	53                   	push   %ebx
     6bc:	56                   	push   %esi
     6bd:	e8 de fd ff ff       	call   4a0 <gettoken>
     6c2:	83 c4 20             	add    $0x20,%esp
     6c5:	83 f8 61             	cmp    $0x61,%eax
     6c8:	75 51                	jne    71b <parseredirs+0x9b>
      panic("missing file for redirection");
    switch(tok){
     6ca:	83 ff 3c             	cmp    $0x3c,%edi
     6cd:	74 31                	je     700 <parseredirs+0x80>
     6cf:	83 ff 3e             	cmp    $0x3e,%edi
     6d2:	74 05                	je     6d9 <parseredirs+0x59>
     6d4:	83 ff 2b             	cmp    $0x2b,%edi
     6d7:	75 b7                	jne    690 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     6d9:	83 ec 0c             	sub    $0xc,%esp
     6dc:	6a 01                	push   $0x1
     6de:	68 01 02 00 00       	push   $0x201
     6e3:	ff 75 e4             	pushl  -0x1c(%ebp)
     6e6:	ff 75 e0             	pushl  -0x20(%ebp)
     6e9:	ff 75 08             	pushl  0x8(%ebp)
     6ec:	e8 af fc ff ff       	call   3a0 <redircmd>
      break;
     6f1:	83 c4 20             	add    $0x20,%esp
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     6f4:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     6f7:	eb 97                	jmp    690 <parseredirs+0x10>
     6f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     700:	83 ec 0c             	sub    $0xc,%esp
     703:	6a 00                	push   $0x0
     705:	6a 00                	push   $0x0
     707:	eb da                	jmp    6e3 <parseredirs+0x63>
     709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }
  return cmd;
}
     710:	8b 45 08             	mov    0x8(%ebp),%eax
     713:	8d 65 f4             	lea    -0xc(%ebp),%esp
     716:	5b                   	pop    %ebx
     717:	5e                   	pop    %esi
     718:	5f                   	pop    %edi
     719:	5d                   	pop    %ebp
     71a:	c3                   	ret    
      panic("missing file for redirection");
     71b:	83 ec 0c             	sub    $0xc,%esp
     71e:	68 2c 12 00 00       	push   $0x122c
     723:	e8 38 fa ff ff       	call   160 <panic>
     728:	90                   	nop
     729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000730 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     730:	55                   	push   %ebp
     731:	89 e5                	mov    %esp,%ebp
     733:	57                   	push   %edi
     734:	56                   	push   %esi
     735:	53                   	push   %ebx
     736:	83 ec 30             	sub    $0x30,%esp
     739:	8b 75 08             	mov    0x8(%ebp),%esi
     73c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     73f:	68 4c 12 00 00       	push   $0x124c
     744:	57                   	push   %edi
     745:	56                   	push   %esi
     746:	e8 c5 fe ff ff       	call   610 <peek>
     74b:	83 c4 10             	add    $0x10,%esp
     74e:	85 c0                	test   %eax,%eax
     750:	0f 85 92 00 00 00    	jne    7e8 <parseexec+0xb8>
     756:	89 c3                	mov    %eax,%ebx
    return parseblock(ps, es);

  ret = execcmd();
     758:	e8 13 fc ff ff       	call   370 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     75d:	83 ec 04             	sub    $0x4,%esp
  ret = execcmd();
     760:	89 45 d0             	mov    %eax,-0x30(%ebp)
  ret = parseredirs(ret, ps, es);
     763:	57                   	push   %edi
     764:	56                   	push   %esi
     765:	50                   	push   %eax
     766:	e8 15 ff ff ff       	call   680 <parseredirs>
     76b:	83 c4 10             	add    $0x10,%esp
     76e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     771:	eb 18                	jmp    78b <parseexec+0x5b>
     773:	90                   	nop
     774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     778:	83 ec 04             	sub    $0x4,%esp
     77b:	57                   	push   %edi
     77c:	56                   	push   %esi
     77d:	ff 75 d4             	pushl  -0x2c(%ebp)
     780:	e8 fb fe ff ff       	call   680 <parseredirs>
     785:	83 c4 10             	add    $0x10,%esp
     788:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     78b:	83 ec 04             	sub    $0x4,%esp
     78e:	68 63 12 00 00       	push   $0x1263
     793:	57                   	push   %edi
     794:	56                   	push   %esi
     795:	e8 76 fe ff ff       	call   610 <peek>
     79a:	83 c4 10             	add    $0x10,%esp
     79d:	85 c0                	test   %eax,%eax
     79f:	75 67                	jne    808 <parseexec+0xd8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     7a1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     7a4:	50                   	push   %eax
     7a5:	8d 45 e0             	lea    -0x20(%ebp),%eax
     7a8:	50                   	push   %eax
     7a9:	57                   	push   %edi
     7aa:	56                   	push   %esi
     7ab:	e8 f0 fc ff ff       	call   4a0 <gettoken>
     7b0:	83 c4 10             	add    $0x10,%esp
     7b3:	85 c0                	test   %eax,%eax
     7b5:	74 51                	je     808 <parseexec+0xd8>
    if(tok != 'a')
     7b7:	83 f8 61             	cmp    $0x61,%eax
     7ba:	75 6b                	jne    827 <parseexec+0xf7>
    cmd->argv[argc] = q;
     7bc:	8b 45 e0             	mov    -0x20(%ebp),%eax
     7bf:	8b 55 d0             	mov    -0x30(%ebp),%edx
     7c2:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
    cmd->eargv[argc] = eq;
     7c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7c9:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
    argc++;
     7cd:	83 c3 01             	add    $0x1,%ebx
    if(argc >= MAXARGS)
     7d0:	83 fb 0a             	cmp    $0xa,%ebx
     7d3:	75 a3                	jne    778 <parseexec+0x48>
      panic("too many args");
     7d5:	83 ec 0c             	sub    $0xc,%esp
     7d8:	68 55 12 00 00       	push   $0x1255
     7dd:	e8 7e f9 ff ff       	call   160 <panic>
     7e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     7e8:	83 ec 08             	sub    $0x8,%esp
     7eb:	57                   	push   %edi
     7ec:	56                   	push   %esi
     7ed:	e8 5e 01 00 00       	call   950 <parseblock>
     7f2:	83 c4 10             	add    $0x10,%esp
     7f5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     7f8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     7fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7fe:	5b                   	pop    %ebx
     7ff:	5e                   	pop    %esi
     800:	5f                   	pop    %edi
     801:	5d                   	pop    %ebp
     802:	c3                   	ret    
     803:	90                   	nop
     804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     808:	8b 45 d0             	mov    -0x30(%ebp),%eax
     80b:	8d 04 98             	lea    (%eax,%ebx,4),%eax
  cmd->argv[argc] = 0;
     80e:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  cmd->eargv[argc] = 0;
     815:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
}
     81c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     81f:	8d 65 f4             	lea    -0xc(%ebp),%esp
     822:	5b                   	pop    %ebx
     823:	5e                   	pop    %esi
     824:	5f                   	pop    %edi
     825:	5d                   	pop    %ebp
     826:	c3                   	ret    
      panic("syntax");
     827:	83 ec 0c             	sub    $0xc,%esp
     82a:	68 4e 12 00 00       	push   $0x124e
     82f:	e8 2c f9 ff ff       	call   160 <panic>
     834:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     83a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000840 <parsepipe>:
{
     840:	55                   	push   %ebp
     841:	89 e5                	mov    %esp,%ebp
     843:	57                   	push   %edi
     844:	56                   	push   %esi
     845:	53                   	push   %ebx
     846:	83 ec 14             	sub    $0x14,%esp
     849:	8b 5d 08             	mov    0x8(%ebp),%ebx
     84c:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parseexec(ps, es);
     84f:	56                   	push   %esi
     850:	53                   	push   %ebx
     851:	e8 da fe ff ff       	call   730 <parseexec>
  if(peek(ps, es, "|")){
     856:	83 c4 0c             	add    $0xc,%esp
  cmd = parseexec(ps, es);
     859:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
     85b:	68 68 12 00 00       	push   $0x1268
     860:	56                   	push   %esi
     861:	53                   	push   %ebx
     862:	e8 a9 fd ff ff       	call   610 <peek>
     867:	83 c4 10             	add    $0x10,%esp
     86a:	85 c0                	test   %eax,%eax
     86c:	75 12                	jne    880 <parsepipe+0x40>
}
     86e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     871:	89 f8                	mov    %edi,%eax
     873:	5b                   	pop    %ebx
     874:	5e                   	pop    %esi
     875:	5f                   	pop    %edi
     876:	5d                   	pop    %ebp
     877:	c3                   	ret    
     878:	90                   	nop
     879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    gettoken(ps, es, 0, 0);
     880:	6a 00                	push   $0x0
     882:	6a 00                	push   $0x0
     884:	56                   	push   %esi
     885:	53                   	push   %ebx
     886:	e8 15 fc ff ff       	call   4a0 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     88b:	58                   	pop    %eax
     88c:	5a                   	pop    %edx
     88d:	56                   	push   %esi
     88e:	53                   	push   %ebx
     88f:	e8 ac ff ff ff       	call   840 <parsepipe>
     894:	89 7d 08             	mov    %edi,0x8(%ebp)
     897:	89 45 0c             	mov    %eax,0xc(%ebp)
     89a:	83 c4 10             	add    $0x10,%esp
}
     89d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8a0:	5b                   	pop    %ebx
     8a1:	5e                   	pop    %esi
     8a2:	5f                   	pop    %edi
     8a3:	5d                   	pop    %ebp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     8a4:	e9 47 fb ff ff       	jmp    3f0 <pipecmd>
     8a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008b0 <parseline>:
{
     8b0:	55                   	push   %ebp
     8b1:	89 e5                	mov    %esp,%ebp
     8b3:	57                   	push   %edi
     8b4:	56                   	push   %esi
     8b5:	53                   	push   %ebx
     8b6:	83 ec 14             	sub    $0x14,%esp
     8b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     8bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parsepipe(ps, es);
     8bf:	56                   	push   %esi
     8c0:	53                   	push   %ebx
     8c1:	e8 7a ff ff ff       	call   840 <parsepipe>
  while(peek(ps, es, "&")){
     8c6:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     8c9:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     8cb:	eb 1b                	jmp    8e8 <parseline+0x38>
     8cd:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     8d0:	6a 00                	push   $0x0
     8d2:	6a 00                	push   $0x0
     8d4:	56                   	push   %esi
     8d5:	53                   	push   %ebx
     8d6:	e8 c5 fb ff ff       	call   4a0 <gettoken>
    cmd = backcmd(cmd);
     8db:	89 3c 24             	mov    %edi,(%esp)
     8de:	e8 8d fb ff ff       	call   470 <backcmd>
     8e3:	83 c4 10             	add    $0x10,%esp
     8e6:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     8e8:	83 ec 04             	sub    $0x4,%esp
     8eb:	68 6a 12 00 00       	push   $0x126a
     8f0:	56                   	push   %esi
     8f1:	53                   	push   %ebx
     8f2:	e8 19 fd ff ff       	call   610 <peek>
     8f7:	83 c4 10             	add    $0x10,%esp
     8fa:	85 c0                	test   %eax,%eax
     8fc:	75 d2                	jne    8d0 <parseline+0x20>
  if(peek(ps, es, ";")){
     8fe:	83 ec 04             	sub    $0x4,%esp
     901:	68 66 12 00 00       	push   $0x1266
     906:	56                   	push   %esi
     907:	53                   	push   %ebx
     908:	e8 03 fd ff ff       	call   610 <peek>
     90d:	83 c4 10             	add    $0x10,%esp
     910:	85 c0                	test   %eax,%eax
     912:	75 0c                	jne    920 <parseline+0x70>
}
     914:	8d 65 f4             	lea    -0xc(%ebp),%esp
     917:	89 f8                	mov    %edi,%eax
     919:	5b                   	pop    %ebx
     91a:	5e                   	pop    %esi
     91b:	5f                   	pop    %edi
     91c:	5d                   	pop    %ebp
     91d:	c3                   	ret    
     91e:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     920:	6a 00                	push   $0x0
     922:	6a 00                	push   $0x0
     924:	56                   	push   %esi
     925:	53                   	push   %ebx
     926:	e8 75 fb ff ff       	call   4a0 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     92b:	58                   	pop    %eax
     92c:	5a                   	pop    %edx
     92d:	56                   	push   %esi
     92e:	53                   	push   %ebx
     92f:	e8 7c ff ff ff       	call   8b0 <parseline>
     934:	89 7d 08             	mov    %edi,0x8(%ebp)
     937:	89 45 0c             	mov    %eax,0xc(%ebp)
     93a:	83 c4 10             	add    $0x10,%esp
}
     93d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     940:	5b                   	pop    %ebx
     941:	5e                   	pop    %esi
     942:	5f                   	pop    %edi
     943:	5d                   	pop    %ebp
    cmd = listcmd(cmd, parseline(ps, es));
     944:	e9 e7 fa ff ff       	jmp    430 <listcmd>
     949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000950 <parseblock>:
{
     950:	55                   	push   %ebp
     951:	89 e5                	mov    %esp,%ebp
     953:	57                   	push   %edi
     954:	56                   	push   %esi
     955:	53                   	push   %ebx
     956:	83 ec 10             	sub    $0x10,%esp
     959:	8b 5d 08             	mov    0x8(%ebp),%ebx
     95c:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     95f:	68 4c 12 00 00       	push   $0x124c
     964:	56                   	push   %esi
     965:	53                   	push   %ebx
     966:	e8 a5 fc ff ff       	call   610 <peek>
     96b:	83 c4 10             	add    $0x10,%esp
     96e:	85 c0                	test   %eax,%eax
     970:	74 4a                	je     9bc <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     972:	6a 00                	push   $0x0
     974:	6a 00                	push   $0x0
     976:	56                   	push   %esi
     977:	53                   	push   %ebx
     978:	e8 23 fb ff ff       	call   4a0 <gettoken>
  cmd = parseline(ps, es);
     97d:	58                   	pop    %eax
     97e:	5a                   	pop    %edx
     97f:	56                   	push   %esi
     980:	53                   	push   %ebx
     981:	e8 2a ff ff ff       	call   8b0 <parseline>
  if(!peek(ps, es, ")"))
     986:	83 c4 0c             	add    $0xc,%esp
  cmd = parseline(ps, es);
     989:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     98b:	68 88 12 00 00       	push   $0x1288
     990:	56                   	push   %esi
     991:	53                   	push   %ebx
     992:	e8 79 fc ff ff       	call   610 <peek>
     997:	83 c4 10             	add    $0x10,%esp
     99a:	85 c0                	test   %eax,%eax
     99c:	74 2b                	je     9c9 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     99e:	6a 00                	push   $0x0
     9a0:	6a 00                	push   $0x0
     9a2:	56                   	push   %esi
     9a3:	53                   	push   %ebx
     9a4:	e8 f7 fa ff ff       	call   4a0 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     9a9:	83 c4 0c             	add    $0xc,%esp
     9ac:	56                   	push   %esi
     9ad:	53                   	push   %ebx
     9ae:	57                   	push   %edi
     9af:	e8 cc fc ff ff       	call   680 <parseredirs>
}
     9b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     9b7:	5b                   	pop    %ebx
     9b8:	5e                   	pop    %esi
     9b9:	5f                   	pop    %edi
     9ba:	5d                   	pop    %ebp
     9bb:	c3                   	ret    
    panic("parseblock");
     9bc:	83 ec 0c             	sub    $0xc,%esp
     9bf:	68 6c 12 00 00       	push   $0x126c
     9c4:	e8 97 f7 ff ff       	call   160 <panic>
    panic("syntax - missing )");
     9c9:	83 ec 0c             	sub    $0xc,%esp
     9cc:	68 77 12 00 00       	push   $0x1277
     9d1:	e8 8a f7 ff ff       	call   160 <panic>
     9d6:	8d 76 00             	lea    0x0(%esi),%esi
     9d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009e0 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     9e0:	55                   	push   %ebp
     9e1:	89 e5                	mov    %esp,%ebp
     9e3:	53                   	push   %ebx
     9e4:	83 ec 04             	sub    $0x4,%esp
     9e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     9ea:	85 db                	test   %ebx,%ebx
     9ec:	74 20                	je     a0e <nulterminate+0x2e>
    return 0;

  switch(cmd->type){
     9ee:	83 3b 05             	cmpl   $0x5,(%ebx)
     9f1:	77 1b                	ja     a0e <nulterminate+0x2e>
     9f3:	8b 03                	mov    (%ebx),%eax
     9f5:	ff 24 85 c8 12 00 00 	jmp    *0x12c8(,%eax,4)
     9fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
     a00:	83 ec 0c             	sub    $0xc,%esp
     a03:	ff 73 04             	pushl  0x4(%ebx)
     a06:	e8 d5 ff ff ff       	call   9e0 <nulterminate>
    break;
     a0b:	83 c4 10             	add    $0x10,%esp
  }
  return cmd;
}
     a0e:	89 d8                	mov    %ebx,%eax
     a10:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a13:	c9                   	leave  
     a14:	c3                   	ret    
     a15:	8d 76 00             	lea    0x0(%esi),%esi
    nulterminate(lcmd->left);
     a18:	83 ec 0c             	sub    $0xc,%esp
     a1b:	ff 73 04             	pushl  0x4(%ebx)
     a1e:	e8 bd ff ff ff       	call   9e0 <nulterminate>
    nulterminate(lcmd->right);
     a23:	58                   	pop    %eax
     a24:	ff 73 08             	pushl  0x8(%ebx)
     a27:	e8 b4 ff ff ff       	call   9e0 <nulterminate>
}
     a2c:	89 d8                	mov    %ebx,%eax
    break;
     a2e:	83 c4 10             	add    $0x10,%esp
}
     a31:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a34:	c9                   	leave  
     a35:	c3                   	ret    
     a36:	8d 76 00             	lea    0x0(%esi),%esi
     a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for(i=0; ecmd->argv[i]; i++)
     a40:	8b 4b 04             	mov    0x4(%ebx),%ecx
     a43:	8d 43 08             	lea    0x8(%ebx),%eax
     a46:	85 c9                	test   %ecx,%ecx
     a48:	74 c4                	je     a0e <nulterminate+0x2e>
     a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     a50:	8b 50 24             	mov    0x24(%eax),%edx
     a53:	83 c0 04             	add    $0x4,%eax
     a56:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     a59:	8b 50 fc             	mov    -0x4(%eax),%edx
     a5c:	85 d2                	test   %edx,%edx
     a5e:	75 f0                	jne    a50 <nulterminate+0x70>
}
     a60:	89 d8                	mov    %ebx,%eax
     a62:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a65:	c9                   	leave  
     a66:	c3                   	ret    
     a67:	89 f6                	mov    %esi,%esi
     a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    nulterminate(rcmd->cmd);
     a70:	83 ec 0c             	sub    $0xc,%esp
     a73:	ff 73 04             	pushl  0x4(%ebx)
     a76:	e8 65 ff ff ff       	call   9e0 <nulterminate>
    *rcmd->efile = 0;
     a7b:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     a7e:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     a81:	c6 00 00             	movb   $0x0,(%eax)
}
     a84:	89 d8                	mov    %ebx,%eax
     a86:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a89:	c9                   	leave  
     a8a:	c3                   	ret    
     a8b:	90                   	nop
     a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a90 <parsecmd>:
{
     a90:	55                   	push   %ebp
     a91:	89 e5                	mov    %esp,%ebp
     a93:	56                   	push   %esi
     a94:	53                   	push   %ebx
  es = s + strlen(s);
     a95:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a98:	83 ec 0c             	sub    $0xc,%esp
     a9b:	53                   	push   %ebx
     a9c:	e8 df 00 00 00       	call   b80 <strlen>
  cmd = parseline(&s, es);
     aa1:	59                   	pop    %ecx
  es = s + strlen(s);
     aa2:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     aa4:	8d 45 08             	lea    0x8(%ebp),%eax
     aa7:	5e                   	pop    %esi
     aa8:	53                   	push   %ebx
     aa9:	50                   	push   %eax
     aaa:	e8 01 fe ff ff       	call   8b0 <parseline>
     aaf:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     ab1:	8d 45 08             	lea    0x8(%ebp),%eax
     ab4:	83 c4 0c             	add    $0xc,%esp
     ab7:	68 11 12 00 00       	push   $0x1211
     abc:	53                   	push   %ebx
     abd:	50                   	push   %eax
     abe:	e8 4d fb ff ff       	call   610 <peek>
  if(s != es){
     ac3:	8b 45 08             	mov    0x8(%ebp),%eax
     ac6:	83 c4 10             	add    $0x10,%esp
     ac9:	39 d8                	cmp    %ebx,%eax
     acb:	75 12                	jne    adf <parsecmd+0x4f>
  nulterminate(cmd);
     acd:	83 ec 0c             	sub    $0xc,%esp
     ad0:	56                   	push   %esi
     ad1:	e8 0a ff ff ff       	call   9e0 <nulterminate>
}
     ad6:	8d 65 f8             	lea    -0x8(%ebp),%esp
     ad9:	89 f0                	mov    %esi,%eax
     adb:	5b                   	pop    %ebx
     adc:	5e                   	pop    %esi
     add:	5d                   	pop    %ebp
     ade:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
     adf:	52                   	push   %edx
     ae0:	50                   	push   %eax
     ae1:	68 8a 12 00 00       	push   $0x128a
     ae6:	6a 02                	push   $0x2
     ae8:	e8 b3 03 00 00       	call   ea0 <printf>
    panic("syntax");
     aed:	c7 04 24 4e 12 00 00 	movl   $0x124e,(%esp)
     af4:	e8 67 f6 ff ff       	call   160 <panic>
     af9:	66 90                	xchg   %ax,%ax
     afb:	66 90                	xchg   %ax,%ax
     afd:	66 90                	xchg   %ax,%ax
     aff:	90                   	nop

00000b00 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     b00:	55                   	push   %ebp
     b01:	89 e5                	mov    %esp,%ebp
     b03:	53                   	push   %ebx
     b04:	8b 45 08             	mov    0x8(%ebp),%eax
     b07:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     b0a:	89 c2                	mov    %eax,%edx
     b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     b10:	83 c1 01             	add    $0x1,%ecx
     b13:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     b17:	83 c2 01             	add    $0x1,%edx
     b1a:	84 db                	test   %bl,%bl
     b1c:	88 5a ff             	mov    %bl,-0x1(%edx)
     b1f:	75 ef                	jne    b10 <strcpy+0x10>
    ;
  return os;
}
     b21:	5b                   	pop    %ebx
     b22:	5d                   	pop    %ebp
     b23:	c3                   	ret    
     b24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b30 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     b30:	55                   	push   %ebp
     b31:	89 e5                	mov    %esp,%ebp
     b33:	53                   	push   %ebx
     b34:	8b 55 08             	mov    0x8(%ebp),%edx
     b37:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     b3a:	0f b6 02             	movzbl (%edx),%eax
     b3d:	0f b6 19             	movzbl (%ecx),%ebx
     b40:	84 c0                	test   %al,%al
     b42:	75 1c                	jne    b60 <strcmp+0x30>
     b44:	eb 2a                	jmp    b70 <strcmp+0x40>
     b46:	8d 76 00             	lea    0x0(%esi),%esi
     b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     b50:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
     b53:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     b56:	83 c1 01             	add    $0x1,%ecx
     b59:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
     b5c:	84 c0                	test   %al,%al
     b5e:	74 10                	je     b70 <strcmp+0x40>
     b60:	38 d8                	cmp    %bl,%al
     b62:	74 ec                	je     b50 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
     b64:	29 d8                	sub    %ebx,%eax
}
     b66:	5b                   	pop    %ebx
     b67:	5d                   	pop    %ebp
     b68:	c3                   	ret    
     b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b70:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     b72:	29 d8                	sub    %ebx,%eax
}
     b74:	5b                   	pop    %ebx
     b75:	5d                   	pop    %ebp
     b76:	c3                   	ret    
     b77:	89 f6                	mov    %esi,%esi
     b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b80 <strlen>:

uint
strlen(const char *s)
{
     b80:	55                   	push   %ebp
     b81:	89 e5                	mov    %esp,%ebp
     b83:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     b86:	80 39 00             	cmpb   $0x0,(%ecx)
     b89:	74 15                	je     ba0 <strlen+0x20>
     b8b:	31 d2                	xor    %edx,%edx
     b8d:	8d 76 00             	lea    0x0(%esi),%esi
     b90:	83 c2 01             	add    $0x1,%edx
     b93:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     b97:	89 d0                	mov    %edx,%eax
     b99:	75 f5                	jne    b90 <strlen+0x10>
    ;
  return n;
}
     b9b:	5d                   	pop    %ebp
     b9c:	c3                   	ret    
     b9d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
     ba0:	31 c0                	xor    %eax,%eax
}
     ba2:	5d                   	pop    %ebp
     ba3:	c3                   	ret    
     ba4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     baa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000bb0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	57                   	push   %edi
     bb4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     bb7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     bba:	8b 45 0c             	mov    0xc(%ebp),%eax
     bbd:	89 d7                	mov    %edx,%edi
     bbf:	fc                   	cld    
     bc0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     bc2:	89 d0                	mov    %edx,%eax
     bc4:	5f                   	pop    %edi
     bc5:	5d                   	pop    %ebp
     bc6:	c3                   	ret    
     bc7:	89 f6                	mov    %esi,%esi
     bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bd0 <strchr>:

char*
strchr(const char *s, char c)
{
     bd0:	55                   	push   %ebp
     bd1:	89 e5                	mov    %esp,%ebp
     bd3:	53                   	push   %ebx
     bd4:	8b 45 08             	mov    0x8(%ebp),%eax
     bd7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
     bda:	0f b6 10             	movzbl (%eax),%edx
     bdd:	84 d2                	test   %dl,%dl
     bdf:	74 1d                	je     bfe <strchr+0x2e>
    if(*s == c)
     be1:	38 d3                	cmp    %dl,%bl
     be3:	89 d9                	mov    %ebx,%ecx
     be5:	75 0d                	jne    bf4 <strchr+0x24>
     be7:	eb 17                	jmp    c00 <strchr+0x30>
     be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bf0:	38 ca                	cmp    %cl,%dl
     bf2:	74 0c                	je     c00 <strchr+0x30>
  for(; *s; s++)
     bf4:	83 c0 01             	add    $0x1,%eax
     bf7:	0f b6 10             	movzbl (%eax),%edx
     bfa:	84 d2                	test   %dl,%dl
     bfc:	75 f2                	jne    bf0 <strchr+0x20>
      return (char*)s;
  return 0;
     bfe:	31 c0                	xor    %eax,%eax
}
     c00:	5b                   	pop    %ebx
     c01:	5d                   	pop    %ebp
     c02:	c3                   	ret    
     c03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c10 <gets>:

char*
gets(char *buf, int max)
{
     c10:	55                   	push   %ebp
     c11:	89 e5                	mov    %esp,%ebp
     c13:	57                   	push   %edi
     c14:	56                   	push   %esi
     c15:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c16:	31 f6                	xor    %esi,%esi
     c18:	89 f3                	mov    %esi,%ebx
{
     c1a:	83 ec 1c             	sub    $0x1c,%esp
     c1d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
     c20:	eb 2f                	jmp    c51 <gets+0x41>
     c22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
     c28:	8d 45 e7             	lea    -0x19(%ebp),%eax
     c2b:	83 ec 04             	sub    $0x4,%esp
     c2e:	6a 01                	push   $0x1
     c30:	50                   	push   %eax
     c31:	6a 00                	push   $0x0
     c33:	e8 32 01 00 00       	call   d6a <read>
    if(cc < 1)
     c38:	83 c4 10             	add    $0x10,%esp
     c3b:	85 c0                	test   %eax,%eax
     c3d:	7e 1c                	jle    c5b <gets+0x4b>
      break;
    buf[i++] = c;
     c3f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     c43:	83 c7 01             	add    $0x1,%edi
     c46:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
     c49:	3c 0a                	cmp    $0xa,%al
     c4b:	74 23                	je     c70 <gets+0x60>
     c4d:	3c 0d                	cmp    $0xd,%al
     c4f:	74 1f                	je     c70 <gets+0x60>
  for(i=0; i+1 < max; ){
     c51:	83 c3 01             	add    $0x1,%ebx
     c54:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     c57:	89 fe                	mov    %edi,%esi
     c59:	7c cd                	jl     c28 <gets+0x18>
     c5b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
     c5d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
     c60:	c6 03 00             	movb   $0x0,(%ebx)
}
     c63:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c66:	5b                   	pop    %ebx
     c67:	5e                   	pop    %esi
     c68:	5f                   	pop    %edi
     c69:	5d                   	pop    %ebp
     c6a:	c3                   	ret    
     c6b:	90                   	nop
     c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c70:	8b 75 08             	mov    0x8(%ebp),%esi
     c73:	8b 45 08             	mov    0x8(%ebp),%eax
     c76:	01 de                	add    %ebx,%esi
     c78:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
     c7a:	c6 03 00             	movb   $0x0,(%ebx)
}
     c7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c80:	5b                   	pop    %ebx
     c81:	5e                   	pop    %esi
     c82:	5f                   	pop    %edi
     c83:	5d                   	pop    %ebp
     c84:	c3                   	ret    
     c85:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c90 <stat>:

int
stat(const char *n, struct stat *st)
{
     c90:	55                   	push   %ebp
     c91:	89 e5                	mov    %esp,%ebp
     c93:	56                   	push   %esi
     c94:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     c95:	83 ec 08             	sub    $0x8,%esp
     c98:	6a 00                	push   $0x0
     c9a:	ff 75 08             	pushl  0x8(%ebp)
     c9d:	e8 f0 00 00 00       	call   d92 <open>
  if(fd < 0)
     ca2:	83 c4 10             	add    $0x10,%esp
     ca5:	85 c0                	test   %eax,%eax
     ca7:	78 27                	js     cd0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     ca9:	83 ec 08             	sub    $0x8,%esp
     cac:	ff 75 0c             	pushl  0xc(%ebp)
     caf:	89 c3                	mov    %eax,%ebx
     cb1:	50                   	push   %eax
     cb2:	e8 f3 00 00 00       	call   daa <fstat>
  close(fd);
     cb7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     cba:	89 c6                	mov    %eax,%esi
  close(fd);
     cbc:	e8 b9 00 00 00       	call   d7a <close>
  return r;
     cc1:	83 c4 10             	add    $0x10,%esp
}
     cc4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     cc7:	89 f0                	mov    %esi,%eax
     cc9:	5b                   	pop    %ebx
     cca:	5e                   	pop    %esi
     ccb:	5d                   	pop    %ebp
     ccc:	c3                   	ret    
     ccd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     cd0:	be ff ff ff ff       	mov    $0xffffffff,%esi
     cd5:	eb ed                	jmp    cc4 <stat+0x34>
     cd7:	89 f6                	mov    %esi,%esi
     cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ce0 <atoi>:

int
atoi(const char *s)
{
     ce0:	55                   	push   %ebp
     ce1:	89 e5                	mov    %esp,%ebp
     ce3:	53                   	push   %ebx
     ce4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     ce7:	0f be 11             	movsbl (%ecx),%edx
     cea:	8d 42 d0             	lea    -0x30(%edx),%eax
     ced:	3c 09                	cmp    $0x9,%al
  n = 0;
     cef:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
     cf4:	77 1f                	ja     d15 <atoi+0x35>
     cf6:	8d 76 00             	lea    0x0(%esi),%esi
     cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
     d00:	8d 04 80             	lea    (%eax,%eax,4),%eax
     d03:	83 c1 01             	add    $0x1,%ecx
     d06:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     d0a:	0f be 11             	movsbl (%ecx),%edx
     d0d:	8d 5a d0             	lea    -0x30(%edx),%ebx
     d10:	80 fb 09             	cmp    $0x9,%bl
     d13:	76 eb                	jbe    d00 <atoi+0x20>
  return n;
}
     d15:	5b                   	pop    %ebx
     d16:	5d                   	pop    %ebp
     d17:	c3                   	ret    
     d18:	90                   	nop
     d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d20 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     d20:	55                   	push   %ebp
     d21:	89 e5                	mov    %esp,%ebp
     d23:	56                   	push   %esi
     d24:	53                   	push   %ebx
     d25:	8b 5d 10             	mov    0x10(%ebp),%ebx
     d28:	8b 45 08             	mov    0x8(%ebp),%eax
     d2b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     d2e:	85 db                	test   %ebx,%ebx
     d30:	7e 14                	jle    d46 <memmove+0x26>
     d32:	31 d2                	xor    %edx,%edx
     d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     d38:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     d3c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     d3f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
     d42:	39 d3                	cmp    %edx,%ebx
     d44:	75 f2                	jne    d38 <memmove+0x18>
  return vdst;
}
     d46:	5b                   	pop    %ebx
     d47:	5e                   	pop    %esi
     d48:	5d                   	pop    %ebp
     d49:	c3                   	ret    

00000d4a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     d4a:	b8 01 00 00 00       	mov    $0x1,%eax
     d4f:	cd 40                	int    $0x40
     d51:	c3                   	ret    

00000d52 <exit>:
SYSCALL(exit)
     d52:	b8 02 00 00 00       	mov    $0x2,%eax
     d57:	cd 40                	int    $0x40
     d59:	c3                   	ret    

00000d5a <wait>:
SYSCALL(wait)
     d5a:	b8 03 00 00 00       	mov    $0x3,%eax
     d5f:	cd 40                	int    $0x40
     d61:	c3                   	ret    

00000d62 <pipe>:
SYSCALL(pipe)
     d62:	b8 04 00 00 00       	mov    $0x4,%eax
     d67:	cd 40                	int    $0x40
     d69:	c3                   	ret    

00000d6a <read>:
SYSCALL(read)
     d6a:	b8 05 00 00 00       	mov    $0x5,%eax
     d6f:	cd 40                	int    $0x40
     d71:	c3                   	ret    

00000d72 <write>:
SYSCALL(write)
     d72:	b8 10 00 00 00       	mov    $0x10,%eax
     d77:	cd 40                	int    $0x40
     d79:	c3                   	ret    

00000d7a <close>:
SYSCALL(close)
     d7a:	b8 15 00 00 00       	mov    $0x15,%eax
     d7f:	cd 40                	int    $0x40
     d81:	c3                   	ret    

00000d82 <kill>:
SYSCALL(kill)
     d82:	b8 06 00 00 00       	mov    $0x6,%eax
     d87:	cd 40                	int    $0x40
     d89:	c3                   	ret    

00000d8a <exec>:
SYSCALL(exec)
     d8a:	b8 07 00 00 00       	mov    $0x7,%eax
     d8f:	cd 40                	int    $0x40
     d91:	c3                   	ret    

00000d92 <open>:
SYSCALL(open)
     d92:	b8 0f 00 00 00       	mov    $0xf,%eax
     d97:	cd 40                	int    $0x40
     d99:	c3                   	ret    

00000d9a <mknod>:
SYSCALL(mknod)
     d9a:	b8 11 00 00 00       	mov    $0x11,%eax
     d9f:	cd 40                	int    $0x40
     da1:	c3                   	ret    

00000da2 <unlink>:
SYSCALL(unlink)
     da2:	b8 12 00 00 00       	mov    $0x12,%eax
     da7:	cd 40                	int    $0x40
     da9:	c3                   	ret    

00000daa <fstat>:
SYSCALL(fstat)
     daa:	b8 08 00 00 00       	mov    $0x8,%eax
     daf:	cd 40                	int    $0x40
     db1:	c3                   	ret    

00000db2 <link>:
SYSCALL(link)
     db2:	b8 13 00 00 00       	mov    $0x13,%eax
     db7:	cd 40                	int    $0x40
     db9:	c3                   	ret    

00000dba <mkdir>:
SYSCALL(mkdir)
     dba:	b8 14 00 00 00       	mov    $0x14,%eax
     dbf:	cd 40                	int    $0x40
     dc1:	c3                   	ret    

00000dc2 <chdir>:
SYSCALL(chdir)
     dc2:	b8 09 00 00 00       	mov    $0x9,%eax
     dc7:	cd 40                	int    $0x40
     dc9:	c3                   	ret    

00000dca <dup>:
SYSCALL(dup)
     dca:	b8 0a 00 00 00       	mov    $0xa,%eax
     dcf:	cd 40                	int    $0x40
     dd1:	c3                   	ret    

00000dd2 <getpid>:
SYSCALL(getpid)
     dd2:	b8 0b 00 00 00       	mov    $0xb,%eax
     dd7:	cd 40                	int    $0x40
     dd9:	c3                   	ret    

00000dda <sbrk>:
SYSCALL(sbrk)
     dda:	b8 0c 00 00 00       	mov    $0xc,%eax
     ddf:	cd 40                	int    $0x40
     de1:	c3                   	ret    

00000de2 <sleep>:
SYSCALL(sleep)
     de2:	b8 0d 00 00 00       	mov    $0xd,%eax
     de7:	cd 40                	int    $0x40
     de9:	c3                   	ret    

00000dea <uptime>:
SYSCALL(uptime)
     dea:	b8 0e 00 00 00       	mov    $0xe,%eax
     def:	cd 40                	int    $0x40
     df1:	c3                   	ret    

00000df2 <lottery>:
     df2:	b8 16 00 00 00       	mov    $0x16,%eax
     df7:	cd 40                	int    $0x40
     df9:	c3                   	ret    
     dfa:	66 90                	xchg   %ax,%ax
     dfc:	66 90                	xchg   %ax,%ax
     dfe:	66 90                	xchg   %ax,%ax

00000e00 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     e00:	55                   	push   %ebp
     e01:	89 e5                	mov    %esp,%ebp
     e03:	57                   	push   %edi
     e04:	56                   	push   %esi
     e05:	53                   	push   %ebx
     e06:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     e09:	85 d2                	test   %edx,%edx
{
     e0b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
     e0e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
     e10:	79 76                	jns    e88 <printint+0x88>
     e12:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     e16:	74 70                	je     e88 <printint+0x88>
    x = -xx;
     e18:	f7 d8                	neg    %eax
    neg = 1;
     e1a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
     e21:	31 f6                	xor    %esi,%esi
     e23:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     e26:	eb 0a                	jmp    e32 <printint+0x32>
     e28:	90                   	nop
     e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
     e30:	89 fe                	mov    %edi,%esi
     e32:	31 d2                	xor    %edx,%edx
     e34:	8d 7e 01             	lea    0x1(%esi),%edi
     e37:	f7 f1                	div    %ecx
     e39:	0f b6 92 e8 12 00 00 	movzbl 0x12e8(%edx),%edx
  }while((x /= base) != 0);
     e40:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
     e42:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
     e45:	75 e9                	jne    e30 <printint+0x30>
  if(neg)
     e47:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     e4a:	85 c0                	test   %eax,%eax
     e4c:	74 08                	je     e56 <printint+0x56>
    buf[i++] = '-';
     e4e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
     e53:	8d 7e 02             	lea    0x2(%esi),%edi
     e56:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
     e5a:	8b 7d c0             	mov    -0x40(%ebp),%edi
     e5d:	8d 76 00             	lea    0x0(%esi),%esi
     e60:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
     e63:	83 ec 04             	sub    $0x4,%esp
     e66:	83 ee 01             	sub    $0x1,%esi
     e69:	6a 01                	push   $0x1
     e6b:	53                   	push   %ebx
     e6c:	57                   	push   %edi
     e6d:	88 45 d7             	mov    %al,-0x29(%ebp)
     e70:	e8 fd fe ff ff       	call   d72 <write>

  while(--i >= 0)
     e75:	83 c4 10             	add    $0x10,%esp
     e78:	39 de                	cmp    %ebx,%esi
     e7a:	75 e4                	jne    e60 <printint+0x60>
    putc(fd, buf[i]);
}
     e7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e7f:	5b                   	pop    %ebx
     e80:	5e                   	pop    %esi
     e81:	5f                   	pop    %edi
     e82:	5d                   	pop    %ebp
     e83:	c3                   	ret    
     e84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
     e88:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     e8f:	eb 90                	jmp    e21 <printint+0x21>
     e91:	eb 0d                	jmp    ea0 <printf>
     e93:	90                   	nop
     e94:	90                   	nop
     e95:	90                   	nop
     e96:	90                   	nop
     e97:	90                   	nop
     e98:	90                   	nop
     e99:	90                   	nop
     e9a:	90                   	nop
     e9b:	90                   	nop
     e9c:	90                   	nop
     e9d:	90                   	nop
     e9e:	90                   	nop
     e9f:	90                   	nop

00000ea0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     ea0:	55                   	push   %ebp
     ea1:	89 e5                	mov    %esp,%ebp
     ea3:	57                   	push   %edi
     ea4:	56                   	push   %esi
     ea5:	53                   	push   %ebx
     ea6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     ea9:	8b 75 0c             	mov    0xc(%ebp),%esi
     eac:	0f b6 1e             	movzbl (%esi),%ebx
     eaf:	84 db                	test   %bl,%bl
     eb1:	0f 84 b3 00 00 00    	je     f6a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
     eb7:	8d 45 10             	lea    0x10(%ebp),%eax
     eba:	83 c6 01             	add    $0x1,%esi
  state = 0;
     ebd:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
     ebf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     ec2:	eb 2f                	jmp    ef3 <printf+0x53>
     ec4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     ec8:	83 f8 25             	cmp    $0x25,%eax
     ecb:	0f 84 a7 00 00 00    	je     f78 <printf+0xd8>
  write(fd, &c, 1);
     ed1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     ed4:	83 ec 04             	sub    $0x4,%esp
     ed7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
     eda:	6a 01                	push   $0x1
     edc:	50                   	push   %eax
     edd:	ff 75 08             	pushl  0x8(%ebp)
     ee0:	e8 8d fe ff ff       	call   d72 <write>
     ee5:	83 c4 10             	add    $0x10,%esp
     ee8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
     eeb:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
     eef:	84 db                	test   %bl,%bl
     ef1:	74 77                	je     f6a <printf+0xca>
    if(state == 0){
     ef3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
     ef5:	0f be cb             	movsbl %bl,%ecx
     ef8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     efb:	74 cb                	je     ec8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     efd:	83 ff 25             	cmp    $0x25,%edi
     f00:	75 e6                	jne    ee8 <printf+0x48>
      if(c == 'd'){
     f02:	83 f8 64             	cmp    $0x64,%eax
     f05:	0f 84 05 01 00 00    	je     1010 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     f0b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
     f11:	83 f9 70             	cmp    $0x70,%ecx
     f14:	74 72                	je     f88 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     f16:	83 f8 73             	cmp    $0x73,%eax
     f19:	0f 84 99 00 00 00    	je     fb8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     f1f:	83 f8 63             	cmp    $0x63,%eax
     f22:	0f 84 08 01 00 00    	je     1030 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     f28:	83 f8 25             	cmp    $0x25,%eax
     f2b:	0f 84 ef 00 00 00    	je     1020 <printf+0x180>
  write(fd, &c, 1);
     f31:	8d 45 e7             	lea    -0x19(%ebp),%eax
     f34:	83 ec 04             	sub    $0x4,%esp
     f37:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     f3b:	6a 01                	push   $0x1
     f3d:	50                   	push   %eax
     f3e:	ff 75 08             	pushl  0x8(%ebp)
     f41:	e8 2c fe ff ff       	call   d72 <write>
     f46:	83 c4 0c             	add    $0xc,%esp
     f49:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     f4c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
     f4f:	6a 01                	push   $0x1
     f51:	50                   	push   %eax
     f52:	ff 75 08             	pushl  0x8(%ebp)
     f55:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     f58:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
     f5a:	e8 13 fe ff ff       	call   d72 <write>
  for(i = 0; fmt[i]; i++){
     f5f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
     f63:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
     f66:	84 db                	test   %bl,%bl
     f68:	75 89                	jne    ef3 <printf+0x53>
    }
  }
}
     f6a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f6d:	5b                   	pop    %ebx
     f6e:	5e                   	pop    %esi
     f6f:	5f                   	pop    %edi
     f70:	5d                   	pop    %ebp
     f71:	c3                   	ret    
     f72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
     f78:	bf 25 00 00 00       	mov    $0x25,%edi
     f7d:	e9 66 ff ff ff       	jmp    ee8 <printf+0x48>
     f82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
     f88:	83 ec 0c             	sub    $0xc,%esp
     f8b:	b9 10 00 00 00       	mov    $0x10,%ecx
     f90:	6a 00                	push   $0x0
     f92:	8b 7d d4             	mov    -0x2c(%ebp),%edi
     f95:	8b 45 08             	mov    0x8(%ebp),%eax
     f98:	8b 17                	mov    (%edi),%edx
     f9a:	e8 61 fe ff ff       	call   e00 <printint>
        ap++;
     f9f:	89 f8                	mov    %edi,%eax
     fa1:	83 c4 10             	add    $0x10,%esp
      state = 0;
     fa4:	31 ff                	xor    %edi,%edi
        ap++;
     fa6:	83 c0 04             	add    $0x4,%eax
     fa9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     fac:	e9 37 ff ff ff       	jmp    ee8 <printf+0x48>
     fb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
     fb8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     fbb:	8b 08                	mov    (%eax),%ecx
        ap++;
     fbd:	83 c0 04             	add    $0x4,%eax
     fc0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
     fc3:	85 c9                	test   %ecx,%ecx
     fc5:	0f 84 8e 00 00 00    	je     1059 <printf+0x1b9>
        while(*s != 0){
     fcb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
     fce:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
     fd0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
     fd2:	84 c0                	test   %al,%al
     fd4:	0f 84 0e ff ff ff    	je     ee8 <printf+0x48>
     fda:	89 75 d0             	mov    %esi,-0x30(%ebp)
     fdd:	89 de                	mov    %ebx,%esi
     fdf:	8b 5d 08             	mov    0x8(%ebp),%ebx
     fe2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
     fe5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
     fe8:	83 ec 04             	sub    $0x4,%esp
          s++;
     feb:	83 c6 01             	add    $0x1,%esi
     fee:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
     ff1:	6a 01                	push   $0x1
     ff3:	57                   	push   %edi
     ff4:	53                   	push   %ebx
     ff5:	e8 78 fd ff ff       	call   d72 <write>
        while(*s != 0){
     ffa:	0f b6 06             	movzbl (%esi),%eax
     ffd:	83 c4 10             	add    $0x10,%esp
    1000:	84 c0                	test   %al,%al
    1002:	75 e4                	jne    fe8 <printf+0x148>
    1004:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
    1007:	31 ff                	xor    %edi,%edi
    1009:	e9 da fe ff ff       	jmp    ee8 <printf+0x48>
    100e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
    1010:	83 ec 0c             	sub    $0xc,%esp
    1013:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1018:	6a 01                	push   $0x1
    101a:	e9 73 ff ff ff       	jmp    f92 <printf+0xf2>
    101f:	90                   	nop
  write(fd, &c, 1);
    1020:	83 ec 04             	sub    $0x4,%esp
    1023:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    1026:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1029:	6a 01                	push   $0x1
    102b:	e9 21 ff ff ff       	jmp    f51 <printf+0xb1>
        putc(fd, *ap);
    1030:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    1033:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1036:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    1038:	6a 01                	push   $0x1
        ap++;
    103a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    103d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    1040:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1043:	50                   	push   %eax
    1044:	ff 75 08             	pushl  0x8(%ebp)
    1047:	e8 26 fd ff ff       	call   d72 <write>
        ap++;
    104c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    104f:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1052:	31 ff                	xor    %edi,%edi
    1054:	e9 8f fe ff ff       	jmp    ee8 <printf+0x48>
          s = "(null)";
    1059:	bb e0 12 00 00       	mov    $0x12e0,%ebx
        while(*s != 0){
    105e:	b8 28 00 00 00       	mov    $0x28,%eax
    1063:	e9 72 ff ff ff       	jmp    fda <printf+0x13a>
    1068:	66 90                	xchg   %ax,%ax
    106a:	66 90                	xchg   %ax,%ax
    106c:	66 90                	xchg   %ax,%ax
    106e:	66 90                	xchg   %ax,%ax

00001070 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1070:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1071:	a1 24 19 00 00       	mov    0x1924,%eax
{
    1076:	89 e5                	mov    %esp,%ebp
    1078:	57                   	push   %edi
    1079:	56                   	push   %esi
    107a:	53                   	push   %ebx
    107b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    107e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1081:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1088:	39 c8                	cmp    %ecx,%eax
    108a:	8b 10                	mov    (%eax),%edx
    108c:	73 32                	jae    10c0 <free+0x50>
    108e:	39 d1                	cmp    %edx,%ecx
    1090:	72 04                	jb     1096 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1092:	39 d0                	cmp    %edx,%eax
    1094:	72 32                	jb     10c8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1096:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1099:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    109c:	39 fa                	cmp    %edi,%edx
    109e:	74 30                	je     10d0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    10a0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    10a3:	8b 50 04             	mov    0x4(%eax),%edx
    10a6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    10a9:	39 f1                	cmp    %esi,%ecx
    10ab:	74 3a                	je     10e7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    10ad:	89 08                	mov    %ecx,(%eax)
  freep = p;
    10af:	a3 24 19 00 00       	mov    %eax,0x1924
}
    10b4:	5b                   	pop    %ebx
    10b5:	5e                   	pop    %esi
    10b6:	5f                   	pop    %edi
    10b7:	5d                   	pop    %ebp
    10b8:	c3                   	ret    
    10b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    10c0:	39 d0                	cmp    %edx,%eax
    10c2:	72 04                	jb     10c8 <free+0x58>
    10c4:	39 d1                	cmp    %edx,%ecx
    10c6:	72 ce                	jb     1096 <free+0x26>
{
    10c8:	89 d0                	mov    %edx,%eax
    10ca:	eb bc                	jmp    1088 <free+0x18>
    10cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    10d0:	03 72 04             	add    0x4(%edx),%esi
    10d3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    10d6:	8b 10                	mov    (%eax),%edx
    10d8:	8b 12                	mov    (%edx),%edx
    10da:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    10dd:	8b 50 04             	mov    0x4(%eax),%edx
    10e0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    10e3:	39 f1                	cmp    %esi,%ecx
    10e5:	75 c6                	jne    10ad <free+0x3d>
    p->s.size += bp->s.size;
    10e7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    10ea:	a3 24 19 00 00       	mov    %eax,0x1924
    p->s.size += bp->s.size;
    10ef:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    10f2:	8b 53 f8             	mov    -0x8(%ebx),%edx
    10f5:	89 10                	mov    %edx,(%eax)
}
    10f7:	5b                   	pop    %ebx
    10f8:	5e                   	pop    %esi
    10f9:	5f                   	pop    %edi
    10fa:	5d                   	pop    %ebp
    10fb:	c3                   	ret    
    10fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001100 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1100:	55                   	push   %ebp
    1101:	89 e5                	mov    %esp,%ebp
    1103:	57                   	push   %edi
    1104:	56                   	push   %esi
    1105:	53                   	push   %ebx
    1106:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1109:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    110c:	8b 15 24 19 00 00    	mov    0x1924,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1112:	8d 78 07             	lea    0x7(%eax),%edi
    1115:	c1 ef 03             	shr    $0x3,%edi
    1118:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    111b:	85 d2                	test   %edx,%edx
    111d:	0f 84 9d 00 00 00    	je     11c0 <malloc+0xc0>
    1123:	8b 02                	mov    (%edx),%eax
    1125:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1128:	39 cf                	cmp    %ecx,%edi
    112a:	76 6c                	jbe    1198 <malloc+0x98>
    112c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1132:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1137:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    113a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1141:	eb 0e                	jmp    1151 <malloc+0x51>
    1143:	90                   	nop
    1144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1148:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    114a:	8b 48 04             	mov    0x4(%eax),%ecx
    114d:	39 f9                	cmp    %edi,%ecx
    114f:	73 47                	jae    1198 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1151:	39 05 24 19 00 00    	cmp    %eax,0x1924
    1157:	89 c2                	mov    %eax,%edx
    1159:	75 ed                	jne    1148 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    115b:	83 ec 0c             	sub    $0xc,%esp
    115e:	56                   	push   %esi
    115f:	e8 76 fc ff ff       	call   dda <sbrk>
  if(p == (char*)-1)
    1164:	83 c4 10             	add    $0x10,%esp
    1167:	83 f8 ff             	cmp    $0xffffffff,%eax
    116a:	74 1c                	je     1188 <malloc+0x88>
  hp->s.size = nu;
    116c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    116f:	83 ec 0c             	sub    $0xc,%esp
    1172:	83 c0 08             	add    $0x8,%eax
    1175:	50                   	push   %eax
    1176:	e8 f5 fe ff ff       	call   1070 <free>
  return freep;
    117b:	8b 15 24 19 00 00    	mov    0x1924,%edx
      if((p = morecore(nunits)) == 0)
    1181:	83 c4 10             	add    $0x10,%esp
    1184:	85 d2                	test   %edx,%edx
    1186:	75 c0                	jne    1148 <malloc+0x48>
        return 0;
  }
}
    1188:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    118b:	31 c0                	xor    %eax,%eax
}
    118d:	5b                   	pop    %ebx
    118e:	5e                   	pop    %esi
    118f:	5f                   	pop    %edi
    1190:	5d                   	pop    %ebp
    1191:	c3                   	ret    
    1192:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1198:	39 cf                	cmp    %ecx,%edi
    119a:	74 54                	je     11f0 <malloc+0xf0>
        p->s.size -= nunits;
    119c:	29 f9                	sub    %edi,%ecx
    119e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    11a1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    11a4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    11a7:	89 15 24 19 00 00    	mov    %edx,0x1924
}
    11ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    11b0:	83 c0 08             	add    $0x8,%eax
}
    11b3:	5b                   	pop    %ebx
    11b4:	5e                   	pop    %esi
    11b5:	5f                   	pop    %edi
    11b6:	5d                   	pop    %ebp
    11b7:	c3                   	ret    
    11b8:	90                   	nop
    11b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    11c0:	c7 05 24 19 00 00 28 	movl   $0x1928,0x1924
    11c7:	19 00 00 
    11ca:	c7 05 28 19 00 00 28 	movl   $0x1928,0x1928
    11d1:	19 00 00 
    base.s.size = 0;
    11d4:	b8 28 19 00 00       	mov    $0x1928,%eax
    11d9:	c7 05 2c 19 00 00 00 	movl   $0x0,0x192c
    11e0:	00 00 00 
    11e3:	e9 44 ff ff ff       	jmp    112c <malloc+0x2c>
    11e8:	90                   	nop
    11e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    11f0:	8b 08                	mov    (%eax),%ecx
    11f2:	89 0a                	mov    %ecx,(%edx)
    11f4:	eb b1                	jmp    11a7 <malloc+0xa7>
