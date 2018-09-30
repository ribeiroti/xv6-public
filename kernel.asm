
kernel: formato do arquivo elf32-i386


Desmontagem da seção .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 80 bf 10 80       	mov    $0x8010bf80,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 c0 2e 10 80       	mov    $0x80102ec0,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb b4 bf 10 80       	mov    $0x8010bfb4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 60 72 10 80       	push   $0x80107260
80100051:	68 80 bf 10 80       	push   $0x8010bf80
80100056:	e8 35 43 00 00       	call   80104390 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 cc 06 11 80 7c 	movl   $0x8011067c,0x801106cc
80100062:	06 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 d0 06 11 80 7c 	movl   $0x8011067c,0x801106d0
8010006c:	06 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba 7c 06 11 80       	mov    $0x8011067c,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 7c 06 11 80 	movl   $0x8011067c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 67 72 10 80       	push   $0x80107267
80100097:	50                   	push   %eax
80100098:	e8 c3 41 00 00       	call   80104260 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 d0 06 11 80       	mov    0x801106d0,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d d0 06 11 80    	mov    %ebx,0x801106d0
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d 7c 06 11 80       	cmp    $0x8011067c,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 80 bf 10 80       	push   $0x8010bf80
801000e4:	e8 e7 43 00 00       	call   801044d0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d d0 06 11 80    	mov    0x801106d0,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 7c 06 11 80    	cmp    $0x8011067c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 7c 06 11 80    	cmp    $0x8011067c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d cc 06 11 80    	mov    0x801106cc,%ebx
80100126:	81 fb 7c 06 11 80    	cmp    $0x8011067c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 7c 06 11 80    	cmp    $0x8011067c,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 80 bf 10 80       	push   $0x8010bf80
80100162:	e8 29 44 00 00       	call   80104590 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 2e 41 00 00       	call   801042a0 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 bd 1f 00 00       	call   80102140 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 6e 72 10 80       	push   $0x8010726e
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 8d 41 00 00       	call   80104340 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 77 1f 00 00       	jmp    80102140 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 7f 72 10 80       	push   $0x8010727f
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 4c 41 00 00       	call   80104340 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 fc 40 00 00       	call   80104300 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 80 bf 10 80 	movl   $0x8010bf80,(%esp)
8010020b:	e8 c0 42 00 00       	call   801044d0 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 d0 06 11 80       	mov    0x801106d0,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 7c 06 11 80 	movl   $0x8011067c,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 d0 06 11 80       	mov    0x801106d0,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d d0 06 11 80    	mov    %ebx,0x801106d0
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 80 bf 10 80 	movl   $0x8010bf80,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 2f 43 00 00       	jmp    80104590 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 86 72 10 80       	push   $0x80107286
80100269:	e8 22 01 00 00       	call   80100390 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 fb 14 00 00       	call   80101780 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 3f 42 00 00       	call   801044d0 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 60 09 11 80    	mov    0x80110960,%edx
801002a7:	39 15 64 09 11 80    	cmp    %edx,0x80110964
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 20 a5 10 80       	push   $0x8010a520
801002c0:	68 60 09 11 80       	push   $0x80110960
801002c5:	e8 66 3a 00 00       	call   80103d30 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 60 09 11 80    	mov    0x80110960,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 64 09 11 80    	cmp    0x80110964,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 e0 34 00 00       	call   801037c0 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 a5 10 80       	push   $0x8010a520
801002ef:	e8 9c 42 00 00       	call   80104590 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 a4 13 00 00       	call   801016a0 <ilock>
        return -1;
801002fc:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100307:	5b                   	pop    %ebx
80100308:	5e                   	pop    %esi
80100309:	5f                   	pop    %edi
8010030a:	5d                   	pop    %ebp
8010030b:	c3                   	ret    
8010030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 60 09 11 80       	mov    %eax,0x80110960
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 e0 08 11 80 	movsbl -0x7feef720(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 20 a5 10 80       	push   $0x8010a520
8010034d:	e8 3e 42 00 00       	call   80104590 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 46 13 00 00       	call   801016a0 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 60 09 11 80    	mov    %edx,0x80110960
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <panic>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 a2 23 00 00       	call   80102750 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 8d 72 10 80       	push   $0x8010728d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 3b 7c 10 80 	movl   $0x80107c3b,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 d3 3f 00 00       	call   801043b0 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 a1 72 10 80       	push   $0x801072a1
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
80100416:	85 c9                	test   %ecx,%ecx
80100418:	74 06                	je     80100420 <consputc+0x10>
8010041a:	fa                   	cli    
8010041b:	eb fe                	jmp    8010041b <consputc+0xb>
8010041d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	89 c6                	mov    %eax,%esi
80100428:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010042b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100430:	0f 84 b1 00 00 00    	je     801004e7 <consputc+0xd7>
    uartputc(c);
80100436:	83 ec 0c             	sub    $0xc,%esp
80100439:	50                   	push   %eax
8010043a:	e8 61 58 00 00       	call   80105ca0 <uartputc>
8010043f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100442:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100447:	b8 0e 00 00 00       	mov    $0xe,%eax
8010044c:	89 da                	mov    %ebx,%edx
8010044e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100454:	89 ca                	mov    %ecx,%edx
80100456:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100457:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010045a:	89 da                	mov    %ebx,%edx
8010045c:	c1 e0 08             	shl    $0x8,%eax
8010045f:	89 c7                	mov    %eax,%edi
80100461:	b8 0f 00 00 00       	mov    $0xf,%eax
80100466:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100467:	89 ca                	mov    %ecx,%edx
80100469:	ec                   	in     (%dx),%al
8010046a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010046d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010046f:	83 fe 0a             	cmp    $0xa,%esi
80100472:	0f 84 f3 00 00 00    	je     8010056b <consputc+0x15b>
  else if(c == BACKSPACE){
80100478:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010047e:	0f 84 d7 00 00 00    	je     8010055b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100484:	89 f0                	mov    %esi,%eax
80100486:	0f b6 c0             	movzbl %al,%eax
80100489:	80 cc 07             	or     $0x7,%ah
8010048c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100493:	80 
80100494:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100497:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010049d:	0f 8f ab 00 00 00    	jg     8010054e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
801004a3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004a9:	7f 66                	jg     80100511 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ab:	be d4 03 00 00       	mov    $0x3d4,%esi
801004b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b5:	89 f2                	mov    %esi,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004bd:	89 d8                	mov    %ebx,%eax
801004bf:	c1 f8 08             	sar    $0x8,%eax
801004c2:	89 ca                	mov    %ecx,%edx
801004c4:	ee                   	out    %al,(%dx)
801004c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004ca:	89 f2                	mov    %esi,%edx
801004cc:	ee                   	out    %al,(%dx)
801004cd:	89 d8                	mov    %ebx,%eax
801004cf:	89 ca                	mov    %ecx,%edx
801004d1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d2:	b8 20 07 00 00       	mov    $0x720,%eax
801004d7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004de:	80 
}
801004df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004e2:	5b                   	pop    %ebx
801004e3:	5e                   	pop    %esi
801004e4:	5f                   	pop    %edi
801004e5:	5d                   	pop    %ebp
801004e6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e7:	83 ec 0c             	sub    $0xc,%esp
801004ea:	6a 08                	push   $0x8
801004ec:	e8 af 57 00 00       	call   80105ca0 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 a3 57 00 00       	call   80105ca0 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 97 57 00 00       	call   80105ca0 <uartputc>
80100509:	83 c4 10             	add    $0x10,%esp
8010050c:	e9 31 ff ff ff       	jmp    80100442 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100511:	52                   	push   %edx
80100512:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
80100517:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010051a:	68 a0 80 0b 80       	push   $0x800b80a0
8010051f:	68 00 80 0b 80       	push   $0x800b8000
80100524:	e8 67 41 00 00       	call   80104690 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100529:	b8 80 07 00 00       	mov    $0x780,%eax
8010052e:	83 c4 0c             	add    $0xc,%esp
80100531:	29 d8                	sub    %ebx,%eax
80100533:	01 c0                	add    %eax,%eax
80100535:	50                   	push   %eax
80100536:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100539:	6a 00                	push   $0x0
8010053b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100540:	50                   	push   %eax
80100541:	e8 9a 40 00 00       	call   801045e0 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 a5 72 10 80       	push   $0x801072a5
80100556:	e8 35 fe ff ff       	call   80100390 <panic>
    if(pos > 0) --pos;
8010055b:	85 db                	test   %ebx,%ebx
8010055d:	0f 84 48 ff ff ff    	je     801004ab <consputc+0x9b>
80100563:	83 eb 01             	sub    $0x1,%ebx
80100566:	e9 2c ff ff ff       	jmp    80100497 <consputc+0x87>
    pos += 80 - pos%80;
8010056b:	89 d8                	mov    %ebx,%eax
8010056d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100572:	99                   	cltd   
80100573:	f7 f9                	idiv   %ecx
80100575:	29 d1                	sub    %edx,%ecx
80100577:	01 cb                	add    %ecx,%ebx
80100579:	e9 19 ff ff ff       	jmp    80100497 <consputc+0x87>
8010057e:	66 90                	xchg   %ax,%ax

80100580 <printint>:
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d3                	mov    %edx,%ebx
80100588:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100590:	74 04                	je     80100596 <printint+0x16>
80100592:	85 c0                	test   %eax,%eax
80100594:	78 5a                	js     801005f0 <printint+0x70>
    x = xx;
80100596:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010059d:	31 c9                	xor    %ecx,%ecx
8010059f:	8d 75 d7             	lea    -0x29(%ebp),%esi
801005a2:	eb 06                	jmp    801005aa <printint+0x2a>
801005a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
801005a8:	89 f9                	mov    %edi,%ecx
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 79 01             	lea    0x1(%ecx),%edi
801005af:	f7 f3                	div    %ebx
801005b1:	0f b6 92 d0 72 10 80 	movzbl -0x7fef8d30(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005ba:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005cb:	8d 79 02             	lea    0x2(%ecx),%edi
801005ce:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005d8:	0f be 03             	movsbl (%ebx),%eax
801005db:	83 eb 01             	sub    $0x1,%ebx
801005de:	e8 2d fe ff ff       	call   80100410 <consputc>
  while(--i >= 0)
801005e3:	39 f3                	cmp    %esi,%ebx
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	90                   	nop
    x = -xx;
801005f0:	f7 d8                	neg    %eax
801005f2:	eb a9                	jmp    8010059d <printint+0x1d>
801005f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060c:	ff 75 08             	pushl  0x8(%ebp)
8010060f:	e8 6c 11 00 00       	call   80101780 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010061b:	e8 b0 3e 00 00       	call   801044d0 <acquire>
  for(i = 0; i < n; i++)
80100620:	83 c4 10             	add    $0x10,%esp
80100623:	85 f6                	test   %esi,%esi
80100625:	7e 18                	jle    8010063f <consolewrite+0x3f>
80100627:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010062a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 d5 fd ff ff       	call   80100410 <consputc>
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 a5 10 80       	push   $0x8010a520
80100647:	e8 44 3f 00 00       	call   80104590 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 4b 10 00 00       	call   801016a0 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100670:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100673:	0f 85 6f 01 00 00    	jne    801007e8 <cprintf+0x188>
  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c7                	mov    %eax,%edi
80100680:	0f 84 77 01 00 00    	je     801007fd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100689:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010068c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010068e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100691:	85 c0                	test   %eax,%eax
80100693:	75 56                	jne    801006eb <cprintf+0x8b>
80100695:	eb 79                	jmp    80100710 <cprintf+0xb0>
80100697:	89 f6                	mov    %esi,%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
801006a0:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
801006a3:	85 d2                	test   %edx,%edx
801006a5:	74 69                	je     80100710 <cprintf+0xb0>
801006a7:	83 c3 02             	add    $0x2,%ebx
    switch(c){
801006aa:	83 fa 70             	cmp    $0x70,%edx
801006ad:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
801006b0:	0f 84 84 00 00 00    	je     8010073a <cprintf+0xda>
801006b6:	7f 78                	jg     80100730 <cprintf+0xd0>
801006b8:	83 fa 25             	cmp    $0x25,%edx
801006bb:	0f 84 ff 00 00 00    	je     801007c0 <cprintf+0x160>
801006c1:	83 fa 64             	cmp    $0x64,%edx
801006c4:	0f 85 8e 00 00 00    	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006cd:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d2:	8d 48 04             	lea    0x4(%eax),%ecx
801006d5:	8b 00                	mov    (%eax),%eax
801006d7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801006da:	b9 01 00 00 00       	mov    $0x1,%ecx
801006df:	e8 9c fe ff ff       	call   80100580 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e4:	0f b6 06             	movzbl (%esi),%eax
801006e7:	85 c0                	test   %eax,%eax
801006e9:	74 25                	je     80100710 <cprintf+0xb0>
801006eb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006ee:	83 f8 25             	cmp    $0x25,%eax
801006f1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801006f4:	74 aa                	je     801006a0 <cprintf+0x40>
801006f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006f9:	e8 12 fd ff ff       	call   80100410 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	0f b6 06             	movzbl (%esi),%eax
      continue;
80100701:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100704:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100706:	85 c0                	test   %eax,%eax
80100708:	75 e1                	jne    801006eb <cprintf+0x8b>
8010070a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
80100710:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100713:	85 c0                	test   %eax,%eax
80100715:	74 10                	je     80100727 <cprintf+0xc7>
    release(&cons.lock);
80100717:	83 ec 0c             	sub    $0xc,%esp
8010071a:	68 20 a5 10 80       	push   $0x8010a520
8010071f:	e8 6c 3e 00 00       	call   80104590 <release>
80100724:	83 c4 10             	add    $0x10,%esp
}
80100727:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010072a:	5b                   	pop    %ebx
8010072b:	5e                   	pop    %esi
8010072c:	5f                   	pop    %edi
8010072d:	5d                   	pop    %ebp
8010072e:	c3                   	ret    
8010072f:	90                   	nop
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	74 43                	je     80100778 <cprintf+0x118>
80100735:	83 fa 78             	cmp    $0x78,%edx
80100738:	75 1e                	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010073a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010073d:	ba 10 00 00 00       	mov    $0x10,%edx
80100742:	8d 48 04             	lea    0x4(%eax),%ecx
80100745:	8b 00                	mov    (%eax),%eax
80100747:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010074a:	31 c9                	xor    %ecx,%ecx
8010074c:	e8 2f fe ff ff       	call   80100580 <printint>
      break;
80100751:	eb 91                	jmp    801006e4 <cprintf+0x84>
80100753:	90                   	nop
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100758:	b8 25 00 00 00       	mov    $0x25,%eax
8010075d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100760:	e8 ab fc ff ff       	call   80100410 <consputc>
      consputc(c);
80100765:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100768:	89 d0                	mov    %edx,%eax
8010076a:	e8 a1 fc ff ff       	call   80100410 <consputc>
      break;
8010076f:	e9 70 ff ff ff       	jmp    801006e4 <cprintf+0x84>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010077b:	8b 10                	mov    (%eax),%edx
8010077d:	8d 48 04             	lea    0x4(%eax),%ecx
80100780:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100783:	85 d2                	test   %edx,%edx
80100785:	74 49                	je     801007d0 <cprintf+0x170>
      for(; *s; s++)
80100787:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010078a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010078d:	84 c0                	test   %al,%al
8010078f:	0f 84 4f ff ff ff    	je     801006e4 <cprintf+0x84>
80100795:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100798:	89 d3                	mov    %edx,%ebx
8010079a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801007a0:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
801007a3:	e8 68 fc ff ff       	call   80100410 <consputc>
      for(; *s; s++)
801007a8:	0f be 03             	movsbl (%ebx),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801007b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007b8:	e9 27 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
801007c0:	b8 25 00 00 00       	mov    $0x25,%eax
801007c5:	e8 46 fc ff ff       	call   80100410 <consputc>
      break;
801007ca:	e9 15 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007cf:	90                   	nop
        s = "(null)";
801007d0:	ba b8 72 10 80       	mov    $0x801072b8,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 a5 10 80       	push   $0x8010a520
801007f0:	e8 db 3c 00 00       	call   801044d0 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 bf 72 10 80       	push   $0x801072bf
80100805:	e8 86 fb ff ff       	call   80100390 <panic>
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100810 <consoleintr>:
{
80100810:	55                   	push   %ebp
80100811:	89 e5                	mov    %esp,%ebp
80100813:	57                   	push   %edi
80100814:	56                   	push   %esi
80100815:	53                   	push   %ebx
  int c, doprocdump = 0;
80100816:	31 f6                	xor    %esi,%esi
{
80100818:	83 ec 18             	sub    $0x18,%esp
8010081b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010081e:	68 20 a5 10 80       	push   $0x8010a520
80100823:	e8 a8 3c 00 00       	call   801044d0 <acquire>
  while((c = getc()) >= 0){
80100828:	83 c4 10             	add    $0x10,%esp
8010082b:	90                   	nop
8010082c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100830:	ff d3                	call   *%ebx
80100832:	85 c0                	test   %eax,%eax
80100834:	89 c7                	mov    %eax,%edi
80100836:	78 48                	js     80100880 <consoleintr+0x70>
    switch(c){
80100838:	83 ff 10             	cmp    $0x10,%edi
8010083b:	0f 84 e7 00 00 00    	je     80100928 <consoleintr+0x118>
80100841:	7e 5d                	jle    801008a0 <consoleintr+0x90>
80100843:	83 ff 15             	cmp    $0x15,%edi
80100846:	0f 84 ec 00 00 00    	je     80100938 <consoleintr+0x128>
8010084c:	83 ff 7f             	cmp    $0x7f,%edi
8010084f:	75 54                	jne    801008a5 <consoleintr+0x95>
      if(input.e != input.w){
80100851:	a1 68 09 11 80       	mov    0x80110968,%eax
80100856:	3b 05 64 09 11 80    	cmp    0x80110964,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 68 09 11 80       	mov    %eax,0x80110968
        consputc(BACKSPACE);
80100866:	b8 00 01 00 00       	mov    $0x100,%eax
8010086b:	e8 a0 fb ff ff       	call   80100410 <consputc>
  while((c = getc()) >= 0){
80100870:	ff d3                	call   *%ebx
80100872:	85 c0                	test   %eax,%eax
80100874:	89 c7                	mov    %eax,%edi
80100876:	79 c0                	jns    80100838 <consoleintr+0x28>
80100878:	90                   	nop
80100879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	68 20 a5 10 80       	push   $0x8010a520
80100888:	e8 03 3d 00 00       	call   80104590 <release>
  if(doprocdump) {
8010088d:	83 c4 10             	add    $0x10,%esp
80100890:	85 f6                	test   %esi,%esi
80100892:	0f 85 f8 00 00 00    	jne    80100990 <consoleintr+0x180>
}
80100898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010089b:	5b                   	pop    %ebx
8010089c:	5e                   	pop    %esi
8010089d:	5f                   	pop    %edi
8010089e:	5d                   	pop    %ebp
8010089f:	c3                   	ret    
    switch(c){
801008a0:	83 ff 08             	cmp    $0x8,%edi
801008a3:	74 ac                	je     80100851 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a5:	85 ff                	test   %edi,%edi
801008a7:	74 87                	je     80100830 <consoleintr+0x20>
801008a9:	a1 68 09 11 80       	mov    0x80110968,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 60 09 11 80    	sub    0x80110960,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 68 09 11 80    	mov    %edx,0x80110968
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 d4 00 00 00    	je     801009a8 <consoleintr+0x198>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 e0 08 11 80    	mov    %cl,-0x7feef720(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 cd 00 00 00    	je     801009b9 <consoleintr+0x1a9>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 c4 00 00 00    	je     801009b9 <consoleintr+0x1a9>
801008f5:	a1 60 09 11 80       	mov    0x80110960,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 68 09 11 80    	cmp    %eax,0x80110968
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 64 09 11 80       	mov    %eax,0x80110964
          wakeup(&input.r);
80100911:	68 60 09 11 80       	push   $0x80110960
80100916:	e8 c5 35 00 00       	call   80103ee0 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 68 09 11 80       	mov    0x80110968,%eax
8010093d:	39 05 64 09 11 80    	cmp    %eax,0x80110964
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 68 09 11 80       	mov    %eax,0x80110968
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 68 09 11 80       	mov    0x80110968,%eax
80100964:	3b 05 64 09 11 80    	cmp    0x80110964,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba e0 08 11 80 0a 	cmpb   $0xa,-0x7feef720(%edx)
8010097f:	75 cf                	jne    80100950 <consoleintr+0x140>
80100981:	e9 aa fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100986:	8d 76 00             	lea    0x0(%esi),%esi
80100989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    procdump(0);  // now call procdump() wo. cons.lock held
80100990:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
}
80100997:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010099a:	5b                   	pop    %ebx
8010099b:	5e                   	pop    %esi
8010099c:	5f                   	pop    %edi
8010099d:	5d                   	pop    %ebp
    procdump(0);  // now call procdump() wo. cons.lock held
8010099e:	e9 1d 36 00 00       	jmp    80103fc0 <procdump>
801009a3:	90                   	nop
801009a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a8:	c6 80 e0 08 11 80 0a 	movb   $0xa,-0x7feef720(%eax)
        consputc(c);
801009af:	b8 0a 00 00 00       	mov    $0xa,%eax
801009b4:	e8 57 fa ff ff       	call   80100410 <consputc>
801009b9:	a1 68 09 11 80       	mov    0x80110968,%eax
801009be:	e9 46 ff ff ff       	jmp    80100909 <consoleintr+0xf9>
801009c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801009c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801009d0 <consoleinit>:

void
consoleinit(void)
{
801009d0:	55                   	push   %ebp
801009d1:	89 e5                	mov    %esp,%ebp
801009d3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009d6:	68 c8 72 10 80       	push   $0x801072c8
801009db:	68 20 a5 10 80       	push   $0x8010a520
801009e0:	e8 ab 39 00 00       	call   80104390 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009e5:	58                   	pop    %eax
801009e6:	5a                   	pop    %edx
801009e7:	6a 00                	push   $0x0
801009e9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009eb:	c7 05 2c 13 11 80 00 	movl   $0x80100600,0x8011132c
801009f2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009f5:	c7 05 28 13 11 80 70 	movl   $0x80100270,0x80111328
801009fc:	02 10 80 
  cons.locking = 1;
801009ff:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
80100a06:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100a09:	e8 e2 18 00 00       	call   801022f0 <ioapicenable>
}
80100a0e:	83 c4 10             	add    $0x10,%esp
80100a11:	c9                   	leave  
80100a12:	c3                   	ret    
80100a13:	66 90                	xchg   %ax,%ax
80100a15:	66 90                	xchg   %ax,%ax
80100a17:	66 90                	xchg   %ax,%ax
80100a19:	66 90                	xchg   %ax,%ax
80100a1b:	66 90                	xchg   %ax,%ax
80100a1d:	66 90                	xchg   %ax,%ax
80100a1f:	90                   	nop

80100a20 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a20:	55                   	push   %ebp
80100a21:	89 e5                	mov    %esp,%ebp
80100a23:	57                   	push   %edi
80100a24:	56                   	push   %esi
80100a25:	53                   	push   %ebx
80100a26:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a2c:	e8 8f 2d 00 00       	call   801037c0 <myproc>
80100a31:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a37:	e8 84 21 00 00       	call   80102bc0 <begin_op>

  if((ip = namei(path)) == 0){
80100a3c:	83 ec 0c             	sub    $0xc,%esp
80100a3f:	ff 75 08             	pushl  0x8(%ebp)
80100a42:	e8 b9 14 00 00       	call   80101f00 <namei>
80100a47:	83 c4 10             	add    $0x10,%esp
80100a4a:	85 c0                	test   %eax,%eax
80100a4c:	0f 84 91 01 00 00    	je     80100be3 <exec+0x1c3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a52:	83 ec 0c             	sub    $0xc,%esp
80100a55:	89 c3                	mov    %eax,%ebx
80100a57:	50                   	push   %eax
80100a58:	e8 43 0c 00 00       	call   801016a0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a5d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a63:	6a 34                	push   $0x34
80100a65:	6a 00                	push   $0x0
80100a67:	50                   	push   %eax
80100a68:	53                   	push   %ebx
80100a69:	e8 12 0f 00 00       	call   80101980 <readi>
80100a6e:	83 c4 20             	add    $0x20,%esp
80100a71:	83 f8 34             	cmp    $0x34,%eax
80100a74:	74 22                	je     80100a98 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a76:	83 ec 0c             	sub    $0xc,%esp
80100a79:	53                   	push   %ebx
80100a7a:	e8 b1 0e 00 00       	call   80101930 <iunlockput>
    end_op();
80100a7f:	e8 ac 21 00 00       	call   80102c30 <end_op>
80100a84:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a87:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a8c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a8f:	5b                   	pop    %ebx
80100a90:	5e                   	pop    %esi
80100a91:	5f                   	pop    %edi
80100a92:	5d                   	pop    %ebp
80100a93:	c3                   	ret    
80100a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100a98:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a9f:	45 4c 46 
80100aa2:	75 d2                	jne    80100a76 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100aa4:	e8 47 63 00 00       	call   80106df0 <setupkvm>
80100aa9:	85 c0                	test   %eax,%eax
80100aab:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100ab1:	74 c3                	je     80100a76 <exec+0x56>
  sz = 0;
80100ab3:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100ab5:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100abc:	00 
80100abd:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100ac3:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100ac9:	0f 84 8c 02 00 00    	je     80100d5b <exec+0x33b>
80100acf:	31 f6                	xor    %esi,%esi
80100ad1:	eb 7f                	jmp    80100b52 <exec+0x132>
80100ad3:	90                   	nop
80100ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100ad8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100adf:	75 63                	jne    80100b44 <exec+0x124>
    if(ph.memsz < ph.filesz)
80100ae1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ae7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100aed:	0f 82 86 00 00 00    	jb     80100b79 <exec+0x159>
80100af3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100af9:	72 7e                	jb     80100b79 <exec+0x159>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100afb:	83 ec 04             	sub    $0x4,%esp
80100afe:	50                   	push   %eax
80100aff:	57                   	push   %edi
80100b00:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b06:	e8 05 61 00 00       	call   80106c10 <allocuvm>
80100b0b:	83 c4 10             	add    $0x10,%esp
80100b0e:	85 c0                	test   %eax,%eax
80100b10:	89 c7                	mov    %eax,%edi
80100b12:	74 65                	je     80100b79 <exec+0x159>
    if(ph.vaddr % PGSIZE != 0)
80100b14:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b1a:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b1f:	75 58                	jne    80100b79 <exec+0x159>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b21:	83 ec 0c             	sub    $0xc,%esp
80100b24:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b2a:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b30:	53                   	push   %ebx
80100b31:	50                   	push   %eax
80100b32:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b38:	e8 13 60 00 00       	call   80106b50 <loaduvm>
80100b3d:	83 c4 20             	add    $0x20,%esp
80100b40:	85 c0                	test   %eax,%eax
80100b42:	78 35                	js     80100b79 <exec+0x159>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b44:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b4b:	83 c6 01             	add    $0x1,%esi
80100b4e:	39 f0                	cmp    %esi,%eax
80100b50:	7e 3d                	jle    80100b8f <exec+0x16f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b52:	89 f0                	mov    %esi,%eax
80100b54:	6a 20                	push   $0x20
80100b56:	c1 e0 05             	shl    $0x5,%eax
80100b59:	03 85 ec fe ff ff    	add    -0x114(%ebp),%eax
80100b5f:	50                   	push   %eax
80100b60:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b66:	50                   	push   %eax
80100b67:	53                   	push   %ebx
80100b68:	e8 13 0e 00 00       	call   80101980 <readi>
80100b6d:	83 c4 10             	add    $0x10,%esp
80100b70:	83 f8 20             	cmp    $0x20,%eax
80100b73:	0f 84 5f ff ff ff    	je     80100ad8 <exec+0xb8>
    freevm(pgdir);
80100b79:	83 ec 0c             	sub    $0xc,%esp
80100b7c:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b82:	e8 e9 61 00 00       	call   80106d70 <freevm>
80100b87:	83 c4 10             	add    $0x10,%esp
80100b8a:	e9 e7 fe ff ff       	jmp    80100a76 <exec+0x56>
80100b8f:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100b95:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100b9b:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100ba1:	83 ec 0c             	sub    $0xc,%esp
80100ba4:	53                   	push   %ebx
80100ba5:	e8 86 0d 00 00       	call   80101930 <iunlockput>
  end_op();
80100baa:	e8 81 20 00 00       	call   80102c30 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100baf:	83 c4 0c             	add    $0xc,%esp
80100bb2:	56                   	push   %esi
80100bb3:	57                   	push   %edi
80100bb4:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bba:	e8 51 60 00 00       	call   80106c10 <allocuvm>
80100bbf:	83 c4 10             	add    $0x10,%esp
80100bc2:	85 c0                	test   %eax,%eax
80100bc4:	89 c6                	mov    %eax,%esi
80100bc6:	75 3a                	jne    80100c02 <exec+0x1e2>
    freevm(pgdir);
80100bc8:	83 ec 0c             	sub    $0xc,%esp
80100bcb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bd1:	e8 9a 61 00 00       	call   80106d70 <freevm>
80100bd6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bd9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bde:	e9 a9 fe ff ff       	jmp    80100a8c <exec+0x6c>
    end_op();
80100be3:	e8 48 20 00 00       	call   80102c30 <end_op>
    cprintf("exec: fail\n");
80100be8:	83 ec 0c             	sub    $0xc,%esp
80100beb:	68 e1 72 10 80       	push   $0x801072e1
80100bf0:	e8 6b fa ff ff       	call   80100660 <cprintf>
    return -1;
80100bf5:	83 c4 10             	add    $0x10,%esp
80100bf8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bfd:	e9 8a fe ff ff       	jmp    80100a8c <exec+0x6c>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c02:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100c08:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100c0b:	31 ff                	xor    %edi,%edi
80100c0d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c0f:	50                   	push   %eax
80100c10:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c16:	e8 75 62 00 00       	call   80106e90 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c1b:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c1e:	83 c4 10             	add    $0x10,%esp
80100c21:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c27:	8b 00                	mov    (%eax),%eax
80100c29:	85 c0                	test   %eax,%eax
80100c2b:	74 70                	je     80100c9d <exec+0x27d>
80100c2d:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c33:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c39:	eb 0a                	jmp    80100c45 <exec+0x225>
80100c3b:	90                   	nop
80100c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100c40:	83 ff 20             	cmp    $0x20,%edi
80100c43:	74 83                	je     80100bc8 <exec+0x1a8>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c45:	83 ec 0c             	sub    $0xc,%esp
80100c48:	50                   	push   %eax
80100c49:	e8 b2 3b 00 00       	call   80104800 <strlen>
80100c4e:	f7 d0                	not    %eax
80100c50:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c52:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c55:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c56:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c59:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5c:	e8 9f 3b 00 00       	call   80104800 <strlen>
80100c61:	83 c0 01             	add    $0x1,%eax
80100c64:	50                   	push   %eax
80100c65:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c68:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c6b:	53                   	push   %ebx
80100c6c:	56                   	push   %esi
80100c6d:	e8 7e 63 00 00       	call   80106ff0 <copyout>
80100c72:	83 c4 20             	add    $0x20,%esp
80100c75:	85 c0                	test   %eax,%eax
80100c77:	0f 88 4b ff ff ff    	js     80100bc8 <exec+0x1a8>
  for(argc = 0; argv[argc]; argc++) {
80100c7d:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c80:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c87:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c8a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c90:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c93:	85 c0                	test   %eax,%eax
80100c95:	75 a9                	jne    80100c40 <exec+0x220>
80100c97:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c9d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100ca4:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100ca6:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100cad:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100cb1:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100cb8:	ff ff ff 
  ustack[1] = argc;
80100cbb:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cc1:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100cc3:	83 c0 0c             	add    $0xc,%eax
80100cc6:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cc8:	50                   	push   %eax
80100cc9:	52                   	push   %edx
80100cca:	53                   	push   %ebx
80100ccb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cd1:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cd7:	e8 14 63 00 00       	call   80106ff0 <copyout>
80100cdc:	83 c4 10             	add    $0x10,%esp
80100cdf:	85 c0                	test   %eax,%eax
80100ce1:	0f 88 e1 fe ff ff    	js     80100bc8 <exec+0x1a8>
  for(last=s=path; *s; s++)
80100ce7:	8b 45 08             	mov    0x8(%ebp),%eax
80100cea:	0f b6 00             	movzbl (%eax),%eax
80100ced:	84 c0                	test   %al,%al
80100cef:	74 17                	je     80100d08 <exec+0x2e8>
80100cf1:	8b 55 08             	mov    0x8(%ebp),%edx
80100cf4:	89 d1                	mov    %edx,%ecx
80100cf6:	83 c1 01             	add    $0x1,%ecx
80100cf9:	3c 2f                	cmp    $0x2f,%al
80100cfb:	0f b6 01             	movzbl (%ecx),%eax
80100cfe:	0f 44 d1             	cmove  %ecx,%edx
80100d01:	84 c0                	test   %al,%al
80100d03:	75 f1                	jne    80100cf6 <exec+0x2d6>
80100d05:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100d08:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100d0e:	50                   	push   %eax
80100d0f:	6a 10                	push   $0x10
80100d11:	ff 75 08             	pushl  0x8(%ebp)
80100d14:	89 f8                	mov    %edi,%eax
80100d16:	83 c0 6c             	add    $0x6c,%eax
80100d19:	50                   	push   %eax
80100d1a:	e8 a1 3a 00 00       	call   801047c0 <safestrcpy>
  curproc->pgdir = pgdir;
80100d1f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  oldpgdir = curproc->pgdir;
80100d25:	89 f9                	mov    %edi,%ecx
80100d27:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->tf->eip = elf.entry;  // main
80100d2a:	8b 41 18             	mov    0x18(%ecx),%eax
  curproc->sz = sz;
80100d2d:	89 31                	mov    %esi,(%ecx)
  curproc->pgdir = pgdir;
80100d2f:	89 51 04             	mov    %edx,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100d32:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d38:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d3b:	8b 41 18             	mov    0x18(%ecx),%eax
80100d3e:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d41:	89 0c 24             	mov    %ecx,(%esp)
80100d44:	e8 77 5c 00 00       	call   801069c0 <switchuvm>
  freevm(oldpgdir);
80100d49:	89 3c 24             	mov    %edi,(%esp)
80100d4c:	e8 1f 60 00 00       	call   80106d70 <freevm>
  return 0;
80100d51:	83 c4 10             	add    $0x10,%esp
80100d54:	31 c0                	xor    %eax,%eax
80100d56:	e9 31 fd ff ff       	jmp    80100a8c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d5b:	be 00 20 00 00       	mov    $0x2000,%esi
80100d60:	e9 3c fe ff ff       	jmp    80100ba1 <exec+0x181>
80100d65:	66 90                	xchg   %ax,%ax
80100d67:	66 90                	xchg   %ax,%ax
80100d69:	66 90                	xchg   %ax,%ax
80100d6b:	66 90                	xchg   %ax,%ax
80100d6d:	66 90                	xchg   %ax,%ax
80100d6f:	90                   	nop

80100d70 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d70:	55                   	push   %ebp
80100d71:	89 e5                	mov    %esp,%ebp
80100d73:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d76:	68 ed 72 10 80       	push   $0x801072ed
80100d7b:	68 80 09 11 80       	push   $0x80110980
80100d80:	e8 0b 36 00 00       	call   80104390 <initlock>
}
80100d85:	83 c4 10             	add    $0x10,%esp
80100d88:	c9                   	leave  
80100d89:	c3                   	ret    
80100d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d90 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d90:	55                   	push   %ebp
80100d91:	89 e5                	mov    %esp,%ebp
80100d93:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d94:	bb b4 09 11 80       	mov    $0x801109b4,%ebx
{
80100d99:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100d9c:	68 80 09 11 80       	push   $0x80110980
80100da1:	e8 2a 37 00 00       	call   801044d0 <acquire>
80100da6:	83 c4 10             	add    $0x10,%esp
80100da9:	eb 10                	jmp    80100dbb <filealloc+0x2b>
80100dab:	90                   	nop
80100dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100db0:	83 c3 18             	add    $0x18,%ebx
80100db3:	81 fb 14 13 11 80    	cmp    $0x80111314,%ebx
80100db9:	73 25                	jae    80100de0 <filealloc+0x50>
    if(f->ref == 0){
80100dbb:	8b 43 04             	mov    0x4(%ebx),%eax
80100dbe:	85 c0                	test   %eax,%eax
80100dc0:	75 ee                	jne    80100db0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100dc2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100dc5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dcc:	68 80 09 11 80       	push   $0x80110980
80100dd1:	e8 ba 37 00 00       	call   80104590 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dd6:	89 d8                	mov    %ebx,%eax
      return f;
80100dd8:	83 c4 10             	add    $0x10,%esp
}
80100ddb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dde:	c9                   	leave  
80100ddf:	c3                   	ret    
  release(&ftable.lock);
80100de0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100de3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100de5:	68 80 09 11 80       	push   $0x80110980
80100dea:	e8 a1 37 00 00       	call   80104590 <release>
}
80100def:	89 d8                	mov    %ebx,%eax
  return 0;
80100df1:	83 c4 10             	add    $0x10,%esp
}
80100df4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100df7:	c9                   	leave  
80100df8:	c3                   	ret    
80100df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100e00 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100e00:	55                   	push   %ebp
80100e01:	89 e5                	mov    %esp,%ebp
80100e03:	53                   	push   %ebx
80100e04:	83 ec 10             	sub    $0x10,%esp
80100e07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100e0a:	68 80 09 11 80       	push   $0x80110980
80100e0f:	e8 bc 36 00 00       	call   801044d0 <acquire>
  if(f->ref < 1)
80100e14:	8b 43 04             	mov    0x4(%ebx),%eax
80100e17:	83 c4 10             	add    $0x10,%esp
80100e1a:	85 c0                	test   %eax,%eax
80100e1c:	7e 1a                	jle    80100e38 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e1e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e21:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e24:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e27:	68 80 09 11 80       	push   $0x80110980
80100e2c:	e8 5f 37 00 00       	call   80104590 <release>
  return f;
}
80100e31:	89 d8                	mov    %ebx,%eax
80100e33:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e36:	c9                   	leave  
80100e37:	c3                   	ret    
    panic("filedup");
80100e38:	83 ec 0c             	sub    $0xc,%esp
80100e3b:	68 f4 72 10 80       	push   $0x801072f4
80100e40:	e8 4b f5 ff ff       	call   80100390 <panic>
80100e45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e50 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e50:	55                   	push   %ebp
80100e51:	89 e5                	mov    %esp,%ebp
80100e53:	57                   	push   %edi
80100e54:	56                   	push   %esi
80100e55:	53                   	push   %ebx
80100e56:	83 ec 28             	sub    $0x28,%esp
80100e59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100e5c:	68 80 09 11 80       	push   $0x80110980
80100e61:	e8 6a 36 00 00       	call   801044d0 <acquire>
  if(f->ref < 1)
80100e66:	8b 43 04             	mov    0x4(%ebx),%eax
80100e69:	83 c4 10             	add    $0x10,%esp
80100e6c:	85 c0                	test   %eax,%eax
80100e6e:	0f 8e 9b 00 00 00    	jle    80100f0f <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e74:	83 e8 01             	sub    $0x1,%eax
80100e77:	85 c0                	test   %eax,%eax
80100e79:	89 43 04             	mov    %eax,0x4(%ebx)
80100e7c:	74 1a                	je     80100e98 <fileclose+0x48>
    release(&ftable.lock);
80100e7e:	c7 45 08 80 09 11 80 	movl   $0x80110980,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e85:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e88:	5b                   	pop    %ebx
80100e89:	5e                   	pop    %esi
80100e8a:	5f                   	pop    %edi
80100e8b:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e8c:	e9 ff 36 00 00       	jmp    80104590 <release>
80100e91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100e98:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100e9c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100e9e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100ea1:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100ea4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100eaa:	88 45 e7             	mov    %al,-0x19(%ebp)
80100ead:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100eb0:	68 80 09 11 80       	push   $0x80110980
  ff = *f;
80100eb5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100eb8:	e8 d3 36 00 00       	call   80104590 <release>
  if(ff.type == FD_PIPE)
80100ebd:	83 c4 10             	add    $0x10,%esp
80100ec0:	83 ff 01             	cmp    $0x1,%edi
80100ec3:	74 13                	je     80100ed8 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100ec5:	83 ff 02             	cmp    $0x2,%edi
80100ec8:	74 26                	je     80100ef0 <fileclose+0xa0>
}
80100eca:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ecd:	5b                   	pop    %ebx
80100ece:	5e                   	pop    %esi
80100ecf:	5f                   	pop    %edi
80100ed0:	5d                   	pop    %ebp
80100ed1:	c3                   	ret    
80100ed2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100ed8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100edc:	83 ec 08             	sub    $0x8,%esp
80100edf:	53                   	push   %ebx
80100ee0:	56                   	push   %esi
80100ee1:	e8 7a 24 00 00       	call   80103360 <pipeclose>
80100ee6:	83 c4 10             	add    $0x10,%esp
80100ee9:	eb df                	jmp    80100eca <fileclose+0x7a>
80100eeb:	90                   	nop
80100eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100ef0:	e8 cb 1c 00 00       	call   80102bc0 <begin_op>
    iput(ff.ip);
80100ef5:	83 ec 0c             	sub    $0xc,%esp
80100ef8:	ff 75 e0             	pushl  -0x20(%ebp)
80100efb:	e8 d0 08 00 00       	call   801017d0 <iput>
    end_op();
80100f00:	83 c4 10             	add    $0x10,%esp
}
80100f03:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f06:	5b                   	pop    %ebx
80100f07:	5e                   	pop    %esi
80100f08:	5f                   	pop    %edi
80100f09:	5d                   	pop    %ebp
    end_op();
80100f0a:	e9 21 1d 00 00       	jmp    80102c30 <end_op>
    panic("fileclose");
80100f0f:	83 ec 0c             	sub    $0xc,%esp
80100f12:	68 fc 72 10 80       	push   $0x801072fc
80100f17:	e8 74 f4 ff ff       	call   80100390 <panic>
80100f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f20 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f20:	55                   	push   %ebp
80100f21:	89 e5                	mov    %esp,%ebp
80100f23:	53                   	push   %ebx
80100f24:	83 ec 04             	sub    $0x4,%esp
80100f27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f2a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f2d:	75 31                	jne    80100f60 <filestat+0x40>
    ilock(f->ip);
80100f2f:	83 ec 0c             	sub    $0xc,%esp
80100f32:	ff 73 10             	pushl  0x10(%ebx)
80100f35:	e8 66 07 00 00       	call   801016a0 <ilock>
    stati(f->ip, st);
80100f3a:	58                   	pop    %eax
80100f3b:	5a                   	pop    %edx
80100f3c:	ff 75 0c             	pushl  0xc(%ebp)
80100f3f:	ff 73 10             	pushl  0x10(%ebx)
80100f42:	e8 09 0a 00 00       	call   80101950 <stati>
    iunlock(f->ip);
80100f47:	59                   	pop    %ecx
80100f48:	ff 73 10             	pushl  0x10(%ebx)
80100f4b:	e8 30 08 00 00       	call   80101780 <iunlock>
    return 0;
80100f50:	83 c4 10             	add    $0x10,%esp
80100f53:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f55:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f58:	c9                   	leave  
80100f59:	c3                   	ret    
80100f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100f60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f65:	eb ee                	jmp    80100f55 <filestat+0x35>
80100f67:	89 f6                	mov    %esi,%esi
80100f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f70 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f70:	55                   	push   %ebp
80100f71:	89 e5                	mov    %esp,%ebp
80100f73:	57                   	push   %edi
80100f74:	56                   	push   %esi
80100f75:	53                   	push   %ebx
80100f76:	83 ec 0c             	sub    $0xc,%esp
80100f79:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f7c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f7f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f82:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f86:	74 60                	je     80100fe8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f88:	8b 03                	mov    (%ebx),%eax
80100f8a:	83 f8 01             	cmp    $0x1,%eax
80100f8d:	74 41                	je     80100fd0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f8f:	83 f8 02             	cmp    $0x2,%eax
80100f92:	75 5b                	jne    80100fef <fileread+0x7f>
    ilock(f->ip);
80100f94:	83 ec 0c             	sub    $0xc,%esp
80100f97:	ff 73 10             	pushl  0x10(%ebx)
80100f9a:	e8 01 07 00 00       	call   801016a0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f9f:	57                   	push   %edi
80100fa0:	ff 73 14             	pushl  0x14(%ebx)
80100fa3:	56                   	push   %esi
80100fa4:	ff 73 10             	pushl  0x10(%ebx)
80100fa7:	e8 d4 09 00 00       	call   80101980 <readi>
80100fac:	83 c4 20             	add    $0x20,%esp
80100faf:	85 c0                	test   %eax,%eax
80100fb1:	89 c6                	mov    %eax,%esi
80100fb3:	7e 03                	jle    80100fb8 <fileread+0x48>
      f->off += r;
80100fb5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fb8:	83 ec 0c             	sub    $0xc,%esp
80100fbb:	ff 73 10             	pushl  0x10(%ebx)
80100fbe:	e8 bd 07 00 00       	call   80101780 <iunlock>
    return r;
80100fc3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100fc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fc9:	89 f0                	mov    %esi,%eax
80100fcb:	5b                   	pop    %ebx
80100fcc:	5e                   	pop    %esi
80100fcd:	5f                   	pop    %edi
80100fce:	5d                   	pop    %ebp
80100fcf:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80100fd0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fd3:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100fd6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fd9:	5b                   	pop    %ebx
80100fda:	5e                   	pop    %esi
80100fdb:	5f                   	pop    %edi
80100fdc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100fdd:	e9 2e 25 00 00       	jmp    80103510 <piperead>
80100fe2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80100fe8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100fed:	eb d7                	jmp    80100fc6 <fileread+0x56>
  panic("fileread");
80100fef:	83 ec 0c             	sub    $0xc,%esp
80100ff2:	68 06 73 10 80       	push   $0x80107306
80100ff7:	e8 94 f3 ff ff       	call   80100390 <panic>
80100ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101000 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101000:	55                   	push   %ebp
80101001:	89 e5                	mov    %esp,%ebp
80101003:	57                   	push   %edi
80101004:	56                   	push   %esi
80101005:	53                   	push   %ebx
80101006:	83 ec 1c             	sub    $0x1c,%esp
80101009:	8b 75 08             	mov    0x8(%ebp),%esi
8010100c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
8010100f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101013:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101016:	8b 45 10             	mov    0x10(%ebp),%eax
80101019:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010101c:	0f 84 aa 00 00 00    	je     801010cc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101022:	8b 06                	mov    (%esi),%eax
80101024:	83 f8 01             	cmp    $0x1,%eax
80101027:	0f 84 c3 00 00 00    	je     801010f0 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010102d:	83 f8 02             	cmp    $0x2,%eax
80101030:	0f 85 d9 00 00 00    	jne    8010110f <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101036:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101039:	31 ff                	xor    %edi,%edi
    while(i < n){
8010103b:	85 c0                	test   %eax,%eax
8010103d:	7f 34                	jg     80101073 <filewrite+0x73>
8010103f:	e9 9c 00 00 00       	jmp    801010e0 <filewrite+0xe0>
80101044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101048:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010104b:	83 ec 0c             	sub    $0xc,%esp
8010104e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101051:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101054:	e8 27 07 00 00       	call   80101780 <iunlock>
      end_op();
80101059:	e8 d2 1b 00 00       	call   80102c30 <end_op>
8010105e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101061:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101064:	39 c3                	cmp    %eax,%ebx
80101066:	0f 85 96 00 00 00    	jne    80101102 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010106c:	01 df                	add    %ebx,%edi
    while(i < n){
8010106e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101071:	7e 6d                	jle    801010e0 <filewrite+0xe0>
      int n1 = n - i;
80101073:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101076:	b8 00 06 00 00       	mov    $0x600,%eax
8010107b:	29 fb                	sub    %edi,%ebx
8010107d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101083:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101086:	e8 35 1b 00 00       	call   80102bc0 <begin_op>
      ilock(f->ip);
8010108b:	83 ec 0c             	sub    $0xc,%esp
8010108e:	ff 76 10             	pushl  0x10(%esi)
80101091:	e8 0a 06 00 00       	call   801016a0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101096:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101099:	53                   	push   %ebx
8010109a:	ff 76 14             	pushl  0x14(%esi)
8010109d:	01 f8                	add    %edi,%eax
8010109f:	50                   	push   %eax
801010a0:	ff 76 10             	pushl  0x10(%esi)
801010a3:	e8 d8 09 00 00       	call   80101a80 <writei>
801010a8:	83 c4 20             	add    $0x20,%esp
801010ab:	85 c0                	test   %eax,%eax
801010ad:	7f 99                	jg     80101048 <filewrite+0x48>
      iunlock(f->ip);
801010af:	83 ec 0c             	sub    $0xc,%esp
801010b2:	ff 76 10             	pushl  0x10(%esi)
801010b5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010b8:	e8 c3 06 00 00       	call   80101780 <iunlock>
      end_op();
801010bd:	e8 6e 1b 00 00       	call   80102c30 <end_op>
      if(r < 0)
801010c2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010c5:	83 c4 10             	add    $0x10,%esp
801010c8:	85 c0                	test   %eax,%eax
801010ca:	74 98                	je     80101064 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801010cf:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
801010d4:	89 f8                	mov    %edi,%eax
801010d6:	5b                   	pop    %ebx
801010d7:	5e                   	pop    %esi
801010d8:	5f                   	pop    %edi
801010d9:	5d                   	pop    %ebp
801010da:	c3                   	ret    
801010db:	90                   	nop
801010dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
801010e0:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010e3:	75 e7                	jne    801010cc <filewrite+0xcc>
}
801010e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010e8:	89 f8                	mov    %edi,%eax
801010ea:	5b                   	pop    %ebx
801010eb:	5e                   	pop    %esi
801010ec:	5f                   	pop    %edi
801010ed:	5d                   	pop    %ebp
801010ee:	c3                   	ret    
801010ef:	90                   	nop
    return pipewrite(f->pipe, addr, n);
801010f0:	8b 46 0c             	mov    0xc(%esi),%eax
801010f3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010f9:	5b                   	pop    %ebx
801010fa:	5e                   	pop    %esi
801010fb:	5f                   	pop    %edi
801010fc:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801010fd:	e9 fe 22 00 00       	jmp    80103400 <pipewrite>
        panic("short filewrite");
80101102:	83 ec 0c             	sub    $0xc,%esp
80101105:	68 0f 73 10 80       	push   $0x8010730f
8010110a:	e8 81 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
8010110f:	83 ec 0c             	sub    $0xc,%esp
80101112:	68 15 73 10 80       	push   $0x80107315
80101117:	e8 74 f2 ff ff       	call   80100390 <panic>
8010111c:	66 90                	xchg   %ax,%ax
8010111e:	66 90                	xchg   %ax,%ax

80101120 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101120:	55                   	push   %ebp
80101121:	89 e5                	mov    %esp,%ebp
80101123:	57                   	push   %edi
80101124:	56                   	push   %esi
80101125:	53                   	push   %ebx
80101126:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101129:	8b 0d 80 13 11 80    	mov    0x80111380,%ecx
{
8010112f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101132:	85 c9                	test   %ecx,%ecx
80101134:	0f 84 87 00 00 00    	je     801011c1 <balloc+0xa1>
8010113a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101141:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101144:	83 ec 08             	sub    $0x8,%esp
80101147:	89 f0                	mov    %esi,%eax
80101149:	c1 f8 0c             	sar    $0xc,%eax
8010114c:	03 05 98 13 11 80    	add    0x80111398,%eax
80101152:	50                   	push   %eax
80101153:	ff 75 d8             	pushl  -0x28(%ebp)
80101156:	e8 75 ef ff ff       	call   801000d0 <bread>
8010115b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010115e:	a1 80 13 11 80       	mov    0x80111380,%eax
80101163:	83 c4 10             	add    $0x10,%esp
80101166:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101169:	31 c0                	xor    %eax,%eax
8010116b:	eb 2f                	jmp    8010119c <balloc+0x7c>
8010116d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101170:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101172:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101175:	bb 01 00 00 00       	mov    $0x1,%ebx
8010117a:	83 e1 07             	and    $0x7,%ecx
8010117d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010117f:	89 c1                	mov    %eax,%ecx
80101181:	c1 f9 03             	sar    $0x3,%ecx
80101184:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101189:	85 df                	test   %ebx,%edi
8010118b:	89 fa                	mov    %edi,%edx
8010118d:	74 41                	je     801011d0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010118f:	83 c0 01             	add    $0x1,%eax
80101192:	83 c6 01             	add    $0x1,%esi
80101195:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010119a:	74 05                	je     801011a1 <balloc+0x81>
8010119c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010119f:	77 cf                	ja     80101170 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801011a1:	83 ec 0c             	sub    $0xc,%esp
801011a4:	ff 75 e4             	pushl  -0x1c(%ebp)
801011a7:	e8 34 f0 ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801011ac:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801011b3:	83 c4 10             	add    $0x10,%esp
801011b6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011b9:	39 05 80 13 11 80    	cmp    %eax,0x80111380
801011bf:	77 80                	ja     80101141 <balloc+0x21>
  }
  panic("balloc: out of blocks");
801011c1:	83 ec 0c             	sub    $0xc,%esp
801011c4:	68 1f 73 10 80       	push   $0x8010731f
801011c9:	e8 c2 f1 ff ff       	call   80100390 <panic>
801011ce:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801011d0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801011d3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801011d6:	09 da                	or     %ebx,%edx
801011d8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801011dc:	57                   	push   %edi
801011dd:	e8 ae 1b 00 00       	call   80102d90 <log_write>
        brelse(bp);
801011e2:	89 3c 24             	mov    %edi,(%esp)
801011e5:	e8 f6 ef ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
801011ea:	58                   	pop    %eax
801011eb:	5a                   	pop    %edx
801011ec:	56                   	push   %esi
801011ed:	ff 75 d8             	pushl  -0x28(%ebp)
801011f0:	e8 db ee ff ff       	call   801000d0 <bread>
801011f5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801011f7:	8d 40 5c             	lea    0x5c(%eax),%eax
801011fa:	83 c4 0c             	add    $0xc,%esp
801011fd:	68 00 02 00 00       	push   $0x200
80101202:	6a 00                	push   $0x0
80101204:	50                   	push   %eax
80101205:	e8 d6 33 00 00       	call   801045e0 <memset>
  log_write(bp);
8010120a:	89 1c 24             	mov    %ebx,(%esp)
8010120d:	e8 7e 1b 00 00       	call   80102d90 <log_write>
  brelse(bp);
80101212:	89 1c 24             	mov    %ebx,(%esp)
80101215:	e8 c6 ef ff ff       	call   801001e0 <brelse>
}
8010121a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010121d:	89 f0                	mov    %esi,%eax
8010121f:	5b                   	pop    %ebx
80101220:	5e                   	pop    %esi
80101221:	5f                   	pop    %edi
80101222:	5d                   	pop    %ebp
80101223:	c3                   	ret    
80101224:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010122a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101230 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101230:	55                   	push   %ebp
80101231:	89 e5                	mov    %esp,%ebp
80101233:	57                   	push   %edi
80101234:	56                   	push   %esi
80101235:	53                   	push   %ebx
80101236:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101238:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010123a:	bb d4 13 11 80       	mov    $0x801113d4,%ebx
{
8010123f:	83 ec 28             	sub    $0x28,%esp
80101242:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101245:	68 a0 13 11 80       	push   $0x801113a0
8010124a:	e8 81 32 00 00       	call   801044d0 <acquire>
8010124f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101252:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101255:	eb 17                	jmp    8010126e <iget+0x3e>
80101257:	89 f6                	mov    %esi,%esi
80101259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101260:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101266:	81 fb f4 2f 11 80    	cmp    $0x80112ff4,%ebx
8010126c:	73 22                	jae    80101290 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010126e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101271:	85 c9                	test   %ecx,%ecx
80101273:	7e 04                	jle    80101279 <iget+0x49>
80101275:	39 3b                	cmp    %edi,(%ebx)
80101277:	74 4f                	je     801012c8 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101279:	85 f6                	test   %esi,%esi
8010127b:	75 e3                	jne    80101260 <iget+0x30>
8010127d:	85 c9                	test   %ecx,%ecx
8010127f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101282:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101288:	81 fb f4 2f 11 80    	cmp    $0x80112ff4,%ebx
8010128e:	72 de                	jb     8010126e <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101290:	85 f6                	test   %esi,%esi
80101292:	74 5b                	je     801012ef <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101294:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101297:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101299:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010129c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801012a3:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801012aa:	68 a0 13 11 80       	push   $0x801113a0
801012af:	e8 dc 32 00 00       	call   80104590 <release>

  return ip;
801012b4:	83 c4 10             	add    $0x10,%esp
}
801012b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012ba:	89 f0                	mov    %esi,%eax
801012bc:	5b                   	pop    %ebx
801012bd:	5e                   	pop    %esi
801012be:	5f                   	pop    %edi
801012bf:	5d                   	pop    %ebp
801012c0:	c3                   	ret    
801012c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012c8:	39 53 04             	cmp    %edx,0x4(%ebx)
801012cb:	75 ac                	jne    80101279 <iget+0x49>
      release(&icache.lock);
801012cd:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801012d0:	83 c1 01             	add    $0x1,%ecx
      return ip;
801012d3:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801012d5:	68 a0 13 11 80       	push   $0x801113a0
      ip->ref++;
801012da:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012dd:	e8 ae 32 00 00       	call   80104590 <release>
      return ip;
801012e2:	83 c4 10             	add    $0x10,%esp
}
801012e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012e8:	89 f0                	mov    %esi,%eax
801012ea:	5b                   	pop    %ebx
801012eb:	5e                   	pop    %esi
801012ec:	5f                   	pop    %edi
801012ed:	5d                   	pop    %ebp
801012ee:	c3                   	ret    
    panic("iget: no inodes");
801012ef:	83 ec 0c             	sub    $0xc,%esp
801012f2:	68 35 73 10 80       	push   $0x80107335
801012f7:	e8 94 f0 ff ff       	call   80100390 <panic>
801012fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101300 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101300:	55                   	push   %ebp
80101301:	89 e5                	mov    %esp,%ebp
80101303:	57                   	push   %edi
80101304:	56                   	push   %esi
80101305:	53                   	push   %ebx
80101306:	89 c6                	mov    %eax,%esi
80101308:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010130b:	83 fa 0b             	cmp    $0xb,%edx
8010130e:	77 18                	ja     80101328 <bmap+0x28>
80101310:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101313:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101316:	85 db                	test   %ebx,%ebx
80101318:	74 76                	je     80101390 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010131a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010131d:	89 d8                	mov    %ebx,%eax
8010131f:	5b                   	pop    %ebx
80101320:	5e                   	pop    %esi
80101321:	5f                   	pop    %edi
80101322:	5d                   	pop    %ebp
80101323:	c3                   	ret    
80101324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101328:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
8010132b:	83 fb 7f             	cmp    $0x7f,%ebx
8010132e:	0f 87 90 00 00 00    	ja     801013c4 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101334:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
8010133a:	8b 00                	mov    (%eax),%eax
8010133c:	85 d2                	test   %edx,%edx
8010133e:	74 70                	je     801013b0 <bmap+0xb0>
    bp = bread(ip->dev, addr);
80101340:	83 ec 08             	sub    $0x8,%esp
80101343:	52                   	push   %edx
80101344:	50                   	push   %eax
80101345:	e8 86 ed ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
8010134a:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010134e:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
80101351:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
80101353:	8b 1a                	mov    (%edx),%ebx
80101355:	85 db                	test   %ebx,%ebx
80101357:	75 1d                	jne    80101376 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
80101359:	8b 06                	mov    (%esi),%eax
8010135b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010135e:	e8 bd fd ff ff       	call   80101120 <balloc>
80101363:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101366:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101369:	89 c3                	mov    %eax,%ebx
8010136b:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010136d:	57                   	push   %edi
8010136e:	e8 1d 1a 00 00       	call   80102d90 <log_write>
80101373:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101376:	83 ec 0c             	sub    $0xc,%esp
80101379:	57                   	push   %edi
8010137a:	e8 61 ee ff ff       	call   801001e0 <brelse>
8010137f:	83 c4 10             	add    $0x10,%esp
}
80101382:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101385:	89 d8                	mov    %ebx,%eax
80101387:	5b                   	pop    %ebx
80101388:	5e                   	pop    %esi
80101389:	5f                   	pop    %edi
8010138a:	5d                   	pop    %ebp
8010138b:	c3                   	ret    
8010138c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101390:	8b 00                	mov    (%eax),%eax
80101392:	e8 89 fd ff ff       	call   80101120 <balloc>
80101397:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010139a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010139d:	89 c3                	mov    %eax,%ebx
}
8010139f:	89 d8                	mov    %ebx,%eax
801013a1:	5b                   	pop    %ebx
801013a2:	5e                   	pop    %esi
801013a3:	5f                   	pop    %edi
801013a4:	5d                   	pop    %ebp
801013a5:	c3                   	ret    
801013a6:	8d 76 00             	lea    0x0(%esi),%esi
801013a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801013b0:	e8 6b fd ff ff       	call   80101120 <balloc>
801013b5:	89 c2                	mov    %eax,%edx
801013b7:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801013bd:	8b 06                	mov    (%esi),%eax
801013bf:	e9 7c ff ff ff       	jmp    80101340 <bmap+0x40>
  panic("bmap: out of range");
801013c4:	83 ec 0c             	sub    $0xc,%esp
801013c7:	68 45 73 10 80       	push   $0x80107345
801013cc:	e8 bf ef ff ff       	call   80100390 <panic>
801013d1:	eb 0d                	jmp    801013e0 <readsb>
801013d3:	90                   	nop
801013d4:	90                   	nop
801013d5:	90                   	nop
801013d6:	90                   	nop
801013d7:	90                   	nop
801013d8:	90                   	nop
801013d9:	90                   	nop
801013da:	90                   	nop
801013db:	90                   	nop
801013dc:	90                   	nop
801013dd:	90                   	nop
801013de:	90                   	nop
801013df:	90                   	nop

801013e0 <readsb>:
{
801013e0:	55                   	push   %ebp
801013e1:	89 e5                	mov    %esp,%ebp
801013e3:	56                   	push   %esi
801013e4:	53                   	push   %ebx
801013e5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801013e8:	83 ec 08             	sub    $0x8,%esp
801013eb:	6a 01                	push   $0x1
801013ed:	ff 75 08             	pushl  0x8(%ebp)
801013f0:	e8 db ec ff ff       	call   801000d0 <bread>
801013f5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801013f7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013fa:	83 c4 0c             	add    $0xc,%esp
801013fd:	6a 1c                	push   $0x1c
801013ff:	50                   	push   %eax
80101400:	56                   	push   %esi
80101401:	e8 8a 32 00 00       	call   80104690 <memmove>
  brelse(bp);
80101406:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101409:	83 c4 10             	add    $0x10,%esp
}
8010140c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010140f:	5b                   	pop    %ebx
80101410:	5e                   	pop    %esi
80101411:	5d                   	pop    %ebp
  brelse(bp);
80101412:	e9 c9 ed ff ff       	jmp    801001e0 <brelse>
80101417:	89 f6                	mov    %esi,%esi
80101419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101420 <bfree>:
{
80101420:	55                   	push   %ebp
80101421:	89 e5                	mov    %esp,%ebp
80101423:	56                   	push   %esi
80101424:	53                   	push   %ebx
80101425:	89 d3                	mov    %edx,%ebx
80101427:	89 c6                	mov    %eax,%esi
  readsb(dev, &sb);
80101429:	83 ec 08             	sub    $0x8,%esp
8010142c:	68 80 13 11 80       	push   $0x80111380
80101431:	50                   	push   %eax
80101432:	e8 a9 ff ff ff       	call   801013e0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101437:	58                   	pop    %eax
80101438:	5a                   	pop    %edx
80101439:	89 da                	mov    %ebx,%edx
8010143b:	c1 ea 0c             	shr    $0xc,%edx
8010143e:	03 15 98 13 11 80    	add    0x80111398,%edx
80101444:	52                   	push   %edx
80101445:	56                   	push   %esi
80101446:	e8 85 ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010144b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010144d:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
80101450:	ba 01 00 00 00       	mov    $0x1,%edx
80101455:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101458:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010145e:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101461:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101463:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101468:	85 d1                	test   %edx,%ecx
8010146a:	74 25                	je     80101491 <bfree+0x71>
  bp->data[bi/8] &= ~m;
8010146c:	f7 d2                	not    %edx
8010146e:	89 c6                	mov    %eax,%esi
  log_write(bp);
80101470:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101473:	21 ca                	and    %ecx,%edx
80101475:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101479:	56                   	push   %esi
8010147a:	e8 11 19 00 00       	call   80102d90 <log_write>
  brelse(bp);
8010147f:	89 34 24             	mov    %esi,(%esp)
80101482:	e8 59 ed ff ff       	call   801001e0 <brelse>
}
80101487:	83 c4 10             	add    $0x10,%esp
8010148a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010148d:	5b                   	pop    %ebx
8010148e:	5e                   	pop    %esi
8010148f:	5d                   	pop    %ebp
80101490:	c3                   	ret    
    panic("freeing free block");
80101491:	83 ec 0c             	sub    $0xc,%esp
80101494:	68 58 73 10 80       	push   $0x80107358
80101499:	e8 f2 ee ff ff       	call   80100390 <panic>
8010149e:	66 90                	xchg   %ax,%ax

801014a0 <iinit>:
{
801014a0:	55                   	push   %ebp
801014a1:	89 e5                	mov    %esp,%ebp
801014a3:	53                   	push   %ebx
801014a4:	bb e0 13 11 80       	mov    $0x801113e0,%ebx
801014a9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801014ac:	68 6b 73 10 80       	push   $0x8010736b
801014b1:	68 a0 13 11 80       	push   $0x801113a0
801014b6:	e8 d5 2e 00 00       	call   80104390 <initlock>
801014bb:	83 c4 10             	add    $0x10,%esp
801014be:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801014c0:	83 ec 08             	sub    $0x8,%esp
801014c3:	68 72 73 10 80       	push   $0x80107372
801014c8:	53                   	push   %ebx
801014c9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014cf:	e8 8c 2d 00 00       	call   80104260 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014d4:	83 c4 10             	add    $0x10,%esp
801014d7:	81 fb 00 30 11 80    	cmp    $0x80113000,%ebx
801014dd:	75 e1                	jne    801014c0 <iinit+0x20>
  readsb(dev, &sb);
801014df:	83 ec 08             	sub    $0x8,%esp
801014e2:	68 80 13 11 80       	push   $0x80111380
801014e7:	ff 75 08             	pushl  0x8(%ebp)
801014ea:	e8 f1 fe ff ff       	call   801013e0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014ef:	ff 35 98 13 11 80    	pushl  0x80111398
801014f5:	ff 35 94 13 11 80    	pushl  0x80111394
801014fb:	ff 35 90 13 11 80    	pushl  0x80111390
80101501:	ff 35 8c 13 11 80    	pushl  0x8011138c
80101507:	ff 35 88 13 11 80    	pushl  0x80111388
8010150d:	ff 35 84 13 11 80    	pushl  0x80111384
80101513:	ff 35 80 13 11 80    	pushl  0x80111380
80101519:	68 d8 73 10 80       	push   $0x801073d8
8010151e:	e8 3d f1 ff ff       	call   80100660 <cprintf>
}
80101523:	83 c4 30             	add    $0x30,%esp
80101526:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101529:	c9                   	leave  
8010152a:	c3                   	ret    
8010152b:	90                   	nop
8010152c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101530 <ialloc>:
{
80101530:	55                   	push   %ebp
80101531:	89 e5                	mov    %esp,%ebp
80101533:	57                   	push   %edi
80101534:	56                   	push   %esi
80101535:	53                   	push   %ebx
80101536:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101539:	83 3d 88 13 11 80 01 	cmpl   $0x1,0x80111388
{
80101540:	8b 45 0c             	mov    0xc(%ebp),%eax
80101543:	8b 75 08             	mov    0x8(%ebp),%esi
80101546:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101549:	0f 86 91 00 00 00    	jbe    801015e0 <ialloc+0xb0>
8010154f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101554:	eb 21                	jmp    80101577 <ialloc+0x47>
80101556:	8d 76 00             	lea    0x0(%esi),%esi
80101559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101560:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101563:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101566:	57                   	push   %edi
80101567:	e8 74 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010156c:	83 c4 10             	add    $0x10,%esp
8010156f:	39 1d 88 13 11 80    	cmp    %ebx,0x80111388
80101575:	76 69                	jbe    801015e0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101577:	89 d8                	mov    %ebx,%eax
80101579:	83 ec 08             	sub    $0x8,%esp
8010157c:	c1 e8 03             	shr    $0x3,%eax
8010157f:	03 05 94 13 11 80    	add    0x80111394,%eax
80101585:	50                   	push   %eax
80101586:	56                   	push   %esi
80101587:	e8 44 eb ff ff       	call   801000d0 <bread>
8010158c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010158e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101590:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
80101593:	83 e0 07             	and    $0x7,%eax
80101596:	c1 e0 06             	shl    $0x6,%eax
80101599:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010159d:	66 83 39 00          	cmpw   $0x0,(%ecx)
801015a1:	75 bd                	jne    80101560 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801015a3:	83 ec 04             	sub    $0x4,%esp
801015a6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801015a9:	6a 40                	push   $0x40
801015ab:	6a 00                	push   $0x0
801015ad:	51                   	push   %ecx
801015ae:	e8 2d 30 00 00       	call   801045e0 <memset>
      dip->type = type;
801015b3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801015b7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801015ba:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801015bd:	89 3c 24             	mov    %edi,(%esp)
801015c0:	e8 cb 17 00 00       	call   80102d90 <log_write>
      brelse(bp);
801015c5:	89 3c 24             	mov    %edi,(%esp)
801015c8:	e8 13 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801015cd:	83 c4 10             	add    $0x10,%esp
}
801015d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801015d3:	89 da                	mov    %ebx,%edx
801015d5:	89 f0                	mov    %esi,%eax
}
801015d7:	5b                   	pop    %ebx
801015d8:	5e                   	pop    %esi
801015d9:	5f                   	pop    %edi
801015da:	5d                   	pop    %ebp
      return iget(dev, inum);
801015db:	e9 50 fc ff ff       	jmp    80101230 <iget>
  panic("ialloc: no inodes");
801015e0:	83 ec 0c             	sub    $0xc,%esp
801015e3:	68 78 73 10 80       	push   $0x80107378
801015e8:	e8 a3 ed ff ff       	call   80100390 <panic>
801015ed:	8d 76 00             	lea    0x0(%esi),%esi

801015f0 <iupdate>:
{
801015f0:	55                   	push   %ebp
801015f1:	89 e5                	mov    %esp,%ebp
801015f3:	56                   	push   %esi
801015f4:	53                   	push   %ebx
801015f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015f8:	83 ec 08             	sub    $0x8,%esp
801015fb:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015fe:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101601:	c1 e8 03             	shr    $0x3,%eax
80101604:	03 05 94 13 11 80    	add    0x80111394,%eax
8010160a:	50                   	push   %eax
8010160b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010160e:	e8 bd ea ff ff       	call   801000d0 <bread>
80101613:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101615:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101618:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010161c:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010161f:	83 e0 07             	and    $0x7,%eax
80101622:	c1 e0 06             	shl    $0x6,%eax
80101625:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101629:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010162c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101630:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101633:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101637:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010163b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010163f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101643:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101647:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010164a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010164d:	6a 34                	push   $0x34
8010164f:	53                   	push   %ebx
80101650:	50                   	push   %eax
80101651:	e8 3a 30 00 00       	call   80104690 <memmove>
  log_write(bp);
80101656:	89 34 24             	mov    %esi,(%esp)
80101659:	e8 32 17 00 00       	call   80102d90 <log_write>
  brelse(bp);
8010165e:	89 75 08             	mov    %esi,0x8(%ebp)
80101661:	83 c4 10             	add    $0x10,%esp
}
80101664:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101667:	5b                   	pop    %ebx
80101668:	5e                   	pop    %esi
80101669:	5d                   	pop    %ebp
  brelse(bp);
8010166a:	e9 71 eb ff ff       	jmp    801001e0 <brelse>
8010166f:	90                   	nop

80101670 <idup>:
{
80101670:	55                   	push   %ebp
80101671:	89 e5                	mov    %esp,%ebp
80101673:	53                   	push   %ebx
80101674:	83 ec 10             	sub    $0x10,%esp
80101677:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010167a:	68 a0 13 11 80       	push   $0x801113a0
8010167f:	e8 4c 2e 00 00       	call   801044d0 <acquire>
  ip->ref++;
80101684:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101688:	c7 04 24 a0 13 11 80 	movl   $0x801113a0,(%esp)
8010168f:	e8 fc 2e 00 00       	call   80104590 <release>
}
80101694:	89 d8                	mov    %ebx,%eax
80101696:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101699:	c9                   	leave  
8010169a:	c3                   	ret    
8010169b:	90                   	nop
8010169c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801016a0 <ilock>:
{
801016a0:	55                   	push   %ebp
801016a1:	89 e5                	mov    %esp,%ebp
801016a3:	56                   	push   %esi
801016a4:	53                   	push   %ebx
801016a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801016a8:	85 db                	test   %ebx,%ebx
801016aa:	0f 84 b7 00 00 00    	je     80101767 <ilock+0xc7>
801016b0:	8b 53 08             	mov    0x8(%ebx),%edx
801016b3:	85 d2                	test   %edx,%edx
801016b5:	0f 8e ac 00 00 00    	jle    80101767 <ilock+0xc7>
  acquiresleep(&ip->lock);
801016bb:	8d 43 0c             	lea    0xc(%ebx),%eax
801016be:	83 ec 0c             	sub    $0xc,%esp
801016c1:	50                   	push   %eax
801016c2:	e8 d9 2b 00 00       	call   801042a0 <acquiresleep>
  if(ip->valid == 0){
801016c7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801016ca:	83 c4 10             	add    $0x10,%esp
801016cd:	85 c0                	test   %eax,%eax
801016cf:	74 0f                	je     801016e0 <ilock+0x40>
}
801016d1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016d4:	5b                   	pop    %ebx
801016d5:	5e                   	pop    %esi
801016d6:	5d                   	pop    %ebp
801016d7:	c3                   	ret    
801016d8:	90                   	nop
801016d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016e0:	8b 43 04             	mov    0x4(%ebx),%eax
801016e3:	83 ec 08             	sub    $0x8,%esp
801016e6:	c1 e8 03             	shr    $0x3,%eax
801016e9:	03 05 94 13 11 80    	add    0x80111394,%eax
801016ef:	50                   	push   %eax
801016f0:	ff 33                	pushl  (%ebx)
801016f2:	e8 d9 e9 ff ff       	call   801000d0 <bread>
801016f7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016f9:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016fc:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016ff:	83 e0 07             	and    $0x7,%eax
80101702:	c1 e0 06             	shl    $0x6,%eax
80101705:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101709:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010170c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010170f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101713:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101717:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010171b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010171f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101723:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101727:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010172b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010172e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101731:	6a 34                	push   $0x34
80101733:	50                   	push   %eax
80101734:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101737:	50                   	push   %eax
80101738:	e8 53 2f 00 00       	call   80104690 <memmove>
    brelse(bp);
8010173d:	89 34 24             	mov    %esi,(%esp)
80101740:	e8 9b ea ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101745:	83 c4 10             	add    $0x10,%esp
80101748:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010174d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101754:	0f 85 77 ff ff ff    	jne    801016d1 <ilock+0x31>
      panic("ilock: no type");
8010175a:	83 ec 0c             	sub    $0xc,%esp
8010175d:	68 90 73 10 80       	push   $0x80107390
80101762:	e8 29 ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101767:	83 ec 0c             	sub    $0xc,%esp
8010176a:	68 8a 73 10 80       	push   $0x8010738a
8010176f:	e8 1c ec ff ff       	call   80100390 <panic>
80101774:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010177a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101780 <iunlock>:
{
80101780:	55                   	push   %ebp
80101781:	89 e5                	mov    %esp,%ebp
80101783:	56                   	push   %esi
80101784:	53                   	push   %ebx
80101785:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101788:	85 db                	test   %ebx,%ebx
8010178a:	74 28                	je     801017b4 <iunlock+0x34>
8010178c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010178f:	83 ec 0c             	sub    $0xc,%esp
80101792:	56                   	push   %esi
80101793:	e8 a8 2b 00 00       	call   80104340 <holdingsleep>
80101798:	83 c4 10             	add    $0x10,%esp
8010179b:	85 c0                	test   %eax,%eax
8010179d:	74 15                	je     801017b4 <iunlock+0x34>
8010179f:	8b 43 08             	mov    0x8(%ebx),%eax
801017a2:	85 c0                	test   %eax,%eax
801017a4:	7e 0e                	jle    801017b4 <iunlock+0x34>
  releasesleep(&ip->lock);
801017a6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801017a9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017ac:	5b                   	pop    %ebx
801017ad:	5e                   	pop    %esi
801017ae:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801017af:	e9 4c 2b 00 00       	jmp    80104300 <releasesleep>
    panic("iunlock");
801017b4:	83 ec 0c             	sub    $0xc,%esp
801017b7:	68 9f 73 10 80       	push   $0x8010739f
801017bc:	e8 cf eb ff ff       	call   80100390 <panic>
801017c1:	eb 0d                	jmp    801017d0 <iput>
801017c3:	90                   	nop
801017c4:	90                   	nop
801017c5:	90                   	nop
801017c6:	90                   	nop
801017c7:	90                   	nop
801017c8:	90                   	nop
801017c9:	90                   	nop
801017ca:	90                   	nop
801017cb:	90                   	nop
801017cc:	90                   	nop
801017cd:	90                   	nop
801017ce:	90                   	nop
801017cf:	90                   	nop

801017d0 <iput>:
{
801017d0:	55                   	push   %ebp
801017d1:	89 e5                	mov    %esp,%ebp
801017d3:	57                   	push   %edi
801017d4:	56                   	push   %esi
801017d5:	53                   	push   %ebx
801017d6:	83 ec 28             	sub    $0x28,%esp
801017d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801017dc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801017df:	57                   	push   %edi
801017e0:	e8 bb 2a 00 00       	call   801042a0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801017e5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801017e8:	83 c4 10             	add    $0x10,%esp
801017eb:	85 d2                	test   %edx,%edx
801017ed:	74 07                	je     801017f6 <iput+0x26>
801017ef:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801017f4:	74 32                	je     80101828 <iput+0x58>
  releasesleep(&ip->lock);
801017f6:	83 ec 0c             	sub    $0xc,%esp
801017f9:	57                   	push   %edi
801017fa:	e8 01 2b 00 00       	call   80104300 <releasesleep>
  acquire(&icache.lock);
801017ff:	c7 04 24 a0 13 11 80 	movl   $0x801113a0,(%esp)
80101806:	e8 c5 2c 00 00       	call   801044d0 <acquire>
  ip->ref--;
8010180b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010180f:	83 c4 10             	add    $0x10,%esp
80101812:	c7 45 08 a0 13 11 80 	movl   $0x801113a0,0x8(%ebp)
}
80101819:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010181c:	5b                   	pop    %ebx
8010181d:	5e                   	pop    %esi
8010181e:	5f                   	pop    %edi
8010181f:	5d                   	pop    %ebp
  release(&icache.lock);
80101820:	e9 6b 2d 00 00       	jmp    80104590 <release>
80101825:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101828:	83 ec 0c             	sub    $0xc,%esp
8010182b:	68 a0 13 11 80       	push   $0x801113a0
80101830:	e8 9b 2c 00 00       	call   801044d0 <acquire>
    int r = ip->ref;
80101835:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101838:	c7 04 24 a0 13 11 80 	movl   $0x801113a0,(%esp)
8010183f:	e8 4c 2d 00 00       	call   80104590 <release>
    if(r == 1){
80101844:	83 c4 10             	add    $0x10,%esp
80101847:	83 fe 01             	cmp    $0x1,%esi
8010184a:	75 aa                	jne    801017f6 <iput+0x26>
8010184c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101852:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101855:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101858:	89 cf                	mov    %ecx,%edi
8010185a:	eb 0b                	jmp    80101867 <iput+0x97>
8010185c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101860:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101863:	39 fe                	cmp    %edi,%esi
80101865:	74 19                	je     80101880 <iput+0xb0>
    if(ip->addrs[i]){
80101867:	8b 16                	mov    (%esi),%edx
80101869:	85 d2                	test   %edx,%edx
8010186b:	74 f3                	je     80101860 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010186d:	8b 03                	mov    (%ebx),%eax
8010186f:	e8 ac fb ff ff       	call   80101420 <bfree>
      ip->addrs[i] = 0;
80101874:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010187a:	eb e4                	jmp    80101860 <iput+0x90>
8010187c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101880:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101886:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101889:	85 c0                	test   %eax,%eax
8010188b:	75 33                	jne    801018c0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010188d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101890:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101897:	53                   	push   %ebx
80101898:	e8 53 fd ff ff       	call   801015f0 <iupdate>
      ip->type = 0;
8010189d:	31 c0                	xor    %eax,%eax
8010189f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
801018a3:	89 1c 24             	mov    %ebx,(%esp)
801018a6:	e8 45 fd ff ff       	call   801015f0 <iupdate>
      ip->valid = 0;
801018ab:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801018b2:	83 c4 10             	add    $0x10,%esp
801018b5:	e9 3c ff ff ff       	jmp    801017f6 <iput+0x26>
801018ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018c0:	83 ec 08             	sub    $0x8,%esp
801018c3:	50                   	push   %eax
801018c4:	ff 33                	pushl  (%ebx)
801018c6:	e8 05 e8 ff ff       	call   801000d0 <bread>
801018cb:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801018d1:	89 7d e0             	mov    %edi,-0x20(%ebp)
801018d4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801018d7:	8d 70 5c             	lea    0x5c(%eax),%esi
801018da:	83 c4 10             	add    $0x10,%esp
801018dd:	89 cf                	mov    %ecx,%edi
801018df:	eb 0e                	jmp    801018ef <iput+0x11f>
801018e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018e8:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
801018eb:	39 fe                	cmp    %edi,%esi
801018ed:	74 0f                	je     801018fe <iput+0x12e>
      if(a[j])
801018ef:	8b 16                	mov    (%esi),%edx
801018f1:	85 d2                	test   %edx,%edx
801018f3:	74 f3                	je     801018e8 <iput+0x118>
        bfree(ip->dev, a[j]);
801018f5:	8b 03                	mov    (%ebx),%eax
801018f7:	e8 24 fb ff ff       	call   80101420 <bfree>
801018fc:	eb ea                	jmp    801018e8 <iput+0x118>
    brelse(bp);
801018fe:	83 ec 0c             	sub    $0xc,%esp
80101901:	ff 75 e4             	pushl  -0x1c(%ebp)
80101904:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101907:	e8 d4 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010190c:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101912:	8b 03                	mov    (%ebx),%eax
80101914:	e8 07 fb ff ff       	call   80101420 <bfree>
    ip->addrs[NDIRECT] = 0;
80101919:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101920:	00 00 00 
80101923:	83 c4 10             	add    $0x10,%esp
80101926:	e9 62 ff ff ff       	jmp    8010188d <iput+0xbd>
8010192b:	90                   	nop
8010192c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101930 <iunlockput>:
{
80101930:	55                   	push   %ebp
80101931:	89 e5                	mov    %esp,%ebp
80101933:	53                   	push   %ebx
80101934:	83 ec 10             	sub    $0x10,%esp
80101937:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010193a:	53                   	push   %ebx
8010193b:	e8 40 fe ff ff       	call   80101780 <iunlock>
  iput(ip);
80101940:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101943:	83 c4 10             	add    $0x10,%esp
}
80101946:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101949:	c9                   	leave  
  iput(ip);
8010194a:	e9 81 fe ff ff       	jmp    801017d0 <iput>
8010194f:	90                   	nop

80101950 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101950:	55                   	push   %ebp
80101951:	89 e5                	mov    %esp,%ebp
80101953:	8b 55 08             	mov    0x8(%ebp),%edx
80101956:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101959:	8b 0a                	mov    (%edx),%ecx
8010195b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010195e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101961:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101964:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101968:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010196b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010196f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101973:	8b 52 58             	mov    0x58(%edx),%edx
80101976:	89 50 10             	mov    %edx,0x10(%eax)
}
80101979:	5d                   	pop    %ebp
8010197a:	c3                   	ret    
8010197b:	90                   	nop
8010197c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101980 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101980:	55                   	push   %ebp
80101981:	89 e5                	mov    %esp,%ebp
80101983:	57                   	push   %edi
80101984:	56                   	push   %esi
80101985:	53                   	push   %ebx
80101986:	83 ec 1c             	sub    $0x1c,%esp
80101989:	8b 45 08             	mov    0x8(%ebp),%eax
8010198c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010198f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101992:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101997:	89 75 e0             	mov    %esi,-0x20(%ebp)
8010199a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010199d:	8b 75 10             	mov    0x10(%ebp),%esi
801019a0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
801019a3:	0f 84 a7 00 00 00    	je     80101a50 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801019a9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801019ac:	8b 40 58             	mov    0x58(%eax),%eax
801019af:	39 c6                	cmp    %eax,%esi
801019b1:	0f 87 ba 00 00 00    	ja     80101a71 <readi+0xf1>
801019b7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019ba:	89 f9                	mov    %edi,%ecx
801019bc:	01 f1                	add    %esi,%ecx
801019be:	0f 82 ad 00 00 00    	jb     80101a71 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019c4:	89 c2                	mov    %eax,%edx
801019c6:	29 f2                	sub    %esi,%edx
801019c8:	39 c8                	cmp    %ecx,%eax
801019ca:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019cd:	31 ff                	xor    %edi,%edi
801019cf:	85 d2                	test   %edx,%edx
    n = ip->size - off;
801019d1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019d4:	74 6c                	je     80101a42 <readi+0xc2>
801019d6:	8d 76 00             	lea    0x0(%esi),%esi
801019d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019e0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019e3:	89 f2                	mov    %esi,%edx
801019e5:	c1 ea 09             	shr    $0x9,%edx
801019e8:	89 d8                	mov    %ebx,%eax
801019ea:	e8 11 f9 ff ff       	call   80101300 <bmap>
801019ef:	83 ec 08             	sub    $0x8,%esp
801019f2:	50                   	push   %eax
801019f3:	ff 33                	pushl  (%ebx)
801019f5:	e8 d6 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801019fa:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019fd:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019ff:	89 f0                	mov    %esi,%eax
80101a01:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a06:	b9 00 02 00 00       	mov    $0x200,%ecx
80101a0b:	83 c4 0c             	add    $0xc,%esp
80101a0e:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101a10:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101a14:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101a17:	29 fb                	sub    %edi,%ebx
80101a19:	39 d9                	cmp    %ebx,%ecx
80101a1b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a1e:	53                   	push   %ebx
80101a1f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a20:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101a22:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a25:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a27:	e8 64 2c 00 00       	call   80104690 <memmove>
    brelse(bp);
80101a2c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a2f:	89 14 24             	mov    %edx,(%esp)
80101a32:	e8 a9 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a37:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a3a:	83 c4 10             	add    $0x10,%esp
80101a3d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a40:	77 9e                	ja     801019e0 <readi+0x60>
  }
  return n;
80101a42:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a45:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a48:	5b                   	pop    %ebx
80101a49:	5e                   	pop    %esi
80101a4a:	5f                   	pop    %edi
80101a4b:	5d                   	pop    %ebp
80101a4c:	c3                   	ret    
80101a4d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a50:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a54:	66 83 f8 09          	cmp    $0x9,%ax
80101a58:	77 17                	ja     80101a71 <readi+0xf1>
80101a5a:	8b 04 c5 20 13 11 80 	mov    -0x7feeece0(,%eax,8),%eax
80101a61:	85 c0                	test   %eax,%eax
80101a63:	74 0c                	je     80101a71 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101a65:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101a68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a6b:	5b                   	pop    %ebx
80101a6c:	5e                   	pop    %esi
80101a6d:	5f                   	pop    %edi
80101a6e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101a6f:	ff e0                	jmp    *%eax
      return -1;
80101a71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a76:	eb cd                	jmp    80101a45 <readi+0xc5>
80101a78:	90                   	nop
80101a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101a80 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a80:	55                   	push   %ebp
80101a81:	89 e5                	mov    %esp,%ebp
80101a83:	57                   	push   %edi
80101a84:	56                   	push   %esi
80101a85:	53                   	push   %ebx
80101a86:	83 ec 1c             	sub    $0x1c,%esp
80101a89:	8b 45 08             	mov    0x8(%ebp),%eax
80101a8c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a8f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a92:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a97:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a9a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a9d:	8b 75 10             	mov    0x10(%ebp),%esi
80101aa0:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101aa3:	0f 84 b7 00 00 00    	je     80101b60 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101aa9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101aac:	39 70 58             	cmp    %esi,0x58(%eax)
80101aaf:	0f 82 eb 00 00 00    	jb     80101ba0 <writei+0x120>
80101ab5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101ab8:	31 d2                	xor    %edx,%edx
80101aba:	89 f8                	mov    %edi,%eax
80101abc:	01 f0                	add    %esi,%eax
80101abe:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101ac1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101ac6:	0f 87 d4 00 00 00    	ja     80101ba0 <writei+0x120>
80101acc:	85 d2                	test   %edx,%edx
80101ace:	0f 85 cc 00 00 00    	jne    80101ba0 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ad4:	85 ff                	test   %edi,%edi
80101ad6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101add:	74 72                	je     80101b51 <writei+0xd1>
80101adf:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ae0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101ae3:	89 f2                	mov    %esi,%edx
80101ae5:	c1 ea 09             	shr    $0x9,%edx
80101ae8:	89 f8                	mov    %edi,%eax
80101aea:	e8 11 f8 ff ff       	call   80101300 <bmap>
80101aef:	83 ec 08             	sub    $0x8,%esp
80101af2:	50                   	push   %eax
80101af3:	ff 37                	pushl  (%edi)
80101af5:	e8 d6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101afa:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101afd:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b00:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101b02:	89 f0                	mov    %esi,%eax
80101b04:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b09:	83 c4 0c             	add    $0xc,%esp
80101b0c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b11:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101b13:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b17:	39 d9                	cmp    %ebx,%ecx
80101b19:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b1c:	53                   	push   %ebx
80101b1d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b20:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101b22:	50                   	push   %eax
80101b23:	e8 68 2b 00 00       	call   80104690 <memmove>
    log_write(bp);
80101b28:	89 3c 24             	mov    %edi,(%esp)
80101b2b:	e8 60 12 00 00       	call   80102d90 <log_write>
    brelse(bp);
80101b30:	89 3c 24             	mov    %edi,(%esp)
80101b33:	e8 a8 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b38:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b3b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b3e:	83 c4 10             	add    $0x10,%esp
80101b41:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b44:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101b47:	77 97                	ja     80101ae0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101b49:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b4c:	3b 70 58             	cmp    0x58(%eax),%esi
80101b4f:	77 37                	ja     80101b88 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b51:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b54:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b57:	5b                   	pop    %ebx
80101b58:	5e                   	pop    %esi
80101b59:	5f                   	pop    %edi
80101b5a:	5d                   	pop    %ebp
80101b5b:	c3                   	ret    
80101b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b60:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b64:	66 83 f8 09          	cmp    $0x9,%ax
80101b68:	77 36                	ja     80101ba0 <writei+0x120>
80101b6a:	8b 04 c5 24 13 11 80 	mov    -0x7feeecdc(,%eax,8),%eax
80101b71:	85 c0                	test   %eax,%eax
80101b73:	74 2b                	je     80101ba0 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101b75:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b7b:	5b                   	pop    %ebx
80101b7c:	5e                   	pop    %esi
80101b7d:	5f                   	pop    %edi
80101b7e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101b7f:	ff e0                	jmp    *%eax
80101b81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101b88:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b8b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101b8e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b91:	50                   	push   %eax
80101b92:	e8 59 fa ff ff       	call   801015f0 <iupdate>
80101b97:	83 c4 10             	add    $0x10,%esp
80101b9a:	eb b5                	jmp    80101b51 <writei+0xd1>
80101b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101ba0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ba5:	eb ad                	jmp    80101b54 <writei+0xd4>
80101ba7:	89 f6                	mov    %esi,%esi
80101ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bb0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101bb0:	55                   	push   %ebp
80101bb1:	89 e5                	mov    %esp,%ebp
80101bb3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101bb6:	6a 0e                	push   $0xe
80101bb8:	ff 75 0c             	pushl  0xc(%ebp)
80101bbb:	ff 75 08             	pushl  0x8(%ebp)
80101bbe:	e8 3d 2b 00 00       	call   80104700 <strncmp>
}
80101bc3:	c9                   	leave  
80101bc4:	c3                   	ret    
80101bc5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bd0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bd0:	55                   	push   %ebp
80101bd1:	89 e5                	mov    %esp,%ebp
80101bd3:	57                   	push   %edi
80101bd4:	56                   	push   %esi
80101bd5:	53                   	push   %ebx
80101bd6:	83 ec 1c             	sub    $0x1c,%esp
80101bd9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bdc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101be1:	0f 85 85 00 00 00    	jne    80101c6c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101be7:	8b 53 58             	mov    0x58(%ebx),%edx
80101bea:	31 ff                	xor    %edi,%edi
80101bec:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bef:	85 d2                	test   %edx,%edx
80101bf1:	74 3e                	je     80101c31 <dirlookup+0x61>
80101bf3:	90                   	nop
80101bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101bf8:	6a 10                	push   $0x10
80101bfa:	57                   	push   %edi
80101bfb:	56                   	push   %esi
80101bfc:	53                   	push   %ebx
80101bfd:	e8 7e fd ff ff       	call   80101980 <readi>
80101c02:	83 c4 10             	add    $0x10,%esp
80101c05:	83 f8 10             	cmp    $0x10,%eax
80101c08:	75 55                	jne    80101c5f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101c0a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c0f:	74 18                	je     80101c29 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101c11:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c14:	83 ec 04             	sub    $0x4,%esp
80101c17:	6a 0e                	push   $0xe
80101c19:	50                   	push   %eax
80101c1a:	ff 75 0c             	pushl  0xc(%ebp)
80101c1d:	e8 de 2a 00 00       	call   80104700 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101c22:	83 c4 10             	add    $0x10,%esp
80101c25:	85 c0                	test   %eax,%eax
80101c27:	74 17                	je     80101c40 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101c29:	83 c7 10             	add    $0x10,%edi
80101c2c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101c2f:	72 c7                	jb     80101bf8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101c31:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101c34:	31 c0                	xor    %eax,%eax
}
80101c36:	5b                   	pop    %ebx
80101c37:	5e                   	pop    %esi
80101c38:	5f                   	pop    %edi
80101c39:	5d                   	pop    %ebp
80101c3a:	c3                   	ret    
80101c3b:	90                   	nop
80101c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101c40:	8b 45 10             	mov    0x10(%ebp),%eax
80101c43:	85 c0                	test   %eax,%eax
80101c45:	74 05                	je     80101c4c <dirlookup+0x7c>
        *poff = off;
80101c47:	8b 45 10             	mov    0x10(%ebp),%eax
80101c4a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c4c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c50:	8b 03                	mov    (%ebx),%eax
80101c52:	e8 d9 f5 ff ff       	call   80101230 <iget>
}
80101c57:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c5a:	5b                   	pop    %ebx
80101c5b:	5e                   	pop    %esi
80101c5c:	5f                   	pop    %edi
80101c5d:	5d                   	pop    %ebp
80101c5e:	c3                   	ret    
      panic("dirlookup read");
80101c5f:	83 ec 0c             	sub    $0xc,%esp
80101c62:	68 b9 73 10 80       	push   $0x801073b9
80101c67:	e8 24 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101c6c:	83 ec 0c             	sub    $0xc,%esp
80101c6f:	68 a7 73 10 80       	push   $0x801073a7
80101c74:	e8 17 e7 ff ff       	call   80100390 <panic>
80101c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101c80 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c80:	55                   	push   %ebp
80101c81:	89 e5                	mov    %esp,%ebp
80101c83:	57                   	push   %edi
80101c84:	56                   	push   %esi
80101c85:	53                   	push   %ebx
80101c86:	89 cf                	mov    %ecx,%edi
80101c88:	89 c3                	mov    %eax,%ebx
80101c8a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c8d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101c90:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101c93:	0f 84 67 01 00 00    	je     80101e00 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c99:	e8 22 1b 00 00       	call   801037c0 <myproc>
  acquire(&icache.lock);
80101c9e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101ca1:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101ca4:	68 a0 13 11 80       	push   $0x801113a0
80101ca9:	e8 22 28 00 00       	call   801044d0 <acquire>
  ip->ref++;
80101cae:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101cb2:	c7 04 24 a0 13 11 80 	movl   $0x801113a0,(%esp)
80101cb9:	e8 d2 28 00 00       	call   80104590 <release>
80101cbe:	83 c4 10             	add    $0x10,%esp
80101cc1:	eb 08                	jmp    80101ccb <namex+0x4b>
80101cc3:	90                   	nop
80101cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101cc8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101ccb:	0f b6 03             	movzbl (%ebx),%eax
80101cce:	3c 2f                	cmp    $0x2f,%al
80101cd0:	74 f6                	je     80101cc8 <namex+0x48>
  if(*path == 0)
80101cd2:	84 c0                	test   %al,%al
80101cd4:	0f 84 ee 00 00 00    	je     80101dc8 <namex+0x148>
  while(*path != '/' && *path != 0)
80101cda:	0f b6 03             	movzbl (%ebx),%eax
80101cdd:	3c 2f                	cmp    $0x2f,%al
80101cdf:	0f 84 b3 00 00 00    	je     80101d98 <namex+0x118>
80101ce5:	84 c0                	test   %al,%al
80101ce7:	89 da                	mov    %ebx,%edx
80101ce9:	75 09                	jne    80101cf4 <namex+0x74>
80101ceb:	e9 a8 00 00 00       	jmp    80101d98 <namex+0x118>
80101cf0:	84 c0                	test   %al,%al
80101cf2:	74 0a                	je     80101cfe <namex+0x7e>
    path++;
80101cf4:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101cf7:	0f b6 02             	movzbl (%edx),%eax
80101cfa:	3c 2f                	cmp    $0x2f,%al
80101cfc:	75 f2                	jne    80101cf0 <namex+0x70>
80101cfe:	89 d1                	mov    %edx,%ecx
80101d00:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101d02:	83 f9 0d             	cmp    $0xd,%ecx
80101d05:	0f 8e 91 00 00 00    	jle    80101d9c <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101d0b:	83 ec 04             	sub    $0x4,%esp
80101d0e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d11:	6a 0e                	push   $0xe
80101d13:	53                   	push   %ebx
80101d14:	57                   	push   %edi
80101d15:	e8 76 29 00 00       	call   80104690 <memmove>
    path++;
80101d1a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101d1d:	83 c4 10             	add    $0x10,%esp
    path++;
80101d20:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101d22:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d25:	75 11                	jne    80101d38 <namex+0xb8>
80101d27:	89 f6                	mov    %esi,%esi
80101d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d30:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d33:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d36:	74 f8                	je     80101d30 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d38:	83 ec 0c             	sub    $0xc,%esp
80101d3b:	56                   	push   %esi
80101d3c:	e8 5f f9 ff ff       	call   801016a0 <ilock>
    if(ip->type != T_DIR){
80101d41:	83 c4 10             	add    $0x10,%esp
80101d44:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d49:	0f 85 91 00 00 00    	jne    80101de0 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d4f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d52:	85 d2                	test   %edx,%edx
80101d54:	74 09                	je     80101d5f <namex+0xdf>
80101d56:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d59:	0f 84 b7 00 00 00    	je     80101e16 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d5f:	83 ec 04             	sub    $0x4,%esp
80101d62:	6a 00                	push   $0x0
80101d64:	57                   	push   %edi
80101d65:	56                   	push   %esi
80101d66:	e8 65 fe ff ff       	call   80101bd0 <dirlookup>
80101d6b:	83 c4 10             	add    $0x10,%esp
80101d6e:	85 c0                	test   %eax,%eax
80101d70:	74 6e                	je     80101de0 <namex+0x160>
  iunlock(ip);
80101d72:	83 ec 0c             	sub    $0xc,%esp
80101d75:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d78:	56                   	push   %esi
80101d79:	e8 02 fa ff ff       	call   80101780 <iunlock>
  iput(ip);
80101d7e:	89 34 24             	mov    %esi,(%esp)
80101d81:	e8 4a fa ff ff       	call   801017d0 <iput>
80101d86:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d89:	83 c4 10             	add    $0x10,%esp
80101d8c:	89 c6                	mov    %eax,%esi
80101d8e:	e9 38 ff ff ff       	jmp    80101ccb <namex+0x4b>
80101d93:	90                   	nop
80101d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101d98:	89 da                	mov    %ebx,%edx
80101d9a:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101d9c:	83 ec 04             	sub    $0x4,%esp
80101d9f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101da2:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101da5:	51                   	push   %ecx
80101da6:	53                   	push   %ebx
80101da7:	57                   	push   %edi
80101da8:	e8 e3 28 00 00       	call   80104690 <memmove>
    name[len] = 0;
80101dad:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101db0:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101db3:	83 c4 10             	add    $0x10,%esp
80101db6:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101dba:	89 d3                	mov    %edx,%ebx
80101dbc:	e9 61 ff ff ff       	jmp    80101d22 <namex+0xa2>
80101dc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101dc8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101dcb:	85 c0                	test   %eax,%eax
80101dcd:	75 5d                	jne    80101e2c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101dcf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dd2:	89 f0                	mov    %esi,%eax
80101dd4:	5b                   	pop    %ebx
80101dd5:	5e                   	pop    %esi
80101dd6:	5f                   	pop    %edi
80101dd7:	5d                   	pop    %ebp
80101dd8:	c3                   	ret    
80101dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101de0:	83 ec 0c             	sub    $0xc,%esp
80101de3:	56                   	push   %esi
80101de4:	e8 97 f9 ff ff       	call   80101780 <iunlock>
  iput(ip);
80101de9:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101dec:	31 f6                	xor    %esi,%esi
  iput(ip);
80101dee:	e8 dd f9 ff ff       	call   801017d0 <iput>
      return 0;
80101df3:	83 c4 10             	add    $0x10,%esp
}
80101df6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101df9:	89 f0                	mov    %esi,%eax
80101dfb:	5b                   	pop    %ebx
80101dfc:	5e                   	pop    %esi
80101dfd:	5f                   	pop    %edi
80101dfe:	5d                   	pop    %ebp
80101dff:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101e00:	ba 01 00 00 00       	mov    $0x1,%edx
80101e05:	b8 01 00 00 00       	mov    $0x1,%eax
80101e0a:	e8 21 f4 ff ff       	call   80101230 <iget>
80101e0f:	89 c6                	mov    %eax,%esi
80101e11:	e9 b5 fe ff ff       	jmp    80101ccb <namex+0x4b>
      iunlock(ip);
80101e16:	83 ec 0c             	sub    $0xc,%esp
80101e19:	56                   	push   %esi
80101e1a:	e8 61 f9 ff ff       	call   80101780 <iunlock>
      return ip;
80101e1f:	83 c4 10             	add    $0x10,%esp
}
80101e22:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e25:	89 f0                	mov    %esi,%eax
80101e27:	5b                   	pop    %ebx
80101e28:	5e                   	pop    %esi
80101e29:	5f                   	pop    %edi
80101e2a:	5d                   	pop    %ebp
80101e2b:	c3                   	ret    
    iput(ip);
80101e2c:	83 ec 0c             	sub    $0xc,%esp
80101e2f:	56                   	push   %esi
    return 0;
80101e30:	31 f6                	xor    %esi,%esi
    iput(ip);
80101e32:	e8 99 f9 ff ff       	call   801017d0 <iput>
    return 0;
80101e37:	83 c4 10             	add    $0x10,%esp
80101e3a:	eb 93                	jmp    80101dcf <namex+0x14f>
80101e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e40 <dirlink>:
{
80101e40:	55                   	push   %ebp
80101e41:	89 e5                	mov    %esp,%ebp
80101e43:	57                   	push   %edi
80101e44:	56                   	push   %esi
80101e45:	53                   	push   %ebx
80101e46:	83 ec 20             	sub    $0x20,%esp
80101e49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e4c:	6a 00                	push   $0x0
80101e4e:	ff 75 0c             	pushl  0xc(%ebp)
80101e51:	53                   	push   %ebx
80101e52:	e8 79 fd ff ff       	call   80101bd0 <dirlookup>
80101e57:	83 c4 10             	add    $0x10,%esp
80101e5a:	85 c0                	test   %eax,%eax
80101e5c:	75 67                	jne    80101ec5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e5e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e61:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e64:	85 ff                	test   %edi,%edi
80101e66:	74 29                	je     80101e91 <dirlink+0x51>
80101e68:	31 ff                	xor    %edi,%edi
80101e6a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e6d:	eb 09                	jmp    80101e78 <dirlink+0x38>
80101e6f:	90                   	nop
80101e70:	83 c7 10             	add    $0x10,%edi
80101e73:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e76:	73 19                	jae    80101e91 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e78:	6a 10                	push   $0x10
80101e7a:	57                   	push   %edi
80101e7b:	56                   	push   %esi
80101e7c:	53                   	push   %ebx
80101e7d:	e8 fe fa ff ff       	call   80101980 <readi>
80101e82:	83 c4 10             	add    $0x10,%esp
80101e85:	83 f8 10             	cmp    $0x10,%eax
80101e88:	75 4e                	jne    80101ed8 <dirlink+0x98>
    if(de.inum == 0)
80101e8a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e8f:	75 df                	jne    80101e70 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101e91:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e94:	83 ec 04             	sub    $0x4,%esp
80101e97:	6a 0e                	push   $0xe
80101e99:	ff 75 0c             	pushl  0xc(%ebp)
80101e9c:	50                   	push   %eax
80101e9d:	e8 be 28 00 00       	call   80104760 <strncpy>
  de.inum = inum;
80101ea2:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ea5:	6a 10                	push   $0x10
80101ea7:	57                   	push   %edi
80101ea8:	56                   	push   %esi
80101ea9:	53                   	push   %ebx
  de.inum = inum;
80101eaa:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101eae:	e8 cd fb ff ff       	call   80101a80 <writei>
80101eb3:	83 c4 20             	add    $0x20,%esp
80101eb6:	83 f8 10             	cmp    $0x10,%eax
80101eb9:	75 2a                	jne    80101ee5 <dirlink+0xa5>
  return 0;
80101ebb:	31 c0                	xor    %eax,%eax
}
80101ebd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ec0:	5b                   	pop    %ebx
80101ec1:	5e                   	pop    %esi
80101ec2:	5f                   	pop    %edi
80101ec3:	5d                   	pop    %ebp
80101ec4:	c3                   	ret    
    iput(ip);
80101ec5:	83 ec 0c             	sub    $0xc,%esp
80101ec8:	50                   	push   %eax
80101ec9:	e8 02 f9 ff ff       	call   801017d0 <iput>
    return -1;
80101ece:	83 c4 10             	add    $0x10,%esp
80101ed1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ed6:	eb e5                	jmp    80101ebd <dirlink+0x7d>
      panic("dirlink read");
80101ed8:	83 ec 0c             	sub    $0xc,%esp
80101edb:	68 c8 73 10 80       	push   $0x801073c8
80101ee0:	e8 ab e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101ee5:	83 ec 0c             	sub    $0xc,%esp
80101ee8:	68 22 7a 10 80       	push   $0x80107a22
80101eed:	e8 9e e4 ff ff       	call   80100390 <panic>
80101ef2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f00 <namei>:

struct inode*
namei(char *path)
{
80101f00:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f01:	31 d2                	xor    %edx,%edx
{
80101f03:	89 e5                	mov    %esp,%ebp
80101f05:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101f08:	8b 45 08             	mov    0x8(%ebp),%eax
80101f0b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101f0e:	e8 6d fd ff ff       	call   80101c80 <namex>
}
80101f13:	c9                   	leave  
80101f14:	c3                   	ret    
80101f15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f20 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f20:	55                   	push   %ebp
  return namex(path, 1, name);
80101f21:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101f26:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f28:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f2b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f2e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101f2f:	e9 4c fd ff ff       	jmp    80101c80 <namex>
80101f34:	66 90                	xchg   %ax,%ax
80101f36:	66 90                	xchg   %ax,%ax
80101f38:	66 90                	xchg   %ax,%ax
80101f3a:	66 90                	xchg   %ax,%ax
80101f3c:	66 90                	xchg   %ax,%ax
80101f3e:	66 90                	xchg   %ax,%ax

80101f40 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f40:	55                   	push   %ebp
80101f41:	89 e5                	mov    %esp,%ebp
80101f43:	57                   	push   %edi
80101f44:	56                   	push   %esi
80101f45:	53                   	push   %ebx
80101f46:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80101f49:	85 c0                	test   %eax,%eax
80101f4b:	0f 84 b4 00 00 00    	je     80102005 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f51:	8b 58 08             	mov    0x8(%eax),%ebx
80101f54:	89 c6                	mov    %eax,%esi
80101f56:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f5c:	0f 87 96 00 00 00    	ja     80101ff8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f62:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80101f67:	89 f6                	mov    %esi,%esi
80101f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101f70:	89 ca                	mov    %ecx,%edx
80101f72:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f73:	83 e0 c0             	and    $0xffffffc0,%eax
80101f76:	3c 40                	cmp    $0x40,%al
80101f78:	75 f6                	jne    80101f70 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f7a:	31 ff                	xor    %edi,%edi
80101f7c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f81:	89 f8                	mov    %edi,%eax
80101f83:	ee                   	out    %al,(%dx)
80101f84:	b8 01 00 00 00       	mov    $0x1,%eax
80101f89:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f8e:	ee                   	out    %al,(%dx)
80101f8f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f94:	89 d8                	mov    %ebx,%eax
80101f96:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101f97:	89 d8                	mov    %ebx,%eax
80101f99:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f9e:	c1 f8 08             	sar    $0x8,%eax
80101fa1:	ee                   	out    %al,(%dx)
80101fa2:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101fa7:	89 f8                	mov    %edi,%eax
80101fa9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101faa:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80101fae:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101fb3:	c1 e0 04             	shl    $0x4,%eax
80101fb6:	83 e0 10             	and    $0x10,%eax
80101fb9:	83 c8 e0             	or     $0xffffffe0,%eax
80101fbc:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101fbd:	f6 06 04             	testb  $0x4,(%esi)
80101fc0:	75 16                	jne    80101fd8 <idestart+0x98>
80101fc2:	b8 20 00 00 00       	mov    $0x20,%eax
80101fc7:	89 ca                	mov    %ecx,%edx
80101fc9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fca:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fcd:	5b                   	pop    %ebx
80101fce:	5e                   	pop    %esi
80101fcf:	5f                   	pop    %edi
80101fd0:	5d                   	pop    %ebp
80101fd1:	c3                   	ret    
80101fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101fd8:	b8 30 00 00 00       	mov    $0x30,%eax
80101fdd:	89 ca                	mov    %ecx,%edx
80101fdf:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80101fe0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80101fe5:	83 c6 5c             	add    $0x5c,%esi
80101fe8:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101fed:	fc                   	cld    
80101fee:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80101ff0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ff3:	5b                   	pop    %ebx
80101ff4:	5e                   	pop    %esi
80101ff5:	5f                   	pop    %edi
80101ff6:	5d                   	pop    %ebp
80101ff7:	c3                   	ret    
    panic("incorrect blockno");
80101ff8:	83 ec 0c             	sub    $0xc,%esp
80101ffb:	68 34 74 10 80       	push   $0x80107434
80102000:	e8 8b e3 ff ff       	call   80100390 <panic>
    panic("idestart");
80102005:	83 ec 0c             	sub    $0xc,%esp
80102008:	68 2b 74 10 80       	push   $0x8010742b
8010200d:	e8 7e e3 ff ff       	call   80100390 <panic>
80102012:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102020 <ideinit>:
{
80102020:	55                   	push   %ebp
80102021:	89 e5                	mov    %esp,%ebp
80102023:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102026:	68 46 74 10 80       	push   $0x80107446
8010202b:	68 80 a5 10 80       	push   $0x8010a580
80102030:	e8 5b 23 00 00       	call   80104390 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102035:	58                   	pop    %eax
80102036:	a1 f0 31 11 80       	mov    0x801131f0,%eax
8010203b:	5a                   	pop    %edx
8010203c:	83 e8 01             	sub    $0x1,%eax
8010203f:	50                   	push   %eax
80102040:	6a 0e                	push   $0xe
80102042:	e8 a9 02 00 00       	call   801022f0 <ioapicenable>
80102047:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010204a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010204f:	90                   	nop
80102050:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102051:	83 e0 c0             	and    $0xffffffc0,%eax
80102054:	3c 40                	cmp    $0x40,%al
80102056:	75 f8                	jne    80102050 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102058:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010205d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102062:	ee                   	out    %al,(%dx)
80102063:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102068:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010206d:	eb 06                	jmp    80102075 <ideinit+0x55>
8010206f:	90                   	nop
  for(i=0; i<1000; i++){
80102070:	83 e9 01             	sub    $0x1,%ecx
80102073:	74 0f                	je     80102084 <ideinit+0x64>
80102075:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102076:	84 c0                	test   %al,%al
80102078:	74 f6                	je     80102070 <ideinit+0x50>
      havedisk1 = 1;
8010207a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102081:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102084:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102089:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010208e:	ee                   	out    %al,(%dx)
}
8010208f:	c9                   	leave  
80102090:	c3                   	ret    
80102091:	eb 0d                	jmp    801020a0 <ideintr>
80102093:	90                   	nop
80102094:	90                   	nop
80102095:	90                   	nop
80102096:	90                   	nop
80102097:	90                   	nop
80102098:	90                   	nop
80102099:	90                   	nop
8010209a:	90                   	nop
8010209b:	90                   	nop
8010209c:	90                   	nop
8010209d:	90                   	nop
8010209e:	90                   	nop
8010209f:	90                   	nop

801020a0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801020a0:	55                   	push   %ebp
801020a1:	89 e5                	mov    %esp,%ebp
801020a3:	57                   	push   %edi
801020a4:	56                   	push   %esi
801020a5:	53                   	push   %ebx
801020a6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801020a9:	68 80 a5 10 80       	push   $0x8010a580
801020ae:	e8 1d 24 00 00       	call   801044d0 <acquire>

  if((b = idequeue) == 0){
801020b3:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
801020b9:	83 c4 10             	add    $0x10,%esp
801020bc:	85 db                	test   %ebx,%ebx
801020be:	74 67                	je     80102127 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801020c0:	8b 43 58             	mov    0x58(%ebx),%eax
801020c3:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020c8:	8b 3b                	mov    (%ebx),%edi
801020ca:	f7 c7 04 00 00 00    	test   $0x4,%edi
801020d0:	75 31                	jne    80102103 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020d2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020d7:	89 f6                	mov    %esi,%esi
801020d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801020e0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020e1:	89 c6                	mov    %eax,%esi
801020e3:	83 e6 c0             	and    $0xffffffc0,%esi
801020e6:	89 f1                	mov    %esi,%ecx
801020e8:	80 f9 40             	cmp    $0x40,%cl
801020eb:	75 f3                	jne    801020e0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020ed:	a8 21                	test   $0x21,%al
801020ef:	75 12                	jne    80102103 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
801020f1:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801020f4:	b9 80 00 00 00       	mov    $0x80,%ecx
801020f9:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020fe:	fc                   	cld    
801020ff:	f3 6d                	rep insl (%dx),%es:(%edi)
80102101:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102103:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
80102106:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102109:	89 f9                	mov    %edi,%ecx
8010210b:	83 c9 02             	or     $0x2,%ecx
8010210e:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102110:	53                   	push   %ebx
80102111:	e8 ca 1d 00 00       	call   80103ee0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102116:	a1 64 a5 10 80       	mov    0x8010a564,%eax
8010211b:	83 c4 10             	add    $0x10,%esp
8010211e:	85 c0                	test   %eax,%eax
80102120:	74 05                	je     80102127 <ideintr+0x87>
    idestart(idequeue);
80102122:	e8 19 fe ff ff       	call   80101f40 <idestart>
    release(&idelock);
80102127:	83 ec 0c             	sub    $0xc,%esp
8010212a:	68 80 a5 10 80       	push   $0x8010a580
8010212f:	e8 5c 24 00 00       	call   80104590 <release>

  release(&idelock);
}
80102134:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102137:	5b                   	pop    %ebx
80102138:	5e                   	pop    %esi
80102139:	5f                   	pop    %edi
8010213a:	5d                   	pop    %ebp
8010213b:	c3                   	ret    
8010213c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102140 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102140:	55                   	push   %ebp
80102141:	89 e5                	mov    %esp,%ebp
80102143:	53                   	push   %ebx
80102144:	83 ec 10             	sub    $0x10,%esp
80102147:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010214a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010214d:	50                   	push   %eax
8010214e:	e8 ed 21 00 00       	call   80104340 <holdingsleep>
80102153:	83 c4 10             	add    $0x10,%esp
80102156:	85 c0                	test   %eax,%eax
80102158:	0f 84 c6 00 00 00    	je     80102224 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010215e:	8b 03                	mov    (%ebx),%eax
80102160:	83 e0 06             	and    $0x6,%eax
80102163:	83 f8 02             	cmp    $0x2,%eax
80102166:	0f 84 ab 00 00 00    	je     80102217 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010216c:	8b 53 04             	mov    0x4(%ebx),%edx
8010216f:	85 d2                	test   %edx,%edx
80102171:	74 0d                	je     80102180 <iderw+0x40>
80102173:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102178:	85 c0                	test   %eax,%eax
8010217a:	0f 84 b1 00 00 00    	je     80102231 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102180:	83 ec 0c             	sub    $0xc,%esp
80102183:	68 80 a5 10 80       	push   $0x8010a580
80102188:	e8 43 23 00 00       	call   801044d0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010218d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
80102193:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102196:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010219d:	85 d2                	test   %edx,%edx
8010219f:	75 09                	jne    801021aa <iderw+0x6a>
801021a1:	eb 6d                	jmp    80102210 <iderw+0xd0>
801021a3:	90                   	nop
801021a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801021a8:	89 c2                	mov    %eax,%edx
801021aa:	8b 42 58             	mov    0x58(%edx),%eax
801021ad:	85 c0                	test   %eax,%eax
801021af:	75 f7                	jne    801021a8 <iderw+0x68>
801021b1:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801021b4:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801021b6:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
801021bc:	74 42                	je     80102200 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021be:	8b 03                	mov    (%ebx),%eax
801021c0:	83 e0 06             	and    $0x6,%eax
801021c3:	83 f8 02             	cmp    $0x2,%eax
801021c6:	74 23                	je     801021eb <iderw+0xab>
801021c8:	90                   	nop
801021c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801021d0:	83 ec 08             	sub    $0x8,%esp
801021d3:	68 80 a5 10 80       	push   $0x8010a580
801021d8:	53                   	push   %ebx
801021d9:	e8 52 1b 00 00       	call   80103d30 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021de:	8b 03                	mov    (%ebx),%eax
801021e0:	83 c4 10             	add    $0x10,%esp
801021e3:	83 e0 06             	and    $0x6,%eax
801021e6:	83 f8 02             	cmp    $0x2,%eax
801021e9:	75 e5                	jne    801021d0 <iderw+0x90>
  }


  release(&idelock);
801021eb:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801021f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021f5:	c9                   	leave  
  release(&idelock);
801021f6:	e9 95 23 00 00       	jmp    80104590 <release>
801021fb:	90                   	nop
801021fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
80102200:	89 d8                	mov    %ebx,%eax
80102202:	e8 39 fd ff ff       	call   80101f40 <idestart>
80102207:	eb b5                	jmp    801021be <iderw+0x7e>
80102209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102210:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
80102215:	eb 9d                	jmp    801021b4 <iderw+0x74>
    panic("iderw: nothing to do");
80102217:	83 ec 0c             	sub    $0xc,%esp
8010221a:	68 60 74 10 80       	push   $0x80107460
8010221f:	e8 6c e1 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102224:	83 ec 0c             	sub    $0xc,%esp
80102227:	68 4a 74 10 80       	push   $0x8010744a
8010222c:	e8 5f e1 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102231:	83 ec 0c             	sub    $0xc,%esp
80102234:	68 75 74 10 80       	push   $0x80107475
80102239:	e8 52 e1 ff ff       	call   80100390 <panic>
8010223e:	66 90                	xchg   %ax,%ax

80102240 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102240:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102241:	c7 05 f4 2f 11 80 00 	movl   $0xfec00000,0x80112ff4
80102248:	00 c0 fe 
{
8010224b:	89 e5                	mov    %esp,%ebp
8010224d:	56                   	push   %esi
8010224e:	53                   	push   %ebx
  ioapic->reg = reg;
8010224f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102256:	00 00 00 
  return ioapic->data;
80102259:	a1 f4 2f 11 80       	mov    0x80112ff4,%eax
8010225e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102261:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102267:	8b 0d f4 2f 11 80    	mov    0x80112ff4,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010226d:	0f b6 15 20 31 11 80 	movzbl 0x80113120,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102274:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102277:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010227a:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010227d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102280:	39 c2                	cmp    %eax,%edx
80102282:	74 16                	je     8010229a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102284:	83 ec 0c             	sub    $0xc,%esp
80102287:	68 94 74 10 80       	push   $0x80107494
8010228c:	e8 cf e3 ff ff       	call   80100660 <cprintf>
80102291:	8b 0d f4 2f 11 80    	mov    0x80112ff4,%ecx
80102297:	83 c4 10             	add    $0x10,%esp
8010229a:	83 c3 21             	add    $0x21,%ebx
{
8010229d:	ba 10 00 00 00       	mov    $0x10,%edx
801022a2:	b8 20 00 00 00       	mov    $0x20,%eax
801022a7:	89 f6                	mov    %esi,%esi
801022a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
801022b0:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
801022b2:	8b 0d f4 2f 11 80    	mov    0x80112ff4,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801022b8:	89 c6                	mov    %eax,%esi
801022ba:	81 ce 00 00 01 00    	or     $0x10000,%esi
801022c0:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022c3:	89 71 10             	mov    %esi,0x10(%ecx)
801022c6:	8d 72 01             	lea    0x1(%edx),%esi
801022c9:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
801022cc:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
801022ce:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
801022d0:	8b 0d f4 2f 11 80    	mov    0x80112ff4,%ecx
801022d6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801022dd:	75 d1                	jne    801022b0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801022df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022e2:	5b                   	pop    %ebx
801022e3:	5e                   	pop    %esi
801022e4:	5d                   	pop    %ebp
801022e5:	c3                   	ret    
801022e6:	8d 76 00             	lea    0x0(%esi),%esi
801022e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022f0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801022f0:	55                   	push   %ebp
  ioapic->reg = reg;
801022f1:	8b 0d f4 2f 11 80    	mov    0x80112ff4,%ecx
{
801022f7:	89 e5                	mov    %esp,%ebp
801022f9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022fc:	8d 50 20             	lea    0x20(%eax),%edx
801022ff:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102303:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102305:	8b 0d f4 2f 11 80    	mov    0x80112ff4,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010230b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010230e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102311:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102314:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102316:	a1 f4 2f 11 80       	mov    0x80112ff4,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010231b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010231e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102321:	5d                   	pop    %ebp
80102322:	c3                   	ret    
80102323:	66 90                	xchg   %ax,%ax
80102325:	66 90                	xchg   %ax,%ax
80102327:	66 90                	xchg   %ax,%ax
80102329:	66 90                	xchg   %ax,%ax
8010232b:	66 90                	xchg   %ax,%ax
8010232d:	66 90                	xchg   %ax,%ax
8010232f:	90                   	nop

80102330 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102330:	55                   	push   %ebp
80102331:	89 e5                	mov    %esp,%ebp
80102333:	53                   	push   %ebx
80102334:	83 ec 04             	sub    $0x4,%esp
80102337:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010233a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102340:	75 70                	jne    801023b2 <kfree+0x82>
80102342:	81 fb 88 5a 11 80    	cmp    $0x80115a88,%ebx
80102348:	72 68                	jb     801023b2 <kfree+0x82>
8010234a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102350:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102355:	77 5b                	ja     801023b2 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102357:	83 ec 04             	sub    $0x4,%esp
8010235a:	68 00 10 00 00       	push   $0x1000
8010235f:	6a 01                	push   $0x1
80102361:	53                   	push   %ebx
80102362:	e8 79 22 00 00       	call   801045e0 <memset>

  if(kmem.use_lock)
80102367:	8b 15 34 30 11 80    	mov    0x80113034,%edx
8010236d:	83 c4 10             	add    $0x10,%esp
80102370:	85 d2                	test   %edx,%edx
80102372:	75 2c                	jne    801023a0 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102374:	a1 38 30 11 80       	mov    0x80113038,%eax
80102379:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010237b:	a1 34 30 11 80       	mov    0x80113034,%eax
  kmem.freelist = r;
80102380:	89 1d 38 30 11 80    	mov    %ebx,0x80113038
  if(kmem.use_lock)
80102386:	85 c0                	test   %eax,%eax
80102388:	75 06                	jne    80102390 <kfree+0x60>
    release(&kmem.lock);
}
8010238a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010238d:	c9                   	leave  
8010238e:	c3                   	ret    
8010238f:	90                   	nop
    release(&kmem.lock);
80102390:	c7 45 08 00 30 11 80 	movl   $0x80113000,0x8(%ebp)
}
80102397:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010239a:	c9                   	leave  
    release(&kmem.lock);
8010239b:	e9 f0 21 00 00       	jmp    80104590 <release>
    acquire(&kmem.lock);
801023a0:	83 ec 0c             	sub    $0xc,%esp
801023a3:	68 00 30 11 80       	push   $0x80113000
801023a8:	e8 23 21 00 00       	call   801044d0 <acquire>
801023ad:	83 c4 10             	add    $0x10,%esp
801023b0:	eb c2                	jmp    80102374 <kfree+0x44>
    panic("kfree");
801023b2:	83 ec 0c             	sub    $0xc,%esp
801023b5:	68 c6 74 10 80       	push   $0x801074c6
801023ba:	e8 d1 df ff ff       	call   80100390 <panic>
801023bf:	90                   	nop

801023c0 <freerange>:
{
801023c0:	55                   	push   %ebp
801023c1:	89 e5                	mov    %esp,%ebp
801023c3:	56                   	push   %esi
801023c4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801023c5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801023c8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801023cb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023d1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023d7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023dd:	39 de                	cmp    %ebx,%esi
801023df:	72 23                	jb     80102404 <freerange+0x44>
801023e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801023e8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023ee:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023f1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023f7:	50                   	push   %eax
801023f8:	e8 33 ff ff ff       	call   80102330 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023fd:	83 c4 10             	add    $0x10,%esp
80102400:	39 f3                	cmp    %esi,%ebx
80102402:	76 e4                	jbe    801023e8 <freerange+0x28>
}
80102404:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102407:	5b                   	pop    %ebx
80102408:	5e                   	pop    %esi
80102409:	5d                   	pop    %ebp
8010240a:	c3                   	ret    
8010240b:	90                   	nop
8010240c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102410 <kinit1>:
{
80102410:	55                   	push   %ebp
80102411:	89 e5                	mov    %esp,%ebp
80102413:	56                   	push   %esi
80102414:	53                   	push   %ebx
80102415:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102418:	83 ec 08             	sub    $0x8,%esp
8010241b:	68 cc 74 10 80       	push   $0x801074cc
80102420:	68 00 30 11 80       	push   $0x80113000
80102425:	e8 66 1f 00 00       	call   80104390 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010242a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010242d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102430:	c7 05 34 30 11 80 00 	movl   $0x0,0x80113034
80102437:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010243a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102440:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102446:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010244c:	39 de                	cmp    %ebx,%esi
8010244e:	72 1c                	jb     8010246c <kinit1+0x5c>
    kfree(p);
80102450:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102456:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102459:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010245f:	50                   	push   %eax
80102460:	e8 cb fe ff ff       	call   80102330 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102465:	83 c4 10             	add    $0x10,%esp
80102468:	39 de                	cmp    %ebx,%esi
8010246a:	73 e4                	jae    80102450 <kinit1+0x40>
}
8010246c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010246f:	5b                   	pop    %ebx
80102470:	5e                   	pop    %esi
80102471:	5d                   	pop    %ebp
80102472:	c3                   	ret    
80102473:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102480 <kinit2>:
{
80102480:	55                   	push   %ebp
80102481:	89 e5                	mov    %esp,%ebp
80102483:	56                   	push   %esi
80102484:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102485:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102488:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010248b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102491:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102497:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010249d:	39 de                	cmp    %ebx,%esi
8010249f:	72 23                	jb     801024c4 <kinit2+0x44>
801024a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801024a8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801024ae:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024b1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024b7:	50                   	push   %eax
801024b8:	e8 73 fe ff ff       	call   80102330 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024bd:	83 c4 10             	add    $0x10,%esp
801024c0:	39 de                	cmp    %ebx,%esi
801024c2:	73 e4                	jae    801024a8 <kinit2+0x28>
  kmem.use_lock = 1;
801024c4:	c7 05 34 30 11 80 01 	movl   $0x1,0x80113034
801024cb:	00 00 00 
}
801024ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024d1:	5b                   	pop    %ebx
801024d2:	5e                   	pop    %esi
801024d3:	5d                   	pop    %ebp
801024d4:	c3                   	ret    
801024d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024e0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801024e0:	a1 34 30 11 80       	mov    0x80113034,%eax
801024e5:	85 c0                	test   %eax,%eax
801024e7:	75 1f                	jne    80102508 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024e9:	a1 38 30 11 80       	mov    0x80113038,%eax
  if(r)
801024ee:	85 c0                	test   %eax,%eax
801024f0:	74 0e                	je     80102500 <kalloc+0x20>
    kmem.freelist = r->next;
801024f2:	8b 10                	mov    (%eax),%edx
801024f4:	89 15 38 30 11 80    	mov    %edx,0x80113038
801024fa:	c3                   	ret    
801024fb:	90                   	nop
801024fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102500:	f3 c3                	repz ret 
80102502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
80102508:	55                   	push   %ebp
80102509:	89 e5                	mov    %esp,%ebp
8010250b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010250e:	68 00 30 11 80       	push   $0x80113000
80102513:	e8 b8 1f 00 00       	call   801044d0 <acquire>
  r = kmem.freelist;
80102518:	a1 38 30 11 80       	mov    0x80113038,%eax
  if(r)
8010251d:	83 c4 10             	add    $0x10,%esp
80102520:	8b 15 34 30 11 80    	mov    0x80113034,%edx
80102526:	85 c0                	test   %eax,%eax
80102528:	74 08                	je     80102532 <kalloc+0x52>
    kmem.freelist = r->next;
8010252a:	8b 08                	mov    (%eax),%ecx
8010252c:	89 0d 38 30 11 80    	mov    %ecx,0x80113038
  if(kmem.use_lock)
80102532:	85 d2                	test   %edx,%edx
80102534:	74 16                	je     8010254c <kalloc+0x6c>
    release(&kmem.lock);
80102536:	83 ec 0c             	sub    $0xc,%esp
80102539:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010253c:	68 00 30 11 80       	push   $0x80113000
80102541:	e8 4a 20 00 00       	call   80104590 <release>
  return (char*)r;
80102546:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102549:	83 c4 10             	add    $0x10,%esp
}
8010254c:	c9                   	leave  
8010254d:	c3                   	ret    
8010254e:	66 90                	xchg   %ax,%ax

80102550 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102550:	ba 64 00 00 00       	mov    $0x64,%edx
80102555:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102556:	a8 01                	test   $0x1,%al
80102558:	0f 84 c2 00 00 00    	je     80102620 <kbdgetc+0xd0>
8010255e:	ba 60 00 00 00       	mov    $0x60,%edx
80102563:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102564:	0f b6 d0             	movzbl %al,%edx
80102567:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx

  if(data == 0xE0){
8010256d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102573:	0f 84 7f 00 00 00    	je     801025f8 <kbdgetc+0xa8>
{
80102579:	55                   	push   %ebp
8010257a:	89 e5                	mov    %esp,%ebp
8010257c:	53                   	push   %ebx
8010257d:	89 cb                	mov    %ecx,%ebx
8010257f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102582:	84 c0                	test   %al,%al
80102584:	78 4a                	js     801025d0 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102586:	85 db                	test   %ebx,%ebx
80102588:	74 09                	je     80102593 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010258a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
8010258d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102590:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102593:	0f b6 82 00 76 10 80 	movzbl -0x7fef8a00(%edx),%eax
8010259a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010259c:	0f b6 82 00 75 10 80 	movzbl -0x7fef8b00(%edx),%eax
801025a3:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025a5:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
801025a7:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
801025ad:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801025b0:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025b3:	8b 04 85 e0 74 10 80 	mov    -0x7fef8b20(,%eax,4),%eax
801025ba:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801025be:	74 31                	je     801025f1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
801025c0:	8d 50 9f             	lea    -0x61(%eax),%edx
801025c3:	83 fa 19             	cmp    $0x19,%edx
801025c6:	77 40                	ja     80102608 <kbdgetc+0xb8>
      c += 'A' - 'a';
801025c8:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025cb:	5b                   	pop    %ebx
801025cc:	5d                   	pop    %ebp
801025cd:	c3                   	ret    
801025ce:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
801025d0:	83 e0 7f             	and    $0x7f,%eax
801025d3:	85 db                	test   %ebx,%ebx
801025d5:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801025d8:	0f b6 82 00 76 10 80 	movzbl -0x7fef8a00(%edx),%eax
801025df:	83 c8 40             	or     $0x40,%eax
801025e2:	0f b6 c0             	movzbl %al,%eax
801025e5:	f7 d0                	not    %eax
801025e7:	21 c1                	and    %eax,%ecx
    return 0;
801025e9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801025eb:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
}
801025f1:	5b                   	pop    %ebx
801025f2:	5d                   	pop    %ebp
801025f3:	c3                   	ret    
801025f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801025f8:	83 c9 40             	or     $0x40,%ecx
    return 0;
801025fb:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801025fd:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
    return 0;
80102603:	c3                   	ret    
80102604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102608:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010260b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010260e:	5b                   	pop    %ebx
      c += 'a' - 'A';
8010260f:	83 f9 1a             	cmp    $0x1a,%ecx
80102612:	0f 42 c2             	cmovb  %edx,%eax
}
80102615:	5d                   	pop    %ebp
80102616:	c3                   	ret    
80102617:	89 f6                	mov    %esi,%esi
80102619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102620:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102625:	c3                   	ret    
80102626:	8d 76 00             	lea    0x0(%esi),%esi
80102629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102630 <kbdintr>:

void
kbdintr(void)
{
80102630:	55                   	push   %ebp
80102631:	89 e5                	mov    %esp,%ebp
80102633:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102636:	68 50 25 10 80       	push   $0x80102550
8010263b:	e8 d0 e1 ff ff       	call   80100810 <consoleintr>
}
80102640:	83 c4 10             	add    $0x10,%esp
80102643:	c9                   	leave  
80102644:	c3                   	ret    
80102645:	66 90                	xchg   %ax,%ax
80102647:	66 90                	xchg   %ax,%ax
80102649:	66 90                	xchg   %ax,%ax
8010264b:	66 90                	xchg   %ax,%ax
8010264d:	66 90                	xchg   %ax,%ax
8010264f:	90                   	nop

80102650 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102650:	a1 3c 30 11 80       	mov    0x8011303c,%eax
{
80102655:	55                   	push   %ebp
80102656:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102658:	85 c0                	test   %eax,%eax
8010265a:	0f 84 c8 00 00 00    	je     80102728 <lapicinit+0xd8>
  lapic[index] = value;
80102660:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102667:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010266a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010266d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102674:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102677:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010267a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102681:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102684:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102687:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010268e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102691:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102694:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010269b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010269e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026a1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801026a8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026ab:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801026ae:	8b 50 30             	mov    0x30(%eax),%edx
801026b1:	c1 ea 10             	shr    $0x10,%edx
801026b4:	80 fa 03             	cmp    $0x3,%dl
801026b7:	77 77                	ja     80102730 <lapicinit+0xe0>
  lapic[index] = value;
801026b9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026c0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026c3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026c6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026cd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026d0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026d3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026da:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026dd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026e0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801026e7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026ea:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026ed:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801026f4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026f7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026fa:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102701:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102704:	8b 50 20             	mov    0x20(%eax),%edx
80102707:	89 f6                	mov    %esi,%esi
80102709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102710:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102716:	80 e6 10             	and    $0x10,%dh
80102719:	75 f5                	jne    80102710 <lapicinit+0xc0>
  lapic[index] = value;
8010271b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102722:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102725:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102728:	5d                   	pop    %ebp
80102729:	c3                   	ret    
8010272a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102730:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102737:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010273a:	8b 50 20             	mov    0x20(%eax),%edx
8010273d:	e9 77 ff ff ff       	jmp    801026b9 <lapicinit+0x69>
80102742:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102750 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102750:	8b 15 3c 30 11 80    	mov    0x8011303c,%edx
{
80102756:	55                   	push   %ebp
80102757:	31 c0                	xor    %eax,%eax
80102759:	89 e5                	mov    %esp,%ebp
  if (!lapic)
8010275b:	85 d2                	test   %edx,%edx
8010275d:	74 06                	je     80102765 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
8010275f:	8b 42 20             	mov    0x20(%edx),%eax
80102762:	c1 e8 18             	shr    $0x18,%eax
}
80102765:	5d                   	pop    %ebp
80102766:	c3                   	ret    
80102767:	89 f6                	mov    %esi,%esi
80102769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102770 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102770:	a1 3c 30 11 80       	mov    0x8011303c,%eax
{
80102775:	55                   	push   %ebp
80102776:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102778:	85 c0                	test   %eax,%eax
8010277a:	74 0d                	je     80102789 <lapiceoi+0x19>
  lapic[index] = value;
8010277c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102783:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102786:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102789:	5d                   	pop    %ebp
8010278a:	c3                   	ret    
8010278b:	90                   	nop
8010278c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102790 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102790:	55                   	push   %ebp
80102791:	89 e5                	mov    %esp,%ebp
}
80102793:	5d                   	pop    %ebp
80102794:	c3                   	ret    
80102795:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027a0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801027a0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027a1:	b8 0f 00 00 00       	mov    $0xf,%eax
801027a6:	ba 70 00 00 00       	mov    $0x70,%edx
801027ab:	89 e5                	mov    %esp,%ebp
801027ad:	53                   	push   %ebx
801027ae:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801027b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801027b4:	ee                   	out    %al,(%dx)
801027b5:	b8 0a 00 00 00       	mov    $0xa,%eax
801027ba:	ba 71 00 00 00       	mov    $0x71,%edx
801027bf:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801027c0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801027c2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
801027c5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801027cb:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801027cd:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
801027d0:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
801027d3:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
801027d5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
801027d8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801027de:	a1 3c 30 11 80       	mov    0x8011303c,%eax
801027e3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027e9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027ec:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801027f3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027f6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027f9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102800:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102803:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102806:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010280c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010280f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102815:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102818:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010281e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102821:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102827:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010282a:	5b                   	pop    %ebx
8010282b:	5d                   	pop    %ebp
8010282c:	c3                   	ret    
8010282d:	8d 76 00             	lea    0x0(%esi),%esi

80102830 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102830:	55                   	push   %ebp
80102831:	b8 0b 00 00 00       	mov    $0xb,%eax
80102836:	ba 70 00 00 00       	mov    $0x70,%edx
8010283b:	89 e5                	mov    %esp,%ebp
8010283d:	57                   	push   %edi
8010283e:	56                   	push   %esi
8010283f:	53                   	push   %ebx
80102840:	83 ec 4c             	sub    $0x4c,%esp
80102843:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102844:	ba 71 00 00 00       	mov    $0x71,%edx
80102849:	ec                   	in     (%dx),%al
8010284a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010284d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102852:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102855:	8d 76 00             	lea    0x0(%esi),%esi
80102858:	31 c0                	xor    %eax,%eax
8010285a:	89 da                	mov    %ebx,%edx
8010285c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010285d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102862:	89 ca                	mov    %ecx,%edx
80102864:	ec                   	in     (%dx),%al
80102865:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102868:	89 da                	mov    %ebx,%edx
8010286a:	b8 02 00 00 00       	mov    $0x2,%eax
8010286f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102870:	89 ca                	mov    %ecx,%edx
80102872:	ec                   	in     (%dx),%al
80102873:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102876:	89 da                	mov    %ebx,%edx
80102878:	b8 04 00 00 00       	mov    $0x4,%eax
8010287d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010287e:	89 ca                	mov    %ecx,%edx
80102880:	ec                   	in     (%dx),%al
80102881:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102884:	89 da                	mov    %ebx,%edx
80102886:	b8 07 00 00 00       	mov    $0x7,%eax
8010288b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010288c:	89 ca                	mov    %ecx,%edx
8010288e:	ec                   	in     (%dx),%al
8010288f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102892:	89 da                	mov    %ebx,%edx
80102894:	b8 08 00 00 00       	mov    $0x8,%eax
80102899:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010289a:	89 ca                	mov    %ecx,%edx
8010289c:	ec                   	in     (%dx),%al
8010289d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010289f:	89 da                	mov    %ebx,%edx
801028a1:	b8 09 00 00 00       	mov    $0x9,%eax
801028a6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028a7:	89 ca                	mov    %ecx,%edx
801028a9:	ec                   	in     (%dx),%al
801028aa:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028ac:	89 da                	mov    %ebx,%edx
801028ae:	b8 0a 00 00 00       	mov    $0xa,%eax
801028b3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028b4:	89 ca                	mov    %ecx,%edx
801028b6:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801028b7:	84 c0                	test   %al,%al
801028b9:	78 9d                	js     80102858 <cmostime+0x28>
  return inb(CMOS_RETURN);
801028bb:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
801028bf:	89 fa                	mov    %edi,%edx
801028c1:	0f b6 fa             	movzbl %dl,%edi
801028c4:	89 f2                	mov    %esi,%edx
801028c6:	0f b6 f2             	movzbl %dl,%esi
801028c9:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028cc:	89 da                	mov    %ebx,%edx
801028ce:	89 75 cc             	mov    %esi,-0x34(%ebp)
801028d1:	89 45 b8             	mov    %eax,-0x48(%ebp)
801028d4:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801028d8:	89 45 bc             	mov    %eax,-0x44(%ebp)
801028db:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801028df:	89 45 c0             	mov    %eax,-0x40(%ebp)
801028e2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801028e6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801028e9:	31 c0                	xor    %eax,%eax
801028eb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ec:	89 ca                	mov    %ecx,%edx
801028ee:	ec                   	in     (%dx),%al
801028ef:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028f2:	89 da                	mov    %ebx,%edx
801028f4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801028f7:	b8 02 00 00 00       	mov    $0x2,%eax
801028fc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028fd:	89 ca                	mov    %ecx,%edx
801028ff:	ec                   	in     (%dx),%al
80102900:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102903:	89 da                	mov    %ebx,%edx
80102905:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102908:	b8 04 00 00 00       	mov    $0x4,%eax
8010290d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010290e:	89 ca                	mov    %ecx,%edx
80102910:	ec                   	in     (%dx),%al
80102911:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102914:	89 da                	mov    %ebx,%edx
80102916:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102919:	b8 07 00 00 00       	mov    $0x7,%eax
8010291e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010291f:	89 ca                	mov    %ecx,%edx
80102921:	ec                   	in     (%dx),%al
80102922:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102925:	89 da                	mov    %ebx,%edx
80102927:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010292a:	b8 08 00 00 00       	mov    $0x8,%eax
8010292f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102930:	89 ca                	mov    %ecx,%edx
80102932:	ec                   	in     (%dx),%al
80102933:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102936:	89 da                	mov    %ebx,%edx
80102938:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010293b:	b8 09 00 00 00       	mov    $0x9,%eax
80102940:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102941:	89 ca                	mov    %ecx,%edx
80102943:	ec                   	in     (%dx),%al
80102944:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102947:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
8010294a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010294d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102950:	6a 18                	push   $0x18
80102952:	50                   	push   %eax
80102953:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102956:	50                   	push   %eax
80102957:	e8 d4 1c 00 00       	call   80104630 <memcmp>
8010295c:	83 c4 10             	add    $0x10,%esp
8010295f:	85 c0                	test   %eax,%eax
80102961:	0f 85 f1 fe ff ff    	jne    80102858 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102967:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
8010296b:	75 78                	jne    801029e5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010296d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102970:	89 c2                	mov    %eax,%edx
80102972:	83 e0 0f             	and    $0xf,%eax
80102975:	c1 ea 04             	shr    $0x4,%edx
80102978:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010297b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010297e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102981:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102984:	89 c2                	mov    %eax,%edx
80102986:	83 e0 0f             	and    $0xf,%eax
80102989:	c1 ea 04             	shr    $0x4,%edx
8010298c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010298f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102992:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102995:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102998:	89 c2                	mov    %eax,%edx
8010299a:	83 e0 0f             	and    $0xf,%eax
8010299d:	c1 ea 04             	shr    $0x4,%edx
801029a0:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029a3:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029a6:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
801029a9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029ac:	89 c2                	mov    %eax,%edx
801029ae:	83 e0 0f             	and    $0xf,%eax
801029b1:	c1 ea 04             	shr    $0x4,%edx
801029b4:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029b7:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029ba:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
801029bd:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029c0:	89 c2                	mov    %eax,%edx
801029c2:	83 e0 0f             	and    $0xf,%eax
801029c5:	c1 ea 04             	shr    $0x4,%edx
801029c8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029cb:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029ce:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801029d1:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029d4:	89 c2                	mov    %eax,%edx
801029d6:	83 e0 0f             	and    $0xf,%eax
801029d9:	c1 ea 04             	shr    $0x4,%edx
801029dc:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029df:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029e2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801029e5:	8b 75 08             	mov    0x8(%ebp),%esi
801029e8:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029eb:	89 06                	mov    %eax,(%esi)
801029ed:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029f0:	89 46 04             	mov    %eax,0x4(%esi)
801029f3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029f6:	89 46 08             	mov    %eax,0x8(%esi)
801029f9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029fc:	89 46 0c             	mov    %eax,0xc(%esi)
801029ff:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a02:	89 46 10             	mov    %eax,0x10(%esi)
80102a05:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a08:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102a0b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102a12:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a15:	5b                   	pop    %ebx
80102a16:	5e                   	pop    %esi
80102a17:	5f                   	pop    %edi
80102a18:	5d                   	pop    %ebp
80102a19:	c3                   	ret    
80102a1a:	66 90                	xchg   %ax,%ax
80102a1c:	66 90                	xchg   %ax,%ax
80102a1e:	66 90                	xchg   %ax,%ax

80102a20 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a20:	8b 0d 88 30 11 80    	mov    0x80113088,%ecx
80102a26:	85 c9                	test   %ecx,%ecx
80102a28:	0f 8e 8a 00 00 00    	jle    80102ab8 <install_trans+0x98>
{
80102a2e:	55                   	push   %ebp
80102a2f:	89 e5                	mov    %esp,%ebp
80102a31:	57                   	push   %edi
80102a32:	56                   	push   %esi
80102a33:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102a34:	31 db                	xor    %ebx,%ebx
{
80102a36:	83 ec 0c             	sub    $0xc,%esp
80102a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102a40:	a1 74 30 11 80       	mov    0x80113074,%eax
80102a45:	83 ec 08             	sub    $0x8,%esp
80102a48:	01 d8                	add    %ebx,%eax
80102a4a:	83 c0 01             	add    $0x1,%eax
80102a4d:	50                   	push   %eax
80102a4e:	ff 35 84 30 11 80    	pushl  0x80113084
80102a54:	e8 77 d6 ff ff       	call   801000d0 <bread>
80102a59:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a5b:	58                   	pop    %eax
80102a5c:	5a                   	pop    %edx
80102a5d:	ff 34 9d 8c 30 11 80 	pushl  -0x7feecf74(,%ebx,4)
80102a64:	ff 35 84 30 11 80    	pushl  0x80113084
  for (tail = 0; tail < log.lh.n; tail++) {
80102a6a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a6d:	e8 5e d6 ff ff       	call   801000d0 <bread>
80102a72:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a74:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a77:	83 c4 0c             	add    $0xc,%esp
80102a7a:	68 00 02 00 00       	push   $0x200
80102a7f:	50                   	push   %eax
80102a80:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a83:	50                   	push   %eax
80102a84:	e8 07 1c 00 00       	call   80104690 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a89:	89 34 24             	mov    %esi,(%esp)
80102a8c:	e8 0f d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102a91:	89 3c 24             	mov    %edi,(%esp)
80102a94:	e8 47 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102a99:	89 34 24             	mov    %esi,(%esp)
80102a9c:	e8 3f d7 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102aa1:	83 c4 10             	add    $0x10,%esp
80102aa4:	39 1d 88 30 11 80    	cmp    %ebx,0x80113088
80102aaa:	7f 94                	jg     80102a40 <install_trans+0x20>
  }
}
80102aac:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102aaf:	5b                   	pop    %ebx
80102ab0:	5e                   	pop    %esi
80102ab1:	5f                   	pop    %edi
80102ab2:	5d                   	pop    %ebp
80102ab3:	c3                   	ret    
80102ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ab8:	f3 c3                	repz ret 
80102aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102ac0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102ac0:	55                   	push   %ebp
80102ac1:	89 e5                	mov    %esp,%ebp
80102ac3:	56                   	push   %esi
80102ac4:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102ac5:	83 ec 08             	sub    $0x8,%esp
80102ac8:	ff 35 74 30 11 80    	pushl  0x80113074
80102ace:	ff 35 84 30 11 80    	pushl  0x80113084
80102ad4:	e8 f7 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102ad9:	8b 1d 88 30 11 80    	mov    0x80113088,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102adf:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ae2:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102ae4:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102ae6:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102ae9:	7e 16                	jle    80102b01 <write_head+0x41>
80102aeb:	c1 e3 02             	shl    $0x2,%ebx
80102aee:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102af0:	8b 8a 8c 30 11 80    	mov    -0x7feecf74(%edx),%ecx
80102af6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102afa:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102afd:	39 da                	cmp    %ebx,%edx
80102aff:	75 ef                	jne    80102af0 <write_head+0x30>
  }
  bwrite(buf);
80102b01:	83 ec 0c             	sub    $0xc,%esp
80102b04:	56                   	push   %esi
80102b05:	e8 96 d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102b0a:	89 34 24             	mov    %esi,(%esp)
80102b0d:	e8 ce d6 ff ff       	call   801001e0 <brelse>
}
80102b12:	83 c4 10             	add    $0x10,%esp
80102b15:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b18:	5b                   	pop    %ebx
80102b19:	5e                   	pop    %esi
80102b1a:	5d                   	pop    %ebp
80102b1b:	c3                   	ret    
80102b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102b20 <initlog>:
{
80102b20:	55                   	push   %ebp
80102b21:	89 e5                	mov    %esp,%ebp
80102b23:	53                   	push   %ebx
80102b24:	83 ec 2c             	sub    $0x2c,%esp
80102b27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102b2a:	68 00 77 10 80       	push   $0x80107700
80102b2f:	68 40 30 11 80       	push   $0x80113040
80102b34:	e8 57 18 00 00       	call   80104390 <initlock>
  readsb(dev, &sb);
80102b39:	58                   	pop    %eax
80102b3a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102b3d:	5a                   	pop    %edx
80102b3e:	50                   	push   %eax
80102b3f:	53                   	push   %ebx
80102b40:	e8 9b e8 ff ff       	call   801013e0 <readsb>
  log.size = sb.nlog;
80102b45:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102b48:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102b4b:	59                   	pop    %ecx
  log.dev = dev;
80102b4c:	89 1d 84 30 11 80    	mov    %ebx,0x80113084
  log.size = sb.nlog;
80102b52:	89 15 78 30 11 80    	mov    %edx,0x80113078
  log.start = sb.logstart;
80102b58:	a3 74 30 11 80       	mov    %eax,0x80113074
  struct buf *buf = bread(log.dev, log.start);
80102b5d:	5a                   	pop    %edx
80102b5e:	50                   	push   %eax
80102b5f:	53                   	push   %ebx
80102b60:	e8 6b d5 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102b65:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b68:	83 c4 10             	add    $0x10,%esp
80102b6b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102b6d:	89 1d 88 30 11 80    	mov    %ebx,0x80113088
  for (i = 0; i < log.lh.n; i++) {
80102b73:	7e 1c                	jle    80102b91 <initlog+0x71>
80102b75:	c1 e3 02             	shl    $0x2,%ebx
80102b78:	31 d2                	xor    %edx,%edx
80102b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102b80:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b84:	83 c2 04             	add    $0x4,%edx
80102b87:	89 8a 88 30 11 80    	mov    %ecx,-0x7feecf78(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102b8d:	39 d3                	cmp    %edx,%ebx
80102b8f:	75 ef                	jne    80102b80 <initlog+0x60>
  brelse(buf);
80102b91:	83 ec 0c             	sub    $0xc,%esp
80102b94:	50                   	push   %eax
80102b95:	e8 46 d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102b9a:	e8 81 fe ff ff       	call   80102a20 <install_trans>
  log.lh.n = 0;
80102b9f:	c7 05 88 30 11 80 00 	movl   $0x0,0x80113088
80102ba6:	00 00 00 
  write_head(); // clear the log
80102ba9:	e8 12 ff ff ff       	call   80102ac0 <write_head>
}
80102bae:	83 c4 10             	add    $0x10,%esp
80102bb1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bb4:	c9                   	leave  
80102bb5:	c3                   	ret    
80102bb6:	8d 76 00             	lea    0x0(%esi),%esi
80102bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102bc0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102bc0:	55                   	push   %ebp
80102bc1:	89 e5                	mov    %esp,%ebp
80102bc3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102bc6:	68 40 30 11 80       	push   $0x80113040
80102bcb:	e8 00 19 00 00       	call   801044d0 <acquire>
80102bd0:	83 c4 10             	add    $0x10,%esp
80102bd3:	eb 18                	jmp    80102bed <begin_op+0x2d>
80102bd5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102bd8:	83 ec 08             	sub    $0x8,%esp
80102bdb:	68 40 30 11 80       	push   $0x80113040
80102be0:	68 40 30 11 80       	push   $0x80113040
80102be5:	e8 46 11 00 00       	call   80103d30 <sleep>
80102bea:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102bed:	a1 80 30 11 80       	mov    0x80113080,%eax
80102bf2:	85 c0                	test   %eax,%eax
80102bf4:	75 e2                	jne    80102bd8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102bf6:	a1 7c 30 11 80       	mov    0x8011307c,%eax
80102bfb:	8b 15 88 30 11 80    	mov    0x80113088,%edx
80102c01:	83 c0 01             	add    $0x1,%eax
80102c04:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102c07:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102c0a:	83 fa 1e             	cmp    $0x1e,%edx
80102c0d:	7f c9                	jg     80102bd8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102c0f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102c12:	a3 7c 30 11 80       	mov    %eax,0x8011307c
      release(&log.lock);
80102c17:	68 40 30 11 80       	push   $0x80113040
80102c1c:	e8 6f 19 00 00       	call   80104590 <release>
      break;
    }
  }
}
80102c21:	83 c4 10             	add    $0x10,%esp
80102c24:	c9                   	leave  
80102c25:	c3                   	ret    
80102c26:	8d 76 00             	lea    0x0(%esi),%esi
80102c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c30 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102c30:	55                   	push   %ebp
80102c31:	89 e5                	mov    %esp,%ebp
80102c33:	57                   	push   %edi
80102c34:	56                   	push   %esi
80102c35:	53                   	push   %ebx
80102c36:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102c39:	68 40 30 11 80       	push   $0x80113040
80102c3e:	e8 8d 18 00 00       	call   801044d0 <acquire>
  log.outstanding -= 1;
80102c43:	a1 7c 30 11 80       	mov    0x8011307c,%eax
  if(log.committing)
80102c48:	8b 35 80 30 11 80    	mov    0x80113080,%esi
80102c4e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102c51:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102c54:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102c56:	89 1d 7c 30 11 80    	mov    %ebx,0x8011307c
  if(log.committing)
80102c5c:	0f 85 1a 01 00 00    	jne    80102d7c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102c62:	85 db                	test   %ebx,%ebx
80102c64:	0f 85 ee 00 00 00    	jne    80102d58 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102c6a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102c6d:	c7 05 80 30 11 80 01 	movl   $0x1,0x80113080
80102c74:	00 00 00 
  release(&log.lock);
80102c77:	68 40 30 11 80       	push   $0x80113040
80102c7c:	e8 0f 19 00 00       	call   80104590 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c81:	8b 0d 88 30 11 80    	mov    0x80113088,%ecx
80102c87:	83 c4 10             	add    $0x10,%esp
80102c8a:	85 c9                	test   %ecx,%ecx
80102c8c:	0f 8e 85 00 00 00    	jle    80102d17 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c92:	a1 74 30 11 80       	mov    0x80113074,%eax
80102c97:	83 ec 08             	sub    $0x8,%esp
80102c9a:	01 d8                	add    %ebx,%eax
80102c9c:	83 c0 01             	add    $0x1,%eax
80102c9f:	50                   	push   %eax
80102ca0:	ff 35 84 30 11 80    	pushl  0x80113084
80102ca6:	e8 25 d4 ff ff       	call   801000d0 <bread>
80102cab:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102cad:	58                   	pop    %eax
80102cae:	5a                   	pop    %edx
80102caf:	ff 34 9d 8c 30 11 80 	pushl  -0x7feecf74(,%ebx,4)
80102cb6:	ff 35 84 30 11 80    	pushl  0x80113084
  for (tail = 0; tail < log.lh.n; tail++) {
80102cbc:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102cbf:	e8 0c d4 ff ff       	call   801000d0 <bread>
80102cc4:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102cc6:	8d 40 5c             	lea    0x5c(%eax),%eax
80102cc9:	83 c4 0c             	add    $0xc,%esp
80102ccc:	68 00 02 00 00       	push   $0x200
80102cd1:	50                   	push   %eax
80102cd2:	8d 46 5c             	lea    0x5c(%esi),%eax
80102cd5:	50                   	push   %eax
80102cd6:	e8 b5 19 00 00       	call   80104690 <memmove>
    bwrite(to);  // write the log
80102cdb:	89 34 24             	mov    %esi,(%esp)
80102cde:	e8 bd d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102ce3:	89 3c 24             	mov    %edi,(%esp)
80102ce6:	e8 f5 d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102ceb:	89 34 24             	mov    %esi,(%esp)
80102cee:	e8 ed d4 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102cf3:	83 c4 10             	add    $0x10,%esp
80102cf6:	3b 1d 88 30 11 80    	cmp    0x80113088,%ebx
80102cfc:	7c 94                	jl     80102c92 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102cfe:	e8 bd fd ff ff       	call   80102ac0 <write_head>
    install_trans(); // Now install writes to home locations
80102d03:	e8 18 fd ff ff       	call   80102a20 <install_trans>
    log.lh.n = 0;
80102d08:	c7 05 88 30 11 80 00 	movl   $0x0,0x80113088
80102d0f:	00 00 00 
    write_head();    // Erase the transaction from the log
80102d12:	e8 a9 fd ff ff       	call   80102ac0 <write_head>
    acquire(&log.lock);
80102d17:	83 ec 0c             	sub    $0xc,%esp
80102d1a:	68 40 30 11 80       	push   $0x80113040
80102d1f:	e8 ac 17 00 00       	call   801044d0 <acquire>
    wakeup(&log);
80102d24:	c7 04 24 40 30 11 80 	movl   $0x80113040,(%esp)
    log.committing = 0;
80102d2b:	c7 05 80 30 11 80 00 	movl   $0x0,0x80113080
80102d32:	00 00 00 
    wakeup(&log);
80102d35:	e8 a6 11 00 00       	call   80103ee0 <wakeup>
    release(&log.lock);
80102d3a:	c7 04 24 40 30 11 80 	movl   $0x80113040,(%esp)
80102d41:	e8 4a 18 00 00       	call   80104590 <release>
80102d46:	83 c4 10             	add    $0x10,%esp
}
80102d49:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d4c:	5b                   	pop    %ebx
80102d4d:	5e                   	pop    %esi
80102d4e:	5f                   	pop    %edi
80102d4f:	5d                   	pop    %ebp
80102d50:	c3                   	ret    
80102d51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102d58:	83 ec 0c             	sub    $0xc,%esp
80102d5b:	68 40 30 11 80       	push   $0x80113040
80102d60:	e8 7b 11 00 00       	call   80103ee0 <wakeup>
  release(&log.lock);
80102d65:	c7 04 24 40 30 11 80 	movl   $0x80113040,(%esp)
80102d6c:	e8 1f 18 00 00       	call   80104590 <release>
80102d71:	83 c4 10             	add    $0x10,%esp
}
80102d74:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d77:	5b                   	pop    %ebx
80102d78:	5e                   	pop    %esi
80102d79:	5f                   	pop    %edi
80102d7a:	5d                   	pop    %ebp
80102d7b:	c3                   	ret    
    panic("log.committing");
80102d7c:	83 ec 0c             	sub    $0xc,%esp
80102d7f:	68 04 77 10 80       	push   $0x80107704
80102d84:	e8 07 d6 ff ff       	call   80100390 <panic>
80102d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d90 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d90:	55                   	push   %ebp
80102d91:	89 e5                	mov    %esp,%ebp
80102d93:	53                   	push   %ebx
80102d94:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d97:	8b 15 88 30 11 80    	mov    0x80113088,%edx
{
80102d9d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102da0:	83 fa 1d             	cmp    $0x1d,%edx
80102da3:	0f 8f 9d 00 00 00    	jg     80102e46 <log_write+0xb6>
80102da9:	a1 78 30 11 80       	mov    0x80113078,%eax
80102dae:	83 e8 01             	sub    $0x1,%eax
80102db1:	39 c2                	cmp    %eax,%edx
80102db3:	0f 8d 8d 00 00 00    	jge    80102e46 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102db9:	a1 7c 30 11 80       	mov    0x8011307c,%eax
80102dbe:	85 c0                	test   %eax,%eax
80102dc0:	0f 8e 8d 00 00 00    	jle    80102e53 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102dc6:	83 ec 0c             	sub    $0xc,%esp
80102dc9:	68 40 30 11 80       	push   $0x80113040
80102dce:	e8 fd 16 00 00       	call   801044d0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102dd3:	8b 0d 88 30 11 80    	mov    0x80113088,%ecx
80102dd9:	83 c4 10             	add    $0x10,%esp
80102ddc:	83 f9 00             	cmp    $0x0,%ecx
80102ddf:	7e 57                	jle    80102e38 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102de1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102de4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102de6:	3b 15 8c 30 11 80    	cmp    0x8011308c,%edx
80102dec:	75 0b                	jne    80102df9 <log_write+0x69>
80102dee:	eb 38                	jmp    80102e28 <log_write+0x98>
80102df0:	39 14 85 8c 30 11 80 	cmp    %edx,-0x7feecf74(,%eax,4)
80102df7:	74 2f                	je     80102e28 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102df9:	83 c0 01             	add    $0x1,%eax
80102dfc:	39 c1                	cmp    %eax,%ecx
80102dfe:	75 f0                	jne    80102df0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102e00:	89 14 85 8c 30 11 80 	mov    %edx,-0x7feecf74(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102e07:	83 c0 01             	add    $0x1,%eax
80102e0a:	a3 88 30 11 80       	mov    %eax,0x80113088
  b->flags |= B_DIRTY; // prevent eviction
80102e0f:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102e12:	c7 45 08 40 30 11 80 	movl   $0x80113040,0x8(%ebp)
}
80102e19:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e1c:	c9                   	leave  
  release(&log.lock);
80102e1d:	e9 6e 17 00 00       	jmp    80104590 <release>
80102e22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102e28:	89 14 85 8c 30 11 80 	mov    %edx,-0x7feecf74(,%eax,4)
80102e2f:	eb de                	jmp    80102e0f <log_write+0x7f>
80102e31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e38:	8b 43 08             	mov    0x8(%ebx),%eax
80102e3b:	a3 8c 30 11 80       	mov    %eax,0x8011308c
  if (i == log.lh.n)
80102e40:	75 cd                	jne    80102e0f <log_write+0x7f>
80102e42:	31 c0                	xor    %eax,%eax
80102e44:	eb c1                	jmp    80102e07 <log_write+0x77>
    panic("too big a transaction");
80102e46:	83 ec 0c             	sub    $0xc,%esp
80102e49:	68 13 77 10 80       	push   $0x80107713
80102e4e:	e8 3d d5 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102e53:	83 ec 0c             	sub    $0xc,%esp
80102e56:	68 29 77 10 80       	push   $0x80107729
80102e5b:	e8 30 d5 ff ff       	call   80100390 <panic>

80102e60 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102e60:	55                   	push   %ebp
80102e61:	89 e5                	mov    %esp,%ebp
80102e63:	53                   	push   %ebx
80102e64:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102e67:	e8 34 09 00 00       	call   801037a0 <cpuid>
80102e6c:	89 c3                	mov    %eax,%ebx
80102e6e:	e8 2d 09 00 00       	call   801037a0 <cpuid>
80102e73:	83 ec 04             	sub    $0x4,%esp
80102e76:	53                   	push   %ebx
80102e77:	50                   	push   %eax
80102e78:	68 44 77 10 80       	push   $0x80107744
80102e7d:	e8 de d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e82:	e8 29 2a 00 00       	call   801058b0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e87:	e8 c4 08 00 00       	call   80103750 <mycpu>
80102e8c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e8e:	b8 01 00 00 00       	mov    $0x1,%eax
80102e93:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102e9a:	e8 61 12 00 00       	call   80104100 <scheduler>
80102e9f:	90                   	nop

80102ea0 <mpenter>:
{
80102ea0:	55                   	push   %ebp
80102ea1:	89 e5                	mov    %esp,%ebp
80102ea3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102ea6:	e8 f5 3a 00 00       	call   801069a0 <switchkvm>
  seginit();
80102eab:	e8 60 3a 00 00       	call   80106910 <seginit>
  lapicinit();
80102eb0:	e8 9b f7 ff ff       	call   80102650 <lapicinit>
  mpmain();
80102eb5:	e8 a6 ff ff ff       	call   80102e60 <mpmain>
80102eba:	66 90                	xchg   %ax,%ax
80102ebc:	66 90                	xchg   %ax,%ax
80102ebe:	66 90                	xchg   %ax,%ax

80102ec0 <main>:
{
80102ec0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102ec4:	83 e4 f0             	and    $0xfffffff0,%esp
80102ec7:	ff 71 fc             	pushl  -0x4(%ecx)
80102eca:	55                   	push   %ebp
80102ecb:	89 e5                	mov    %esp,%ebp
80102ecd:	53                   	push   %ebx
80102ece:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102ecf:	83 ec 08             	sub    $0x8,%esp
80102ed2:	68 00 00 40 80       	push   $0x80400000
80102ed7:	68 88 5a 11 80       	push   $0x80115a88
80102edc:	e8 2f f5 ff ff       	call   80102410 <kinit1>
  kvmalloc();      // kernel page table
80102ee1:	e8 8a 3f 00 00       	call   80106e70 <kvmalloc>
  mpinit();        // detect other processors
80102ee6:	e8 75 01 00 00       	call   80103060 <mpinit>
  lapicinit();     // interrupt controller
80102eeb:	e8 60 f7 ff ff       	call   80102650 <lapicinit>
  seginit();       // segment descriptors
80102ef0:	e8 1b 3a 00 00       	call   80106910 <seginit>
  picinit();       // disable pic
80102ef5:	e8 36 03 00 00       	call   80103230 <picinit>
  ioapicinit();    // another interrupt controller
80102efa:	e8 41 f3 ff ff       	call   80102240 <ioapicinit>
  consoleinit();   // console hardware
80102eff:	e8 cc da ff ff       	call   801009d0 <consoleinit>
  uartinit();      // serial port
80102f04:	e8 d7 2c 00 00       	call   80105be0 <uartinit>
  pinit();         // process table
80102f09:	e8 22 08 00 00       	call   80103730 <pinit>
  tvinit();        // trap vectors
80102f0e:	e8 1d 29 00 00       	call   80105830 <tvinit>
  binit();         // buffer cache
80102f13:	e8 28 d1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102f18:	e8 53 de ff ff       	call   80100d70 <fileinit>
  ideinit();       // disk 
80102f1d:	e8 fe f0 ff ff       	call   80102020 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f22:	83 c4 0c             	add    $0xc,%esp
80102f25:	68 8a 00 00 00       	push   $0x8a
80102f2a:	68 90 a4 10 80       	push   $0x8010a490
80102f2f:	68 00 70 00 80       	push   $0x80007000
80102f34:	e8 57 17 00 00       	call   80104690 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f39:	69 05 f0 31 11 80 b0 	imul   $0xb0,0x801131f0,%eax
80102f40:	00 00 00 
80102f43:	83 c4 10             	add    $0x10,%esp
80102f46:	05 40 31 11 80       	add    $0x80113140,%eax
80102f4b:	3d 40 31 11 80       	cmp    $0x80113140,%eax
80102f50:	76 71                	jbe    80102fc3 <main+0x103>
80102f52:	bb 40 31 11 80       	mov    $0x80113140,%ebx
80102f57:	89 f6                	mov    %esi,%esi
80102f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80102f60:	e8 eb 07 00 00       	call   80103750 <mycpu>
80102f65:	39 d8                	cmp    %ebx,%eax
80102f67:	74 41                	je     80102faa <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102f69:	e8 72 f5 ff ff       	call   801024e0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f6e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80102f73:	c7 05 f8 6f 00 80 a0 	movl   $0x80102ea0,0x80006ff8
80102f7a:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f7d:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102f84:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f87:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
80102f8c:	0f b6 03             	movzbl (%ebx),%eax
80102f8f:	83 ec 08             	sub    $0x8,%esp
80102f92:	68 00 70 00 00       	push   $0x7000
80102f97:	50                   	push   %eax
80102f98:	e8 03 f8 ff ff       	call   801027a0 <lapicstartap>
80102f9d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102fa0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102fa6:	85 c0                	test   %eax,%eax
80102fa8:	74 f6                	je     80102fa0 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
80102faa:	69 05 f0 31 11 80 b0 	imul   $0xb0,0x801131f0,%eax
80102fb1:	00 00 00 
80102fb4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102fba:	05 40 31 11 80       	add    $0x80113140,%eax
80102fbf:	39 c3                	cmp    %eax,%ebx
80102fc1:	72 9d                	jb     80102f60 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102fc3:	83 ec 08             	sub    $0x8,%esp
80102fc6:	68 00 00 00 8e       	push   $0x8e000000
80102fcb:	68 00 00 40 80       	push   $0x80400000
80102fd0:	e8 ab f4 ff ff       	call   80102480 <kinit2>
  userinit();      // first user process
80102fd5:	e8 16 08 00 00       	call   801037f0 <userinit>
  mpmain();        // finish this processor's setup
80102fda:	e8 81 fe ff ff       	call   80102e60 <mpmain>
80102fdf:	90                   	nop

80102fe0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fe0:	55                   	push   %ebp
80102fe1:	89 e5                	mov    %esp,%ebp
80102fe3:	57                   	push   %edi
80102fe4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102fe5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80102feb:	53                   	push   %ebx
  e = addr+len;
80102fec:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80102fef:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80102ff2:	39 de                	cmp    %ebx,%esi
80102ff4:	72 10                	jb     80103006 <mpsearch1+0x26>
80102ff6:	eb 50                	jmp    80103048 <mpsearch1+0x68>
80102ff8:	90                   	nop
80102ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103000:	39 fb                	cmp    %edi,%ebx
80103002:	89 fe                	mov    %edi,%esi
80103004:	76 42                	jbe    80103048 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103006:	83 ec 04             	sub    $0x4,%esp
80103009:	8d 7e 10             	lea    0x10(%esi),%edi
8010300c:	6a 04                	push   $0x4
8010300e:	68 58 77 10 80       	push   $0x80107758
80103013:	56                   	push   %esi
80103014:	e8 17 16 00 00       	call   80104630 <memcmp>
80103019:	83 c4 10             	add    $0x10,%esp
8010301c:	85 c0                	test   %eax,%eax
8010301e:	75 e0                	jne    80103000 <mpsearch1+0x20>
80103020:	89 f1                	mov    %esi,%ecx
80103022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103028:	0f b6 11             	movzbl (%ecx),%edx
8010302b:	83 c1 01             	add    $0x1,%ecx
8010302e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103030:	39 f9                	cmp    %edi,%ecx
80103032:	75 f4                	jne    80103028 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103034:	84 c0                	test   %al,%al
80103036:	75 c8                	jne    80103000 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103038:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010303b:	89 f0                	mov    %esi,%eax
8010303d:	5b                   	pop    %ebx
8010303e:	5e                   	pop    %esi
8010303f:	5f                   	pop    %edi
80103040:	5d                   	pop    %ebp
80103041:	c3                   	ret    
80103042:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103048:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010304b:	31 f6                	xor    %esi,%esi
}
8010304d:	89 f0                	mov    %esi,%eax
8010304f:	5b                   	pop    %ebx
80103050:	5e                   	pop    %esi
80103051:	5f                   	pop    %edi
80103052:	5d                   	pop    %ebp
80103053:	c3                   	ret    
80103054:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010305a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103060 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103060:	55                   	push   %ebp
80103061:	89 e5                	mov    %esp,%ebp
80103063:	57                   	push   %edi
80103064:	56                   	push   %esi
80103065:	53                   	push   %ebx
80103066:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103069:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103070:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103077:	c1 e0 08             	shl    $0x8,%eax
8010307a:	09 d0                	or     %edx,%eax
8010307c:	c1 e0 04             	shl    $0x4,%eax
8010307f:	85 c0                	test   %eax,%eax
80103081:	75 1b                	jne    8010309e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103083:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010308a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103091:	c1 e0 08             	shl    $0x8,%eax
80103094:	09 d0                	or     %edx,%eax
80103096:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103099:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010309e:	ba 00 04 00 00       	mov    $0x400,%edx
801030a3:	e8 38 ff ff ff       	call   80102fe0 <mpsearch1>
801030a8:	85 c0                	test   %eax,%eax
801030aa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801030ad:	0f 84 35 01 00 00    	je     801031e8 <mpinit+0x188>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801030b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801030b6:	8b 58 04             	mov    0x4(%eax),%ebx
801030b9:	85 db                	test   %ebx,%ebx
801030bb:	0f 84 47 01 00 00    	je     80103208 <mpinit+0x1a8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801030c1:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
801030c7:	83 ec 04             	sub    $0x4,%esp
801030ca:	6a 04                	push   $0x4
801030cc:	68 75 77 10 80       	push   $0x80107775
801030d1:	56                   	push   %esi
801030d2:	e8 59 15 00 00       	call   80104630 <memcmp>
801030d7:	83 c4 10             	add    $0x10,%esp
801030da:	85 c0                	test   %eax,%eax
801030dc:	0f 85 26 01 00 00    	jne    80103208 <mpinit+0x1a8>
  if(conf->version != 1 && conf->version != 4)
801030e2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801030e9:	3c 01                	cmp    $0x1,%al
801030eb:	0f 95 c2             	setne  %dl
801030ee:	3c 04                	cmp    $0x4,%al
801030f0:	0f 95 c0             	setne  %al
801030f3:	20 c2                	and    %al,%dl
801030f5:	0f 85 0d 01 00 00    	jne    80103208 <mpinit+0x1a8>
  if(sum((uchar*)conf, conf->length) != 0)
801030fb:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
80103102:	66 85 ff             	test   %di,%di
80103105:	74 1a                	je     80103121 <mpinit+0xc1>
80103107:	89 f0                	mov    %esi,%eax
80103109:	01 f7                	add    %esi,%edi
  sum = 0;
8010310b:	31 d2                	xor    %edx,%edx
8010310d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103110:	0f b6 08             	movzbl (%eax),%ecx
80103113:	83 c0 01             	add    $0x1,%eax
80103116:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103118:	39 c7                	cmp    %eax,%edi
8010311a:	75 f4                	jne    80103110 <mpinit+0xb0>
8010311c:	84 d2                	test   %dl,%dl
8010311e:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103121:	85 f6                	test   %esi,%esi
80103123:	0f 84 df 00 00 00    	je     80103208 <mpinit+0x1a8>
80103129:	84 d2                	test   %dl,%dl
8010312b:	0f 85 d7 00 00 00    	jne    80103208 <mpinit+0x1a8>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103131:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103137:	a3 3c 30 11 80       	mov    %eax,0x8011303c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010313c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103143:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103149:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010314e:	01 d6                	add    %edx,%esi
80103150:	39 c6                	cmp    %eax,%esi
80103152:	76 23                	jbe    80103177 <mpinit+0x117>
    switch(*p){
80103154:	0f b6 10             	movzbl (%eax),%edx
80103157:	80 fa 04             	cmp    $0x4,%dl
8010315a:	0f 87 c2 00 00 00    	ja     80103222 <mpinit+0x1c2>
80103160:	ff 24 95 9c 77 10 80 	jmp    *-0x7fef8864(,%edx,4)
80103167:	89 f6                	mov    %esi,%esi
80103169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103170:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103173:	39 c6                	cmp    %eax,%esi
80103175:	77 dd                	ja     80103154 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103177:	85 db                	test   %ebx,%ebx
80103179:	0f 84 96 00 00 00    	je     80103215 <mpinit+0x1b5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010317f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103182:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103186:	74 15                	je     8010319d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103188:	b8 70 00 00 00       	mov    $0x70,%eax
8010318d:	ba 22 00 00 00       	mov    $0x22,%edx
80103192:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103193:	ba 23 00 00 00       	mov    $0x23,%edx
80103198:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103199:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010319c:	ee                   	out    %al,(%dx)
  }
}
8010319d:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031a0:	5b                   	pop    %ebx
801031a1:	5e                   	pop    %esi
801031a2:	5f                   	pop    %edi
801031a3:	5d                   	pop    %ebp
801031a4:	c3                   	ret    
801031a5:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
801031a8:	8b 0d f0 31 11 80    	mov    0x801131f0,%ecx
801031ae:	85 c9                	test   %ecx,%ecx
801031b0:	7f 19                	jg     801031cb <mpinit+0x16b>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031b2:	0f b6 50 01          	movzbl 0x1(%eax),%edx
801031b6:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
801031bc:	83 c1 01             	add    $0x1,%ecx
801031bf:	89 0d f0 31 11 80    	mov    %ecx,0x801131f0
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031c5:	88 97 40 31 11 80    	mov    %dl,-0x7feecec0(%edi)
      p += sizeof(struct mpproc);
801031cb:	83 c0 14             	add    $0x14,%eax
      continue;
801031ce:	eb 80                	jmp    80103150 <mpinit+0xf0>
      ioapicid = ioapic->apicno;
801031d0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801031d4:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801031d7:	88 15 20 31 11 80    	mov    %dl,0x80113120
      continue;
801031dd:	e9 6e ff ff ff       	jmp    80103150 <mpinit+0xf0>
801031e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
801031e8:	ba 00 00 01 00       	mov    $0x10000,%edx
801031ed:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801031f2:	e8 e9 fd ff ff       	call   80102fe0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031f7:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
801031f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031fc:	0f 85 b1 fe ff ff    	jne    801030b3 <mpinit+0x53>
80103202:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103208:	83 ec 0c             	sub    $0xc,%esp
8010320b:	68 5d 77 10 80       	push   $0x8010775d
80103210:	e8 7b d1 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
80103215:	83 ec 0c             	sub    $0xc,%esp
80103218:	68 7c 77 10 80       	push   $0x8010777c
8010321d:	e8 6e d1 ff ff       	call   80100390 <panic>
      ismp = 0;
80103222:	31 db                	xor    %ebx,%ebx
80103224:	e9 2e ff ff ff       	jmp    80103157 <mpinit+0xf7>
80103229:	66 90                	xchg   %ax,%ax
8010322b:	66 90                	xchg   %ax,%ax
8010322d:	66 90                	xchg   %ax,%ax
8010322f:	90                   	nop

80103230 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103230:	55                   	push   %ebp
80103231:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103236:	ba 21 00 00 00       	mov    $0x21,%edx
8010323b:	89 e5                	mov    %esp,%ebp
8010323d:	ee                   	out    %al,(%dx)
8010323e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103243:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103244:	5d                   	pop    %ebp
80103245:	c3                   	ret    
80103246:	66 90                	xchg   %ax,%ax
80103248:	66 90                	xchg   %ax,%ax
8010324a:	66 90                	xchg   %ax,%ax
8010324c:	66 90                	xchg   %ax,%ax
8010324e:	66 90                	xchg   %ax,%ax

80103250 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103250:	55                   	push   %ebp
80103251:	89 e5                	mov    %esp,%ebp
80103253:	57                   	push   %edi
80103254:	56                   	push   %esi
80103255:	53                   	push   %ebx
80103256:	83 ec 0c             	sub    $0xc,%esp
80103259:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010325c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010325f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103265:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010326b:	e8 20 db ff ff       	call   80100d90 <filealloc>
80103270:	85 c0                	test   %eax,%eax
80103272:	89 03                	mov    %eax,(%ebx)
80103274:	74 22                	je     80103298 <pipealloc+0x48>
80103276:	e8 15 db ff ff       	call   80100d90 <filealloc>
8010327b:	85 c0                	test   %eax,%eax
8010327d:	89 06                	mov    %eax,(%esi)
8010327f:	74 3f                	je     801032c0 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103281:	e8 5a f2 ff ff       	call   801024e0 <kalloc>
80103286:	85 c0                	test   %eax,%eax
80103288:	89 c7                	mov    %eax,%edi
8010328a:	75 54                	jne    801032e0 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010328c:	8b 03                	mov    (%ebx),%eax
8010328e:	85 c0                	test   %eax,%eax
80103290:	75 34                	jne    801032c6 <pipealloc+0x76>
80103292:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103298:	8b 06                	mov    (%esi),%eax
8010329a:	85 c0                	test   %eax,%eax
8010329c:	74 0c                	je     801032aa <pipealloc+0x5a>
    fileclose(*f1);
8010329e:	83 ec 0c             	sub    $0xc,%esp
801032a1:	50                   	push   %eax
801032a2:	e8 a9 db ff ff       	call   80100e50 <fileclose>
801032a7:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801032aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801032ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801032b2:	5b                   	pop    %ebx
801032b3:	5e                   	pop    %esi
801032b4:	5f                   	pop    %edi
801032b5:	5d                   	pop    %ebp
801032b6:	c3                   	ret    
801032b7:	89 f6                	mov    %esi,%esi
801032b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
801032c0:	8b 03                	mov    (%ebx),%eax
801032c2:	85 c0                	test   %eax,%eax
801032c4:	74 e4                	je     801032aa <pipealloc+0x5a>
    fileclose(*f0);
801032c6:	83 ec 0c             	sub    $0xc,%esp
801032c9:	50                   	push   %eax
801032ca:	e8 81 db ff ff       	call   80100e50 <fileclose>
  if(*f1)
801032cf:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
801032d1:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801032d4:	85 c0                	test   %eax,%eax
801032d6:	75 c6                	jne    8010329e <pipealloc+0x4e>
801032d8:	eb d0                	jmp    801032aa <pipealloc+0x5a>
801032da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
801032e0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801032e3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801032ea:	00 00 00 
  p->writeopen = 1;
801032ed:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801032f4:	00 00 00 
  p->nwrite = 0;
801032f7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801032fe:	00 00 00 
  p->nread = 0;
80103301:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103308:	00 00 00 
  initlock(&p->lock, "pipe");
8010330b:	68 b0 77 10 80       	push   $0x801077b0
80103310:	50                   	push   %eax
80103311:	e8 7a 10 00 00       	call   80104390 <initlock>
  (*f0)->type = FD_PIPE;
80103316:	8b 03                	mov    (%ebx),%eax
  return 0;
80103318:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010331b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103321:	8b 03                	mov    (%ebx),%eax
80103323:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103327:	8b 03                	mov    (%ebx),%eax
80103329:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010332d:	8b 03                	mov    (%ebx),%eax
8010332f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103332:	8b 06                	mov    (%esi),%eax
80103334:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010333a:	8b 06                	mov    (%esi),%eax
8010333c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103340:	8b 06                	mov    (%esi),%eax
80103342:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103346:	8b 06                	mov    (%esi),%eax
80103348:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010334b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010334e:	31 c0                	xor    %eax,%eax
}
80103350:	5b                   	pop    %ebx
80103351:	5e                   	pop    %esi
80103352:	5f                   	pop    %edi
80103353:	5d                   	pop    %ebp
80103354:	c3                   	ret    
80103355:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103360 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103360:	55                   	push   %ebp
80103361:	89 e5                	mov    %esp,%ebp
80103363:	56                   	push   %esi
80103364:	53                   	push   %ebx
80103365:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103368:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010336b:	83 ec 0c             	sub    $0xc,%esp
8010336e:	53                   	push   %ebx
8010336f:	e8 5c 11 00 00       	call   801044d0 <acquire>
  if(writable){
80103374:	83 c4 10             	add    $0x10,%esp
80103377:	85 f6                	test   %esi,%esi
80103379:	74 45                	je     801033c0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010337b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103381:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103384:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010338b:	00 00 00 
    wakeup(&p->nread);
8010338e:	50                   	push   %eax
8010338f:	e8 4c 0b 00 00       	call   80103ee0 <wakeup>
80103394:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103397:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010339d:	85 d2                	test   %edx,%edx
8010339f:	75 0a                	jne    801033ab <pipeclose+0x4b>
801033a1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801033a7:	85 c0                	test   %eax,%eax
801033a9:	74 35                	je     801033e0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801033ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801033ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033b1:	5b                   	pop    %ebx
801033b2:	5e                   	pop    %esi
801033b3:	5d                   	pop    %ebp
    release(&p->lock);
801033b4:	e9 d7 11 00 00       	jmp    80104590 <release>
801033b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801033c0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801033c6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
801033c9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801033d0:	00 00 00 
    wakeup(&p->nwrite);
801033d3:	50                   	push   %eax
801033d4:	e8 07 0b 00 00       	call   80103ee0 <wakeup>
801033d9:	83 c4 10             	add    $0x10,%esp
801033dc:	eb b9                	jmp    80103397 <pipeclose+0x37>
801033de:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801033e0:	83 ec 0c             	sub    $0xc,%esp
801033e3:	53                   	push   %ebx
801033e4:	e8 a7 11 00 00       	call   80104590 <release>
    kfree((char*)p);
801033e9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801033ec:	83 c4 10             	add    $0x10,%esp
}
801033ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033f2:	5b                   	pop    %ebx
801033f3:	5e                   	pop    %esi
801033f4:	5d                   	pop    %ebp
    kfree((char*)p);
801033f5:	e9 36 ef ff ff       	jmp    80102330 <kfree>
801033fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103400 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103400:	55                   	push   %ebp
80103401:	89 e5                	mov    %esp,%ebp
80103403:	57                   	push   %edi
80103404:	56                   	push   %esi
80103405:	53                   	push   %ebx
80103406:	83 ec 28             	sub    $0x28,%esp
80103409:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010340c:	53                   	push   %ebx
8010340d:	e8 be 10 00 00       	call   801044d0 <acquire>
  for(i = 0; i < n; i++){
80103412:	8b 45 10             	mov    0x10(%ebp),%eax
80103415:	83 c4 10             	add    $0x10,%esp
80103418:	85 c0                	test   %eax,%eax
8010341a:	0f 8e c9 00 00 00    	jle    801034e9 <pipewrite+0xe9>
80103420:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103423:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103429:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010342f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103432:	03 4d 10             	add    0x10(%ebp),%ecx
80103435:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103438:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010343e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103444:	39 d0                	cmp    %edx,%eax
80103446:	75 71                	jne    801034b9 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103448:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010344e:	85 c0                	test   %eax,%eax
80103450:	74 4e                	je     801034a0 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103452:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103458:	eb 3a                	jmp    80103494 <pipewrite+0x94>
8010345a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103460:	83 ec 0c             	sub    $0xc,%esp
80103463:	57                   	push   %edi
80103464:	e8 77 0a 00 00       	call   80103ee0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103469:	5a                   	pop    %edx
8010346a:	59                   	pop    %ecx
8010346b:	53                   	push   %ebx
8010346c:	56                   	push   %esi
8010346d:	e8 be 08 00 00       	call   80103d30 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103472:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103478:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010347e:	83 c4 10             	add    $0x10,%esp
80103481:	05 00 02 00 00       	add    $0x200,%eax
80103486:	39 c2                	cmp    %eax,%edx
80103488:	75 36                	jne    801034c0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010348a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103490:	85 c0                	test   %eax,%eax
80103492:	74 0c                	je     801034a0 <pipewrite+0xa0>
80103494:	e8 27 03 00 00       	call   801037c0 <myproc>
80103499:	8b 40 24             	mov    0x24(%eax),%eax
8010349c:	85 c0                	test   %eax,%eax
8010349e:	74 c0                	je     80103460 <pipewrite+0x60>
        release(&p->lock);
801034a0:	83 ec 0c             	sub    $0xc,%esp
801034a3:	53                   	push   %ebx
801034a4:	e8 e7 10 00 00       	call   80104590 <release>
        return -1;
801034a9:	83 c4 10             	add    $0x10,%esp
801034ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801034b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034b4:	5b                   	pop    %ebx
801034b5:	5e                   	pop    %esi
801034b6:	5f                   	pop    %edi
801034b7:	5d                   	pop    %ebp
801034b8:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034b9:	89 c2                	mov    %eax,%edx
801034bb:	90                   	nop
801034bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034c0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801034c3:	8d 42 01             	lea    0x1(%edx),%eax
801034c6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801034cc:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801034d2:	83 c6 01             	add    $0x1,%esi
801034d5:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
801034d9:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801034dc:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034df:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801034e3:	0f 85 4f ff ff ff    	jne    80103438 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801034e9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801034ef:	83 ec 0c             	sub    $0xc,%esp
801034f2:	50                   	push   %eax
801034f3:	e8 e8 09 00 00       	call   80103ee0 <wakeup>
  release(&p->lock);
801034f8:	89 1c 24             	mov    %ebx,(%esp)
801034fb:	e8 90 10 00 00       	call   80104590 <release>
  return n;
80103500:	83 c4 10             	add    $0x10,%esp
80103503:	8b 45 10             	mov    0x10(%ebp),%eax
80103506:	eb a9                	jmp    801034b1 <pipewrite+0xb1>
80103508:	90                   	nop
80103509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103510 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103510:	55                   	push   %ebp
80103511:	89 e5                	mov    %esp,%ebp
80103513:	57                   	push   %edi
80103514:	56                   	push   %esi
80103515:	53                   	push   %ebx
80103516:	83 ec 18             	sub    $0x18,%esp
80103519:	8b 75 08             	mov    0x8(%ebp),%esi
8010351c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010351f:	56                   	push   %esi
80103520:	e8 ab 0f 00 00       	call   801044d0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103525:	83 c4 10             	add    $0x10,%esp
80103528:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010352e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103534:	75 6a                	jne    801035a0 <piperead+0x90>
80103536:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010353c:	85 db                	test   %ebx,%ebx
8010353e:	0f 84 c4 00 00 00    	je     80103608 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103544:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010354a:	eb 2d                	jmp    80103579 <piperead+0x69>
8010354c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103550:	83 ec 08             	sub    $0x8,%esp
80103553:	56                   	push   %esi
80103554:	53                   	push   %ebx
80103555:	e8 d6 07 00 00       	call   80103d30 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010355a:	83 c4 10             	add    $0x10,%esp
8010355d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103563:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103569:	75 35                	jne    801035a0 <piperead+0x90>
8010356b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103571:	85 d2                	test   %edx,%edx
80103573:	0f 84 8f 00 00 00    	je     80103608 <piperead+0xf8>
    if(myproc()->killed){
80103579:	e8 42 02 00 00       	call   801037c0 <myproc>
8010357e:	8b 48 24             	mov    0x24(%eax),%ecx
80103581:	85 c9                	test   %ecx,%ecx
80103583:	74 cb                	je     80103550 <piperead+0x40>
      release(&p->lock);
80103585:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103588:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010358d:	56                   	push   %esi
8010358e:	e8 fd 0f 00 00       	call   80104590 <release>
      return -1;
80103593:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103596:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103599:	89 d8                	mov    %ebx,%eax
8010359b:	5b                   	pop    %ebx
8010359c:	5e                   	pop    %esi
8010359d:	5f                   	pop    %edi
8010359e:	5d                   	pop    %ebp
8010359f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035a0:	8b 45 10             	mov    0x10(%ebp),%eax
801035a3:	85 c0                	test   %eax,%eax
801035a5:	7e 61                	jle    80103608 <piperead+0xf8>
    if(p->nread == p->nwrite)
801035a7:	31 db                	xor    %ebx,%ebx
801035a9:	eb 13                	jmp    801035be <piperead+0xae>
801035ab:	90                   	nop
801035ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035b0:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801035b6:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801035bc:	74 1f                	je     801035dd <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
801035be:	8d 41 01             	lea    0x1(%ecx),%eax
801035c1:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801035c7:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
801035cd:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
801035d2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035d5:	83 c3 01             	add    $0x1,%ebx
801035d8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801035db:	75 d3                	jne    801035b0 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801035dd:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801035e3:	83 ec 0c             	sub    $0xc,%esp
801035e6:	50                   	push   %eax
801035e7:	e8 f4 08 00 00       	call   80103ee0 <wakeup>
  release(&p->lock);
801035ec:	89 34 24             	mov    %esi,(%esp)
801035ef:	e8 9c 0f 00 00       	call   80104590 <release>
  return i;
801035f4:	83 c4 10             	add    $0x10,%esp
}
801035f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035fa:	89 d8                	mov    %ebx,%eax
801035fc:	5b                   	pop    %ebx
801035fd:	5e                   	pop    %esi
801035fe:	5f                   	pop    %edi
801035ff:	5d                   	pop    %ebp
80103600:	c3                   	ret    
80103601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103608:	31 db                	xor    %ebx,%ebx
8010360a:	eb d1                	jmp    801035dd <piperead+0xcd>
8010360c:	66 90                	xchg   %ax,%ax
8010360e:	66 90                	xchg   %ax,%ax

80103610 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103610:	55                   	push   %ebp
80103611:	89 e5                	mov    %esp,%ebp
80103613:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103614:	bb 34 32 11 80       	mov    $0x80113234,%ebx
{
80103619:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010361c:	68 00 32 11 80       	push   $0x80113200
80103621:	e8 aa 0e 00 00       	call   801044d0 <acquire>
80103626:	83 c4 10             	add    $0x10,%esp
80103629:	eb 10                	jmp    8010363b <allocproc+0x2b>
8010362b:	90                   	nop
8010362c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103630:	83 eb 80             	sub    $0xffffff80,%ebx
80103633:	81 fb 34 52 11 80    	cmp    $0x80115234,%ebx
80103639:	73 75                	jae    801036b0 <allocproc+0xa0>
    if(p->state == UNUSED)
8010363b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010363e:	85 c0                	test   %eax,%eax
80103640:	75 ee                	jne    80103630 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103642:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
80103647:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
8010364a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103651:	8d 50 01             	lea    0x1(%eax),%edx
80103654:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103657:	68 00 32 11 80       	push   $0x80113200
  p->pid = nextpid++;
8010365c:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
80103662:	e8 29 0f 00 00       	call   80104590 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103667:	e8 74 ee ff ff       	call   801024e0 <kalloc>
8010366c:	83 c4 10             	add    $0x10,%esp
8010366f:	85 c0                	test   %eax,%eax
80103671:	89 43 08             	mov    %eax,0x8(%ebx)
80103674:	74 53                	je     801036c9 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103676:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010367c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010367f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103684:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103687:	c7 40 14 1e 58 10 80 	movl   $0x8010581e,0x14(%eax)
  p->context = (struct context*)sp;
8010368e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103691:	6a 14                	push   $0x14
80103693:	6a 00                	push   $0x0
80103695:	50                   	push   %eax
80103696:	e8 45 0f 00 00       	call   801045e0 <memset>
  p->context->eip = (uint)forkret;
8010369b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010369e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
801036a1:	c7 40 10 e0 36 10 80 	movl   $0x801036e0,0x10(%eax)
}
801036a8:	89 d8                	mov    %ebx,%eax
801036aa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801036ad:	c9                   	leave  
801036ae:	c3                   	ret    
801036af:	90                   	nop
  release(&ptable.lock);
801036b0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801036b3:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801036b5:	68 00 32 11 80       	push   $0x80113200
801036ba:	e8 d1 0e 00 00       	call   80104590 <release>
}
801036bf:	89 d8                	mov    %ebx,%eax
  return 0;
801036c1:	83 c4 10             	add    $0x10,%esp
}
801036c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801036c7:	c9                   	leave  
801036c8:	c3                   	ret    
    p->state = UNUSED;
801036c9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801036d0:	31 db                	xor    %ebx,%ebx
801036d2:	eb d4                	jmp    801036a8 <allocproc+0x98>
801036d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801036da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801036e0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801036e0:	55                   	push   %ebp
801036e1:	89 e5                	mov    %esp,%ebp
801036e3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801036e6:	68 00 32 11 80       	push   $0x80113200
801036eb:	e8 a0 0e 00 00       	call   80104590 <release>

  if (first) {
801036f0:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801036f5:	83 c4 10             	add    $0x10,%esp
801036f8:	85 c0                	test   %eax,%eax
801036fa:	75 04                	jne    80103700 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801036fc:	c9                   	leave  
801036fd:	c3                   	ret    
801036fe:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103700:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103703:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
8010370a:	00 00 00 
    iinit(ROOTDEV);
8010370d:	6a 01                	push   $0x1
8010370f:	e8 8c dd ff ff       	call   801014a0 <iinit>
    initlog(ROOTDEV);
80103714:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010371b:	e8 00 f4 ff ff       	call   80102b20 <initlog>
80103720:	83 c4 10             	add    $0x10,%esp
}
80103723:	c9                   	leave  
80103724:	c3                   	ret    
80103725:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103730 <pinit>:
{
80103730:	55                   	push   %ebp
80103731:	89 e5                	mov    %esp,%ebp
80103733:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103736:	68 b5 77 10 80       	push   $0x801077b5
8010373b:	68 00 32 11 80       	push   $0x80113200
80103740:	e8 4b 0c 00 00       	call   80104390 <initlock>
}
80103745:	83 c4 10             	add    $0x10,%esp
80103748:	c9                   	leave  
80103749:	c3                   	ret    
8010374a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103750 <mycpu>:
{
80103750:	55                   	push   %ebp
80103751:	89 e5                	mov    %esp,%ebp
80103753:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103756:	9c                   	pushf  
80103757:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103758:	f6 c4 02             	test   $0x2,%ah
8010375b:	75 32                	jne    8010378f <mycpu+0x3f>
  apicid = lapicid();
8010375d:	e8 ee ef ff ff       	call   80102750 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103762:	8b 15 f0 31 11 80    	mov    0x801131f0,%edx
80103768:	85 d2                	test   %edx,%edx
8010376a:	7e 0b                	jle    80103777 <mycpu+0x27>
    if (cpus[i].apicid == apicid)
8010376c:	0f b6 15 40 31 11 80 	movzbl 0x80113140,%edx
80103773:	39 d0                	cmp    %edx,%eax
80103775:	74 11                	je     80103788 <mycpu+0x38>
  panic("unknown apicid\n");
80103777:	83 ec 0c             	sub    $0xc,%esp
8010377a:	68 bc 77 10 80       	push   $0x801077bc
8010377f:	e8 0c cc ff ff       	call   80100390 <panic>
80103784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80103788:	b8 40 31 11 80       	mov    $0x80113140,%eax
8010378d:	c9                   	leave  
8010378e:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
8010378f:	83 ec 0c             	sub    $0xc,%esp
80103792:	68 90 78 10 80       	push   $0x80107890
80103797:	e8 f4 cb ff ff       	call   80100390 <panic>
8010379c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801037a0 <cpuid>:
cpuid() {
801037a0:	55                   	push   %ebp
801037a1:	89 e5                	mov    %esp,%ebp
801037a3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801037a6:	e8 a5 ff ff ff       	call   80103750 <mycpu>
801037ab:	2d 40 31 11 80       	sub    $0x80113140,%eax
}
801037b0:	c9                   	leave  
  return mycpu()-cpus;
801037b1:	c1 f8 04             	sar    $0x4,%eax
801037b4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801037ba:	c3                   	ret    
801037bb:	90                   	nop
801037bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801037c0 <myproc>:
myproc(void) {
801037c0:	55                   	push   %ebp
801037c1:	89 e5                	mov    %esp,%ebp
801037c3:	53                   	push   %ebx
801037c4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801037c7:	e8 34 0c 00 00       	call   80104400 <pushcli>
  c = mycpu();
801037cc:	e8 7f ff ff ff       	call   80103750 <mycpu>
  p = c->proc;
801037d1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801037d7:	e8 64 0c 00 00       	call   80104440 <popcli>
}
801037dc:	83 c4 04             	add    $0x4,%esp
801037df:	89 d8                	mov    %ebx,%eax
801037e1:	5b                   	pop    %ebx
801037e2:	5d                   	pop    %ebp
801037e3:	c3                   	ret    
801037e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801037ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801037f0 <userinit>:
{
801037f0:	55                   	push   %ebp
801037f1:	89 e5                	mov    %esp,%ebp
801037f3:	53                   	push   %ebx
801037f4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
801037f7:	e8 14 fe ff ff       	call   80103610 <allocproc>
801037fc:	89 c3                	mov    %eax,%ebx
  initproc = p;
801037fe:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
80103803:	e8 e8 35 00 00       	call   80106df0 <setupkvm>
80103808:	85 c0                	test   %eax,%eax
8010380a:	89 43 04             	mov    %eax,0x4(%ebx)
8010380d:	0f 84 bd 00 00 00    	je     801038d0 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103813:	83 ec 04             	sub    $0x4,%esp
80103816:	68 2c 00 00 00       	push   $0x2c
8010381b:	68 64 a4 10 80       	push   $0x8010a464
80103820:	50                   	push   %eax
80103821:	e8 aa 32 00 00       	call   80106ad0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103826:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103829:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010382f:	6a 4c                	push   $0x4c
80103831:	6a 00                	push   $0x0
80103833:	ff 73 18             	pushl  0x18(%ebx)
80103836:	e8 a5 0d 00 00       	call   801045e0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010383b:	8b 43 18             	mov    0x18(%ebx),%eax
8010383e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103843:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103848:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010384b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010384f:	8b 43 18             	mov    0x18(%ebx),%eax
80103852:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103856:	8b 43 18             	mov    0x18(%ebx),%eax
80103859:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010385d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103861:	8b 43 18             	mov    0x18(%ebx),%eax
80103864:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103868:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010386c:	8b 43 18             	mov    0x18(%ebx),%eax
8010386f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103876:	8b 43 18             	mov    0x18(%ebx),%eax
80103879:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103880:	8b 43 18             	mov    0x18(%ebx),%eax
80103883:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010388a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010388d:	6a 10                	push   $0x10
8010388f:	68 e5 77 10 80       	push   $0x801077e5
80103894:	50                   	push   %eax
80103895:	e8 26 0f 00 00       	call   801047c0 <safestrcpy>
  p->cwd = namei("/");
8010389a:	c7 04 24 ee 77 10 80 	movl   $0x801077ee,(%esp)
801038a1:	e8 5a e6 ff ff       	call   80101f00 <namei>
801038a6:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
801038a9:	c7 04 24 00 32 11 80 	movl   $0x80113200,(%esp)
801038b0:	e8 1b 0c 00 00       	call   801044d0 <acquire>
  p->state = RUNNABLE;
801038b5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
801038bc:	c7 04 24 00 32 11 80 	movl   $0x80113200,(%esp)
801038c3:	e8 c8 0c 00 00       	call   80104590 <release>
}
801038c8:	83 c4 10             	add    $0x10,%esp
801038cb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038ce:	c9                   	leave  
801038cf:	c3                   	ret    
    panic("userinit: out of memory?");
801038d0:	83 ec 0c             	sub    $0xc,%esp
801038d3:	68 cc 77 10 80       	push   $0x801077cc
801038d8:	e8 b3 ca ff ff       	call   80100390 <panic>
801038dd:	8d 76 00             	lea    0x0(%esi),%esi

801038e0 <growproc>:
{
801038e0:	55                   	push   %ebp
801038e1:	89 e5                	mov    %esp,%ebp
801038e3:	56                   	push   %esi
801038e4:	53                   	push   %ebx
801038e5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801038e8:	e8 13 0b 00 00       	call   80104400 <pushcli>
  c = mycpu();
801038ed:	e8 5e fe ff ff       	call   80103750 <mycpu>
  p = c->proc;
801038f2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801038f8:	e8 43 0b 00 00       	call   80104440 <popcli>
  if(n > 0){
801038fd:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103900:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103902:	7f 1c                	jg     80103920 <growproc+0x40>
  } else if(n < 0){
80103904:	75 3a                	jne    80103940 <growproc+0x60>
  switchuvm(curproc);
80103906:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103909:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
8010390b:	53                   	push   %ebx
8010390c:	e8 af 30 00 00       	call   801069c0 <switchuvm>
  return 0;
80103911:	83 c4 10             	add    $0x10,%esp
80103914:	31 c0                	xor    %eax,%eax
}
80103916:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103919:	5b                   	pop    %ebx
8010391a:	5e                   	pop    %esi
8010391b:	5d                   	pop    %ebp
8010391c:	c3                   	ret    
8010391d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103920:	83 ec 04             	sub    $0x4,%esp
80103923:	01 c6                	add    %eax,%esi
80103925:	56                   	push   %esi
80103926:	50                   	push   %eax
80103927:	ff 73 04             	pushl  0x4(%ebx)
8010392a:	e8 e1 32 00 00       	call   80106c10 <allocuvm>
8010392f:	83 c4 10             	add    $0x10,%esp
80103932:	85 c0                	test   %eax,%eax
80103934:	75 d0                	jne    80103906 <growproc+0x26>
      return -1;
80103936:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010393b:	eb d9                	jmp    80103916 <growproc+0x36>
8010393d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103940:	83 ec 04             	sub    $0x4,%esp
80103943:	01 c6                	add    %eax,%esi
80103945:	56                   	push   %esi
80103946:	50                   	push   %eax
80103947:	ff 73 04             	pushl  0x4(%ebx)
8010394a:	e8 f1 33 00 00       	call   80106d40 <deallocuvm>
8010394f:	83 c4 10             	add    $0x10,%esp
80103952:	85 c0                	test   %eax,%eax
80103954:	75 b0                	jne    80103906 <growproc+0x26>
80103956:	eb de                	jmp    80103936 <growproc+0x56>
80103958:	90                   	nop
80103959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103960 <fork>:
{
80103960:	55                   	push   %ebp
80103961:	89 e5                	mov    %esp,%ebp
80103963:	57                   	push   %edi
80103964:	56                   	push   %esi
80103965:	53                   	push   %ebx
80103966:	83 ec 1c             	sub    $0x1c,%esp
80103969:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
8010396c:	e8 8f 0a 00 00       	call   80104400 <pushcli>
  c = mycpu();
80103971:	e8 da fd ff ff       	call   80103750 <mycpu>
  p = c->proc;
80103976:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010397c:	e8 bf 0a 00 00       	call   80104440 <popcli>
    if((np = allocproc()) == 0){
80103981:	e8 8a fc ff ff       	call   80103610 <allocproc>
80103986:	85 c0                	test   %eax,%eax
80103988:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010398b:	0f 84 e3 00 00 00    	je     80103a74 <fork+0x114>
    if (tickets == 0) {
80103991:	85 f6                	test   %esi,%esi
80103993:	0f 84 cf 00 00 00    	je     80103a68 <fork+0x108>
        np->tickets = MAXTICKETS;
80103999:	b8 00 19 00 00       	mov    $0x1900,%eax
8010399e:	81 fe 01 19 00 00    	cmp    $0x1901,%esi
801039a4:	0f 4d f0             	cmovge %eax,%esi
801039a7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801039aa:	89 70 7c             	mov    %esi,0x7c(%eax)
    if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
801039ad:	83 ec 08             	sub    $0x8,%esp
801039b0:	ff 33                	pushl  (%ebx)
801039b2:	ff 73 04             	pushl  0x4(%ebx)
801039b5:	e8 06 35 00 00       	call   80106ec0 <copyuvm>
801039ba:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801039bd:	83 c4 10             	add    $0x10,%esp
801039c0:	85 c0                	test   %eax,%eax
801039c2:	89 41 04             	mov    %eax,0x4(%ecx)
801039c5:	0f 84 b0 00 00 00    	je     80103a7b <fork+0x11b>
  np->sz = curproc->sz;
801039cb:	8b 03                	mov    (%ebx),%eax
801039cd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801039d0:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
801039d2:	89 59 14             	mov    %ebx,0x14(%ecx)
801039d5:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
801039d7:	8b 79 18             	mov    0x18(%ecx),%edi
801039da:	8b 73 18             	mov    0x18(%ebx),%esi
801039dd:	b9 13 00 00 00       	mov    $0x13,%ecx
801039e2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
801039e4:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
801039e6:	8b 40 18             	mov    0x18(%eax),%eax
801039e9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
801039f0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
801039f4:	85 c0                	test   %eax,%eax
801039f6:	74 13                	je     80103a0b <fork+0xab>
      np->ofile[i] = filedup(curproc->ofile[i]);
801039f8:	83 ec 0c             	sub    $0xc,%esp
801039fb:	50                   	push   %eax
801039fc:	e8 ff d3 ff ff       	call   80100e00 <filedup>
80103a01:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103a04:	83 c4 10             	add    $0x10,%esp
80103a07:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103a0b:	83 c6 01             	add    $0x1,%esi
80103a0e:	83 fe 10             	cmp    $0x10,%esi
80103a11:	75 dd                	jne    801039f0 <fork+0x90>
  np->cwd = idup(curproc->cwd);
80103a13:	83 ec 0c             	sub    $0xc,%esp
80103a16:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a19:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103a1c:	e8 4f dc ff ff       	call   80101670 <idup>
80103a21:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a24:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103a27:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a2a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103a2d:	6a 10                	push   $0x10
80103a2f:	53                   	push   %ebx
80103a30:	50                   	push   %eax
80103a31:	e8 8a 0d 00 00       	call   801047c0 <safestrcpy>
  pid = np->pid;
80103a36:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103a39:	c7 04 24 00 32 11 80 	movl   $0x80113200,(%esp)
80103a40:	e8 8b 0a 00 00       	call   801044d0 <acquire>
  np->state = RUNNABLE;
80103a45:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103a4c:	c7 04 24 00 32 11 80 	movl   $0x80113200,(%esp)
80103a53:	e8 38 0b 00 00       	call   80104590 <release>
  return pid;
80103a58:	83 c4 10             	add    $0x10,%esp
}
80103a5b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a5e:	89 d8                	mov    %ebx,%eax
80103a60:	5b                   	pop    %ebx
80103a61:	5e                   	pop    %esi
80103a62:	5f                   	pop    %edi
80103a63:	5d                   	pop    %ebp
80103a64:	c3                   	ret    
80103a65:	8d 76 00             	lea    0x0(%esi),%esi
        np->tickets = NTICKETS;
80103a68:	c7 40 7c 40 00 00 00 	movl   $0x40,0x7c(%eax)
80103a6f:	e9 39 ff ff ff       	jmp    801039ad <fork+0x4d>
        return -1;
80103a74:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103a79:	eb e0                	jmp    80103a5b <fork+0xfb>
      kfree(np->kstack);
80103a7b:	83 ec 0c             	sub    $0xc,%esp
80103a7e:	ff 71 08             	pushl  0x8(%ecx)
80103a81:	89 cf                	mov    %ecx,%edi
      return -1;
80103a83:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      kfree(np->kstack);
80103a88:	e8 a3 e8 ff ff       	call   80102330 <kfree>
      np->kstack = 0;
80103a8d:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
      np->state = UNUSED;
80103a94:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
      return -1;
80103a9b:	83 c4 10             	add    $0x10,%esp
80103a9e:	eb bb                	jmp    80103a5b <fork+0xfb>

80103aa0 <tickets_total>:
int tickets_total(void){
80103aa0:	55                   	push   %ebp
  int total = 0;
80103aa1:	31 c0                	xor    %eax,%eax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103aa3:	ba 34 32 11 80       	mov    $0x80113234,%edx
int tickets_total(void){
80103aa8:	89 e5                	mov    %esp,%ebp
80103aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p->state==RUNNABLE){
80103ab0:	83 7a 0c 03          	cmpl   $0x3,0xc(%edx)
80103ab4:	75 03                	jne    80103ab9 <tickets_total+0x19>
      total += p->tickets;
80103ab6:	03 42 7c             	add    0x7c(%edx),%eax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103ab9:	83 ea 80             	sub    $0xffffff80,%edx
80103abc:	81 fa 34 52 11 80    	cmp    $0x80115234,%edx
80103ac2:	72 ec                	jb     80103ab0 <tickets_total+0x10>
}
80103ac4:	5d                   	pop    %ebp
80103ac5:	c3                   	ret    
80103ac6:	8d 76 00             	lea    0x0(%esi),%esi
80103ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ad0 <total_occurrences>:
int total_occurrences(int *occurrences){
80103ad0:	55                   	push   %ebp
    int total = 0;
80103ad1:	31 c0                	xor    %eax,%eax
int total_occurrences(int *occurrences){
80103ad3:	89 e5                	mov    %esp,%ebp
80103ad5:	8b 55 08             	mov    0x8(%ebp),%edx
80103ad8:	8d 8a 00 01 00 00    	lea    0x100(%edx),%ecx
80103ade:	66 90                	xchg   %ax,%ax
        total += occurrences[i];
80103ae0:	03 02                	add    (%edx),%eax
80103ae2:	83 c2 04             	add    $0x4,%edx
    for (int i = 0; i < NPROC; i++) {
80103ae5:	39 ca                	cmp    %ecx,%edx
80103ae7:	75 f7                	jne    80103ae0 <total_occurrences+0x10>
}
80103ae9:	5d                   	pop    %ebp
80103aea:	c3                   	ret    
80103aeb:	90                   	nop
80103aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103af0 <sched>:
{
80103af0:	55                   	push   %ebp
80103af1:	89 e5                	mov    %esp,%ebp
80103af3:	56                   	push   %esi
80103af4:	53                   	push   %ebx
  pushcli();
80103af5:	e8 06 09 00 00       	call   80104400 <pushcli>
  c = mycpu();
80103afa:	e8 51 fc ff ff       	call   80103750 <mycpu>
  p = c->proc;
80103aff:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b05:	e8 36 09 00 00       	call   80104440 <popcli>
  if(!holding(&ptable.lock))
80103b0a:	83 ec 0c             	sub    $0xc,%esp
80103b0d:	68 00 32 11 80       	push   $0x80113200
80103b12:	e8 89 09 00 00       	call   801044a0 <holding>
80103b17:	83 c4 10             	add    $0x10,%esp
80103b1a:	85 c0                	test   %eax,%eax
80103b1c:	74 4f                	je     80103b6d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103b1e:	e8 2d fc ff ff       	call   80103750 <mycpu>
80103b23:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103b2a:	75 68                	jne    80103b94 <sched+0xa4>
  if(p->state == RUNNING)
80103b2c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103b30:	74 55                	je     80103b87 <sched+0x97>
80103b32:	9c                   	pushf  
80103b33:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103b34:	f6 c4 02             	test   $0x2,%ah
80103b37:	75 41                	jne    80103b7a <sched+0x8a>
  intena = mycpu()->intena;
80103b39:	e8 12 fc ff ff       	call   80103750 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103b3e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103b41:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103b47:	e8 04 fc ff ff       	call   80103750 <mycpu>
80103b4c:	83 ec 08             	sub    $0x8,%esp
80103b4f:	ff 70 04             	pushl  0x4(%eax)
80103b52:	53                   	push   %ebx
80103b53:	e8 c3 0c 00 00       	call   8010481b <swtch>
  mycpu()->intena = intena;
80103b58:	e8 f3 fb ff ff       	call   80103750 <mycpu>
}
80103b5d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103b60:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103b66:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b69:	5b                   	pop    %ebx
80103b6a:	5e                   	pop    %esi
80103b6b:	5d                   	pop    %ebp
80103b6c:	c3                   	ret    
    panic("sched ptable.lock");
80103b6d:	83 ec 0c             	sub    $0xc,%esp
80103b70:	68 f0 77 10 80       	push   $0x801077f0
80103b75:	e8 16 c8 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103b7a:	83 ec 0c             	sub    $0xc,%esp
80103b7d:	68 1c 78 10 80       	push   $0x8010781c
80103b82:	e8 09 c8 ff ff       	call   80100390 <panic>
    panic("sched running");
80103b87:	83 ec 0c             	sub    $0xc,%esp
80103b8a:	68 0e 78 10 80       	push   $0x8010780e
80103b8f:	e8 fc c7 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103b94:	83 ec 0c             	sub    $0xc,%esp
80103b97:	68 02 78 10 80       	push   $0x80107802
80103b9c:	e8 ef c7 ff ff       	call   80100390 <panic>
80103ba1:	eb 0d                	jmp    80103bb0 <exit>
80103ba3:	90                   	nop
80103ba4:	90                   	nop
80103ba5:	90                   	nop
80103ba6:	90                   	nop
80103ba7:	90                   	nop
80103ba8:	90                   	nop
80103ba9:	90                   	nop
80103baa:	90                   	nop
80103bab:	90                   	nop
80103bac:	90                   	nop
80103bad:	90                   	nop
80103bae:	90                   	nop
80103baf:	90                   	nop

80103bb0 <exit>:
{
80103bb0:	55                   	push   %ebp
80103bb1:	89 e5                	mov    %esp,%ebp
80103bb3:	57                   	push   %edi
80103bb4:	56                   	push   %esi
80103bb5:	53                   	push   %ebx
80103bb6:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103bb9:	e8 42 08 00 00       	call   80104400 <pushcli>
  c = mycpu();
80103bbe:	e8 8d fb ff ff       	call   80103750 <mycpu>
  p = c->proc;
80103bc3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103bc9:	e8 72 08 00 00       	call   80104440 <popcli>
  if(curproc == initproc)
80103bce:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103bd4:	8d 5e 28             	lea    0x28(%esi),%ebx
80103bd7:	8d 7e 68             	lea    0x68(%esi),%edi
80103bda:	0f 84 e7 00 00 00    	je     80103cc7 <exit+0x117>
    if(curproc->ofile[fd]){
80103be0:	8b 03                	mov    (%ebx),%eax
80103be2:	85 c0                	test   %eax,%eax
80103be4:	74 12                	je     80103bf8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103be6:	83 ec 0c             	sub    $0xc,%esp
80103be9:	50                   	push   %eax
80103bea:	e8 61 d2 ff ff       	call   80100e50 <fileclose>
      curproc->ofile[fd] = 0;
80103bef:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103bf5:	83 c4 10             	add    $0x10,%esp
80103bf8:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103bfb:	39 fb                	cmp    %edi,%ebx
80103bfd:	75 e1                	jne    80103be0 <exit+0x30>
  begin_op();
80103bff:	e8 bc ef ff ff       	call   80102bc0 <begin_op>
  iput(curproc->cwd);
80103c04:	83 ec 0c             	sub    $0xc,%esp
80103c07:	ff 76 68             	pushl  0x68(%esi)
80103c0a:	e8 c1 db ff ff       	call   801017d0 <iput>
  end_op();
80103c0f:	e8 1c f0 ff ff       	call   80102c30 <end_op>
  curproc->cwd = 0;
80103c14:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80103c1b:	c7 04 24 00 32 11 80 	movl   $0x80113200,(%esp)
80103c22:	e8 a9 08 00 00       	call   801044d0 <acquire>
  wakeup1(curproc->parent);
80103c27:	8b 56 14             	mov    0x14(%esi),%edx
80103c2a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c2d:	b8 34 32 11 80       	mov    $0x80113234,%eax
80103c32:	eb 0e                	jmp    80103c42 <exit+0x92>
80103c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c38:	83 e8 80             	sub    $0xffffff80,%eax
80103c3b:	3d 34 52 11 80       	cmp    $0x80115234,%eax
80103c40:	73 1c                	jae    80103c5e <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103c42:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103c46:	75 f0                	jne    80103c38 <exit+0x88>
80103c48:	3b 50 20             	cmp    0x20(%eax),%edx
80103c4b:	75 eb                	jne    80103c38 <exit+0x88>
      p->state = RUNNABLE;
80103c4d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c54:	83 e8 80             	sub    $0xffffff80,%eax
80103c57:	3d 34 52 11 80       	cmp    $0x80115234,%eax
80103c5c:	72 e4                	jb     80103c42 <exit+0x92>
      p->parent = initproc;
80103c5e:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c64:	ba 34 32 11 80       	mov    $0x80113234,%edx
80103c69:	eb 10                	jmp    80103c7b <exit+0xcb>
80103c6b:	90                   	nop
80103c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c70:	83 ea 80             	sub    $0xffffff80,%edx
80103c73:	81 fa 34 52 11 80    	cmp    $0x80115234,%edx
80103c79:	73 33                	jae    80103cae <exit+0xfe>
    if(p->parent == curproc){
80103c7b:	39 72 14             	cmp    %esi,0x14(%edx)
80103c7e:	75 f0                	jne    80103c70 <exit+0xc0>
      if(p->state == ZOMBIE)
80103c80:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103c84:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103c87:	75 e7                	jne    80103c70 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c89:	b8 34 32 11 80       	mov    $0x80113234,%eax
80103c8e:	eb 0a                	jmp    80103c9a <exit+0xea>
80103c90:	83 e8 80             	sub    $0xffffff80,%eax
80103c93:	3d 34 52 11 80       	cmp    $0x80115234,%eax
80103c98:	73 d6                	jae    80103c70 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103c9a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103c9e:	75 f0                	jne    80103c90 <exit+0xe0>
80103ca0:	3b 48 20             	cmp    0x20(%eax),%ecx
80103ca3:	75 eb                	jne    80103c90 <exit+0xe0>
      p->state = RUNNABLE;
80103ca5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103cac:	eb e2                	jmp    80103c90 <exit+0xe0>
  curproc->state = ZOMBIE;
80103cae:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103cb5:	e8 36 fe ff ff       	call   80103af0 <sched>
  panic("zombie exit");
80103cba:	83 ec 0c             	sub    $0xc,%esp
80103cbd:	68 3d 78 10 80       	push   $0x8010783d
80103cc2:	e8 c9 c6 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103cc7:	83 ec 0c             	sub    $0xc,%esp
80103cca:	68 30 78 10 80       	push   $0x80107830
80103ccf:	e8 bc c6 ff ff       	call   80100390 <panic>
80103cd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103cda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103ce0 <yield>:
{
80103ce0:	55                   	push   %ebp
80103ce1:	89 e5                	mov    %esp,%ebp
80103ce3:	53                   	push   %ebx
80103ce4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103ce7:	68 00 32 11 80       	push   $0x80113200
80103cec:	e8 df 07 00 00       	call   801044d0 <acquire>
  pushcli();
80103cf1:	e8 0a 07 00 00       	call   80104400 <pushcli>
  c = mycpu();
80103cf6:	e8 55 fa ff ff       	call   80103750 <mycpu>
  p = c->proc;
80103cfb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d01:	e8 3a 07 00 00       	call   80104440 <popcli>
  myproc()->state = RUNNABLE;
80103d06:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103d0d:	e8 de fd ff ff       	call   80103af0 <sched>
  release(&ptable.lock);
80103d12:	c7 04 24 00 32 11 80 	movl   $0x80113200,(%esp)
80103d19:	e8 72 08 00 00       	call   80104590 <release>
}
80103d1e:	83 c4 10             	add    $0x10,%esp
80103d21:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d24:	c9                   	leave  
80103d25:	c3                   	ret    
80103d26:	8d 76 00             	lea    0x0(%esi),%esi
80103d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d30 <sleep>:
{
80103d30:	55                   	push   %ebp
80103d31:	89 e5                	mov    %esp,%ebp
80103d33:	57                   	push   %edi
80103d34:	56                   	push   %esi
80103d35:	53                   	push   %ebx
80103d36:	83 ec 0c             	sub    $0xc,%esp
80103d39:	8b 7d 08             	mov    0x8(%ebp),%edi
80103d3c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103d3f:	e8 bc 06 00 00       	call   80104400 <pushcli>
  c = mycpu();
80103d44:	e8 07 fa ff ff       	call   80103750 <mycpu>
  p = c->proc;
80103d49:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d4f:	e8 ec 06 00 00       	call   80104440 <popcli>
  if(p == 0)
80103d54:	85 db                	test   %ebx,%ebx
80103d56:	0f 84 87 00 00 00    	je     80103de3 <sleep+0xb3>
  if(lk == 0)
80103d5c:	85 f6                	test   %esi,%esi
80103d5e:	74 76                	je     80103dd6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103d60:	81 fe 00 32 11 80    	cmp    $0x80113200,%esi
80103d66:	74 50                	je     80103db8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103d68:	83 ec 0c             	sub    $0xc,%esp
80103d6b:	68 00 32 11 80       	push   $0x80113200
80103d70:	e8 5b 07 00 00       	call   801044d0 <acquire>
    release(lk);
80103d75:	89 34 24             	mov    %esi,(%esp)
80103d78:	e8 13 08 00 00       	call   80104590 <release>
  p->chan = chan;
80103d7d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103d80:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103d87:	e8 64 fd ff ff       	call   80103af0 <sched>
  p->chan = 0;
80103d8c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103d93:	c7 04 24 00 32 11 80 	movl   $0x80113200,(%esp)
80103d9a:	e8 f1 07 00 00       	call   80104590 <release>
    acquire(lk);
80103d9f:	89 75 08             	mov    %esi,0x8(%ebp)
80103da2:	83 c4 10             	add    $0x10,%esp
}
80103da5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103da8:	5b                   	pop    %ebx
80103da9:	5e                   	pop    %esi
80103daa:	5f                   	pop    %edi
80103dab:	5d                   	pop    %ebp
    acquire(lk);
80103dac:	e9 1f 07 00 00       	jmp    801044d0 <acquire>
80103db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103db8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103dbb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103dc2:	e8 29 fd ff ff       	call   80103af0 <sched>
  p->chan = 0;
80103dc7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103dce:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103dd1:	5b                   	pop    %ebx
80103dd2:	5e                   	pop    %esi
80103dd3:	5f                   	pop    %edi
80103dd4:	5d                   	pop    %ebp
80103dd5:	c3                   	ret    
    panic("sleep without lk");
80103dd6:	83 ec 0c             	sub    $0xc,%esp
80103dd9:	68 4f 78 10 80       	push   $0x8010784f
80103dde:	e8 ad c5 ff ff       	call   80100390 <panic>
    panic("sleep");
80103de3:	83 ec 0c             	sub    $0xc,%esp
80103de6:	68 49 78 10 80       	push   $0x80107849
80103deb:	e8 a0 c5 ff ff       	call   80100390 <panic>

80103df0 <wait>:
{
80103df0:	55                   	push   %ebp
80103df1:	89 e5                	mov    %esp,%ebp
80103df3:	56                   	push   %esi
80103df4:	53                   	push   %ebx
  pushcli();
80103df5:	e8 06 06 00 00       	call   80104400 <pushcli>
  c = mycpu();
80103dfa:	e8 51 f9 ff ff       	call   80103750 <mycpu>
  p = c->proc;
80103dff:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103e05:	e8 36 06 00 00       	call   80104440 <popcli>
  acquire(&ptable.lock);
80103e0a:	83 ec 0c             	sub    $0xc,%esp
80103e0d:	68 00 32 11 80       	push   $0x80113200
80103e12:	e8 b9 06 00 00       	call   801044d0 <acquire>
80103e17:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103e1a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e1c:	bb 34 32 11 80       	mov    $0x80113234,%ebx
80103e21:	eb 10                	jmp    80103e33 <wait+0x43>
80103e23:	90                   	nop
80103e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e28:	83 eb 80             	sub    $0xffffff80,%ebx
80103e2b:	81 fb 34 52 11 80    	cmp    $0x80115234,%ebx
80103e31:	73 1b                	jae    80103e4e <wait+0x5e>
      if(p->parent != curproc)
80103e33:	39 73 14             	cmp    %esi,0x14(%ebx)
80103e36:	75 f0                	jne    80103e28 <wait+0x38>
      if(p->state == ZOMBIE){
80103e38:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103e3c:	74 32                	je     80103e70 <wait+0x80>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e3e:	83 eb 80             	sub    $0xffffff80,%ebx
      havekids = 1;
80103e41:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e46:	81 fb 34 52 11 80    	cmp    $0x80115234,%ebx
80103e4c:	72 e5                	jb     80103e33 <wait+0x43>
    if(!havekids || curproc->killed){
80103e4e:	85 c0                	test   %eax,%eax
80103e50:	74 74                	je     80103ec6 <wait+0xd6>
80103e52:	8b 46 24             	mov    0x24(%esi),%eax
80103e55:	85 c0                	test   %eax,%eax
80103e57:	75 6d                	jne    80103ec6 <wait+0xd6>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103e59:	83 ec 08             	sub    $0x8,%esp
80103e5c:	68 00 32 11 80       	push   $0x80113200
80103e61:	56                   	push   %esi
80103e62:	e8 c9 fe ff ff       	call   80103d30 <sleep>
    havekids = 0;
80103e67:	83 c4 10             	add    $0x10,%esp
80103e6a:	eb ae                	jmp    80103e1a <wait+0x2a>
80103e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80103e70:	83 ec 0c             	sub    $0xc,%esp
80103e73:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80103e76:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103e79:	e8 b2 e4 ff ff       	call   80102330 <kfree>
        freevm(p->pgdir);
80103e7e:	5a                   	pop    %edx
80103e7f:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80103e82:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103e89:	e8 e2 2e 00 00       	call   80106d70 <freevm>
        release(&ptable.lock);
80103e8e:	c7 04 24 00 32 11 80 	movl   $0x80113200,(%esp)
        p->pid = 0;
80103e95:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103e9c:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103ea3:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103ea7:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103eae:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103eb5:	e8 d6 06 00 00       	call   80104590 <release>
        return pid;
80103eba:	83 c4 10             	add    $0x10,%esp
}
80103ebd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ec0:	89 f0                	mov    %esi,%eax
80103ec2:	5b                   	pop    %ebx
80103ec3:	5e                   	pop    %esi
80103ec4:	5d                   	pop    %ebp
80103ec5:	c3                   	ret    
      release(&ptable.lock);
80103ec6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103ec9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80103ece:	68 00 32 11 80       	push   $0x80113200
80103ed3:	e8 b8 06 00 00       	call   80104590 <release>
      return -1;
80103ed8:	83 c4 10             	add    $0x10,%esp
80103edb:	eb e0                	jmp    80103ebd <wait+0xcd>
80103edd:	8d 76 00             	lea    0x0(%esi),%esi

80103ee0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103ee0:	55                   	push   %ebp
80103ee1:	89 e5                	mov    %esp,%ebp
80103ee3:	53                   	push   %ebx
80103ee4:	83 ec 10             	sub    $0x10,%esp
80103ee7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103eea:	68 00 32 11 80       	push   $0x80113200
80103eef:	e8 dc 05 00 00       	call   801044d0 <acquire>
80103ef4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ef7:	b8 34 32 11 80       	mov    $0x80113234,%eax
80103efc:	eb 0c                	jmp    80103f0a <wakeup+0x2a>
80103efe:	66 90                	xchg   %ax,%ax
80103f00:	83 e8 80             	sub    $0xffffff80,%eax
80103f03:	3d 34 52 11 80       	cmp    $0x80115234,%eax
80103f08:	73 1c                	jae    80103f26 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
80103f0a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f0e:	75 f0                	jne    80103f00 <wakeup+0x20>
80103f10:	3b 58 20             	cmp    0x20(%eax),%ebx
80103f13:	75 eb                	jne    80103f00 <wakeup+0x20>
      p->state = RUNNABLE;
80103f15:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f1c:	83 e8 80             	sub    $0xffffff80,%eax
80103f1f:	3d 34 52 11 80       	cmp    $0x80115234,%eax
80103f24:	72 e4                	jb     80103f0a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80103f26:	c7 45 08 00 32 11 80 	movl   $0x80113200,0x8(%ebp)
}
80103f2d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f30:	c9                   	leave  
  release(&ptable.lock);
80103f31:	e9 5a 06 00 00       	jmp    80104590 <release>
80103f36:	8d 76 00             	lea    0x0(%esi),%esi
80103f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f40 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	53                   	push   %ebx
80103f44:	83 ec 10             	sub    $0x10,%esp
80103f47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80103f4a:	68 00 32 11 80       	push   $0x80113200
80103f4f:	e8 7c 05 00 00       	call   801044d0 <acquire>
80103f54:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f57:	b8 34 32 11 80       	mov    $0x80113234,%eax
80103f5c:	eb 0c                	jmp    80103f6a <kill+0x2a>
80103f5e:	66 90                	xchg   %ax,%ax
80103f60:	83 e8 80             	sub    $0xffffff80,%eax
80103f63:	3d 34 52 11 80       	cmp    $0x80115234,%eax
80103f68:	73 36                	jae    80103fa0 <kill+0x60>
    if(p->pid == pid){
80103f6a:	39 58 10             	cmp    %ebx,0x10(%eax)
80103f6d:	75 f1                	jne    80103f60 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103f6f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80103f73:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
80103f7a:	75 07                	jne    80103f83 <kill+0x43>
        p->state = RUNNABLE;
80103f7c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80103f83:	83 ec 0c             	sub    $0xc,%esp
80103f86:	68 00 32 11 80       	push   $0x80113200
80103f8b:	e8 00 06 00 00       	call   80104590 <release>
      return 0;
80103f90:	83 c4 10             	add    $0x10,%esp
80103f93:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80103f95:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f98:	c9                   	leave  
80103f99:	c3                   	ret    
80103f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80103fa0:	83 ec 0c             	sub    $0xc,%esp
80103fa3:	68 00 32 11 80       	push   $0x80113200
80103fa8:	e8 e3 05 00 00       	call   80104590 <release>
  return -1;
80103fad:	83 c4 10             	add    $0x10,%esp
80103fb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103fb5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fb8:	c9                   	leave  
80103fb9:	c3                   	ret    
80103fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103fc0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(int *occurrences)
{
80103fc0:	55                   	push   %ebp
80103fc1:	89 e5                	mov    %esp,%ebp
80103fc3:	57                   	push   %edi
80103fc4:	56                   	push   %esi
80103fc5:	53                   	push   %ebx
  uint pc[10];



  cprintf("PID\t| NAME\t\t| STATE   \t| QTD_T\t| OC\t| PROC\t| ESTI\t|\n");
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fc6:	be 34 32 11 80       	mov    $0x80113234,%esi
{
80103fcb:	83 ec 68             	sub    $0x68,%esp
  cprintf("PID\t| NAME\t\t| STATE   \t| QTD_T\t| OC\t| PROC\t| ESTI\t|\n");
80103fce:	68 b8 78 10 80       	push   $0x801078b8
80103fd3:	e8 88 c6 ff ff       	call   80100660 <cprintf>
80103fd8:	8b 45 08             	mov    0x8(%ebp),%eax
80103fdb:	83 c4 10             	add    $0x10,%esp
80103fde:	8d b8 00 01 00 00    	lea    0x100(%eax),%edi
80103fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

      if(p->state == UNUSED)
80103fe8:	8b 46 0c             	mov    0xc(%esi),%eax
80103feb:	85 c0                	test   %eax,%eax
80103fed:	0f 84 d3 00 00 00    	je     801040c6 <procdump+0x106>
        continue;

      if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103ff3:	83 f8 05             	cmp    $0x5,%eax
        state = states[p->state];
      else
        state = "???";
80103ff6:	b9 60 78 10 80       	mov    $0x80107860,%ecx
      if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103ffb:	77 11                	ja     8010400e <procdump+0x4e>
80103ffd:	8b 0c 85 1c 79 10 80 	mov    -0x7fef86e4(,%eax,4),%ecx
        state = "???";
80104004:	b8 60 78 10 80       	mov    $0x80107860,%eax
80104009:	85 c9                	test   %ecx,%ecx
8010400b:	0f 44 c8             	cmove  %eax,%ecx

      // ESTATÍSTICAS DOS PROCESSOS
      cprintf("%d\t| %s     \t| %s   \t| %d\t|%d\t| %d%\t| %d%\t|", \
              p->pid, p->name, state, p->tickets, occurrences[p->pid],\
              (int)(((float)occurrences[p->pid]/total_occurrences(occurrences))*100), \
              (int)(((float)p->tickets/tickets_total())*100)); //PORCENTAGEM ESTIMADA
8010400e:	8b 46 7c             	mov    0x7c(%esi),%eax
  int total = 0;
80104011:	31 d2                	xor    %edx,%edx
              (int)(((float)p->tickets/tickets_total())*100)); //PORCENTAGEM ESTIMADA
80104013:	89 45 ac             	mov    %eax,-0x54(%ebp)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104016:	b8 34 32 11 80       	mov    $0x80113234,%eax
              (int)(((float)p->tickets/tickets_total())*100)); //PORCENTAGEM ESTIMADA
8010401b:	db 45 ac             	fildl  -0x54(%ebp)
8010401e:	66 90                	xchg   %ax,%ax
    if(p->state==RUNNABLE){
80104020:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80104024:	75 03                	jne    80104029 <procdump+0x69>
      total += p->tickets;
80104026:	03 50 7c             	add    0x7c(%eax),%edx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104029:	83 e8 80             	sub    $0xffffff80,%eax
8010402c:	3d 34 52 11 80       	cmp    $0x80115234,%eax
80104031:	72 ed                	jb     80104020 <procdump+0x60>
              (int)(((float)p->tickets/tickets_total())*100)); //PORCENTAGEM ESTIMADA
80104033:	89 55 a8             	mov    %edx,-0x58(%ebp)
      cprintf("%d\t| %s     \t| %s   \t| %d\t|%d\t| %d%\t| %d%\t|", \
80104036:	d9 7d b6             	fnstcw -0x4a(%ebp)
80104039:	0f b7 45 b6          	movzwl -0x4a(%ebp),%eax
              (int)(((float)p->tickets/tickets_total())*100)); //PORCENTAGEM ESTIMADA
8010403d:	db 45 a8             	fildl  -0x58(%ebp)
              (int)(((float)occurrences[p->pid]/total_occurrences(occurrences))*100), \
80104040:	8b 5e 10             	mov    0x10(%esi),%ebx
    int total = 0;
80104043:	31 d2                	xor    %edx,%edx
              (int)(((float)p->tickets/tickets_total())*100)); //PORCENTAGEM ESTIMADA
80104045:	de f9                	fdivrp %st,%st(1)
      cprintf("%d\t| %s     \t| %s   \t| %d\t|%d\t| %d%\t| %d%\t|", \
80104047:	80 cc 0c             	or     $0xc,%ah
8010404a:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
              (int)(((float)occurrences[p->pid]/total_occurrences(occurrences))*100), \
8010404e:	8b 45 08             	mov    0x8(%ebp),%eax
80104051:	8b 04 98             	mov    (%eax,%ebx,4),%eax
80104054:	89 45 a8             	mov    %eax,-0x58(%ebp)
80104057:	8b 45 08             	mov    0x8(%ebp),%eax
              (int)(((float)p->tickets/tickets_total())*100)); //PORCENTAGEM ESTIMADA
8010405a:	d8 0d 34 79 10 80    	fmuls  0x80107934
      cprintf("%d\t| %s     \t| %s   \t| %d\t|%d\t| %d%\t| %d%\t|", \
80104060:	d9 6d b4             	fldcw  -0x4c(%ebp)
80104063:	db 5d a4             	fistpl -0x5c(%ebp)
80104066:	d9 6d b6             	fldcw  -0x4a(%ebp)
              (int)(((float)occurrences[p->pid]/total_occurrences(occurrences))*100), \
80104069:	db 45 a8             	fildl  -0x58(%ebp)
8010406c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        total += occurrences[i];
80104070:	03 10                	add    (%eax),%edx
80104072:	83 c0 04             	add    $0x4,%eax
    for (int i = 0; i < NPROC; i++) {
80104075:	39 c7                	cmp    %eax,%edi
80104077:	75 f7                	jne    80104070 <procdump+0xb0>
      cprintf("%d\t| %s     \t| %s   \t| %d\t|%d\t| %d%\t| %d%\t|", \
80104079:	ff 75 a4             	pushl  -0x5c(%ebp)
              (int)(((float)occurrences[p->pid]/total_occurrences(occurrences))*100), \
8010407c:	89 55 a4             	mov    %edx,-0x5c(%ebp)
8010407f:	db 45 a4             	fildl  -0x5c(%ebp)
80104082:	de f9                	fdivrp %st,%st(1)
80104084:	d8 0d 34 79 10 80    	fmuls  0x80107934
      cprintf("%d\t| %s     \t| %s   \t| %d\t|%d\t| %d%\t| %d%\t|", \
8010408a:	d9 6d b4             	fldcw  -0x4c(%ebp)
8010408d:	db 5d b0             	fistpl -0x50(%ebp)
80104090:	d9 6d b6             	fldcw  -0x4a(%ebp)
80104093:	8b 45 b0             	mov    -0x50(%ebp),%eax
80104096:	50                   	push   %eax
80104097:	8d 46 6c             	lea    0x6c(%esi),%eax
8010409a:	ff 75 a8             	pushl  -0x58(%ebp)
8010409d:	ff 75 ac             	pushl  -0x54(%ebp)
801040a0:	51                   	push   %ecx
801040a1:	50                   	push   %eax
801040a2:	53                   	push   %ebx
801040a3:	68 f0 78 10 80       	push   $0x801078f0
801040a8:	e8 b3 c5 ff ff       	call   80100660 <cprintf>
      //----------------------------------------------


    if(p->state == SLEEPING){
801040ad:	83 c4 20             	add    $0x20,%esp
801040b0:	83 7e 0c 02          	cmpl   $0x2,0xc(%esi)
801040b4:	74 27                	je     801040dd <procdump+0x11d>
        for(int i=0; i<10 && pc[i] != 0; i++)
            continue;
//          cprintf(" %p", pc[i]);
    }

    cprintf("\n");
801040b6:	83 ec 0c             	sub    $0xc,%esp
801040b9:	68 3b 7c 10 80       	push   $0x80107c3b
801040be:	e8 9d c5 ff ff       	call   80100660 <cprintf>
801040c3:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040c6:	83 ee 80             	sub    $0xffffff80,%esi
801040c9:	81 fe 34 52 11 80    	cmp    $0x80115234,%esi
801040cf:	0f 82 13 ff ff ff    	jb     80103fe8 <procdump+0x28>
  }
}
801040d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040d8:	5b                   	pop    %ebx
801040d9:	5e                   	pop    %esi
801040da:	5f                   	pop    %edi
801040db:	5d                   	pop    %ebp
801040dc:	c3                   	ret    
      getcallerpcs((uint*)p->context->ebp+2, pc);
801040dd:	8d 45 c0             	lea    -0x40(%ebp),%eax
801040e0:	83 ec 08             	sub    $0x8,%esp
801040e3:	50                   	push   %eax
801040e4:	8b 46 1c             	mov    0x1c(%esi),%eax
801040e7:	8b 40 0c             	mov    0xc(%eax),%eax
801040ea:	83 c0 08             	add    $0x8,%eax
801040ed:	50                   	push   %eax
801040ee:	e8 bd 02 00 00       	call   801043b0 <getcallerpcs>
801040f3:	83 c4 10             	add    $0x10,%esp
801040f6:	eb be                	jmp    801040b6 <procdump+0xf6>
801040f8:	90                   	nop
801040f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104100 <scheduler>:
void scheduler(void){
80104100:	55                   	push   %ebp
80104101:	89 e5                	mov    %esp,%ebp
80104103:	57                   	push   %edi
80104104:	56                   	push   %esi
80104105:	53                   	push   %ebx
80104106:	81 ec 1c 01 00 00    	sub    $0x11c,%esp
  struct cpu *c = mycpu();
8010410c:	e8 3f f6 ff ff       	call   80103750 <mycpu>
80104111:	8d 55 e8             	lea    -0x18(%ebp),%edx
80104114:	89 c7                	mov    %eax,%edi
80104116:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
        occurrences[i] = 0;
8010411c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104122:	83 c0 04             	add    $0x4,%eax
    for (int i = 0; i < NPROC; i++) {
80104125:	39 c2                	cmp    %eax,%edx
80104127:	75 f3                	jne    8010411c <scheduler+0x1c>
    golden_ticket = random_at_most(ticks);
80104129:	83 ec 0c             	sub    $0xc,%esp
  c->proc = 0;
8010412c:	c7 87 ac 00 00 00 00 	movl   $0x0,0xac(%edi)
80104133:	00 00 00 
    golden_ticket = random_at_most(ticks);
80104136:	ff 35 80 5a 11 80    	pushl  0x80115a80
    int d = 0;
8010413c:	31 f6                	xor    %esi,%esi
    golden_ticket = random_at_most(ticks);
8010413e:	e8 dd 30 00 00       	call   80107220 <random_at_most>
80104143:	8d 47 04             	lea    0x4(%edi),%eax
80104146:	83 c4 10             	add    $0x10,%esp
80104149:	89 85 e4 fe ff ff    	mov    %eax,-0x11c(%ebp)
8010414f:	90                   	nop
  asm volatile("sti");
80104150:	fb                   	sti    
      acquire(&ptable.lock);
80104151:	83 ec 0c             	sub    $0xc,%esp
      d++;
80104154:	83 c6 01             	add    $0x1,%esi
      acquire(&ptable.lock);
80104157:	68 00 32 11 80       	push   $0x80113200
8010415c:	e8 6f 03 00 00       	call   801044d0 <acquire>
      d++;
80104161:	83 c4 10             	add    $0x10,%esp
  int total = 0;
80104164:	31 d2                	xor    %edx,%edx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104166:	b8 34 32 11 80       	mov    $0x80113234,%eax
8010416b:	90                   	nop
8010416c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state==RUNNABLE){
80104170:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80104174:	75 03                	jne    80104179 <scheduler+0x79>
      total += p->tickets;
80104176:	03 50 7c             	add    0x7c(%eax),%edx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104179:	83 e8 80             	sub    $0xffffff80,%eax
8010417c:	3d 34 52 11 80       	cmp    $0x80115234,%eax
80104181:	72 ed                	jb     80104170 <scheduler+0x70>
      golden_ticket = random_at_most(total_no_tickets);  // ticket sorteado randômicamente;
80104183:	83 ec 0c             	sub    $0xc,%esp
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104186:	bb 34 32 11 80       	mov    $0x80113234,%ebx
      golden_ticket = random_at_most(total_no_tickets);  // ticket sorteado randômicamente;
8010418b:	52                   	push   %edx
8010418c:	e8 8f 30 00 00       	call   80107220 <random_at_most>
80104191:	83 c4 10             	add    $0x10,%esp
      count = 0;
80104194:	31 d2                	xor    %edx,%edx
80104196:	8b 4b 7c             	mov    0x7c(%ebx),%ecx
80104199:	01 d1                	add    %edx,%ecx
          if(p->state != RUNNABLE){
8010419b:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
8010419f:	0f 85 9b 00 00 00    	jne    80104240 <scheduler+0x140>
          if (golden_ticket < count || golden_ticket > (count + p->tickets)){
801041a5:	39 d0                	cmp    %edx,%eax
801041a7:	0f 8c 93 00 00 00    	jl     80104240 <scheduler+0x140>
801041ad:	39 c1                	cmp    %eax,%ecx
801041af:	0f 8c 8b 00 00 00    	jl     80104240 <scheduler+0x140>
          occurrences[p->pid]++;  // Incrementa quantidade de ocorrências por processo
801041b5:	8b 43 10             	mov    0x10(%ebx),%eax
801041b8:	83 84 85 e8 fe ff ff 	addl   $0x1,-0x118(%ebp,%eax,4)
801041bf:	01 
          if(d % 100 == 0){
801041c0:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
801041c5:	f7 e6                	mul    %esi
801041c7:	c1 ea 05             	shr    $0x5,%edx
801041ca:	6b c2 64             	imul   $0x64,%edx,%eax
801041cd:	39 c6                	cmp    %eax,%esi
801041cf:	75 1e                	jne    801041ef <scheduler+0xef>
              procdump(occurrences);
801041d1:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
801041d7:	83 ec 0c             	sub    $0xc,%esp
801041da:	50                   	push   %eax
801041db:	e8 e0 fd ff ff       	call   80103fc0 <procdump>
              cprintf("\n");
801041e0:	c7 04 24 3b 7c 10 80 	movl   $0x80107c3b,(%esp)
801041e7:	e8 74 c4 ff ff       	call   80100660 <cprintf>
801041ec:	83 c4 10             	add    $0x10,%esp
          switchuvm(p);
801041ef:	83 ec 0c             	sub    $0xc,%esp
          c->proc = p;
801041f2:	89 9f ac 00 00 00    	mov    %ebx,0xac(%edi)
          switchuvm(p);
801041f8:	53                   	push   %ebx
801041f9:	e8 c2 27 00 00       	call   801069c0 <switchuvm>
          swtch(&(c->scheduler), p->context);
801041fe:	58                   	pop    %eax
801041ff:	5a                   	pop    %edx
80104200:	ff 73 1c             	pushl  0x1c(%ebx)
80104203:	ff b5 e4 fe ff ff    	pushl  -0x11c(%ebp)
          p->state = RUNNING;
80104209:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
          swtch(&(c->scheduler), p->context);
80104210:	e8 06 06 00 00       	call   8010481b <swtch>
          switchkvm();
80104215:	e8 86 27 00 00       	call   801069a0 <switchkvm>
          c->proc = 0;
8010421a:	c7 87 ac 00 00 00 00 	movl   $0x0,0xac(%edi)
80104221:	00 00 00 
          break;
80104224:	83 c4 10             	add    $0x10,%esp
    release(&ptable.lock);
80104227:	83 ec 0c             	sub    $0xc,%esp
8010422a:	68 00 32 11 80       	push   $0x80113200
8010422f:	e8 5c 03 00 00       	call   80104590 <release>
      sti();
80104234:	83 c4 10             	add    $0x10,%esp
80104237:	e9 14 ff ff ff       	jmp    80104150 <scheduler+0x50>
8010423c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104240:	83 eb 80             	sub    $0xffffff80,%ebx
80104243:	89 ca                	mov    %ecx,%edx
80104245:	81 fb 34 52 11 80    	cmp    $0x80115234,%ebx
8010424b:	0f 82 45 ff ff ff    	jb     80104196 <scheduler+0x96>
80104251:	eb d4                	jmp    80104227 <scheduler+0x127>
80104253:	66 90                	xchg   %ax,%ax
80104255:	66 90                	xchg   %ax,%ax
80104257:	66 90                	xchg   %ax,%ax
80104259:	66 90                	xchg   %ax,%ax
8010425b:	66 90                	xchg   %ax,%ax
8010425d:	66 90                	xchg   %ax,%ax
8010425f:	90                   	nop

80104260 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104260:	55                   	push   %ebp
80104261:	89 e5                	mov    %esp,%ebp
80104263:	53                   	push   %ebx
80104264:	83 ec 0c             	sub    $0xc,%esp
80104267:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010426a:	68 38 79 10 80       	push   $0x80107938
8010426f:	8d 43 04             	lea    0x4(%ebx),%eax
80104272:	50                   	push   %eax
80104273:	e8 18 01 00 00       	call   80104390 <initlock>
  lk->name = name;
80104278:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010427b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104281:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104284:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010428b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010428e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104291:	c9                   	leave  
80104292:	c3                   	ret    
80104293:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042a0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	56                   	push   %esi
801042a4:	53                   	push   %ebx
801042a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801042a8:	83 ec 0c             	sub    $0xc,%esp
801042ab:	8d 73 04             	lea    0x4(%ebx),%esi
801042ae:	56                   	push   %esi
801042af:	e8 1c 02 00 00       	call   801044d0 <acquire>
  while (lk->locked) {
801042b4:	8b 13                	mov    (%ebx),%edx
801042b6:	83 c4 10             	add    $0x10,%esp
801042b9:	85 d2                	test   %edx,%edx
801042bb:	74 16                	je     801042d3 <acquiresleep+0x33>
801042bd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801042c0:	83 ec 08             	sub    $0x8,%esp
801042c3:	56                   	push   %esi
801042c4:	53                   	push   %ebx
801042c5:	e8 66 fa ff ff       	call   80103d30 <sleep>
  while (lk->locked) {
801042ca:	8b 03                	mov    (%ebx),%eax
801042cc:	83 c4 10             	add    $0x10,%esp
801042cf:	85 c0                	test   %eax,%eax
801042d1:	75 ed                	jne    801042c0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801042d3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801042d9:	e8 e2 f4 ff ff       	call   801037c0 <myproc>
801042de:	8b 40 10             	mov    0x10(%eax),%eax
801042e1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801042e4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801042e7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042ea:	5b                   	pop    %ebx
801042eb:	5e                   	pop    %esi
801042ec:	5d                   	pop    %ebp
  release(&lk->lk);
801042ed:	e9 9e 02 00 00       	jmp    80104590 <release>
801042f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104300 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104300:	55                   	push   %ebp
80104301:	89 e5                	mov    %esp,%ebp
80104303:	56                   	push   %esi
80104304:	53                   	push   %ebx
80104305:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104308:	83 ec 0c             	sub    $0xc,%esp
8010430b:	8d 73 04             	lea    0x4(%ebx),%esi
8010430e:	56                   	push   %esi
8010430f:	e8 bc 01 00 00       	call   801044d0 <acquire>
  lk->locked = 0;
80104314:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010431a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104321:	89 1c 24             	mov    %ebx,(%esp)
80104324:	e8 b7 fb ff ff       	call   80103ee0 <wakeup>
  release(&lk->lk);
80104329:	89 75 08             	mov    %esi,0x8(%ebp)
8010432c:	83 c4 10             	add    $0x10,%esp
}
8010432f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104332:	5b                   	pop    %ebx
80104333:	5e                   	pop    %esi
80104334:	5d                   	pop    %ebp
  release(&lk->lk);
80104335:	e9 56 02 00 00       	jmp    80104590 <release>
8010433a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104340 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104340:	55                   	push   %ebp
80104341:	89 e5                	mov    %esp,%ebp
80104343:	57                   	push   %edi
80104344:	56                   	push   %esi
80104345:	53                   	push   %ebx
80104346:	31 ff                	xor    %edi,%edi
80104348:	83 ec 18             	sub    $0x18,%esp
8010434b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010434e:	8d 73 04             	lea    0x4(%ebx),%esi
80104351:	56                   	push   %esi
80104352:	e8 79 01 00 00       	call   801044d0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104357:	8b 03                	mov    (%ebx),%eax
80104359:	83 c4 10             	add    $0x10,%esp
8010435c:	85 c0                	test   %eax,%eax
8010435e:	74 13                	je     80104373 <holdingsleep+0x33>
80104360:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104363:	e8 58 f4 ff ff       	call   801037c0 <myproc>
80104368:	39 58 10             	cmp    %ebx,0x10(%eax)
8010436b:	0f 94 c0             	sete   %al
8010436e:	0f b6 c0             	movzbl %al,%eax
80104371:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104373:	83 ec 0c             	sub    $0xc,%esp
80104376:	56                   	push   %esi
80104377:	e8 14 02 00 00       	call   80104590 <release>
  return r;
}
8010437c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010437f:	89 f8                	mov    %edi,%eax
80104381:	5b                   	pop    %ebx
80104382:	5e                   	pop    %esi
80104383:	5f                   	pop    %edi
80104384:	5d                   	pop    %ebp
80104385:	c3                   	ret    
80104386:	66 90                	xchg   %ax,%ax
80104388:	66 90                	xchg   %ax,%ax
8010438a:	66 90                	xchg   %ax,%ax
8010438c:	66 90                	xchg   %ax,%ax
8010438e:	66 90                	xchg   %ax,%ax

80104390 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104390:	55                   	push   %ebp
80104391:	89 e5                	mov    %esp,%ebp
80104393:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104396:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104399:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010439f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801043a2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801043a9:	5d                   	pop    %ebp
801043aa:	c3                   	ret    
801043ab:	90                   	nop
801043ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043b0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801043b0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801043b1:	31 d2                	xor    %edx,%edx
{
801043b3:	89 e5                	mov    %esp,%ebp
801043b5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801043b6:	8b 45 08             	mov    0x8(%ebp),%eax
{
801043b9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801043bc:	83 e8 08             	sub    $0x8,%eax
801043bf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801043c0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801043c6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801043cc:	77 1a                	ja     801043e8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801043ce:	8b 58 04             	mov    0x4(%eax),%ebx
801043d1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801043d4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801043d7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801043d9:	83 fa 0a             	cmp    $0xa,%edx
801043dc:	75 e2                	jne    801043c0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801043de:	5b                   	pop    %ebx
801043df:	5d                   	pop    %ebp
801043e0:	c3                   	ret    
801043e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043e8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801043eb:	83 c1 28             	add    $0x28,%ecx
801043ee:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801043f0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801043f6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801043f9:	39 c1                	cmp    %eax,%ecx
801043fb:	75 f3                	jne    801043f0 <getcallerpcs+0x40>
}
801043fd:	5b                   	pop    %ebx
801043fe:	5d                   	pop    %ebp
801043ff:	c3                   	ret    

80104400 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	53                   	push   %ebx
80104404:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104407:	9c                   	pushf  
80104408:	5b                   	pop    %ebx
  asm volatile("cli");
80104409:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010440a:	e8 41 f3 ff ff       	call   80103750 <mycpu>
8010440f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104415:	85 c0                	test   %eax,%eax
80104417:	75 11                	jne    8010442a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104419:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010441f:	e8 2c f3 ff ff       	call   80103750 <mycpu>
80104424:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010442a:	e8 21 f3 ff ff       	call   80103750 <mycpu>
8010442f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104436:	83 c4 04             	add    $0x4,%esp
80104439:	5b                   	pop    %ebx
8010443a:	5d                   	pop    %ebp
8010443b:	c3                   	ret    
8010443c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104440 <popcli>:

void
popcli(void)
{
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104446:	9c                   	pushf  
80104447:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104448:	f6 c4 02             	test   $0x2,%ah
8010444b:	75 35                	jne    80104482 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010444d:	e8 fe f2 ff ff       	call   80103750 <mycpu>
80104452:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104459:	78 34                	js     8010448f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010445b:	e8 f0 f2 ff ff       	call   80103750 <mycpu>
80104460:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104466:	85 d2                	test   %edx,%edx
80104468:	74 06                	je     80104470 <popcli+0x30>
    sti();
}
8010446a:	c9                   	leave  
8010446b:	c3                   	ret    
8010446c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104470:	e8 db f2 ff ff       	call   80103750 <mycpu>
80104475:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010447b:	85 c0                	test   %eax,%eax
8010447d:	74 eb                	je     8010446a <popcli+0x2a>
  asm volatile("sti");
8010447f:	fb                   	sti    
}
80104480:	c9                   	leave  
80104481:	c3                   	ret    
    panic("popcli - interruptible");
80104482:	83 ec 0c             	sub    $0xc,%esp
80104485:	68 43 79 10 80       	push   $0x80107943
8010448a:	e8 01 bf ff ff       	call   80100390 <panic>
    panic("popcli");
8010448f:	83 ec 0c             	sub    $0xc,%esp
80104492:	68 5a 79 10 80       	push   $0x8010795a
80104497:	e8 f4 be ff ff       	call   80100390 <panic>
8010449c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801044a0 <holding>:
{
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	56                   	push   %esi
801044a4:	53                   	push   %ebx
801044a5:	8b 75 08             	mov    0x8(%ebp),%esi
801044a8:	31 db                	xor    %ebx,%ebx
  pushcli();
801044aa:	e8 51 ff ff ff       	call   80104400 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801044af:	8b 06                	mov    (%esi),%eax
801044b1:	85 c0                	test   %eax,%eax
801044b3:	74 10                	je     801044c5 <holding+0x25>
801044b5:	8b 5e 08             	mov    0x8(%esi),%ebx
801044b8:	e8 93 f2 ff ff       	call   80103750 <mycpu>
801044bd:	39 c3                	cmp    %eax,%ebx
801044bf:	0f 94 c3             	sete   %bl
801044c2:	0f b6 db             	movzbl %bl,%ebx
  popcli();
801044c5:	e8 76 ff ff ff       	call   80104440 <popcli>
}
801044ca:	89 d8                	mov    %ebx,%eax
801044cc:	5b                   	pop    %ebx
801044cd:	5e                   	pop    %esi
801044ce:	5d                   	pop    %ebp
801044cf:	c3                   	ret    

801044d0 <acquire>:
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	56                   	push   %esi
801044d4:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
801044d5:	e8 26 ff ff ff       	call   80104400 <pushcli>
  if(holding(lk))
801044da:	8b 5d 08             	mov    0x8(%ebp),%ebx
801044dd:	83 ec 0c             	sub    $0xc,%esp
801044e0:	53                   	push   %ebx
801044e1:	e8 ba ff ff ff       	call   801044a0 <holding>
801044e6:	83 c4 10             	add    $0x10,%esp
801044e9:	85 c0                	test   %eax,%eax
801044eb:	0f 85 83 00 00 00    	jne    80104574 <acquire+0xa4>
801044f1:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
801044f3:	ba 01 00 00 00       	mov    $0x1,%edx
801044f8:	eb 09                	jmp    80104503 <acquire+0x33>
801044fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104500:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104503:	89 d0                	mov    %edx,%eax
80104505:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104508:	85 c0                	test   %eax,%eax
8010450a:	75 f4                	jne    80104500 <acquire+0x30>
  __sync_synchronize();
8010450c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104511:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104514:	e8 37 f2 ff ff       	call   80103750 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104519:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
8010451c:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
8010451f:	89 e8                	mov    %ebp,%eax
80104521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104528:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
8010452e:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104534:	77 1a                	ja     80104550 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104536:	8b 48 04             	mov    0x4(%eax),%ecx
80104539:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
8010453c:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
8010453f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104541:	83 fe 0a             	cmp    $0xa,%esi
80104544:	75 e2                	jne    80104528 <acquire+0x58>
}
80104546:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104549:	5b                   	pop    %ebx
8010454a:	5e                   	pop    %esi
8010454b:	5d                   	pop    %ebp
8010454c:	c3                   	ret    
8010454d:	8d 76 00             	lea    0x0(%esi),%esi
80104550:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104553:	83 c2 28             	add    $0x28,%edx
80104556:	8d 76 00             	lea    0x0(%esi),%esi
80104559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104560:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104566:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104569:	39 d0                	cmp    %edx,%eax
8010456b:	75 f3                	jne    80104560 <acquire+0x90>
}
8010456d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104570:	5b                   	pop    %ebx
80104571:	5e                   	pop    %esi
80104572:	5d                   	pop    %ebp
80104573:	c3                   	ret    
    panic("acquire");
80104574:	83 ec 0c             	sub    $0xc,%esp
80104577:	68 61 79 10 80       	push   $0x80107961
8010457c:	e8 0f be ff ff       	call   80100390 <panic>
80104581:	eb 0d                	jmp    80104590 <release>
80104583:	90                   	nop
80104584:	90                   	nop
80104585:	90                   	nop
80104586:	90                   	nop
80104587:	90                   	nop
80104588:	90                   	nop
80104589:	90                   	nop
8010458a:	90                   	nop
8010458b:	90                   	nop
8010458c:	90                   	nop
8010458d:	90                   	nop
8010458e:	90                   	nop
8010458f:	90                   	nop

80104590 <release>:
{
80104590:	55                   	push   %ebp
80104591:	89 e5                	mov    %esp,%ebp
80104593:	53                   	push   %ebx
80104594:	83 ec 10             	sub    $0x10,%esp
80104597:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010459a:	53                   	push   %ebx
8010459b:	e8 00 ff ff ff       	call   801044a0 <holding>
801045a0:	83 c4 10             	add    $0x10,%esp
801045a3:	85 c0                	test   %eax,%eax
801045a5:	74 22                	je     801045c9 <release+0x39>
  lk->pcs[0] = 0;
801045a7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801045ae:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801045b5:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801045ba:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801045c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045c3:	c9                   	leave  
  popcli();
801045c4:	e9 77 fe ff ff       	jmp    80104440 <popcli>
    panic("release");
801045c9:	83 ec 0c             	sub    $0xc,%esp
801045cc:	68 69 79 10 80       	push   $0x80107969
801045d1:	e8 ba bd ff ff       	call   80100390 <panic>
801045d6:	66 90                	xchg   %ax,%ax
801045d8:	66 90                	xchg   %ax,%ax
801045da:	66 90                	xchg   %ax,%ax
801045dc:	66 90                	xchg   %ax,%ax
801045de:	66 90                	xchg   %ax,%ax

801045e0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	57                   	push   %edi
801045e4:	53                   	push   %ebx
801045e5:	8b 55 08             	mov    0x8(%ebp),%edx
801045e8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801045eb:	f6 c2 03             	test   $0x3,%dl
801045ee:	75 05                	jne    801045f5 <memset+0x15>
801045f0:	f6 c1 03             	test   $0x3,%cl
801045f3:	74 13                	je     80104608 <memset+0x28>
  asm volatile("cld; rep stosb" :
801045f5:	89 d7                	mov    %edx,%edi
801045f7:	8b 45 0c             	mov    0xc(%ebp),%eax
801045fa:	fc                   	cld    
801045fb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801045fd:	5b                   	pop    %ebx
801045fe:	89 d0                	mov    %edx,%eax
80104600:	5f                   	pop    %edi
80104601:	5d                   	pop    %ebp
80104602:	c3                   	ret    
80104603:	90                   	nop
80104604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104608:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010460c:	c1 e9 02             	shr    $0x2,%ecx
8010460f:	89 f8                	mov    %edi,%eax
80104611:	89 fb                	mov    %edi,%ebx
80104613:	c1 e0 18             	shl    $0x18,%eax
80104616:	c1 e3 10             	shl    $0x10,%ebx
80104619:	09 d8                	or     %ebx,%eax
8010461b:	09 f8                	or     %edi,%eax
8010461d:	c1 e7 08             	shl    $0x8,%edi
80104620:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104622:	89 d7                	mov    %edx,%edi
80104624:	fc                   	cld    
80104625:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104627:	5b                   	pop    %ebx
80104628:	89 d0                	mov    %edx,%eax
8010462a:	5f                   	pop    %edi
8010462b:	5d                   	pop    %ebp
8010462c:	c3                   	ret    
8010462d:	8d 76 00             	lea    0x0(%esi),%esi

80104630 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	57                   	push   %edi
80104634:	56                   	push   %esi
80104635:	53                   	push   %ebx
80104636:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104639:	8b 75 08             	mov    0x8(%ebp),%esi
8010463c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010463f:	85 db                	test   %ebx,%ebx
80104641:	74 29                	je     8010466c <memcmp+0x3c>
    if(*s1 != *s2)
80104643:	0f b6 16             	movzbl (%esi),%edx
80104646:	0f b6 0f             	movzbl (%edi),%ecx
80104649:	38 d1                	cmp    %dl,%cl
8010464b:	75 2b                	jne    80104678 <memcmp+0x48>
8010464d:	b8 01 00 00 00       	mov    $0x1,%eax
80104652:	eb 14                	jmp    80104668 <memcmp+0x38>
80104654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104658:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
8010465c:	83 c0 01             	add    $0x1,%eax
8010465f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104664:	38 ca                	cmp    %cl,%dl
80104666:	75 10                	jne    80104678 <memcmp+0x48>
  while(n-- > 0){
80104668:	39 d8                	cmp    %ebx,%eax
8010466a:	75 ec                	jne    80104658 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010466c:	5b                   	pop    %ebx
  return 0;
8010466d:	31 c0                	xor    %eax,%eax
}
8010466f:	5e                   	pop    %esi
80104670:	5f                   	pop    %edi
80104671:	5d                   	pop    %ebp
80104672:	c3                   	ret    
80104673:	90                   	nop
80104674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104678:	0f b6 c2             	movzbl %dl,%eax
}
8010467b:	5b                   	pop    %ebx
      return *s1 - *s2;
8010467c:	29 c8                	sub    %ecx,%eax
}
8010467e:	5e                   	pop    %esi
8010467f:	5f                   	pop    %edi
80104680:	5d                   	pop    %ebp
80104681:	c3                   	ret    
80104682:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104690 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104690:	55                   	push   %ebp
80104691:	89 e5                	mov    %esp,%ebp
80104693:	56                   	push   %esi
80104694:	53                   	push   %ebx
80104695:	8b 45 08             	mov    0x8(%ebp),%eax
80104698:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010469b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010469e:	39 c3                	cmp    %eax,%ebx
801046a0:	73 26                	jae    801046c8 <memmove+0x38>
801046a2:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
801046a5:	39 c8                	cmp    %ecx,%eax
801046a7:	73 1f                	jae    801046c8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
801046a9:	85 f6                	test   %esi,%esi
801046ab:	8d 56 ff             	lea    -0x1(%esi),%edx
801046ae:	74 0f                	je     801046bf <memmove+0x2f>
      *--d = *--s;
801046b0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801046b4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
801046b7:	83 ea 01             	sub    $0x1,%edx
801046ba:	83 fa ff             	cmp    $0xffffffff,%edx
801046bd:	75 f1                	jne    801046b0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801046bf:	5b                   	pop    %ebx
801046c0:	5e                   	pop    %esi
801046c1:	5d                   	pop    %ebp
801046c2:	c3                   	ret    
801046c3:	90                   	nop
801046c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
801046c8:	31 d2                	xor    %edx,%edx
801046ca:	85 f6                	test   %esi,%esi
801046cc:	74 f1                	je     801046bf <memmove+0x2f>
801046ce:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
801046d0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801046d4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801046d7:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
801046da:	39 d6                	cmp    %edx,%esi
801046dc:	75 f2                	jne    801046d0 <memmove+0x40>
}
801046de:	5b                   	pop    %ebx
801046df:	5e                   	pop    %esi
801046e0:	5d                   	pop    %ebp
801046e1:	c3                   	ret    
801046e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046f0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801046f0:	55                   	push   %ebp
801046f1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
801046f3:	5d                   	pop    %ebp
  return memmove(dst, src, n);
801046f4:	eb 9a                	jmp    80104690 <memmove>
801046f6:	8d 76 00             	lea    0x0(%esi),%esi
801046f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104700 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104700:	55                   	push   %ebp
80104701:	89 e5                	mov    %esp,%ebp
80104703:	57                   	push   %edi
80104704:	56                   	push   %esi
80104705:	8b 7d 10             	mov    0x10(%ebp),%edi
80104708:	53                   	push   %ebx
80104709:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010470c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010470f:	85 ff                	test   %edi,%edi
80104711:	74 2f                	je     80104742 <strncmp+0x42>
80104713:	0f b6 01             	movzbl (%ecx),%eax
80104716:	0f b6 1e             	movzbl (%esi),%ebx
80104719:	84 c0                	test   %al,%al
8010471b:	74 37                	je     80104754 <strncmp+0x54>
8010471d:	38 c3                	cmp    %al,%bl
8010471f:	75 33                	jne    80104754 <strncmp+0x54>
80104721:	01 f7                	add    %esi,%edi
80104723:	eb 13                	jmp    80104738 <strncmp+0x38>
80104725:	8d 76 00             	lea    0x0(%esi),%esi
80104728:	0f b6 01             	movzbl (%ecx),%eax
8010472b:	84 c0                	test   %al,%al
8010472d:	74 21                	je     80104750 <strncmp+0x50>
8010472f:	0f b6 1a             	movzbl (%edx),%ebx
80104732:	89 d6                	mov    %edx,%esi
80104734:	38 d8                	cmp    %bl,%al
80104736:	75 1c                	jne    80104754 <strncmp+0x54>
    n--, p++, q++;
80104738:	8d 56 01             	lea    0x1(%esi),%edx
8010473b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
8010473e:	39 fa                	cmp    %edi,%edx
80104740:	75 e6                	jne    80104728 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104742:	5b                   	pop    %ebx
    return 0;
80104743:	31 c0                	xor    %eax,%eax
}
80104745:	5e                   	pop    %esi
80104746:	5f                   	pop    %edi
80104747:	5d                   	pop    %ebp
80104748:	c3                   	ret    
80104749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104750:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104754:	29 d8                	sub    %ebx,%eax
}
80104756:	5b                   	pop    %ebx
80104757:	5e                   	pop    %esi
80104758:	5f                   	pop    %edi
80104759:	5d                   	pop    %ebp
8010475a:	c3                   	ret    
8010475b:	90                   	nop
8010475c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104760 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104760:	55                   	push   %ebp
80104761:	89 e5                	mov    %esp,%ebp
80104763:	56                   	push   %esi
80104764:	53                   	push   %ebx
80104765:	8b 45 08             	mov    0x8(%ebp),%eax
80104768:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010476b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010476e:	89 c2                	mov    %eax,%edx
80104770:	eb 19                	jmp    8010478b <strncpy+0x2b>
80104772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104778:	83 c3 01             	add    $0x1,%ebx
8010477b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010477f:	83 c2 01             	add    $0x1,%edx
80104782:	84 c9                	test   %cl,%cl
80104784:	88 4a ff             	mov    %cl,-0x1(%edx)
80104787:	74 09                	je     80104792 <strncpy+0x32>
80104789:	89 f1                	mov    %esi,%ecx
8010478b:	85 c9                	test   %ecx,%ecx
8010478d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104790:	7f e6                	jg     80104778 <strncpy+0x18>
    ;
  while(n-- > 0)
80104792:	31 c9                	xor    %ecx,%ecx
80104794:	85 f6                	test   %esi,%esi
80104796:	7e 17                	jle    801047af <strncpy+0x4f>
80104798:	90                   	nop
80104799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
801047a0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
801047a4:	89 f3                	mov    %esi,%ebx
801047a6:	83 c1 01             	add    $0x1,%ecx
801047a9:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
801047ab:	85 db                	test   %ebx,%ebx
801047ad:	7f f1                	jg     801047a0 <strncpy+0x40>
  return os;
}
801047af:	5b                   	pop    %ebx
801047b0:	5e                   	pop    %esi
801047b1:	5d                   	pop    %ebp
801047b2:	c3                   	ret    
801047b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801047b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047c0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
801047c3:	56                   	push   %esi
801047c4:	53                   	push   %ebx
801047c5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801047c8:	8b 45 08             	mov    0x8(%ebp),%eax
801047cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
801047ce:	85 c9                	test   %ecx,%ecx
801047d0:	7e 26                	jle    801047f8 <safestrcpy+0x38>
801047d2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801047d6:	89 c1                	mov    %eax,%ecx
801047d8:	eb 17                	jmp    801047f1 <safestrcpy+0x31>
801047da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801047e0:	83 c2 01             	add    $0x1,%edx
801047e3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801047e7:	83 c1 01             	add    $0x1,%ecx
801047ea:	84 db                	test   %bl,%bl
801047ec:	88 59 ff             	mov    %bl,-0x1(%ecx)
801047ef:	74 04                	je     801047f5 <safestrcpy+0x35>
801047f1:	39 f2                	cmp    %esi,%edx
801047f3:	75 eb                	jne    801047e0 <safestrcpy+0x20>
    ;
  *s = 0;
801047f5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
801047f8:	5b                   	pop    %ebx
801047f9:	5e                   	pop    %esi
801047fa:	5d                   	pop    %ebp
801047fb:	c3                   	ret    
801047fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104800 <strlen>:

int
strlen(const char *s)
{
80104800:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104801:	31 c0                	xor    %eax,%eax
{
80104803:	89 e5                	mov    %esp,%ebp
80104805:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104808:	80 3a 00             	cmpb   $0x0,(%edx)
8010480b:	74 0c                	je     80104819 <strlen+0x19>
8010480d:	8d 76 00             	lea    0x0(%esi),%esi
80104810:	83 c0 01             	add    $0x1,%eax
80104813:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104817:	75 f7                	jne    80104810 <strlen+0x10>
    ;
  return n;
}
80104819:	5d                   	pop    %ebp
8010481a:	c3                   	ret    

8010481b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010481b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010481f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104823:	55                   	push   %ebp
  pushl %ebx
80104824:	53                   	push   %ebx
  pushl %esi
80104825:	56                   	push   %esi
  pushl %edi
80104826:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104827:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104829:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010482b:	5f                   	pop    %edi
  popl %esi
8010482c:	5e                   	pop    %esi
  popl %ebx
8010482d:	5b                   	pop    %ebx
  popl %ebp
8010482e:	5d                   	pop    %ebp
  ret
8010482f:	c3                   	ret    

80104830 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	53                   	push   %ebx
80104834:	83 ec 04             	sub    $0x4,%esp
80104837:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010483a:	e8 81 ef ff ff       	call   801037c0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010483f:	8b 00                	mov    (%eax),%eax
80104841:	39 d8                	cmp    %ebx,%eax
80104843:	76 1b                	jbe    80104860 <fetchint+0x30>
80104845:	8d 53 04             	lea    0x4(%ebx),%edx
80104848:	39 d0                	cmp    %edx,%eax
8010484a:	72 14                	jb     80104860 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010484c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010484f:	8b 13                	mov    (%ebx),%edx
80104851:	89 10                	mov    %edx,(%eax)
  return 0;
80104853:	31 c0                	xor    %eax,%eax
}
80104855:	83 c4 04             	add    $0x4,%esp
80104858:	5b                   	pop    %ebx
80104859:	5d                   	pop    %ebp
8010485a:	c3                   	ret    
8010485b:	90                   	nop
8010485c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104860:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104865:	eb ee                	jmp    80104855 <fetchint+0x25>
80104867:	89 f6                	mov    %esi,%esi
80104869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104870 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	53                   	push   %ebx
80104874:	83 ec 04             	sub    $0x4,%esp
80104877:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010487a:	e8 41 ef ff ff       	call   801037c0 <myproc>

  if(addr >= curproc->sz)
8010487f:	39 18                	cmp    %ebx,(%eax)
80104881:	76 29                	jbe    801048ac <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104883:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104886:	89 da                	mov    %ebx,%edx
80104888:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010488a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010488c:	39 c3                	cmp    %eax,%ebx
8010488e:	73 1c                	jae    801048ac <fetchstr+0x3c>
    if(*s == 0)
80104890:	80 3b 00             	cmpb   $0x0,(%ebx)
80104893:	75 10                	jne    801048a5 <fetchstr+0x35>
80104895:	eb 39                	jmp    801048d0 <fetchstr+0x60>
80104897:	89 f6                	mov    %esi,%esi
80104899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801048a0:	80 3a 00             	cmpb   $0x0,(%edx)
801048a3:	74 1b                	je     801048c0 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
801048a5:	83 c2 01             	add    $0x1,%edx
801048a8:	39 d0                	cmp    %edx,%eax
801048aa:	77 f4                	ja     801048a0 <fetchstr+0x30>
    return -1;
801048ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
801048b1:	83 c4 04             	add    $0x4,%esp
801048b4:	5b                   	pop    %ebx
801048b5:	5d                   	pop    %ebp
801048b6:	c3                   	ret    
801048b7:	89 f6                	mov    %esi,%esi
801048b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801048c0:	83 c4 04             	add    $0x4,%esp
801048c3:	89 d0                	mov    %edx,%eax
801048c5:	29 d8                	sub    %ebx,%eax
801048c7:	5b                   	pop    %ebx
801048c8:	5d                   	pop    %ebp
801048c9:	c3                   	ret    
801048ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
801048d0:	31 c0                	xor    %eax,%eax
      return s - *pp;
801048d2:	eb dd                	jmp    801048b1 <fetchstr+0x41>
801048d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801048e0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801048e0:	55                   	push   %ebp
801048e1:	89 e5                	mov    %esp,%ebp
801048e3:	56                   	push   %esi
801048e4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801048e5:	e8 d6 ee ff ff       	call   801037c0 <myproc>
801048ea:	8b 40 18             	mov    0x18(%eax),%eax
801048ed:	8b 55 08             	mov    0x8(%ebp),%edx
801048f0:	8b 40 44             	mov    0x44(%eax),%eax
801048f3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801048f6:	e8 c5 ee ff ff       	call   801037c0 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801048fb:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801048fd:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104900:	39 c6                	cmp    %eax,%esi
80104902:	73 1c                	jae    80104920 <argint+0x40>
80104904:	8d 53 08             	lea    0x8(%ebx),%edx
80104907:	39 d0                	cmp    %edx,%eax
80104909:	72 15                	jb     80104920 <argint+0x40>
  *ip = *(int*)(addr);
8010490b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010490e:	8b 53 04             	mov    0x4(%ebx),%edx
80104911:	89 10                	mov    %edx,(%eax)
  return 0;
80104913:	31 c0                	xor    %eax,%eax
}
80104915:	5b                   	pop    %ebx
80104916:	5e                   	pop    %esi
80104917:	5d                   	pop    %ebp
80104918:	c3                   	ret    
80104919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104920:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104925:	eb ee                	jmp    80104915 <argint+0x35>
80104927:	89 f6                	mov    %esi,%esi
80104929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104930 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	56                   	push   %esi
80104934:	53                   	push   %ebx
80104935:	83 ec 10             	sub    $0x10,%esp
80104938:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010493b:	e8 80 ee ff ff       	call   801037c0 <myproc>
80104940:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104942:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104945:	83 ec 08             	sub    $0x8,%esp
80104948:	50                   	push   %eax
80104949:	ff 75 08             	pushl  0x8(%ebp)
8010494c:	e8 8f ff ff ff       	call   801048e0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104951:	83 c4 10             	add    $0x10,%esp
80104954:	85 c0                	test   %eax,%eax
80104956:	78 28                	js     80104980 <argptr+0x50>
80104958:	85 db                	test   %ebx,%ebx
8010495a:	78 24                	js     80104980 <argptr+0x50>
8010495c:	8b 16                	mov    (%esi),%edx
8010495e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104961:	39 c2                	cmp    %eax,%edx
80104963:	76 1b                	jbe    80104980 <argptr+0x50>
80104965:	01 c3                	add    %eax,%ebx
80104967:	39 da                	cmp    %ebx,%edx
80104969:	72 15                	jb     80104980 <argptr+0x50>
    return -1;
  *pp = (char*)i;
8010496b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010496e:	89 02                	mov    %eax,(%edx)
  return 0;
80104970:	31 c0                	xor    %eax,%eax
}
80104972:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104975:	5b                   	pop    %ebx
80104976:	5e                   	pop    %esi
80104977:	5d                   	pop    %ebp
80104978:	c3                   	ret    
80104979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104980:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104985:	eb eb                	jmp    80104972 <argptr+0x42>
80104987:	89 f6                	mov    %esi,%esi
80104989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104990 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104990:	55                   	push   %ebp
80104991:	89 e5                	mov    %esp,%ebp
80104993:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104996:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104999:	50                   	push   %eax
8010499a:	ff 75 08             	pushl  0x8(%ebp)
8010499d:	e8 3e ff ff ff       	call   801048e0 <argint>
801049a2:	83 c4 10             	add    $0x10,%esp
801049a5:	85 c0                	test   %eax,%eax
801049a7:	78 17                	js     801049c0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
801049a9:	83 ec 08             	sub    $0x8,%esp
801049ac:	ff 75 0c             	pushl  0xc(%ebp)
801049af:	ff 75 f4             	pushl  -0xc(%ebp)
801049b2:	e8 b9 fe ff ff       	call   80104870 <fetchstr>
801049b7:	83 c4 10             	add    $0x10,%esp
}
801049ba:	c9                   	leave  
801049bb:	c3                   	ret    
801049bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801049c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801049c5:	c9                   	leave  
801049c6:	c3                   	ret    
801049c7:	89 f6                	mov    %esi,%esi
801049c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049d0 <syscall>:
[SYS_lottery] sys_lottery,
};

void
syscall(void)
{
801049d0:	55                   	push   %ebp
801049d1:	89 e5                	mov    %esp,%ebp
801049d3:	53                   	push   %ebx
801049d4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
801049d7:	e8 e4 ed ff ff       	call   801037c0 <myproc>
801049dc:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
801049de:	8b 40 18             	mov    0x18(%eax),%eax
801049e1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801049e4:	8d 50 ff             	lea    -0x1(%eax),%edx
801049e7:	83 fa 15             	cmp    $0x15,%edx
801049ea:	77 1c                	ja     80104a08 <syscall+0x38>
801049ec:	8b 14 85 a0 79 10 80 	mov    -0x7fef8660(,%eax,4),%edx
801049f3:	85 d2                	test   %edx,%edx
801049f5:	74 11                	je     80104a08 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
801049f7:	ff d2                	call   *%edx
801049f9:	8b 53 18             	mov    0x18(%ebx),%edx
801049fc:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801049ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a02:	c9                   	leave  
80104a03:	c3                   	ret    
80104a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104a08:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104a09:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104a0c:	50                   	push   %eax
80104a0d:	ff 73 10             	pushl  0x10(%ebx)
80104a10:	68 71 79 10 80       	push   $0x80107971
80104a15:	e8 46 bc ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
80104a1a:	8b 43 18             	mov    0x18(%ebx),%eax
80104a1d:	83 c4 10             	add    $0x10,%esp
80104a20:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104a27:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a2a:	c9                   	leave  
80104a2b:	c3                   	ret    
80104a2c:	66 90                	xchg   %ax,%ax
80104a2e:	66 90                	xchg   %ax,%ax

80104a30 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a30:	55                   	push   %ebp
80104a31:	89 e5                	mov    %esp,%ebp
80104a33:	57                   	push   %edi
80104a34:	56                   	push   %esi
80104a35:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a36:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80104a39:	83 ec 44             	sub    $0x44,%esp
80104a3c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104a3f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104a42:	56                   	push   %esi
80104a43:	50                   	push   %eax
{
80104a44:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104a47:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104a4a:	e8 d1 d4 ff ff       	call   80101f20 <nameiparent>
80104a4f:	83 c4 10             	add    $0x10,%esp
80104a52:	85 c0                	test   %eax,%eax
80104a54:	0f 84 46 01 00 00    	je     80104ba0 <create+0x170>
    return 0;
  ilock(dp);
80104a5a:	83 ec 0c             	sub    $0xc,%esp
80104a5d:	89 c3                	mov    %eax,%ebx
80104a5f:	50                   	push   %eax
80104a60:	e8 3b cc ff ff       	call   801016a0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104a65:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104a68:	83 c4 0c             	add    $0xc,%esp
80104a6b:	50                   	push   %eax
80104a6c:	56                   	push   %esi
80104a6d:	53                   	push   %ebx
80104a6e:	e8 5d d1 ff ff       	call   80101bd0 <dirlookup>
80104a73:	83 c4 10             	add    $0x10,%esp
80104a76:	85 c0                	test   %eax,%eax
80104a78:	89 c7                	mov    %eax,%edi
80104a7a:	74 34                	je     80104ab0 <create+0x80>
    iunlockput(dp);
80104a7c:	83 ec 0c             	sub    $0xc,%esp
80104a7f:	53                   	push   %ebx
80104a80:	e8 ab ce ff ff       	call   80101930 <iunlockput>
    ilock(ip);
80104a85:	89 3c 24             	mov    %edi,(%esp)
80104a88:	e8 13 cc ff ff       	call   801016a0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104a8d:	83 c4 10             	add    $0x10,%esp
80104a90:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104a95:	0f 85 95 00 00 00    	jne    80104b30 <create+0x100>
80104a9b:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104aa0:	0f 85 8a 00 00 00    	jne    80104b30 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104aa6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104aa9:	89 f8                	mov    %edi,%eax
80104aab:	5b                   	pop    %ebx
80104aac:	5e                   	pop    %esi
80104aad:	5f                   	pop    %edi
80104aae:	5d                   	pop    %ebp
80104aaf:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80104ab0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104ab4:	83 ec 08             	sub    $0x8,%esp
80104ab7:	50                   	push   %eax
80104ab8:	ff 33                	pushl  (%ebx)
80104aba:	e8 71 ca ff ff       	call   80101530 <ialloc>
80104abf:	83 c4 10             	add    $0x10,%esp
80104ac2:	85 c0                	test   %eax,%eax
80104ac4:	89 c7                	mov    %eax,%edi
80104ac6:	0f 84 e8 00 00 00    	je     80104bb4 <create+0x184>
  ilock(ip);
80104acc:	83 ec 0c             	sub    $0xc,%esp
80104acf:	50                   	push   %eax
80104ad0:	e8 cb cb ff ff       	call   801016a0 <ilock>
  ip->major = major;
80104ad5:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104ad9:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104add:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104ae1:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104ae5:	b8 01 00 00 00       	mov    $0x1,%eax
80104aea:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104aee:	89 3c 24             	mov    %edi,(%esp)
80104af1:	e8 fa ca ff ff       	call   801015f0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104af6:	83 c4 10             	add    $0x10,%esp
80104af9:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104afe:	74 50                	je     80104b50 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104b00:	83 ec 04             	sub    $0x4,%esp
80104b03:	ff 77 04             	pushl  0x4(%edi)
80104b06:	56                   	push   %esi
80104b07:	53                   	push   %ebx
80104b08:	e8 33 d3 ff ff       	call   80101e40 <dirlink>
80104b0d:	83 c4 10             	add    $0x10,%esp
80104b10:	85 c0                	test   %eax,%eax
80104b12:	0f 88 8f 00 00 00    	js     80104ba7 <create+0x177>
  iunlockput(dp);
80104b18:	83 ec 0c             	sub    $0xc,%esp
80104b1b:	53                   	push   %ebx
80104b1c:	e8 0f ce ff ff       	call   80101930 <iunlockput>
  return ip;
80104b21:	83 c4 10             	add    $0x10,%esp
}
80104b24:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b27:	89 f8                	mov    %edi,%eax
80104b29:	5b                   	pop    %ebx
80104b2a:	5e                   	pop    %esi
80104b2b:	5f                   	pop    %edi
80104b2c:	5d                   	pop    %ebp
80104b2d:	c3                   	ret    
80104b2e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104b30:	83 ec 0c             	sub    $0xc,%esp
80104b33:	57                   	push   %edi
    return 0;
80104b34:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104b36:	e8 f5 cd ff ff       	call   80101930 <iunlockput>
    return 0;
80104b3b:	83 c4 10             	add    $0x10,%esp
}
80104b3e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b41:	89 f8                	mov    %edi,%eax
80104b43:	5b                   	pop    %ebx
80104b44:	5e                   	pop    %esi
80104b45:	5f                   	pop    %edi
80104b46:	5d                   	pop    %ebp
80104b47:	c3                   	ret    
80104b48:	90                   	nop
80104b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80104b50:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104b55:	83 ec 0c             	sub    $0xc,%esp
80104b58:	53                   	push   %ebx
80104b59:	e8 92 ca ff ff       	call   801015f0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104b5e:	83 c4 0c             	add    $0xc,%esp
80104b61:	ff 77 04             	pushl  0x4(%edi)
80104b64:	68 18 7a 10 80       	push   $0x80107a18
80104b69:	57                   	push   %edi
80104b6a:	e8 d1 d2 ff ff       	call   80101e40 <dirlink>
80104b6f:	83 c4 10             	add    $0x10,%esp
80104b72:	85 c0                	test   %eax,%eax
80104b74:	78 1c                	js     80104b92 <create+0x162>
80104b76:	83 ec 04             	sub    $0x4,%esp
80104b79:	ff 73 04             	pushl  0x4(%ebx)
80104b7c:	68 17 7a 10 80       	push   $0x80107a17
80104b81:	57                   	push   %edi
80104b82:	e8 b9 d2 ff ff       	call   80101e40 <dirlink>
80104b87:	83 c4 10             	add    $0x10,%esp
80104b8a:	85 c0                	test   %eax,%eax
80104b8c:	0f 89 6e ff ff ff    	jns    80104b00 <create+0xd0>
      panic("create dots");
80104b92:	83 ec 0c             	sub    $0xc,%esp
80104b95:	68 0b 7a 10 80       	push   $0x80107a0b
80104b9a:	e8 f1 b7 ff ff       	call   80100390 <panic>
80104b9f:	90                   	nop
    return 0;
80104ba0:	31 ff                	xor    %edi,%edi
80104ba2:	e9 ff fe ff ff       	jmp    80104aa6 <create+0x76>
    panic("create: dirlink");
80104ba7:	83 ec 0c             	sub    $0xc,%esp
80104baa:	68 1a 7a 10 80       	push   $0x80107a1a
80104baf:	e8 dc b7 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80104bb4:	83 ec 0c             	sub    $0xc,%esp
80104bb7:	68 fc 79 10 80       	push   $0x801079fc
80104bbc:	e8 cf b7 ff ff       	call   80100390 <panic>
80104bc1:	eb 0d                	jmp    80104bd0 <argfd.constprop.0>
80104bc3:	90                   	nop
80104bc4:	90                   	nop
80104bc5:	90                   	nop
80104bc6:	90                   	nop
80104bc7:	90                   	nop
80104bc8:	90                   	nop
80104bc9:	90                   	nop
80104bca:	90                   	nop
80104bcb:	90                   	nop
80104bcc:	90                   	nop
80104bcd:	90                   	nop
80104bce:	90                   	nop
80104bcf:	90                   	nop

80104bd0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	56                   	push   %esi
80104bd4:	53                   	push   %ebx
80104bd5:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104bd7:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104bda:	89 d6                	mov    %edx,%esi
80104bdc:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104bdf:	50                   	push   %eax
80104be0:	6a 00                	push   $0x0
80104be2:	e8 f9 fc ff ff       	call   801048e0 <argint>
80104be7:	83 c4 10             	add    $0x10,%esp
80104bea:	85 c0                	test   %eax,%eax
80104bec:	78 2a                	js     80104c18 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104bee:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104bf2:	77 24                	ja     80104c18 <argfd.constprop.0+0x48>
80104bf4:	e8 c7 eb ff ff       	call   801037c0 <myproc>
80104bf9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104bfc:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104c00:	85 c0                	test   %eax,%eax
80104c02:	74 14                	je     80104c18 <argfd.constprop.0+0x48>
  if(pfd)
80104c04:	85 db                	test   %ebx,%ebx
80104c06:	74 02                	je     80104c0a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104c08:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80104c0a:	89 06                	mov    %eax,(%esi)
  return 0;
80104c0c:	31 c0                	xor    %eax,%eax
}
80104c0e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c11:	5b                   	pop    %ebx
80104c12:	5e                   	pop    %esi
80104c13:	5d                   	pop    %ebp
80104c14:	c3                   	ret    
80104c15:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104c18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c1d:	eb ef                	jmp    80104c0e <argfd.constprop.0+0x3e>
80104c1f:	90                   	nop

80104c20 <sys_dup>:
{
80104c20:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104c21:	31 c0                	xor    %eax,%eax
{
80104c23:	89 e5                	mov    %esp,%ebp
80104c25:	56                   	push   %esi
80104c26:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104c27:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104c2a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104c2d:	e8 9e ff ff ff       	call   80104bd0 <argfd.constprop.0>
80104c32:	85 c0                	test   %eax,%eax
80104c34:	78 42                	js     80104c78 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80104c36:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104c39:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104c3b:	e8 80 eb ff ff       	call   801037c0 <myproc>
80104c40:	eb 0e                	jmp    80104c50 <sys_dup+0x30>
80104c42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104c48:	83 c3 01             	add    $0x1,%ebx
80104c4b:	83 fb 10             	cmp    $0x10,%ebx
80104c4e:	74 28                	je     80104c78 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80104c50:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104c54:	85 d2                	test   %edx,%edx
80104c56:	75 f0                	jne    80104c48 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80104c58:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104c5c:	83 ec 0c             	sub    $0xc,%esp
80104c5f:	ff 75 f4             	pushl  -0xc(%ebp)
80104c62:	e8 99 c1 ff ff       	call   80100e00 <filedup>
  return fd;
80104c67:	83 c4 10             	add    $0x10,%esp
}
80104c6a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c6d:	89 d8                	mov    %ebx,%eax
80104c6f:	5b                   	pop    %ebx
80104c70:	5e                   	pop    %esi
80104c71:	5d                   	pop    %ebp
80104c72:	c3                   	ret    
80104c73:	90                   	nop
80104c74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c78:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104c7b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104c80:	89 d8                	mov    %ebx,%eax
80104c82:	5b                   	pop    %ebx
80104c83:	5e                   	pop    %esi
80104c84:	5d                   	pop    %ebp
80104c85:	c3                   	ret    
80104c86:	8d 76 00             	lea    0x0(%esi),%esi
80104c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c90 <sys_read>:
{
80104c90:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c91:	31 c0                	xor    %eax,%eax
{
80104c93:	89 e5                	mov    %esp,%ebp
80104c95:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c98:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104c9b:	e8 30 ff ff ff       	call   80104bd0 <argfd.constprop.0>
80104ca0:	85 c0                	test   %eax,%eax
80104ca2:	78 4c                	js     80104cf0 <sys_read+0x60>
80104ca4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104ca7:	83 ec 08             	sub    $0x8,%esp
80104caa:	50                   	push   %eax
80104cab:	6a 02                	push   $0x2
80104cad:	e8 2e fc ff ff       	call   801048e0 <argint>
80104cb2:	83 c4 10             	add    $0x10,%esp
80104cb5:	85 c0                	test   %eax,%eax
80104cb7:	78 37                	js     80104cf0 <sys_read+0x60>
80104cb9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104cbc:	83 ec 04             	sub    $0x4,%esp
80104cbf:	ff 75 f0             	pushl  -0x10(%ebp)
80104cc2:	50                   	push   %eax
80104cc3:	6a 01                	push   $0x1
80104cc5:	e8 66 fc ff ff       	call   80104930 <argptr>
80104cca:	83 c4 10             	add    $0x10,%esp
80104ccd:	85 c0                	test   %eax,%eax
80104ccf:	78 1f                	js     80104cf0 <sys_read+0x60>
  return fileread(f, p, n);
80104cd1:	83 ec 04             	sub    $0x4,%esp
80104cd4:	ff 75 f0             	pushl  -0x10(%ebp)
80104cd7:	ff 75 f4             	pushl  -0xc(%ebp)
80104cda:	ff 75 ec             	pushl  -0x14(%ebp)
80104cdd:	e8 8e c2 ff ff       	call   80100f70 <fileread>
80104ce2:	83 c4 10             	add    $0x10,%esp
}
80104ce5:	c9                   	leave  
80104ce6:	c3                   	ret    
80104ce7:	89 f6                	mov    %esi,%esi
80104ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104cf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104cf5:	c9                   	leave  
80104cf6:	c3                   	ret    
80104cf7:	89 f6                	mov    %esi,%esi
80104cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d00 <sys_write>:
{
80104d00:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d01:	31 c0                	xor    %eax,%eax
{
80104d03:	89 e5                	mov    %esp,%ebp
80104d05:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d08:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d0b:	e8 c0 fe ff ff       	call   80104bd0 <argfd.constprop.0>
80104d10:	85 c0                	test   %eax,%eax
80104d12:	78 4c                	js     80104d60 <sys_write+0x60>
80104d14:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d17:	83 ec 08             	sub    $0x8,%esp
80104d1a:	50                   	push   %eax
80104d1b:	6a 02                	push   $0x2
80104d1d:	e8 be fb ff ff       	call   801048e0 <argint>
80104d22:	83 c4 10             	add    $0x10,%esp
80104d25:	85 c0                	test   %eax,%eax
80104d27:	78 37                	js     80104d60 <sys_write+0x60>
80104d29:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d2c:	83 ec 04             	sub    $0x4,%esp
80104d2f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d32:	50                   	push   %eax
80104d33:	6a 01                	push   $0x1
80104d35:	e8 f6 fb ff ff       	call   80104930 <argptr>
80104d3a:	83 c4 10             	add    $0x10,%esp
80104d3d:	85 c0                	test   %eax,%eax
80104d3f:	78 1f                	js     80104d60 <sys_write+0x60>
  return filewrite(f, p, n);
80104d41:	83 ec 04             	sub    $0x4,%esp
80104d44:	ff 75 f0             	pushl  -0x10(%ebp)
80104d47:	ff 75 f4             	pushl  -0xc(%ebp)
80104d4a:	ff 75 ec             	pushl  -0x14(%ebp)
80104d4d:	e8 ae c2 ff ff       	call   80101000 <filewrite>
80104d52:	83 c4 10             	add    $0x10,%esp
}
80104d55:	c9                   	leave  
80104d56:	c3                   	ret    
80104d57:	89 f6                	mov    %esi,%esi
80104d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104d60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d65:	c9                   	leave  
80104d66:	c3                   	ret    
80104d67:	89 f6                	mov    %esi,%esi
80104d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d70 <sys_close>:
{
80104d70:	55                   	push   %ebp
80104d71:	89 e5                	mov    %esp,%ebp
80104d73:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104d76:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104d79:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d7c:	e8 4f fe ff ff       	call   80104bd0 <argfd.constprop.0>
80104d81:	85 c0                	test   %eax,%eax
80104d83:	78 2b                	js     80104db0 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80104d85:	e8 36 ea ff ff       	call   801037c0 <myproc>
80104d8a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104d8d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104d90:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104d97:	00 
  fileclose(f);
80104d98:	ff 75 f4             	pushl  -0xc(%ebp)
80104d9b:	e8 b0 c0 ff ff       	call   80100e50 <fileclose>
  return 0;
80104da0:	83 c4 10             	add    $0x10,%esp
80104da3:	31 c0                	xor    %eax,%eax
}
80104da5:	c9                   	leave  
80104da6:	c3                   	ret    
80104da7:	89 f6                	mov    %esi,%esi
80104da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104db0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104db5:	c9                   	leave  
80104db6:	c3                   	ret    
80104db7:	89 f6                	mov    %esi,%esi
80104db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104dc0 <sys_fstat>:
{
80104dc0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104dc1:	31 c0                	xor    %eax,%eax
{
80104dc3:	89 e5                	mov    %esp,%ebp
80104dc5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104dc8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104dcb:	e8 00 fe ff ff       	call   80104bd0 <argfd.constprop.0>
80104dd0:	85 c0                	test   %eax,%eax
80104dd2:	78 2c                	js     80104e00 <sys_fstat+0x40>
80104dd4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104dd7:	83 ec 04             	sub    $0x4,%esp
80104dda:	6a 14                	push   $0x14
80104ddc:	50                   	push   %eax
80104ddd:	6a 01                	push   $0x1
80104ddf:	e8 4c fb ff ff       	call   80104930 <argptr>
80104de4:	83 c4 10             	add    $0x10,%esp
80104de7:	85 c0                	test   %eax,%eax
80104de9:	78 15                	js     80104e00 <sys_fstat+0x40>
  return filestat(f, st);
80104deb:	83 ec 08             	sub    $0x8,%esp
80104dee:	ff 75 f4             	pushl  -0xc(%ebp)
80104df1:	ff 75 f0             	pushl  -0x10(%ebp)
80104df4:	e8 27 c1 ff ff       	call   80100f20 <filestat>
80104df9:	83 c4 10             	add    $0x10,%esp
}
80104dfc:	c9                   	leave  
80104dfd:	c3                   	ret    
80104dfe:	66 90                	xchg   %ax,%ax
    return -1;
80104e00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e05:	c9                   	leave  
80104e06:	c3                   	ret    
80104e07:	89 f6                	mov    %esi,%esi
80104e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e10 <sys_link>:
{
80104e10:	55                   	push   %ebp
80104e11:	89 e5                	mov    %esp,%ebp
80104e13:	57                   	push   %edi
80104e14:	56                   	push   %esi
80104e15:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e16:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104e19:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e1c:	50                   	push   %eax
80104e1d:	6a 00                	push   $0x0
80104e1f:	e8 6c fb ff ff       	call   80104990 <argstr>
80104e24:	83 c4 10             	add    $0x10,%esp
80104e27:	85 c0                	test   %eax,%eax
80104e29:	0f 88 fb 00 00 00    	js     80104f2a <sys_link+0x11a>
80104e2f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104e32:	83 ec 08             	sub    $0x8,%esp
80104e35:	50                   	push   %eax
80104e36:	6a 01                	push   $0x1
80104e38:	e8 53 fb ff ff       	call   80104990 <argstr>
80104e3d:	83 c4 10             	add    $0x10,%esp
80104e40:	85 c0                	test   %eax,%eax
80104e42:	0f 88 e2 00 00 00    	js     80104f2a <sys_link+0x11a>
  begin_op();
80104e48:	e8 73 dd ff ff       	call   80102bc0 <begin_op>
  if((ip = namei(old)) == 0){
80104e4d:	83 ec 0c             	sub    $0xc,%esp
80104e50:	ff 75 d4             	pushl  -0x2c(%ebp)
80104e53:	e8 a8 d0 ff ff       	call   80101f00 <namei>
80104e58:	83 c4 10             	add    $0x10,%esp
80104e5b:	85 c0                	test   %eax,%eax
80104e5d:	89 c3                	mov    %eax,%ebx
80104e5f:	0f 84 ea 00 00 00    	je     80104f4f <sys_link+0x13f>
  ilock(ip);
80104e65:	83 ec 0c             	sub    $0xc,%esp
80104e68:	50                   	push   %eax
80104e69:	e8 32 c8 ff ff       	call   801016a0 <ilock>
  if(ip->type == T_DIR){
80104e6e:	83 c4 10             	add    $0x10,%esp
80104e71:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104e76:	0f 84 bb 00 00 00    	je     80104f37 <sys_link+0x127>
  ip->nlink++;
80104e7c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104e81:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80104e84:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104e87:	53                   	push   %ebx
80104e88:	e8 63 c7 ff ff       	call   801015f0 <iupdate>
  iunlock(ip);
80104e8d:	89 1c 24             	mov    %ebx,(%esp)
80104e90:	e8 eb c8 ff ff       	call   80101780 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104e95:	58                   	pop    %eax
80104e96:	5a                   	pop    %edx
80104e97:	57                   	push   %edi
80104e98:	ff 75 d0             	pushl  -0x30(%ebp)
80104e9b:	e8 80 d0 ff ff       	call   80101f20 <nameiparent>
80104ea0:	83 c4 10             	add    $0x10,%esp
80104ea3:	85 c0                	test   %eax,%eax
80104ea5:	89 c6                	mov    %eax,%esi
80104ea7:	74 5b                	je     80104f04 <sys_link+0xf4>
  ilock(dp);
80104ea9:	83 ec 0c             	sub    $0xc,%esp
80104eac:	50                   	push   %eax
80104ead:	e8 ee c7 ff ff       	call   801016a0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104eb2:	83 c4 10             	add    $0x10,%esp
80104eb5:	8b 03                	mov    (%ebx),%eax
80104eb7:	39 06                	cmp    %eax,(%esi)
80104eb9:	75 3d                	jne    80104ef8 <sys_link+0xe8>
80104ebb:	83 ec 04             	sub    $0x4,%esp
80104ebe:	ff 73 04             	pushl  0x4(%ebx)
80104ec1:	57                   	push   %edi
80104ec2:	56                   	push   %esi
80104ec3:	e8 78 cf ff ff       	call   80101e40 <dirlink>
80104ec8:	83 c4 10             	add    $0x10,%esp
80104ecb:	85 c0                	test   %eax,%eax
80104ecd:	78 29                	js     80104ef8 <sys_link+0xe8>
  iunlockput(dp);
80104ecf:	83 ec 0c             	sub    $0xc,%esp
80104ed2:	56                   	push   %esi
80104ed3:	e8 58 ca ff ff       	call   80101930 <iunlockput>
  iput(ip);
80104ed8:	89 1c 24             	mov    %ebx,(%esp)
80104edb:	e8 f0 c8 ff ff       	call   801017d0 <iput>
  end_op();
80104ee0:	e8 4b dd ff ff       	call   80102c30 <end_op>
  return 0;
80104ee5:	83 c4 10             	add    $0x10,%esp
80104ee8:	31 c0                	xor    %eax,%eax
}
80104eea:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104eed:	5b                   	pop    %ebx
80104eee:	5e                   	pop    %esi
80104eef:	5f                   	pop    %edi
80104ef0:	5d                   	pop    %ebp
80104ef1:	c3                   	ret    
80104ef2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80104ef8:	83 ec 0c             	sub    $0xc,%esp
80104efb:	56                   	push   %esi
80104efc:	e8 2f ca ff ff       	call   80101930 <iunlockput>
    goto bad;
80104f01:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80104f04:	83 ec 0c             	sub    $0xc,%esp
80104f07:	53                   	push   %ebx
80104f08:	e8 93 c7 ff ff       	call   801016a0 <ilock>
  ip->nlink--;
80104f0d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f12:	89 1c 24             	mov    %ebx,(%esp)
80104f15:	e8 d6 c6 ff ff       	call   801015f0 <iupdate>
  iunlockput(ip);
80104f1a:	89 1c 24             	mov    %ebx,(%esp)
80104f1d:	e8 0e ca ff ff       	call   80101930 <iunlockput>
  end_op();
80104f22:	e8 09 dd ff ff       	call   80102c30 <end_op>
  return -1;
80104f27:	83 c4 10             	add    $0x10,%esp
}
80104f2a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104f2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f32:	5b                   	pop    %ebx
80104f33:	5e                   	pop    %esi
80104f34:	5f                   	pop    %edi
80104f35:	5d                   	pop    %ebp
80104f36:	c3                   	ret    
    iunlockput(ip);
80104f37:	83 ec 0c             	sub    $0xc,%esp
80104f3a:	53                   	push   %ebx
80104f3b:	e8 f0 c9 ff ff       	call   80101930 <iunlockput>
    end_op();
80104f40:	e8 eb dc ff ff       	call   80102c30 <end_op>
    return -1;
80104f45:	83 c4 10             	add    $0x10,%esp
80104f48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f4d:	eb 9b                	jmp    80104eea <sys_link+0xda>
    end_op();
80104f4f:	e8 dc dc ff ff       	call   80102c30 <end_op>
    return -1;
80104f54:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f59:	eb 8f                	jmp    80104eea <sys_link+0xda>
80104f5b:	90                   	nop
80104f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f60 <sys_unlink>:
{
80104f60:	55                   	push   %ebp
80104f61:	89 e5                	mov    %esp,%ebp
80104f63:	57                   	push   %edi
80104f64:	56                   	push   %esi
80104f65:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80104f66:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80104f69:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
80104f6c:	50                   	push   %eax
80104f6d:	6a 00                	push   $0x0
80104f6f:	e8 1c fa ff ff       	call   80104990 <argstr>
80104f74:	83 c4 10             	add    $0x10,%esp
80104f77:	85 c0                	test   %eax,%eax
80104f79:	0f 88 77 01 00 00    	js     801050f6 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
80104f7f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80104f82:	e8 39 dc ff ff       	call   80102bc0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104f87:	83 ec 08             	sub    $0x8,%esp
80104f8a:	53                   	push   %ebx
80104f8b:	ff 75 c0             	pushl  -0x40(%ebp)
80104f8e:	e8 8d cf ff ff       	call   80101f20 <nameiparent>
80104f93:	83 c4 10             	add    $0x10,%esp
80104f96:	85 c0                	test   %eax,%eax
80104f98:	89 c6                	mov    %eax,%esi
80104f9a:	0f 84 60 01 00 00    	je     80105100 <sys_unlink+0x1a0>
  ilock(dp);
80104fa0:	83 ec 0c             	sub    $0xc,%esp
80104fa3:	50                   	push   %eax
80104fa4:	e8 f7 c6 ff ff       	call   801016a0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104fa9:	58                   	pop    %eax
80104faa:	5a                   	pop    %edx
80104fab:	68 18 7a 10 80       	push   $0x80107a18
80104fb0:	53                   	push   %ebx
80104fb1:	e8 fa cb ff ff       	call   80101bb0 <namecmp>
80104fb6:	83 c4 10             	add    $0x10,%esp
80104fb9:	85 c0                	test   %eax,%eax
80104fbb:	0f 84 03 01 00 00    	je     801050c4 <sys_unlink+0x164>
80104fc1:	83 ec 08             	sub    $0x8,%esp
80104fc4:	68 17 7a 10 80       	push   $0x80107a17
80104fc9:	53                   	push   %ebx
80104fca:	e8 e1 cb ff ff       	call   80101bb0 <namecmp>
80104fcf:	83 c4 10             	add    $0x10,%esp
80104fd2:	85 c0                	test   %eax,%eax
80104fd4:	0f 84 ea 00 00 00    	je     801050c4 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
80104fda:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104fdd:	83 ec 04             	sub    $0x4,%esp
80104fe0:	50                   	push   %eax
80104fe1:	53                   	push   %ebx
80104fe2:	56                   	push   %esi
80104fe3:	e8 e8 cb ff ff       	call   80101bd0 <dirlookup>
80104fe8:	83 c4 10             	add    $0x10,%esp
80104feb:	85 c0                	test   %eax,%eax
80104fed:	89 c3                	mov    %eax,%ebx
80104fef:	0f 84 cf 00 00 00    	je     801050c4 <sys_unlink+0x164>
  ilock(ip);
80104ff5:	83 ec 0c             	sub    $0xc,%esp
80104ff8:	50                   	push   %eax
80104ff9:	e8 a2 c6 ff ff       	call   801016a0 <ilock>
  if(ip->nlink < 1)
80104ffe:	83 c4 10             	add    $0x10,%esp
80105001:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105006:	0f 8e 10 01 00 00    	jle    8010511c <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010500c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105011:	74 6d                	je     80105080 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105013:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105016:	83 ec 04             	sub    $0x4,%esp
80105019:	6a 10                	push   $0x10
8010501b:	6a 00                	push   $0x0
8010501d:	50                   	push   %eax
8010501e:	e8 bd f5 ff ff       	call   801045e0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105023:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105026:	6a 10                	push   $0x10
80105028:	ff 75 c4             	pushl  -0x3c(%ebp)
8010502b:	50                   	push   %eax
8010502c:	56                   	push   %esi
8010502d:	e8 4e ca ff ff       	call   80101a80 <writei>
80105032:	83 c4 20             	add    $0x20,%esp
80105035:	83 f8 10             	cmp    $0x10,%eax
80105038:	0f 85 eb 00 00 00    	jne    80105129 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
8010503e:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105043:	0f 84 97 00 00 00    	je     801050e0 <sys_unlink+0x180>
  iunlockput(dp);
80105049:	83 ec 0c             	sub    $0xc,%esp
8010504c:	56                   	push   %esi
8010504d:	e8 de c8 ff ff       	call   80101930 <iunlockput>
  ip->nlink--;
80105052:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105057:	89 1c 24             	mov    %ebx,(%esp)
8010505a:	e8 91 c5 ff ff       	call   801015f0 <iupdate>
  iunlockput(ip);
8010505f:	89 1c 24             	mov    %ebx,(%esp)
80105062:	e8 c9 c8 ff ff       	call   80101930 <iunlockput>
  end_op();
80105067:	e8 c4 db ff ff       	call   80102c30 <end_op>
  return 0;
8010506c:	83 c4 10             	add    $0x10,%esp
8010506f:	31 c0                	xor    %eax,%eax
}
80105071:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105074:	5b                   	pop    %ebx
80105075:	5e                   	pop    %esi
80105076:	5f                   	pop    %edi
80105077:	5d                   	pop    %ebp
80105078:	c3                   	ret    
80105079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105080:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105084:	76 8d                	jbe    80105013 <sys_unlink+0xb3>
80105086:	bf 20 00 00 00       	mov    $0x20,%edi
8010508b:	eb 0f                	jmp    8010509c <sys_unlink+0x13c>
8010508d:	8d 76 00             	lea    0x0(%esi),%esi
80105090:	83 c7 10             	add    $0x10,%edi
80105093:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105096:	0f 83 77 ff ff ff    	jae    80105013 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010509c:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010509f:	6a 10                	push   $0x10
801050a1:	57                   	push   %edi
801050a2:	50                   	push   %eax
801050a3:	53                   	push   %ebx
801050a4:	e8 d7 c8 ff ff       	call   80101980 <readi>
801050a9:	83 c4 10             	add    $0x10,%esp
801050ac:	83 f8 10             	cmp    $0x10,%eax
801050af:	75 5e                	jne    8010510f <sys_unlink+0x1af>
    if(de.inum != 0)
801050b1:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801050b6:	74 d8                	je     80105090 <sys_unlink+0x130>
    iunlockput(ip);
801050b8:	83 ec 0c             	sub    $0xc,%esp
801050bb:	53                   	push   %ebx
801050bc:	e8 6f c8 ff ff       	call   80101930 <iunlockput>
    goto bad;
801050c1:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
801050c4:	83 ec 0c             	sub    $0xc,%esp
801050c7:	56                   	push   %esi
801050c8:	e8 63 c8 ff ff       	call   80101930 <iunlockput>
  end_op();
801050cd:	e8 5e db ff ff       	call   80102c30 <end_op>
  return -1;
801050d2:	83 c4 10             	add    $0x10,%esp
801050d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050da:	eb 95                	jmp    80105071 <sys_unlink+0x111>
801050dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
801050e0:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
801050e5:	83 ec 0c             	sub    $0xc,%esp
801050e8:	56                   	push   %esi
801050e9:	e8 02 c5 ff ff       	call   801015f0 <iupdate>
801050ee:	83 c4 10             	add    $0x10,%esp
801050f1:	e9 53 ff ff ff       	jmp    80105049 <sys_unlink+0xe9>
    return -1;
801050f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050fb:	e9 71 ff ff ff       	jmp    80105071 <sys_unlink+0x111>
    end_op();
80105100:	e8 2b db ff ff       	call   80102c30 <end_op>
    return -1;
80105105:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010510a:	e9 62 ff ff ff       	jmp    80105071 <sys_unlink+0x111>
      panic("isdirempty: readi");
8010510f:	83 ec 0c             	sub    $0xc,%esp
80105112:	68 3c 7a 10 80       	push   $0x80107a3c
80105117:	e8 74 b2 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
8010511c:	83 ec 0c             	sub    $0xc,%esp
8010511f:	68 2a 7a 10 80       	push   $0x80107a2a
80105124:	e8 67 b2 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105129:	83 ec 0c             	sub    $0xc,%esp
8010512c:	68 4e 7a 10 80       	push   $0x80107a4e
80105131:	e8 5a b2 ff ff       	call   80100390 <panic>
80105136:	8d 76 00             	lea    0x0(%esi),%esi
80105139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105140 <sys_open>:

int
sys_open(void)
{
80105140:	55                   	push   %ebp
80105141:	89 e5                	mov    %esp,%ebp
80105143:	57                   	push   %edi
80105144:	56                   	push   %esi
80105145:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105146:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105149:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010514c:	50                   	push   %eax
8010514d:	6a 00                	push   $0x0
8010514f:	e8 3c f8 ff ff       	call   80104990 <argstr>
80105154:	83 c4 10             	add    $0x10,%esp
80105157:	85 c0                	test   %eax,%eax
80105159:	0f 88 1d 01 00 00    	js     8010527c <sys_open+0x13c>
8010515f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105162:	83 ec 08             	sub    $0x8,%esp
80105165:	50                   	push   %eax
80105166:	6a 01                	push   $0x1
80105168:	e8 73 f7 ff ff       	call   801048e0 <argint>
8010516d:	83 c4 10             	add    $0x10,%esp
80105170:	85 c0                	test   %eax,%eax
80105172:	0f 88 04 01 00 00    	js     8010527c <sys_open+0x13c>
    return -1;

  begin_op();
80105178:	e8 43 da ff ff       	call   80102bc0 <begin_op>

  if(omode & O_CREATE){
8010517d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105181:	0f 85 a9 00 00 00    	jne    80105230 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105187:	83 ec 0c             	sub    $0xc,%esp
8010518a:	ff 75 e0             	pushl  -0x20(%ebp)
8010518d:	e8 6e cd ff ff       	call   80101f00 <namei>
80105192:	83 c4 10             	add    $0x10,%esp
80105195:	85 c0                	test   %eax,%eax
80105197:	89 c6                	mov    %eax,%esi
80105199:	0f 84 b2 00 00 00    	je     80105251 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
8010519f:	83 ec 0c             	sub    $0xc,%esp
801051a2:	50                   	push   %eax
801051a3:	e8 f8 c4 ff ff       	call   801016a0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801051a8:	83 c4 10             	add    $0x10,%esp
801051ab:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801051b0:	0f 84 aa 00 00 00    	je     80105260 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801051b6:	e8 d5 bb ff ff       	call   80100d90 <filealloc>
801051bb:	85 c0                	test   %eax,%eax
801051bd:	89 c7                	mov    %eax,%edi
801051bf:	0f 84 a6 00 00 00    	je     8010526b <sys_open+0x12b>
  struct proc *curproc = myproc();
801051c5:	e8 f6 e5 ff ff       	call   801037c0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801051ca:	31 db                	xor    %ebx,%ebx
801051cc:	eb 0e                	jmp    801051dc <sys_open+0x9c>
801051ce:	66 90                	xchg   %ax,%ax
801051d0:	83 c3 01             	add    $0x1,%ebx
801051d3:	83 fb 10             	cmp    $0x10,%ebx
801051d6:	0f 84 ac 00 00 00    	je     80105288 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
801051dc:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801051e0:	85 d2                	test   %edx,%edx
801051e2:	75 ec                	jne    801051d0 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801051e4:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801051e7:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
801051eb:	56                   	push   %esi
801051ec:	e8 8f c5 ff ff       	call   80101780 <iunlock>
  end_op();
801051f1:	e8 3a da ff ff       	call   80102c30 <end_op>

  f->type = FD_INODE;
801051f6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801051fc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801051ff:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105202:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105205:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010520c:	89 d0                	mov    %edx,%eax
8010520e:	f7 d0                	not    %eax
80105210:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105213:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105216:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105219:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
8010521d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105220:	89 d8                	mov    %ebx,%eax
80105222:	5b                   	pop    %ebx
80105223:	5e                   	pop    %esi
80105224:	5f                   	pop    %edi
80105225:	5d                   	pop    %ebp
80105226:	c3                   	ret    
80105227:	89 f6                	mov    %esi,%esi
80105229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105230:	83 ec 0c             	sub    $0xc,%esp
80105233:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105236:	31 c9                	xor    %ecx,%ecx
80105238:	6a 00                	push   $0x0
8010523a:	ba 02 00 00 00       	mov    $0x2,%edx
8010523f:	e8 ec f7 ff ff       	call   80104a30 <create>
    if(ip == 0){
80105244:	83 c4 10             	add    $0x10,%esp
80105247:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105249:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010524b:	0f 85 65 ff ff ff    	jne    801051b6 <sys_open+0x76>
      end_op();
80105251:	e8 da d9 ff ff       	call   80102c30 <end_op>
      return -1;
80105256:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010525b:	eb c0                	jmp    8010521d <sys_open+0xdd>
8010525d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105260:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105263:	85 c9                	test   %ecx,%ecx
80105265:	0f 84 4b ff ff ff    	je     801051b6 <sys_open+0x76>
    iunlockput(ip);
8010526b:	83 ec 0c             	sub    $0xc,%esp
8010526e:	56                   	push   %esi
8010526f:	e8 bc c6 ff ff       	call   80101930 <iunlockput>
    end_op();
80105274:	e8 b7 d9 ff ff       	call   80102c30 <end_op>
    return -1;
80105279:	83 c4 10             	add    $0x10,%esp
8010527c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105281:	eb 9a                	jmp    8010521d <sys_open+0xdd>
80105283:	90                   	nop
80105284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105288:	83 ec 0c             	sub    $0xc,%esp
8010528b:	57                   	push   %edi
8010528c:	e8 bf bb ff ff       	call   80100e50 <fileclose>
80105291:	83 c4 10             	add    $0x10,%esp
80105294:	eb d5                	jmp    8010526b <sys_open+0x12b>
80105296:	8d 76 00             	lea    0x0(%esi),%esi
80105299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052a0 <sys_mkdir>:

int
sys_mkdir(void)
{
801052a0:	55                   	push   %ebp
801052a1:	89 e5                	mov    %esp,%ebp
801052a3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801052a6:	e8 15 d9 ff ff       	call   80102bc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801052ab:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052ae:	83 ec 08             	sub    $0x8,%esp
801052b1:	50                   	push   %eax
801052b2:	6a 00                	push   $0x0
801052b4:	e8 d7 f6 ff ff       	call   80104990 <argstr>
801052b9:	83 c4 10             	add    $0x10,%esp
801052bc:	85 c0                	test   %eax,%eax
801052be:	78 30                	js     801052f0 <sys_mkdir+0x50>
801052c0:	83 ec 0c             	sub    $0xc,%esp
801052c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052c6:	31 c9                	xor    %ecx,%ecx
801052c8:	6a 00                	push   $0x0
801052ca:	ba 01 00 00 00       	mov    $0x1,%edx
801052cf:	e8 5c f7 ff ff       	call   80104a30 <create>
801052d4:	83 c4 10             	add    $0x10,%esp
801052d7:	85 c0                	test   %eax,%eax
801052d9:	74 15                	je     801052f0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801052db:	83 ec 0c             	sub    $0xc,%esp
801052de:	50                   	push   %eax
801052df:	e8 4c c6 ff ff       	call   80101930 <iunlockput>
  end_op();
801052e4:	e8 47 d9 ff ff       	call   80102c30 <end_op>
  return 0;
801052e9:	83 c4 10             	add    $0x10,%esp
801052ec:	31 c0                	xor    %eax,%eax
}
801052ee:	c9                   	leave  
801052ef:	c3                   	ret    
    end_op();
801052f0:	e8 3b d9 ff ff       	call   80102c30 <end_op>
    return -1;
801052f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801052fa:	c9                   	leave  
801052fb:	c3                   	ret    
801052fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105300 <sys_mknod>:

int
sys_mknod(void)
{
80105300:	55                   	push   %ebp
80105301:	89 e5                	mov    %esp,%ebp
80105303:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105306:	e8 b5 d8 ff ff       	call   80102bc0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010530b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010530e:	83 ec 08             	sub    $0x8,%esp
80105311:	50                   	push   %eax
80105312:	6a 00                	push   $0x0
80105314:	e8 77 f6 ff ff       	call   80104990 <argstr>
80105319:	83 c4 10             	add    $0x10,%esp
8010531c:	85 c0                	test   %eax,%eax
8010531e:	78 60                	js     80105380 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105320:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105323:	83 ec 08             	sub    $0x8,%esp
80105326:	50                   	push   %eax
80105327:	6a 01                	push   $0x1
80105329:	e8 b2 f5 ff ff       	call   801048e0 <argint>
  if((argstr(0, &path)) < 0 ||
8010532e:	83 c4 10             	add    $0x10,%esp
80105331:	85 c0                	test   %eax,%eax
80105333:	78 4b                	js     80105380 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105335:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105338:	83 ec 08             	sub    $0x8,%esp
8010533b:	50                   	push   %eax
8010533c:	6a 02                	push   $0x2
8010533e:	e8 9d f5 ff ff       	call   801048e0 <argint>
     argint(1, &major) < 0 ||
80105343:	83 c4 10             	add    $0x10,%esp
80105346:	85 c0                	test   %eax,%eax
80105348:	78 36                	js     80105380 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010534a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
8010534e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105351:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105355:	ba 03 00 00 00       	mov    $0x3,%edx
8010535a:	50                   	push   %eax
8010535b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010535e:	e8 cd f6 ff ff       	call   80104a30 <create>
80105363:	83 c4 10             	add    $0x10,%esp
80105366:	85 c0                	test   %eax,%eax
80105368:	74 16                	je     80105380 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010536a:	83 ec 0c             	sub    $0xc,%esp
8010536d:	50                   	push   %eax
8010536e:	e8 bd c5 ff ff       	call   80101930 <iunlockput>
  end_op();
80105373:	e8 b8 d8 ff ff       	call   80102c30 <end_op>
  return 0;
80105378:	83 c4 10             	add    $0x10,%esp
8010537b:	31 c0                	xor    %eax,%eax
}
8010537d:	c9                   	leave  
8010537e:	c3                   	ret    
8010537f:	90                   	nop
    end_op();
80105380:	e8 ab d8 ff ff       	call   80102c30 <end_op>
    return -1;
80105385:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010538a:	c9                   	leave  
8010538b:	c3                   	ret    
8010538c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105390 <sys_chdir>:

int
sys_chdir(void)
{
80105390:	55                   	push   %ebp
80105391:	89 e5                	mov    %esp,%ebp
80105393:	56                   	push   %esi
80105394:	53                   	push   %ebx
80105395:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105398:	e8 23 e4 ff ff       	call   801037c0 <myproc>
8010539d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010539f:	e8 1c d8 ff ff       	call   80102bc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801053a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053a7:	83 ec 08             	sub    $0x8,%esp
801053aa:	50                   	push   %eax
801053ab:	6a 00                	push   $0x0
801053ad:	e8 de f5 ff ff       	call   80104990 <argstr>
801053b2:	83 c4 10             	add    $0x10,%esp
801053b5:	85 c0                	test   %eax,%eax
801053b7:	78 77                	js     80105430 <sys_chdir+0xa0>
801053b9:	83 ec 0c             	sub    $0xc,%esp
801053bc:	ff 75 f4             	pushl  -0xc(%ebp)
801053bf:	e8 3c cb ff ff       	call   80101f00 <namei>
801053c4:	83 c4 10             	add    $0x10,%esp
801053c7:	85 c0                	test   %eax,%eax
801053c9:	89 c3                	mov    %eax,%ebx
801053cb:	74 63                	je     80105430 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801053cd:	83 ec 0c             	sub    $0xc,%esp
801053d0:	50                   	push   %eax
801053d1:	e8 ca c2 ff ff       	call   801016a0 <ilock>
  if(ip->type != T_DIR){
801053d6:	83 c4 10             	add    $0x10,%esp
801053d9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801053de:	75 30                	jne    80105410 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801053e0:	83 ec 0c             	sub    $0xc,%esp
801053e3:	53                   	push   %ebx
801053e4:	e8 97 c3 ff ff       	call   80101780 <iunlock>
  iput(curproc->cwd);
801053e9:	58                   	pop    %eax
801053ea:	ff 76 68             	pushl  0x68(%esi)
801053ed:	e8 de c3 ff ff       	call   801017d0 <iput>
  end_op();
801053f2:	e8 39 d8 ff ff       	call   80102c30 <end_op>
  curproc->cwd = ip;
801053f7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
801053fa:	83 c4 10             	add    $0x10,%esp
801053fd:	31 c0                	xor    %eax,%eax
}
801053ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105402:	5b                   	pop    %ebx
80105403:	5e                   	pop    %esi
80105404:	5d                   	pop    %ebp
80105405:	c3                   	ret    
80105406:	8d 76 00             	lea    0x0(%esi),%esi
80105409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105410:	83 ec 0c             	sub    $0xc,%esp
80105413:	53                   	push   %ebx
80105414:	e8 17 c5 ff ff       	call   80101930 <iunlockput>
    end_op();
80105419:	e8 12 d8 ff ff       	call   80102c30 <end_op>
    return -1;
8010541e:	83 c4 10             	add    $0x10,%esp
80105421:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105426:	eb d7                	jmp    801053ff <sys_chdir+0x6f>
80105428:	90                   	nop
80105429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105430:	e8 fb d7 ff ff       	call   80102c30 <end_op>
    return -1;
80105435:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010543a:	eb c3                	jmp    801053ff <sys_chdir+0x6f>
8010543c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105440 <sys_exec>:

int
sys_exec(void)
{
80105440:	55                   	push   %ebp
80105441:	89 e5                	mov    %esp,%ebp
80105443:	57                   	push   %edi
80105444:	56                   	push   %esi
80105445:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105446:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010544c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105452:	50                   	push   %eax
80105453:	6a 00                	push   $0x0
80105455:	e8 36 f5 ff ff       	call   80104990 <argstr>
8010545a:	83 c4 10             	add    $0x10,%esp
8010545d:	85 c0                	test   %eax,%eax
8010545f:	0f 88 87 00 00 00    	js     801054ec <sys_exec+0xac>
80105465:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010546b:	83 ec 08             	sub    $0x8,%esp
8010546e:	50                   	push   %eax
8010546f:	6a 01                	push   $0x1
80105471:	e8 6a f4 ff ff       	call   801048e0 <argint>
80105476:	83 c4 10             	add    $0x10,%esp
80105479:	85 c0                	test   %eax,%eax
8010547b:	78 6f                	js     801054ec <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010547d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105483:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105486:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105488:	68 80 00 00 00       	push   $0x80
8010548d:	6a 00                	push   $0x0
8010548f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105495:	50                   	push   %eax
80105496:	e8 45 f1 ff ff       	call   801045e0 <memset>
8010549b:	83 c4 10             	add    $0x10,%esp
8010549e:	eb 2c                	jmp    801054cc <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
801054a0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801054a6:	85 c0                	test   %eax,%eax
801054a8:	74 56                	je     80105500 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801054aa:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801054b0:	83 ec 08             	sub    $0x8,%esp
801054b3:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801054b6:	52                   	push   %edx
801054b7:	50                   	push   %eax
801054b8:	e8 b3 f3 ff ff       	call   80104870 <fetchstr>
801054bd:	83 c4 10             	add    $0x10,%esp
801054c0:	85 c0                	test   %eax,%eax
801054c2:	78 28                	js     801054ec <sys_exec+0xac>
  for(i=0;; i++){
801054c4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801054c7:	83 fb 20             	cmp    $0x20,%ebx
801054ca:	74 20                	je     801054ec <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801054cc:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801054d2:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
801054d9:	83 ec 08             	sub    $0x8,%esp
801054dc:	57                   	push   %edi
801054dd:	01 f0                	add    %esi,%eax
801054df:	50                   	push   %eax
801054e0:	e8 4b f3 ff ff       	call   80104830 <fetchint>
801054e5:	83 c4 10             	add    $0x10,%esp
801054e8:	85 c0                	test   %eax,%eax
801054ea:	79 b4                	jns    801054a0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
801054ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801054ef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054f4:	5b                   	pop    %ebx
801054f5:	5e                   	pop    %esi
801054f6:	5f                   	pop    %edi
801054f7:	5d                   	pop    %ebp
801054f8:	c3                   	ret    
801054f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105500:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105506:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105509:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105510:	00 00 00 00 
  return exec(path, argv);
80105514:	50                   	push   %eax
80105515:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010551b:	e8 00 b5 ff ff       	call   80100a20 <exec>
80105520:	83 c4 10             	add    $0x10,%esp
}
80105523:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105526:	5b                   	pop    %ebx
80105527:	5e                   	pop    %esi
80105528:	5f                   	pop    %edi
80105529:	5d                   	pop    %ebp
8010552a:	c3                   	ret    
8010552b:	90                   	nop
8010552c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105530 <sys_pipe>:

int
sys_pipe(void)
{
80105530:	55                   	push   %ebp
80105531:	89 e5                	mov    %esp,%ebp
80105533:	57                   	push   %edi
80105534:	56                   	push   %esi
80105535:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105536:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105539:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010553c:	6a 08                	push   $0x8
8010553e:	50                   	push   %eax
8010553f:	6a 00                	push   $0x0
80105541:	e8 ea f3 ff ff       	call   80104930 <argptr>
80105546:	83 c4 10             	add    $0x10,%esp
80105549:	85 c0                	test   %eax,%eax
8010554b:	0f 88 ae 00 00 00    	js     801055ff <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105551:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105554:	83 ec 08             	sub    $0x8,%esp
80105557:	50                   	push   %eax
80105558:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010555b:	50                   	push   %eax
8010555c:	e8 ef dc ff ff       	call   80103250 <pipealloc>
80105561:	83 c4 10             	add    $0x10,%esp
80105564:	85 c0                	test   %eax,%eax
80105566:	0f 88 93 00 00 00    	js     801055ff <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010556c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010556f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105571:	e8 4a e2 ff ff       	call   801037c0 <myproc>
80105576:	eb 10                	jmp    80105588 <sys_pipe+0x58>
80105578:	90                   	nop
80105579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105580:	83 c3 01             	add    $0x1,%ebx
80105583:	83 fb 10             	cmp    $0x10,%ebx
80105586:	74 60                	je     801055e8 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105588:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010558c:	85 f6                	test   %esi,%esi
8010558e:	75 f0                	jne    80105580 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105590:	8d 73 08             	lea    0x8(%ebx),%esi
80105593:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105597:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010559a:	e8 21 e2 ff ff       	call   801037c0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010559f:	31 d2                	xor    %edx,%edx
801055a1:	eb 0d                	jmp    801055b0 <sys_pipe+0x80>
801055a3:	90                   	nop
801055a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801055a8:	83 c2 01             	add    $0x1,%edx
801055ab:	83 fa 10             	cmp    $0x10,%edx
801055ae:	74 28                	je     801055d8 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
801055b0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801055b4:	85 c9                	test   %ecx,%ecx
801055b6:	75 f0                	jne    801055a8 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
801055b8:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801055bc:	8b 45 dc             	mov    -0x24(%ebp),%eax
801055bf:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801055c1:	8b 45 dc             	mov    -0x24(%ebp),%eax
801055c4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801055c7:	31 c0                	xor    %eax,%eax
}
801055c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055cc:	5b                   	pop    %ebx
801055cd:	5e                   	pop    %esi
801055ce:	5f                   	pop    %edi
801055cf:	5d                   	pop    %ebp
801055d0:	c3                   	ret    
801055d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
801055d8:	e8 e3 e1 ff ff       	call   801037c0 <myproc>
801055dd:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801055e4:	00 
801055e5:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
801055e8:	83 ec 0c             	sub    $0xc,%esp
801055eb:	ff 75 e0             	pushl  -0x20(%ebp)
801055ee:	e8 5d b8 ff ff       	call   80100e50 <fileclose>
    fileclose(wf);
801055f3:	58                   	pop    %eax
801055f4:	ff 75 e4             	pushl  -0x1c(%ebp)
801055f7:	e8 54 b8 ff ff       	call   80100e50 <fileclose>
    return -1;
801055fc:	83 c4 10             	add    $0x10,%esp
801055ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105604:	eb c3                	jmp    801055c9 <sys_pipe+0x99>
80105606:	66 90                	xchg   %ax,%ax
80105608:	66 90                	xchg   %ax,%ax
8010560a:	66 90                	xchg   %ax,%ax
8010560c:	66 90                	xchg   %ax,%ax
8010560e:	66 90                	xchg   %ax,%ax

80105610 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105610:	55                   	push   %ebp
80105611:	89 e5                	mov    %esp,%ebp
80105613:	83 ec 20             	sub    $0x20,%esp
  int tickets;

  if(argint(0, &tickets) < 0)
80105616:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105619:	50                   	push   %eax
8010561a:	6a 00                	push   $0x0
8010561c:	e8 bf f2 ff ff       	call   801048e0 <argint>
80105621:	83 c4 10             	add    $0x10,%esp
80105624:	85 c0                	test   %eax,%eax
80105626:	78 18                	js     80105640 <sys_fork+0x30>
    return -1;
  return fork(tickets);
80105628:	83 ec 0c             	sub    $0xc,%esp
8010562b:	ff 75 f4             	pushl  -0xc(%ebp)
8010562e:	e8 2d e3 ff ff       	call   80103960 <fork>
80105633:	83 c4 10             	add    $0x10,%esp
}
80105636:	c9                   	leave  
80105637:	c3                   	ret    
80105638:	90                   	nop
80105639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105640:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105645:	c9                   	leave  
80105646:	c3                   	ret    
80105647:	89 f6                	mov    %esi,%esi
80105649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105650 <sys_exit>:

int
sys_exit(void)
{
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	83 ec 08             	sub    $0x8,%esp
  exit();
80105656:	e8 55 e5 ff ff       	call   80103bb0 <exit>
  return 0;  // not reached
}
8010565b:	31 c0                	xor    %eax,%eax
8010565d:	c9                   	leave  
8010565e:	c3                   	ret    
8010565f:	90                   	nop

80105660 <sys_wait>:

int
sys_wait(void)
{
80105660:	55                   	push   %ebp
80105661:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105663:	5d                   	pop    %ebp
  return wait();
80105664:	e9 87 e7 ff ff       	jmp    80103df0 <wait>
80105669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105670 <sys_kill>:

int
sys_kill(void)
{
80105670:	55                   	push   %ebp
80105671:	89 e5                	mov    %esp,%ebp
80105673:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105676:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105679:	50                   	push   %eax
8010567a:	6a 00                	push   $0x0
8010567c:	e8 5f f2 ff ff       	call   801048e0 <argint>
80105681:	83 c4 10             	add    $0x10,%esp
80105684:	85 c0                	test   %eax,%eax
80105686:	78 18                	js     801056a0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105688:	83 ec 0c             	sub    $0xc,%esp
8010568b:	ff 75 f4             	pushl  -0xc(%ebp)
8010568e:	e8 ad e8 ff ff       	call   80103f40 <kill>
80105693:	83 c4 10             	add    $0x10,%esp
}
80105696:	c9                   	leave  
80105697:	c3                   	ret    
80105698:	90                   	nop
80105699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801056a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056a5:	c9                   	leave  
801056a6:	c3                   	ret    
801056a7:	89 f6                	mov    %esi,%esi
801056a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056b0 <sys_getpid>:

int
sys_getpid(void)
{
801056b0:	55                   	push   %ebp
801056b1:	89 e5                	mov    %esp,%ebp
801056b3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801056b6:	e8 05 e1 ff ff       	call   801037c0 <myproc>
801056bb:	8b 40 10             	mov    0x10(%eax),%eax
}
801056be:	c9                   	leave  
801056bf:	c3                   	ret    

801056c0 <sys_sbrk>:

int
sys_sbrk(void)
{
801056c0:	55                   	push   %ebp
801056c1:	89 e5                	mov    %esp,%ebp
801056c3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801056c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801056c7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801056ca:	50                   	push   %eax
801056cb:	6a 00                	push   $0x0
801056cd:	e8 0e f2 ff ff       	call   801048e0 <argint>
801056d2:	83 c4 10             	add    $0x10,%esp
801056d5:	85 c0                	test   %eax,%eax
801056d7:	78 27                	js     80105700 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801056d9:	e8 e2 e0 ff ff       	call   801037c0 <myproc>
  if(growproc(n) < 0)
801056de:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801056e1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801056e3:	ff 75 f4             	pushl  -0xc(%ebp)
801056e6:	e8 f5 e1 ff ff       	call   801038e0 <growproc>
801056eb:	83 c4 10             	add    $0x10,%esp
801056ee:	85 c0                	test   %eax,%eax
801056f0:	78 0e                	js     80105700 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801056f2:	89 d8                	mov    %ebx,%eax
801056f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056f7:	c9                   	leave  
801056f8:	c3                   	ret    
801056f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105700:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105705:	eb eb                	jmp    801056f2 <sys_sbrk+0x32>
80105707:	89 f6                	mov    %esi,%esi
80105709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105710 <sys_sleep>:

int
sys_sleep(void)
{
80105710:	55                   	push   %ebp
80105711:	89 e5                	mov    %esp,%ebp
80105713:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105714:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105717:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010571a:	50                   	push   %eax
8010571b:	6a 00                	push   $0x0
8010571d:	e8 be f1 ff ff       	call   801048e0 <argint>
80105722:	83 c4 10             	add    $0x10,%esp
80105725:	85 c0                	test   %eax,%eax
80105727:	0f 88 8a 00 00 00    	js     801057b7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010572d:	83 ec 0c             	sub    $0xc,%esp
80105730:	68 40 52 11 80       	push   $0x80115240
80105735:	e8 96 ed ff ff       	call   801044d0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010573a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010573d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105740:	8b 1d 80 5a 11 80    	mov    0x80115a80,%ebx
  while(ticks - ticks0 < n){
80105746:	85 d2                	test   %edx,%edx
80105748:	75 27                	jne    80105771 <sys_sleep+0x61>
8010574a:	eb 54                	jmp    801057a0 <sys_sleep+0x90>
8010574c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105750:	83 ec 08             	sub    $0x8,%esp
80105753:	68 40 52 11 80       	push   $0x80115240
80105758:	68 80 5a 11 80       	push   $0x80115a80
8010575d:	e8 ce e5 ff ff       	call   80103d30 <sleep>
  while(ticks - ticks0 < n){
80105762:	a1 80 5a 11 80       	mov    0x80115a80,%eax
80105767:	83 c4 10             	add    $0x10,%esp
8010576a:	29 d8                	sub    %ebx,%eax
8010576c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010576f:	73 2f                	jae    801057a0 <sys_sleep+0x90>
    if(myproc()->killed){
80105771:	e8 4a e0 ff ff       	call   801037c0 <myproc>
80105776:	8b 40 24             	mov    0x24(%eax),%eax
80105779:	85 c0                	test   %eax,%eax
8010577b:	74 d3                	je     80105750 <sys_sleep+0x40>
      release(&tickslock);
8010577d:	83 ec 0c             	sub    $0xc,%esp
80105780:	68 40 52 11 80       	push   $0x80115240
80105785:	e8 06 ee ff ff       	call   80104590 <release>
      return -1;
8010578a:	83 c4 10             	add    $0x10,%esp
8010578d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105792:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105795:	c9                   	leave  
80105796:	c3                   	ret    
80105797:	89 f6                	mov    %esi,%esi
80105799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
801057a0:	83 ec 0c             	sub    $0xc,%esp
801057a3:	68 40 52 11 80       	push   $0x80115240
801057a8:	e8 e3 ed ff ff       	call   80104590 <release>
  return 0;
801057ad:	83 c4 10             	add    $0x10,%esp
801057b0:	31 c0                	xor    %eax,%eax
}
801057b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057b5:	c9                   	leave  
801057b6:	c3                   	ret    
    return -1;
801057b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057bc:	eb f4                	jmp    801057b2 <sys_sleep+0xa2>
801057be:	66 90                	xchg   %ax,%ax

801057c0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	53                   	push   %ebx
801057c4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801057c7:	68 40 52 11 80       	push   $0x80115240
801057cc:	e8 ff ec ff ff       	call   801044d0 <acquire>
  xticks = ticks;
801057d1:	8b 1d 80 5a 11 80    	mov    0x80115a80,%ebx
  release(&tickslock);
801057d7:	c7 04 24 40 52 11 80 	movl   $0x80115240,(%esp)
801057de:	e8 ad ed ff ff       	call   80104590 <release>
  return xticks;
}
801057e3:	89 d8                	mov    %ebx,%eax
801057e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057e8:	c9                   	leave  
801057e9:	c3                   	ret    
801057ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801057f0 <sys_lottery>:

int sys_lottery(void)
{
801057f0:	55                   	push   %ebp
801057f1:	89 e5                	mov    %esp,%ebp
801057f3:	83 ec 20             	sub    $0x20,%esp
  int n;

  if(argint(0, &n) < 0)
801057f6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057f9:	50                   	push   %eax
801057fa:	6a 00                	push   $0x0
801057fc:	e8 df f0 ff ff       	call   801048e0 <argint>
      return  -1;
  }

  return 0;

}
80105801:	c9                   	leave  
  if(argint(0, &n) < 0)
80105802:	c1 f8 1f             	sar    $0x1f,%eax
}
80105805:	c3                   	ret    

80105806 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105806:	1e                   	push   %ds
  pushl %es
80105807:	06                   	push   %es
  pushl %fs
80105808:	0f a0                	push   %fs
  pushl %gs
8010580a:	0f a8                	push   %gs
  pushal
8010580c:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
8010580d:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105811:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105813:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105815:	54                   	push   %esp
  call trap
80105816:	e8 c5 00 00 00       	call   801058e0 <trap>
  addl $4, %esp
8010581b:	83 c4 04             	add    $0x4,%esp

8010581e <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
8010581e:	61                   	popa   
  popl %gs
8010581f:	0f a9                	pop    %gs
  popl %fs
80105821:	0f a1                	pop    %fs
  popl %es
80105823:	07                   	pop    %es
  popl %ds
80105824:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105825:	83 c4 08             	add    $0x8,%esp
  iret
80105828:	cf                   	iret   
80105829:	66 90                	xchg   %ax,%ax
8010582b:	66 90                	xchg   %ax,%ax
8010582d:	66 90                	xchg   %ax,%ax
8010582f:	90                   	nop

80105830 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105830:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105831:	31 c0                	xor    %eax,%eax
{
80105833:	89 e5                	mov    %esp,%ebp
80105835:	83 ec 08             	sub    $0x8,%esp
80105838:	90                   	nop
80105839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105840:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105847:	c7 04 c5 82 52 11 80 	movl   $0x8e000008,-0x7feead7e(,%eax,8)
8010584e:	08 00 00 8e 
80105852:	66 89 14 c5 80 52 11 	mov    %dx,-0x7feead80(,%eax,8)
80105859:	80 
8010585a:	c1 ea 10             	shr    $0x10,%edx
8010585d:	66 89 14 c5 86 52 11 	mov    %dx,-0x7feead7a(,%eax,8)
80105864:	80 
  for(i = 0; i < 256; i++)
80105865:	83 c0 01             	add    $0x1,%eax
80105868:	3d 00 01 00 00       	cmp    $0x100,%eax
8010586d:	75 d1                	jne    80105840 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010586f:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105874:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105877:	c7 05 82 54 11 80 08 	movl   $0xef000008,0x80115482
8010587e:	00 00 ef 
  initlock(&tickslock, "time");
80105881:	68 5d 7a 10 80       	push   $0x80107a5d
80105886:	68 40 52 11 80       	push   $0x80115240
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010588b:	66 a3 80 54 11 80    	mov    %ax,0x80115480
80105891:	c1 e8 10             	shr    $0x10,%eax
80105894:	66 a3 86 54 11 80    	mov    %ax,0x80115486
  initlock(&tickslock, "time");
8010589a:	e8 f1 ea ff ff       	call   80104390 <initlock>
}
8010589f:	83 c4 10             	add    $0x10,%esp
801058a2:	c9                   	leave  
801058a3:	c3                   	ret    
801058a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801058aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801058b0 <idtinit>:

void
idtinit(void)
{
801058b0:	55                   	push   %ebp
  pd[0] = size-1;
801058b1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801058b6:	89 e5                	mov    %esp,%ebp
801058b8:	83 ec 10             	sub    $0x10,%esp
801058bb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801058bf:	b8 80 52 11 80       	mov    $0x80115280,%eax
801058c4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801058c8:	c1 e8 10             	shr    $0x10,%eax
801058cb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801058cf:	8d 45 fa             	lea    -0x6(%ebp),%eax
801058d2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801058d5:	c9                   	leave  
801058d6:	c3                   	ret    
801058d7:	89 f6                	mov    %esi,%esi
801058d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058e0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801058e0:	55                   	push   %ebp
801058e1:	89 e5                	mov    %esp,%ebp
801058e3:	57                   	push   %edi
801058e4:	56                   	push   %esi
801058e5:	53                   	push   %ebx
801058e6:	83 ec 1c             	sub    $0x1c,%esp
801058e9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
801058ec:	8b 47 30             	mov    0x30(%edi),%eax
801058ef:	83 f8 40             	cmp    $0x40,%eax
801058f2:	0f 84 f0 00 00 00    	je     801059e8 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801058f8:	83 e8 20             	sub    $0x20,%eax
801058fb:	83 f8 1f             	cmp    $0x1f,%eax
801058fe:	77 10                	ja     80105910 <trap+0x30>
80105900:	ff 24 85 04 7b 10 80 	jmp    *-0x7fef84fc(,%eax,4)
80105907:	89 f6                	mov    %esi,%esi
80105909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105910:	e8 ab de ff ff       	call   801037c0 <myproc>
80105915:	85 c0                	test   %eax,%eax
80105917:	8b 5f 38             	mov    0x38(%edi),%ebx
8010591a:	0f 84 14 02 00 00    	je     80105b34 <trap+0x254>
80105920:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105924:	0f 84 0a 02 00 00    	je     80105b34 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010592a:	0f 20 d1             	mov    %cr2,%ecx
8010592d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105930:	e8 6b de ff ff       	call   801037a0 <cpuid>
80105935:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105938:	8b 47 34             	mov    0x34(%edi),%eax
8010593b:	8b 77 30             	mov    0x30(%edi),%esi
8010593e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105941:	e8 7a de ff ff       	call   801037c0 <myproc>
80105946:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105949:	e8 72 de ff ff       	call   801037c0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010594e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105951:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105954:	51                   	push   %ecx
80105955:	53                   	push   %ebx
80105956:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80105957:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010595a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010595d:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010595e:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105961:	52                   	push   %edx
80105962:	ff 70 10             	pushl  0x10(%eax)
80105965:	68 c0 7a 10 80       	push   $0x80107ac0
8010596a:	e8 f1 ac ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
8010596f:	83 c4 20             	add    $0x20,%esp
80105972:	e8 49 de ff ff       	call   801037c0 <myproc>
80105977:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010597e:	e8 3d de ff ff       	call   801037c0 <myproc>
80105983:	85 c0                	test   %eax,%eax
80105985:	74 1d                	je     801059a4 <trap+0xc4>
80105987:	e8 34 de ff ff       	call   801037c0 <myproc>
8010598c:	8b 50 24             	mov    0x24(%eax),%edx
8010598f:	85 d2                	test   %edx,%edx
80105991:	74 11                	je     801059a4 <trap+0xc4>
80105993:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105997:	83 e0 03             	and    $0x3,%eax
8010599a:	66 83 f8 03          	cmp    $0x3,%ax
8010599e:	0f 84 4c 01 00 00    	je     80105af0 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801059a4:	e8 17 de ff ff       	call   801037c0 <myproc>
801059a9:	85 c0                	test   %eax,%eax
801059ab:	74 0b                	je     801059b8 <trap+0xd8>
801059ad:	e8 0e de ff ff       	call   801037c0 <myproc>
801059b2:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801059b6:	74 68                	je     80105a20 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801059b8:	e8 03 de ff ff       	call   801037c0 <myproc>
801059bd:	85 c0                	test   %eax,%eax
801059bf:	74 19                	je     801059da <trap+0xfa>
801059c1:	e8 fa dd ff ff       	call   801037c0 <myproc>
801059c6:	8b 40 24             	mov    0x24(%eax),%eax
801059c9:	85 c0                	test   %eax,%eax
801059cb:	74 0d                	je     801059da <trap+0xfa>
801059cd:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801059d1:	83 e0 03             	and    $0x3,%eax
801059d4:	66 83 f8 03          	cmp    $0x3,%ax
801059d8:	74 37                	je     80105a11 <trap+0x131>
    exit();
}
801059da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059dd:	5b                   	pop    %ebx
801059de:	5e                   	pop    %esi
801059df:	5f                   	pop    %edi
801059e0:	5d                   	pop    %ebp
801059e1:	c3                   	ret    
801059e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
801059e8:	e8 d3 dd ff ff       	call   801037c0 <myproc>
801059ed:	8b 58 24             	mov    0x24(%eax),%ebx
801059f0:	85 db                	test   %ebx,%ebx
801059f2:	0f 85 e8 00 00 00    	jne    80105ae0 <trap+0x200>
    myproc()->tf = tf;
801059f8:	e8 c3 dd ff ff       	call   801037c0 <myproc>
801059fd:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105a00:	e8 cb ef ff ff       	call   801049d0 <syscall>
    if(myproc()->killed)
80105a05:	e8 b6 dd ff ff       	call   801037c0 <myproc>
80105a0a:	8b 48 24             	mov    0x24(%eax),%ecx
80105a0d:	85 c9                	test   %ecx,%ecx
80105a0f:	74 c9                	je     801059da <trap+0xfa>
}
80105a11:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a14:	5b                   	pop    %ebx
80105a15:	5e                   	pop    %esi
80105a16:	5f                   	pop    %edi
80105a17:	5d                   	pop    %ebp
      exit();
80105a18:	e9 93 e1 ff ff       	jmp    80103bb0 <exit>
80105a1d:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105a20:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105a24:	75 92                	jne    801059b8 <trap+0xd8>
    yield();
80105a26:	e8 b5 e2 ff ff       	call   80103ce0 <yield>
80105a2b:	eb 8b                	jmp    801059b8 <trap+0xd8>
80105a2d:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80105a30:	e8 6b dd ff ff       	call   801037a0 <cpuid>
80105a35:	85 c0                	test   %eax,%eax
80105a37:	0f 84 c3 00 00 00    	je     80105b00 <trap+0x220>
    lapiceoi();
80105a3d:	e8 2e cd ff ff       	call   80102770 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a42:	e8 79 dd ff ff       	call   801037c0 <myproc>
80105a47:	85 c0                	test   %eax,%eax
80105a49:	0f 85 38 ff ff ff    	jne    80105987 <trap+0xa7>
80105a4f:	e9 50 ff ff ff       	jmp    801059a4 <trap+0xc4>
80105a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105a58:	e8 d3 cb ff ff       	call   80102630 <kbdintr>
    lapiceoi();
80105a5d:	e8 0e cd ff ff       	call   80102770 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a62:	e8 59 dd ff ff       	call   801037c0 <myproc>
80105a67:	85 c0                	test   %eax,%eax
80105a69:	0f 85 18 ff ff ff    	jne    80105987 <trap+0xa7>
80105a6f:	e9 30 ff ff ff       	jmp    801059a4 <trap+0xc4>
80105a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105a78:	e8 53 02 00 00       	call   80105cd0 <uartintr>
    lapiceoi();
80105a7d:	e8 ee cc ff ff       	call   80102770 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a82:	e8 39 dd ff ff       	call   801037c0 <myproc>
80105a87:	85 c0                	test   %eax,%eax
80105a89:	0f 85 f8 fe ff ff    	jne    80105987 <trap+0xa7>
80105a8f:	e9 10 ff ff ff       	jmp    801059a4 <trap+0xc4>
80105a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105a98:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105a9c:	8b 77 38             	mov    0x38(%edi),%esi
80105a9f:	e8 fc dc ff ff       	call   801037a0 <cpuid>
80105aa4:	56                   	push   %esi
80105aa5:	53                   	push   %ebx
80105aa6:	50                   	push   %eax
80105aa7:	68 68 7a 10 80       	push   $0x80107a68
80105aac:	e8 af ab ff ff       	call   80100660 <cprintf>
    lapiceoi();
80105ab1:	e8 ba cc ff ff       	call   80102770 <lapiceoi>
    break;
80105ab6:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ab9:	e8 02 dd ff ff       	call   801037c0 <myproc>
80105abe:	85 c0                	test   %eax,%eax
80105ac0:	0f 85 c1 fe ff ff    	jne    80105987 <trap+0xa7>
80105ac6:	e9 d9 fe ff ff       	jmp    801059a4 <trap+0xc4>
80105acb:	90                   	nop
80105acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80105ad0:	e8 cb c5 ff ff       	call   801020a0 <ideintr>
80105ad5:	e9 63 ff ff ff       	jmp    80105a3d <trap+0x15d>
80105ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105ae0:	e8 cb e0 ff ff       	call   80103bb0 <exit>
80105ae5:	e9 0e ff ff ff       	jmp    801059f8 <trap+0x118>
80105aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80105af0:	e8 bb e0 ff ff       	call   80103bb0 <exit>
80105af5:	e9 aa fe ff ff       	jmp    801059a4 <trap+0xc4>
80105afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105b00:	83 ec 0c             	sub    $0xc,%esp
80105b03:	68 40 52 11 80       	push   $0x80115240
80105b08:	e8 c3 e9 ff ff       	call   801044d0 <acquire>
      wakeup(&ticks);
80105b0d:	c7 04 24 80 5a 11 80 	movl   $0x80115a80,(%esp)
      ticks++;
80105b14:	83 05 80 5a 11 80 01 	addl   $0x1,0x80115a80
      wakeup(&ticks);
80105b1b:	e8 c0 e3 ff ff       	call   80103ee0 <wakeup>
      release(&tickslock);
80105b20:	c7 04 24 40 52 11 80 	movl   $0x80115240,(%esp)
80105b27:	e8 64 ea ff ff       	call   80104590 <release>
80105b2c:	83 c4 10             	add    $0x10,%esp
80105b2f:	e9 09 ff ff ff       	jmp    80105a3d <trap+0x15d>
80105b34:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105b37:	e8 64 dc ff ff       	call   801037a0 <cpuid>
80105b3c:	83 ec 0c             	sub    $0xc,%esp
80105b3f:	56                   	push   %esi
80105b40:	53                   	push   %ebx
80105b41:	50                   	push   %eax
80105b42:	ff 77 30             	pushl  0x30(%edi)
80105b45:	68 8c 7a 10 80       	push   $0x80107a8c
80105b4a:	e8 11 ab ff ff       	call   80100660 <cprintf>
      panic("trap");
80105b4f:	83 c4 14             	add    $0x14,%esp
80105b52:	68 62 7a 10 80       	push   $0x80107a62
80105b57:	e8 34 a8 ff ff       	call   80100390 <panic>
80105b5c:	66 90                	xchg   %ax,%ax
80105b5e:	66 90                	xchg   %ax,%ax

80105b60 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105b60:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
{
80105b65:	55                   	push   %ebp
80105b66:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105b68:	85 c0                	test   %eax,%eax
80105b6a:	74 1c                	je     80105b88 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105b6c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105b71:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105b72:	a8 01                	test   $0x1,%al
80105b74:	74 12                	je     80105b88 <uartgetc+0x28>
80105b76:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105b7b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105b7c:	0f b6 c0             	movzbl %al,%eax
}
80105b7f:	5d                   	pop    %ebp
80105b80:	c3                   	ret    
80105b81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105b88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b8d:	5d                   	pop    %ebp
80105b8e:	c3                   	ret    
80105b8f:	90                   	nop

80105b90 <uartputc.part.0>:
uartputc(int c)
80105b90:	55                   	push   %ebp
80105b91:	89 e5                	mov    %esp,%ebp
80105b93:	57                   	push   %edi
80105b94:	56                   	push   %esi
80105b95:	53                   	push   %ebx
80105b96:	89 c7                	mov    %eax,%edi
80105b98:	bb 80 00 00 00       	mov    $0x80,%ebx
80105b9d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105ba2:	83 ec 0c             	sub    $0xc,%esp
80105ba5:	eb 1b                	jmp    80105bc2 <uartputc.part.0+0x32>
80105ba7:	89 f6                	mov    %esi,%esi
80105ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80105bb0:	83 ec 0c             	sub    $0xc,%esp
80105bb3:	6a 0a                	push   $0xa
80105bb5:	e8 d6 cb ff ff       	call   80102790 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105bba:	83 c4 10             	add    $0x10,%esp
80105bbd:	83 eb 01             	sub    $0x1,%ebx
80105bc0:	74 07                	je     80105bc9 <uartputc.part.0+0x39>
80105bc2:	89 f2                	mov    %esi,%edx
80105bc4:	ec                   	in     (%dx),%al
80105bc5:	a8 20                	test   $0x20,%al
80105bc7:	74 e7                	je     80105bb0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105bc9:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105bce:	89 f8                	mov    %edi,%eax
80105bd0:	ee                   	out    %al,(%dx)
}
80105bd1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bd4:	5b                   	pop    %ebx
80105bd5:	5e                   	pop    %esi
80105bd6:	5f                   	pop    %edi
80105bd7:	5d                   	pop    %ebp
80105bd8:	c3                   	ret    
80105bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105be0 <uartinit>:
{
80105be0:	55                   	push   %ebp
80105be1:	31 c9                	xor    %ecx,%ecx
80105be3:	89 c8                	mov    %ecx,%eax
80105be5:	89 e5                	mov    %esp,%ebp
80105be7:	57                   	push   %edi
80105be8:	56                   	push   %esi
80105be9:	53                   	push   %ebx
80105bea:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105bef:	89 da                	mov    %ebx,%edx
80105bf1:	83 ec 0c             	sub    $0xc,%esp
80105bf4:	ee                   	out    %al,(%dx)
80105bf5:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105bfa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105bff:	89 fa                	mov    %edi,%edx
80105c01:	ee                   	out    %al,(%dx)
80105c02:	b8 0c 00 00 00       	mov    $0xc,%eax
80105c07:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c0c:	ee                   	out    %al,(%dx)
80105c0d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105c12:	89 c8                	mov    %ecx,%eax
80105c14:	89 f2                	mov    %esi,%edx
80105c16:	ee                   	out    %al,(%dx)
80105c17:	b8 03 00 00 00       	mov    $0x3,%eax
80105c1c:	89 fa                	mov    %edi,%edx
80105c1e:	ee                   	out    %al,(%dx)
80105c1f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105c24:	89 c8                	mov    %ecx,%eax
80105c26:	ee                   	out    %al,(%dx)
80105c27:	b8 01 00 00 00       	mov    $0x1,%eax
80105c2c:	89 f2                	mov    %esi,%edx
80105c2e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105c2f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105c34:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105c35:	3c ff                	cmp    $0xff,%al
80105c37:	74 5a                	je     80105c93 <uartinit+0xb3>
  uart = 1;
80105c39:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105c40:	00 00 00 
80105c43:	89 da                	mov    %ebx,%edx
80105c45:	ec                   	in     (%dx),%al
80105c46:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c4b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105c4c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105c4f:	bb 84 7b 10 80       	mov    $0x80107b84,%ebx
  ioapicenable(IRQ_COM1, 0);
80105c54:	6a 00                	push   $0x0
80105c56:	6a 04                	push   $0x4
80105c58:	e8 93 c6 ff ff       	call   801022f0 <ioapicenable>
80105c5d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105c60:	b8 78 00 00 00       	mov    $0x78,%eax
80105c65:	eb 13                	jmp    80105c7a <uartinit+0x9a>
80105c67:	89 f6                	mov    %esi,%esi
80105c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105c70:	83 c3 01             	add    $0x1,%ebx
80105c73:	0f be 03             	movsbl (%ebx),%eax
80105c76:	84 c0                	test   %al,%al
80105c78:	74 19                	je     80105c93 <uartinit+0xb3>
  if(!uart)
80105c7a:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105c80:	85 d2                	test   %edx,%edx
80105c82:	74 ec                	je     80105c70 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80105c84:	83 c3 01             	add    $0x1,%ebx
80105c87:	e8 04 ff ff ff       	call   80105b90 <uartputc.part.0>
80105c8c:	0f be 03             	movsbl (%ebx),%eax
80105c8f:	84 c0                	test   %al,%al
80105c91:	75 e7                	jne    80105c7a <uartinit+0x9a>
}
80105c93:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c96:	5b                   	pop    %ebx
80105c97:	5e                   	pop    %esi
80105c98:	5f                   	pop    %edi
80105c99:	5d                   	pop    %ebp
80105c9a:	c3                   	ret    
80105c9b:	90                   	nop
80105c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ca0 <uartputc>:
  if(!uart)
80105ca0:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
{
80105ca6:	55                   	push   %ebp
80105ca7:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105ca9:	85 d2                	test   %edx,%edx
{
80105cab:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105cae:	74 10                	je     80105cc0 <uartputc+0x20>
}
80105cb0:	5d                   	pop    %ebp
80105cb1:	e9 da fe ff ff       	jmp    80105b90 <uartputc.part.0>
80105cb6:	8d 76 00             	lea    0x0(%esi),%esi
80105cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105cc0:	5d                   	pop    %ebp
80105cc1:	c3                   	ret    
80105cc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105cd0 <uartintr>:

void
uartintr(void)
{
80105cd0:	55                   	push   %ebp
80105cd1:	89 e5                	mov    %esp,%ebp
80105cd3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105cd6:	68 60 5b 10 80       	push   $0x80105b60
80105cdb:	e8 30 ab ff ff       	call   80100810 <consoleintr>
}
80105ce0:	83 c4 10             	add    $0x10,%esp
80105ce3:	c9                   	leave  
80105ce4:	c3                   	ret    

80105ce5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105ce5:	6a 00                	push   $0x0
  pushl $0
80105ce7:	6a 00                	push   $0x0
  jmp alltraps
80105ce9:	e9 18 fb ff ff       	jmp    80105806 <alltraps>

80105cee <vector1>:
.globl vector1
vector1:
  pushl $0
80105cee:	6a 00                	push   $0x0
  pushl $1
80105cf0:	6a 01                	push   $0x1
  jmp alltraps
80105cf2:	e9 0f fb ff ff       	jmp    80105806 <alltraps>

80105cf7 <vector2>:
.globl vector2
vector2:
  pushl $0
80105cf7:	6a 00                	push   $0x0
  pushl $2
80105cf9:	6a 02                	push   $0x2
  jmp alltraps
80105cfb:	e9 06 fb ff ff       	jmp    80105806 <alltraps>

80105d00 <vector3>:
.globl vector3
vector3:
  pushl $0
80105d00:	6a 00                	push   $0x0
  pushl $3
80105d02:	6a 03                	push   $0x3
  jmp alltraps
80105d04:	e9 fd fa ff ff       	jmp    80105806 <alltraps>

80105d09 <vector4>:
.globl vector4
vector4:
  pushl $0
80105d09:	6a 00                	push   $0x0
  pushl $4
80105d0b:	6a 04                	push   $0x4
  jmp alltraps
80105d0d:	e9 f4 fa ff ff       	jmp    80105806 <alltraps>

80105d12 <vector5>:
.globl vector5
vector5:
  pushl $0
80105d12:	6a 00                	push   $0x0
  pushl $5
80105d14:	6a 05                	push   $0x5
  jmp alltraps
80105d16:	e9 eb fa ff ff       	jmp    80105806 <alltraps>

80105d1b <vector6>:
.globl vector6
vector6:
  pushl $0
80105d1b:	6a 00                	push   $0x0
  pushl $6
80105d1d:	6a 06                	push   $0x6
  jmp alltraps
80105d1f:	e9 e2 fa ff ff       	jmp    80105806 <alltraps>

80105d24 <vector7>:
.globl vector7
vector7:
  pushl $0
80105d24:	6a 00                	push   $0x0
  pushl $7
80105d26:	6a 07                	push   $0x7
  jmp alltraps
80105d28:	e9 d9 fa ff ff       	jmp    80105806 <alltraps>

80105d2d <vector8>:
.globl vector8
vector8:
  pushl $8
80105d2d:	6a 08                	push   $0x8
  jmp alltraps
80105d2f:	e9 d2 fa ff ff       	jmp    80105806 <alltraps>

80105d34 <vector9>:
.globl vector9
vector9:
  pushl $0
80105d34:	6a 00                	push   $0x0
  pushl $9
80105d36:	6a 09                	push   $0x9
  jmp alltraps
80105d38:	e9 c9 fa ff ff       	jmp    80105806 <alltraps>

80105d3d <vector10>:
.globl vector10
vector10:
  pushl $10
80105d3d:	6a 0a                	push   $0xa
  jmp alltraps
80105d3f:	e9 c2 fa ff ff       	jmp    80105806 <alltraps>

80105d44 <vector11>:
.globl vector11
vector11:
  pushl $11
80105d44:	6a 0b                	push   $0xb
  jmp alltraps
80105d46:	e9 bb fa ff ff       	jmp    80105806 <alltraps>

80105d4b <vector12>:
.globl vector12
vector12:
  pushl $12
80105d4b:	6a 0c                	push   $0xc
  jmp alltraps
80105d4d:	e9 b4 fa ff ff       	jmp    80105806 <alltraps>

80105d52 <vector13>:
.globl vector13
vector13:
  pushl $13
80105d52:	6a 0d                	push   $0xd
  jmp alltraps
80105d54:	e9 ad fa ff ff       	jmp    80105806 <alltraps>

80105d59 <vector14>:
.globl vector14
vector14:
  pushl $14
80105d59:	6a 0e                	push   $0xe
  jmp alltraps
80105d5b:	e9 a6 fa ff ff       	jmp    80105806 <alltraps>

80105d60 <vector15>:
.globl vector15
vector15:
  pushl $0
80105d60:	6a 00                	push   $0x0
  pushl $15
80105d62:	6a 0f                	push   $0xf
  jmp alltraps
80105d64:	e9 9d fa ff ff       	jmp    80105806 <alltraps>

80105d69 <vector16>:
.globl vector16
vector16:
  pushl $0
80105d69:	6a 00                	push   $0x0
  pushl $16
80105d6b:	6a 10                	push   $0x10
  jmp alltraps
80105d6d:	e9 94 fa ff ff       	jmp    80105806 <alltraps>

80105d72 <vector17>:
.globl vector17
vector17:
  pushl $17
80105d72:	6a 11                	push   $0x11
  jmp alltraps
80105d74:	e9 8d fa ff ff       	jmp    80105806 <alltraps>

80105d79 <vector18>:
.globl vector18
vector18:
  pushl $0
80105d79:	6a 00                	push   $0x0
  pushl $18
80105d7b:	6a 12                	push   $0x12
  jmp alltraps
80105d7d:	e9 84 fa ff ff       	jmp    80105806 <alltraps>

80105d82 <vector19>:
.globl vector19
vector19:
  pushl $0
80105d82:	6a 00                	push   $0x0
  pushl $19
80105d84:	6a 13                	push   $0x13
  jmp alltraps
80105d86:	e9 7b fa ff ff       	jmp    80105806 <alltraps>

80105d8b <vector20>:
.globl vector20
vector20:
  pushl $0
80105d8b:	6a 00                	push   $0x0
  pushl $20
80105d8d:	6a 14                	push   $0x14
  jmp alltraps
80105d8f:	e9 72 fa ff ff       	jmp    80105806 <alltraps>

80105d94 <vector21>:
.globl vector21
vector21:
  pushl $0
80105d94:	6a 00                	push   $0x0
  pushl $21
80105d96:	6a 15                	push   $0x15
  jmp alltraps
80105d98:	e9 69 fa ff ff       	jmp    80105806 <alltraps>

80105d9d <vector22>:
.globl vector22
vector22:
  pushl $0
80105d9d:	6a 00                	push   $0x0
  pushl $22
80105d9f:	6a 16                	push   $0x16
  jmp alltraps
80105da1:	e9 60 fa ff ff       	jmp    80105806 <alltraps>

80105da6 <vector23>:
.globl vector23
vector23:
  pushl $0
80105da6:	6a 00                	push   $0x0
  pushl $23
80105da8:	6a 17                	push   $0x17
  jmp alltraps
80105daa:	e9 57 fa ff ff       	jmp    80105806 <alltraps>

80105daf <vector24>:
.globl vector24
vector24:
  pushl $0
80105daf:	6a 00                	push   $0x0
  pushl $24
80105db1:	6a 18                	push   $0x18
  jmp alltraps
80105db3:	e9 4e fa ff ff       	jmp    80105806 <alltraps>

80105db8 <vector25>:
.globl vector25
vector25:
  pushl $0
80105db8:	6a 00                	push   $0x0
  pushl $25
80105dba:	6a 19                	push   $0x19
  jmp alltraps
80105dbc:	e9 45 fa ff ff       	jmp    80105806 <alltraps>

80105dc1 <vector26>:
.globl vector26
vector26:
  pushl $0
80105dc1:	6a 00                	push   $0x0
  pushl $26
80105dc3:	6a 1a                	push   $0x1a
  jmp alltraps
80105dc5:	e9 3c fa ff ff       	jmp    80105806 <alltraps>

80105dca <vector27>:
.globl vector27
vector27:
  pushl $0
80105dca:	6a 00                	push   $0x0
  pushl $27
80105dcc:	6a 1b                	push   $0x1b
  jmp alltraps
80105dce:	e9 33 fa ff ff       	jmp    80105806 <alltraps>

80105dd3 <vector28>:
.globl vector28
vector28:
  pushl $0
80105dd3:	6a 00                	push   $0x0
  pushl $28
80105dd5:	6a 1c                	push   $0x1c
  jmp alltraps
80105dd7:	e9 2a fa ff ff       	jmp    80105806 <alltraps>

80105ddc <vector29>:
.globl vector29
vector29:
  pushl $0
80105ddc:	6a 00                	push   $0x0
  pushl $29
80105dde:	6a 1d                	push   $0x1d
  jmp alltraps
80105de0:	e9 21 fa ff ff       	jmp    80105806 <alltraps>

80105de5 <vector30>:
.globl vector30
vector30:
  pushl $0
80105de5:	6a 00                	push   $0x0
  pushl $30
80105de7:	6a 1e                	push   $0x1e
  jmp alltraps
80105de9:	e9 18 fa ff ff       	jmp    80105806 <alltraps>

80105dee <vector31>:
.globl vector31
vector31:
  pushl $0
80105dee:	6a 00                	push   $0x0
  pushl $31
80105df0:	6a 1f                	push   $0x1f
  jmp alltraps
80105df2:	e9 0f fa ff ff       	jmp    80105806 <alltraps>

80105df7 <vector32>:
.globl vector32
vector32:
  pushl $0
80105df7:	6a 00                	push   $0x0
  pushl $32
80105df9:	6a 20                	push   $0x20
  jmp alltraps
80105dfb:	e9 06 fa ff ff       	jmp    80105806 <alltraps>

80105e00 <vector33>:
.globl vector33
vector33:
  pushl $0
80105e00:	6a 00                	push   $0x0
  pushl $33
80105e02:	6a 21                	push   $0x21
  jmp alltraps
80105e04:	e9 fd f9 ff ff       	jmp    80105806 <alltraps>

80105e09 <vector34>:
.globl vector34
vector34:
  pushl $0
80105e09:	6a 00                	push   $0x0
  pushl $34
80105e0b:	6a 22                	push   $0x22
  jmp alltraps
80105e0d:	e9 f4 f9 ff ff       	jmp    80105806 <alltraps>

80105e12 <vector35>:
.globl vector35
vector35:
  pushl $0
80105e12:	6a 00                	push   $0x0
  pushl $35
80105e14:	6a 23                	push   $0x23
  jmp alltraps
80105e16:	e9 eb f9 ff ff       	jmp    80105806 <alltraps>

80105e1b <vector36>:
.globl vector36
vector36:
  pushl $0
80105e1b:	6a 00                	push   $0x0
  pushl $36
80105e1d:	6a 24                	push   $0x24
  jmp alltraps
80105e1f:	e9 e2 f9 ff ff       	jmp    80105806 <alltraps>

80105e24 <vector37>:
.globl vector37
vector37:
  pushl $0
80105e24:	6a 00                	push   $0x0
  pushl $37
80105e26:	6a 25                	push   $0x25
  jmp alltraps
80105e28:	e9 d9 f9 ff ff       	jmp    80105806 <alltraps>

80105e2d <vector38>:
.globl vector38
vector38:
  pushl $0
80105e2d:	6a 00                	push   $0x0
  pushl $38
80105e2f:	6a 26                	push   $0x26
  jmp alltraps
80105e31:	e9 d0 f9 ff ff       	jmp    80105806 <alltraps>

80105e36 <vector39>:
.globl vector39
vector39:
  pushl $0
80105e36:	6a 00                	push   $0x0
  pushl $39
80105e38:	6a 27                	push   $0x27
  jmp alltraps
80105e3a:	e9 c7 f9 ff ff       	jmp    80105806 <alltraps>

80105e3f <vector40>:
.globl vector40
vector40:
  pushl $0
80105e3f:	6a 00                	push   $0x0
  pushl $40
80105e41:	6a 28                	push   $0x28
  jmp alltraps
80105e43:	e9 be f9 ff ff       	jmp    80105806 <alltraps>

80105e48 <vector41>:
.globl vector41
vector41:
  pushl $0
80105e48:	6a 00                	push   $0x0
  pushl $41
80105e4a:	6a 29                	push   $0x29
  jmp alltraps
80105e4c:	e9 b5 f9 ff ff       	jmp    80105806 <alltraps>

80105e51 <vector42>:
.globl vector42
vector42:
  pushl $0
80105e51:	6a 00                	push   $0x0
  pushl $42
80105e53:	6a 2a                	push   $0x2a
  jmp alltraps
80105e55:	e9 ac f9 ff ff       	jmp    80105806 <alltraps>

80105e5a <vector43>:
.globl vector43
vector43:
  pushl $0
80105e5a:	6a 00                	push   $0x0
  pushl $43
80105e5c:	6a 2b                	push   $0x2b
  jmp alltraps
80105e5e:	e9 a3 f9 ff ff       	jmp    80105806 <alltraps>

80105e63 <vector44>:
.globl vector44
vector44:
  pushl $0
80105e63:	6a 00                	push   $0x0
  pushl $44
80105e65:	6a 2c                	push   $0x2c
  jmp alltraps
80105e67:	e9 9a f9 ff ff       	jmp    80105806 <alltraps>

80105e6c <vector45>:
.globl vector45
vector45:
  pushl $0
80105e6c:	6a 00                	push   $0x0
  pushl $45
80105e6e:	6a 2d                	push   $0x2d
  jmp alltraps
80105e70:	e9 91 f9 ff ff       	jmp    80105806 <alltraps>

80105e75 <vector46>:
.globl vector46
vector46:
  pushl $0
80105e75:	6a 00                	push   $0x0
  pushl $46
80105e77:	6a 2e                	push   $0x2e
  jmp alltraps
80105e79:	e9 88 f9 ff ff       	jmp    80105806 <alltraps>

80105e7e <vector47>:
.globl vector47
vector47:
  pushl $0
80105e7e:	6a 00                	push   $0x0
  pushl $47
80105e80:	6a 2f                	push   $0x2f
  jmp alltraps
80105e82:	e9 7f f9 ff ff       	jmp    80105806 <alltraps>

80105e87 <vector48>:
.globl vector48
vector48:
  pushl $0
80105e87:	6a 00                	push   $0x0
  pushl $48
80105e89:	6a 30                	push   $0x30
  jmp alltraps
80105e8b:	e9 76 f9 ff ff       	jmp    80105806 <alltraps>

80105e90 <vector49>:
.globl vector49
vector49:
  pushl $0
80105e90:	6a 00                	push   $0x0
  pushl $49
80105e92:	6a 31                	push   $0x31
  jmp alltraps
80105e94:	e9 6d f9 ff ff       	jmp    80105806 <alltraps>

80105e99 <vector50>:
.globl vector50
vector50:
  pushl $0
80105e99:	6a 00                	push   $0x0
  pushl $50
80105e9b:	6a 32                	push   $0x32
  jmp alltraps
80105e9d:	e9 64 f9 ff ff       	jmp    80105806 <alltraps>

80105ea2 <vector51>:
.globl vector51
vector51:
  pushl $0
80105ea2:	6a 00                	push   $0x0
  pushl $51
80105ea4:	6a 33                	push   $0x33
  jmp alltraps
80105ea6:	e9 5b f9 ff ff       	jmp    80105806 <alltraps>

80105eab <vector52>:
.globl vector52
vector52:
  pushl $0
80105eab:	6a 00                	push   $0x0
  pushl $52
80105ead:	6a 34                	push   $0x34
  jmp alltraps
80105eaf:	e9 52 f9 ff ff       	jmp    80105806 <alltraps>

80105eb4 <vector53>:
.globl vector53
vector53:
  pushl $0
80105eb4:	6a 00                	push   $0x0
  pushl $53
80105eb6:	6a 35                	push   $0x35
  jmp alltraps
80105eb8:	e9 49 f9 ff ff       	jmp    80105806 <alltraps>

80105ebd <vector54>:
.globl vector54
vector54:
  pushl $0
80105ebd:	6a 00                	push   $0x0
  pushl $54
80105ebf:	6a 36                	push   $0x36
  jmp alltraps
80105ec1:	e9 40 f9 ff ff       	jmp    80105806 <alltraps>

80105ec6 <vector55>:
.globl vector55
vector55:
  pushl $0
80105ec6:	6a 00                	push   $0x0
  pushl $55
80105ec8:	6a 37                	push   $0x37
  jmp alltraps
80105eca:	e9 37 f9 ff ff       	jmp    80105806 <alltraps>

80105ecf <vector56>:
.globl vector56
vector56:
  pushl $0
80105ecf:	6a 00                	push   $0x0
  pushl $56
80105ed1:	6a 38                	push   $0x38
  jmp alltraps
80105ed3:	e9 2e f9 ff ff       	jmp    80105806 <alltraps>

80105ed8 <vector57>:
.globl vector57
vector57:
  pushl $0
80105ed8:	6a 00                	push   $0x0
  pushl $57
80105eda:	6a 39                	push   $0x39
  jmp alltraps
80105edc:	e9 25 f9 ff ff       	jmp    80105806 <alltraps>

80105ee1 <vector58>:
.globl vector58
vector58:
  pushl $0
80105ee1:	6a 00                	push   $0x0
  pushl $58
80105ee3:	6a 3a                	push   $0x3a
  jmp alltraps
80105ee5:	e9 1c f9 ff ff       	jmp    80105806 <alltraps>

80105eea <vector59>:
.globl vector59
vector59:
  pushl $0
80105eea:	6a 00                	push   $0x0
  pushl $59
80105eec:	6a 3b                	push   $0x3b
  jmp alltraps
80105eee:	e9 13 f9 ff ff       	jmp    80105806 <alltraps>

80105ef3 <vector60>:
.globl vector60
vector60:
  pushl $0
80105ef3:	6a 00                	push   $0x0
  pushl $60
80105ef5:	6a 3c                	push   $0x3c
  jmp alltraps
80105ef7:	e9 0a f9 ff ff       	jmp    80105806 <alltraps>

80105efc <vector61>:
.globl vector61
vector61:
  pushl $0
80105efc:	6a 00                	push   $0x0
  pushl $61
80105efe:	6a 3d                	push   $0x3d
  jmp alltraps
80105f00:	e9 01 f9 ff ff       	jmp    80105806 <alltraps>

80105f05 <vector62>:
.globl vector62
vector62:
  pushl $0
80105f05:	6a 00                	push   $0x0
  pushl $62
80105f07:	6a 3e                	push   $0x3e
  jmp alltraps
80105f09:	e9 f8 f8 ff ff       	jmp    80105806 <alltraps>

80105f0e <vector63>:
.globl vector63
vector63:
  pushl $0
80105f0e:	6a 00                	push   $0x0
  pushl $63
80105f10:	6a 3f                	push   $0x3f
  jmp alltraps
80105f12:	e9 ef f8 ff ff       	jmp    80105806 <alltraps>

80105f17 <vector64>:
.globl vector64
vector64:
  pushl $0
80105f17:	6a 00                	push   $0x0
  pushl $64
80105f19:	6a 40                	push   $0x40
  jmp alltraps
80105f1b:	e9 e6 f8 ff ff       	jmp    80105806 <alltraps>

80105f20 <vector65>:
.globl vector65
vector65:
  pushl $0
80105f20:	6a 00                	push   $0x0
  pushl $65
80105f22:	6a 41                	push   $0x41
  jmp alltraps
80105f24:	e9 dd f8 ff ff       	jmp    80105806 <alltraps>

80105f29 <vector66>:
.globl vector66
vector66:
  pushl $0
80105f29:	6a 00                	push   $0x0
  pushl $66
80105f2b:	6a 42                	push   $0x42
  jmp alltraps
80105f2d:	e9 d4 f8 ff ff       	jmp    80105806 <alltraps>

80105f32 <vector67>:
.globl vector67
vector67:
  pushl $0
80105f32:	6a 00                	push   $0x0
  pushl $67
80105f34:	6a 43                	push   $0x43
  jmp alltraps
80105f36:	e9 cb f8 ff ff       	jmp    80105806 <alltraps>

80105f3b <vector68>:
.globl vector68
vector68:
  pushl $0
80105f3b:	6a 00                	push   $0x0
  pushl $68
80105f3d:	6a 44                	push   $0x44
  jmp alltraps
80105f3f:	e9 c2 f8 ff ff       	jmp    80105806 <alltraps>

80105f44 <vector69>:
.globl vector69
vector69:
  pushl $0
80105f44:	6a 00                	push   $0x0
  pushl $69
80105f46:	6a 45                	push   $0x45
  jmp alltraps
80105f48:	e9 b9 f8 ff ff       	jmp    80105806 <alltraps>

80105f4d <vector70>:
.globl vector70
vector70:
  pushl $0
80105f4d:	6a 00                	push   $0x0
  pushl $70
80105f4f:	6a 46                	push   $0x46
  jmp alltraps
80105f51:	e9 b0 f8 ff ff       	jmp    80105806 <alltraps>

80105f56 <vector71>:
.globl vector71
vector71:
  pushl $0
80105f56:	6a 00                	push   $0x0
  pushl $71
80105f58:	6a 47                	push   $0x47
  jmp alltraps
80105f5a:	e9 a7 f8 ff ff       	jmp    80105806 <alltraps>

80105f5f <vector72>:
.globl vector72
vector72:
  pushl $0
80105f5f:	6a 00                	push   $0x0
  pushl $72
80105f61:	6a 48                	push   $0x48
  jmp alltraps
80105f63:	e9 9e f8 ff ff       	jmp    80105806 <alltraps>

80105f68 <vector73>:
.globl vector73
vector73:
  pushl $0
80105f68:	6a 00                	push   $0x0
  pushl $73
80105f6a:	6a 49                	push   $0x49
  jmp alltraps
80105f6c:	e9 95 f8 ff ff       	jmp    80105806 <alltraps>

80105f71 <vector74>:
.globl vector74
vector74:
  pushl $0
80105f71:	6a 00                	push   $0x0
  pushl $74
80105f73:	6a 4a                	push   $0x4a
  jmp alltraps
80105f75:	e9 8c f8 ff ff       	jmp    80105806 <alltraps>

80105f7a <vector75>:
.globl vector75
vector75:
  pushl $0
80105f7a:	6a 00                	push   $0x0
  pushl $75
80105f7c:	6a 4b                	push   $0x4b
  jmp alltraps
80105f7e:	e9 83 f8 ff ff       	jmp    80105806 <alltraps>

80105f83 <vector76>:
.globl vector76
vector76:
  pushl $0
80105f83:	6a 00                	push   $0x0
  pushl $76
80105f85:	6a 4c                	push   $0x4c
  jmp alltraps
80105f87:	e9 7a f8 ff ff       	jmp    80105806 <alltraps>

80105f8c <vector77>:
.globl vector77
vector77:
  pushl $0
80105f8c:	6a 00                	push   $0x0
  pushl $77
80105f8e:	6a 4d                	push   $0x4d
  jmp alltraps
80105f90:	e9 71 f8 ff ff       	jmp    80105806 <alltraps>

80105f95 <vector78>:
.globl vector78
vector78:
  pushl $0
80105f95:	6a 00                	push   $0x0
  pushl $78
80105f97:	6a 4e                	push   $0x4e
  jmp alltraps
80105f99:	e9 68 f8 ff ff       	jmp    80105806 <alltraps>

80105f9e <vector79>:
.globl vector79
vector79:
  pushl $0
80105f9e:	6a 00                	push   $0x0
  pushl $79
80105fa0:	6a 4f                	push   $0x4f
  jmp alltraps
80105fa2:	e9 5f f8 ff ff       	jmp    80105806 <alltraps>

80105fa7 <vector80>:
.globl vector80
vector80:
  pushl $0
80105fa7:	6a 00                	push   $0x0
  pushl $80
80105fa9:	6a 50                	push   $0x50
  jmp alltraps
80105fab:	e9 56 f8 ff ff       	jmp    80105806 <alltraps>

80105fb0 <vector81>:
.globl vector81
vector81:
  pushl $0
80105fb0:	6a 00                	push   $0x0
  pushl $81
80105fb2:	6a 51                	push   $0x51
  jmp alltraps
80105fb4:	e9 4d f8 ff ff       	jmp    80105806 <alltraps>

80105fb9 <vector82>:
.globl vector82
vector82:
  pushl $0
80105fb9:	6a 00                	push   $0x0
  pushl $82
80105fbb:	6a 52                	push   $0x52
  jmp alltraps
80105fbd:	e9 44 f8 ff ff       	jmp    80105806 <alltraps>

80105fc2 <vector83>:
.globl vector83
vector83:
  pushl $0
80105fc2:	6a 00                	push   $0x0
  pushl $83
80105fc4:	6a 53                	push   $0x53
  jmp alltraps
80105fc6:	e9 3b f8 ff ff       	jmp    80105806 <alltraps>

80105fcb <vector84>:
.globl vector84
vector84:
  pushl $0
80105fcb:	6a 00                	push   $0x0
  pushl $84
80105fcd:	6a 54                	push   $0x54
  jmp alltraps
80105fcf:	e9 32 f8 ff ff       	jmp    80105806 <alltraps>

80105fd4 <vector85>:
.globl vector85
vector85:
  pushl $0
80105fd4:	6a 00                	push   $0x0
  pushl $85
80105fd6:	6a 55                	push   $0x55
  jmp alltraps
80105fd8:	e9 29 f8 ff ff       	jmp    80105806 <alltraps>

80105fdd <vector86>:
.globl vector86
vector86:
  pushl $0
80105fdd:	6a 00                	push   $0x0
  pushl $86
80105fdf:	6a 56                	push   $0x56
  jmp alltraps
80105fe1:	e9 20 f8 ff ff       	jmp    80105806 <alltraps>

80105fe6 <vector87>:
.globl vector87
vector87:
  pushl $0
80105fe6:	6a 00                	push   $0x0
  pushl $87
80105fe8:	6a 57                	push   $0x57
  jmp alltraps
80105fea:	e9 17 f8 ff ff       	jmp    80105806 <alltraps>

80105fef <vector88>:
.globl vector88
vector88:
  pushl $0
80105fef:	6a 00                	push   $0x0
  pushl $88
80105ff1:	6a 58                	push   $0x58
  jmp alltraps
80105ff3:	e9 0e f8 ff ff       	jmp    80105806 <alltraps>

80105ff8 <vector89>:
.globl vector89
vector89:
  pushl $0
80105ff8:	6a 00                	push   $0x0
  pushl $89
80105ffa:	6a 59                	push   $0x59
  jmp alltraps
80105ffc:	e9 05 f8 ff ff       	jmp    80105806 <alltraps>

80106001 <vector90>:
.globl vector90
vector90:
  pushl $0
80106001:	6a 00                	push   $0x0
  pushl $90
80106003:	6a 5a                	push   $0x5a
  jmp alltraps
80106005:	e9 fc f7 ff ff       	jmp    80105806 <alltraps>

8010600a <vector91>:
.globl vector91
vector91:
  pushl $0
8010600a:	6a 00                	push   $0x0
  pushl $91
8010600c:	6a 5b                	push   $0x5b
  jmp alltraps
8010600e:	e9 f3 f7 ff ff       	jmp    80105806 <alltraps>

80106013 <vector92>:
.globl vector92
vector92:
  pushl $0
80106013:	6a 00                	push   $0x0
  pushl $92
80106015:	6a 5c                	push   $0x5c
  jmp alltraps
80106017:	e9 ea f7 ff ff       	jmp    80105806 <alltraps>

8010601c <vector93>:
.globl vector93
vector93:
  pushl $0
8010601c:	6a 00                	push   $0x0
  pushl $93
8010601e:	6a 5d                	push   $0x5d
  jmp alltraps
80106020:	e9 e1 f7 ff ff       	jmp    80105806 <alltraps>

80106025 <vector94>:
.globl vector94
vector94:
  pushl $0
80106025:	6a 00                	push   $0x0
  pushl $94
80106027:	6a 5e                	push   $0x5e
  jmp alltraps
80106029:	e9 d8 f7 ff ff       	jmp    80105806 <alltraps>

8010602e <vector95>:
.globl vector95
vector95:
  pushl $0
8010602e:	6a 00                	push   $0x0
  pushl $95
80106030:	6a 5f                	push   $0x5f
  jmp alltraps
80106032:	e9 cf f7 ff ff       	jmp    80105806 <alltraps>

80106037 <vector96>:
.globl vector96
vector96:
  pushl $0
80106037:	6a 00                	push   $0x0
  pushl $96
80106039:	6a 60                	push   $0x60
  jmp alltraps
8010603b:	e9 c6 f7 ff ff       	jmp    80105806 <alltraps>

80106040 <vector97>:
.globl vector97
vector97:
  pushl $0
80106040:	6a 00                	push   $0x0
  pushl $97
80106042:	6a 61                	push   $0x61
  jmp alltraps
80106044:	e9 bd f7 ff ff       	jmp    80105806 <alltraps>

80106049 <vector98>:
.globl vector98
vector98:
  pushl $0
80106049:	6a 00                	push   $0x0
  pushl $98
8010604b:	6a 62                	push   $0x62
  jmp alltraps
8010604d:	e9 b4 f7 ff ff       	jmp    80105806 <alltraps>

80106052 <vector99>:
.globl vector99
vector99:
  pushl $0
80106052:	6a 00                	push   $0x0
  pushl $99
80106054:	6a 63                	push   $0x63
  jmp alltraps
80106056:	e9 ab f7 ff ff       	jmp    80105806 <alltraps>

8010605b <vector100>:
.globl vector100
vector100:
  pushl $0
8010605b:	6a 00                	push   $0x0
  pushl $100
8010605d:	6a 64                	push   $0x64
  jmp alltraps
8010605f:	e9 a2 f7 ff ff       	jmp    80105806 <alltraps>

80106064 <vector101>:
.globl vector101
vector101:
  pushl $0
80106064:	6a 00                	push   $0x0
  pushl $101
80106066:	6a 65                	push   $0x65
  jmp alltraps
80106068:	e9 99 f7 ff ff       	jmp    80105806 <alltraps>

8010606d <vector102>:
.globl vector102
vector102:
  pushl $0
8010606d:	6a 00                	push   $0x0
  pushl $102
8010606f:	6a 66                	push   $0x66
  jmp alltraps
80106071:	e9 90 f7 ff ff       	jmp    80105806 <alltraps>

80106076 <vector103>:
.globl vector103
vector103:
  pushl $0
80106076:	6a 00                	push   $0x0
  pushl $103
80106078:	6a 67                	push   $0x67
  jmp alltraps
8010607a:	e9 87 f7 ff ff       	jmp    80105806 <alltraps>

8010607f <vector104>:
.globl vector104
vector104:
  pushl $0
8010607f:	6a 00                	push   $0x0
  pushl $104
80106081:	6a 68                	push   $0x68
  jmp alltraps
80106083:	e9 7e f7 ff ff       	jmp    80105806 <alltraps>

80106088 <vector105>:
.globl vector105
vector105:
  pushl $0
80106088:	6a 00                	push   $0x0
  pushl $105
8010608a:	6a 69                	push   $0x69
  jmp alltraps
8010608c:	e9 75 f7 ff ff       	jmp    80105806 <alltraps>

80106091 <vector106>:
.globl vector106
vector106:
  pushl $0
80106091:	6a 00                	push   $0x0
  pushl $106
80106093:	6a 6a                	push   $0x6a
  jmp alltraps
80106095:	e9 6c f7 ff ff       	jmp    80105806 <alltraps>

8010609a <vector107>:
.globl vector107
vector107:
  pushl $0
8010609a:	6a 00                	push   $0x0
  pushl $107
8010609c:	6a 6b                	push   $0x6b
  jmp alltraps
8010609e:	e9 63 f7 ff ff       	jmp    80105806 <alltraps>

801060a3 <vector108>:
.globl vector108
vector108:
  pushl $0
801060a3:	6a 00                	push   $0x0
  pushl $108
801060a5:	6a 6c                	push   $0x6c
  jmp alltraps
801060a7:	e9 5a f7 ff ff       	jmp    80105806 <alltraps>

801060ac <vector109>:
.globl vector109
vector109:
  pushl $0
801060ac:	6a 00                	push   $0x0
  pushl $109
801060ae:	6a 6d                	push   $0x6d
  jmp alltraps
801060b0:	e9 51 f7 ff ff       	jmp    80105806 <alltraps>

801060b5 <vector110>:
.globl vector110
vector110:
  pushl $0
801060b5:	6a 00                	push   $0x0
  pushl $110
801060b7:	6a 6e                	push   $0x6e
  jmp alltraps
801060b9:	e9 48 f7 ff ff       	jmp    80105806 <alltraps>

801060be <vector111>:
.globl vector111
vector111:
  pushl $0
801060be:	6a 00                	push   $0x0
  pushl $111
801060c0:	6a 6f                	push   $0x6f
  jmp alltraps
801060c2:	e9 3f f7 ff ff       	jmp    80105806 <alltraps>

801060c7 <vector112>:
.globl vector112
vector112:
  pushl $0
801060c7:	6a 00                	push   $0x0
  pushl $112
801060c9:	6a 70                	push   $0x70
  jmp alltraps
801060cb:	e9 36 f7 ff ff       	jmp    80105806 <alltraps>

801060d0 <vector113>:
.globl vector113
vector113:
  pushl $0
801060d0:	6a 00                	push   $0x0
  pushl $113
801060d2:	6a 71                	push   $0x71
  jmp alltraps
801060d4:	e9 2d f7 ff ff       	jmp    80105806 <alltraps>

801060d9 <vector114>:
.globl vector114
vector114:
  pushl $0
801060d9:	6a 00                	push   $0x0
  pushl $114
801060db:	6a 72                	push   $0x72
  jmp alltraps
801060dd:	e9 24 f7 ff ff       	jmp    80105806 <alltraps>

801060e2 <vector115>:
.globl vector115
vector115:
  pushl $0
801060e2:	6a 00                	push   $0x0
  pushl $115
801060e4:	6a 73                	push   $0x73
  jmp alltraps
801060e6:	e9 1b f7 ff ff       	jmp    80105806 <alltraps>

801060eb <vector116>:
.globl vector116
vector116:
  pushl $0
801060eb:	6a 00                	push   $0x0
  pushl $116
801060ed:	6a 74                	push   $0x74
  jmp alltraps
801060ef:	e9 12 f7 ff ff       	jmp    80105806 <alltraps>

801060f4 <vector117>:
.globl vector117
vector117:
  pushl $0
801060f4:	6a 00                	push   $0x0
  pushl $117
801060f6:	6a 75                	push   $0x75
  jmp alltraps
801060f8:	e9 09 f7 ff ff       	jmp    80105806 <alltraps>

801060fd <vector118>:
.globl vector118
vector118:
  pushl $0
801060fd:	6a 00                	push   $0x0
  pushl $118
801060ff:	6a 76                	push   $0x76
  jmp alltraps
80106101:	e9 00 f7 ff ff       	jmp    80105806 <alltraps>

80106106 <vector119>:
.globl vector119
vector119:
  pushl $0
80106106:	6a 00                	push   $0x0
  pushl $119
80106108:	6a 77                	push   $0x77
  jmp alltraps
8010610a:	e9 f7 f6 ff ff       	jmp    80105806 <alltraps>

8010610f <vector120>:
.globl vector120
vector120:
  pushl $0
8010610f:	6a 00                	push   $0x0
  pushl $120
80106111:	6a 78                	push   $0x78
  jmp alltraps
80106113:	e9 ee f6 ff ff       	jmp    80105806 <alltraps>

80106118 <vector121>:
.globl vector121
vector121:
  pushl $0
80106118:	6a 00                	push   $0x0
  pushl $121
8010611a:	6a 79                	push   $0x79
  jmp alltraps
8010611c:	e9 e5 f6 ff ff       	jmp    80105806 <alltraps>

80106121 <vector122>:
.globl vector122
vector122:
  pushl $0
80106121:	6a 00                	push   $0x0
  pushl $122
80106123:	6a 7a                	push   $0x7a
  jmp alltraps
80106125:	e9 dc f6 ff ff       	jmp    80105806 <alltraps>

8010612a <vector123>:
.globl vector123
vector123:
  pushl $0
8010612a:	6a 00                	push   $0x0
  pushl $123
8010612c:	6a 7b                	push   $0x7b
  jmp alltraps
8010612e:	e9 d3 f6 ff ff       	jmp    80105806 <alltraps>

80106133 <vector124>:
.globl vector124
vector124:
  pushl $0
80106133:	6a 00                	push   $0x0
  pushl $124
80106135:	6a 7c                	push   $0x7c
  jmp alltraps
80106137:	e9 ca f6 ff ff       	jmp    80105806 <alltraps>

8010613c <vector125>:
.globl vector125
vector125:
  pushl $0
8010613c:	6a 00                	push   $0x0
  pushl $125
8010613e:	6a 7d                	push   $0x7d
  jmp alltraps
80106140:	e9 c1 f6 ff ff       	jmp    80105806 <alltraps>

80106145 <vector126>:
.globl vector126
vector126:
  pushl $0
80106145:	6a 00                	push   $0x0
  pushl $126
80106147:	6a 7e                	push   $0x7e
  jmp alltraps
80106149:	e9 b8 f6 ff ff       	jmp    80105806 <alltraps>

8010614e <vector127>:
.globl vector127
vector127:
  pushl $0
8010614e:	6a 00                	push   $0x0
  pushl $127
80106150:	6a 7f                	push   $0x7f
  jmp alltraps
80106152:	e9 af f6 ff ff       	jmp    80105806 <alltraps>

80106157 <vector128>:
.globl vector128
vector128:
  pushl $0
80106157:	6a 00                	push   $0x0
  pushl $128
80106159:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010615e:	e9 a3 f6 ff ff       	jmp    80105806 <alltraps>

80106163 <vector129>:
.globl vector129
vector129:
  pushl $0
80106163:	6a 00                	push   $0x0
  pushl $129
80106165:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010616a:	e9 97 f6 ff ff       	jmp    80105806 <alltraps>

8010616f <vector130>:
.globl vector130
vector130:
  pushl $0
8010616f:	6a 00                	push   $0x0
  pushl $130
80106171:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106176:	e9 8b f6 ff ff       	jmp    80105806 <alltraps>

8010617b <vector131>:
.globl vector131
vector131:
  pushl $0
8010617b:	6a 00                	push   $0x0
  pushl $131
8010617d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106182:	e9 7f f6 ff ff       	jmp    80105806 <alltraps>

80106187 <vector132>:
.globl vector132
vector132:
  pushl $0
80106187:	6a 00                	push   $0x0
  pushl $132
80106189:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010618e:	e9 73 f6 ff ff       	jmp    80105806 <alltraps>

80106193 <vector133>:
.globl vector133
vector133:
  pushl $0
80106193:	6a 00                	push   $0x0
  pushl $133
80106195:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010619a:	e9 67 f6 ff ff       	jmp    80105806 <alltraps>

8010619f <vector134>:
.globl vector134
vector134:
  pushl $0
8010619f:	6a 00                	push   $0x0
  pushl $134
801061a1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801061a6:	e9 5b f6 ff ff       	jmp    80105806 <alltraps>

801061ab <vector135>:
.globl vector135
vector135:
  pushl $0
801061ab:	6a 00                	push   $0x0
  pushl $135
801061ad:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801061b2:	e9 4f f6 ff ff       	jmp    80105806 <alltraps>

801061b7 <vector136>:
.globl vector136
vector136:
  pushl $0
801061b7:	6a 00                	push   $0x0
  pushl $136
801061b9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801061be:	e9 43 f6 ff ff       	jmp    80105806 <alltraps>

801061c3 <vector137>:
.globl vector137
vector137:
  pushl $0
801061c3:	6a 00                	push   $0x0
  pushl $137
801061c5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801061ca:	e9 37 f6 ff ff       	jmp    80105806 <alltraps>

801061cf <vector138>:
.globl vector138
vector138:
  pushl $0
801061cf:	6a 00                	push   $0x0
  pushl $138
801061d1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801061d6:	e9 2b f6 ff ff       	jmp    80105806 <alltraps>

801061db <vector139>:
.globl vector139
vector139:
  pushl $0
801061db:	6a 00                	push   $0x0
  pushl $139
801061dd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801061e2:	e9 1f f6 ff ff       	jmp    80105806 <alltraps>

801061e7 <vector140>:
.globl vector140
vector140:
  pushl $0
801061e7:	6a 00                	push   $0x0
  pushl $140
801061e9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801061ee:	e9 13 f6 ff ff       	jmp    80105806 <alltraps>

801061f3 <vector141>:
.globl vector141
vector141:
  pushl $0
801061f3:	6a 00                	push   $0x0
  pushl $141
801061f5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801061fa:	e9 07 f6 ff ff       	jmp    80105806 <alltraps>

801061ff <vector142>:
.globl vector142
vector142:
  pushl $0
801061ff:	6a 00                	push   $0x0
  pushl $142
80106201:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106206:	e9 fb f5 ff ff       	jmp    80105806 <alltraps>

8010620b <vector143>:
.globl vector143
vector143:
  pushl $0
8010620b:	6a 00                	push   $0x0
  pushl $143
8010620d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106212:	e9 ef f5 ff ff       	jmp    80105806 <alltraps>

80106217 <vector144>:
.globl vector144
vector144:
  pushl $0
80106217:	6a 00                	push   $0x0
  pushl $144
80106219:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010621e:	e9 e3 f5 ff ff       	jmp    80105806 <alltraps>

80106223 <vector145>:
.globl vector145
vector145:
  pushl $0
80106223:	6a 00                	push   $0x0
  pushl $145
80106225:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010622a:	e9 d7 f5 ff ff       	jmp    80105806 <alltraps>

8010622f <vector146>:
.globl vector146
vector146:
  pushl $0
8010622f:	6a 00                	push   $0x0
  pushl $146
80106231:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106236:	e9 cb f5 ff ff       	jmp    80105806 <alltraps>

8010623b <vector147>:
.globl vector147
vector147:
  pushl $0
8010623b:	6a 00                	push   $0x0
  pushl $147
8010623d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106242:	e9 bf f5 ff ff       	jmp    80105806 <alltraps>

80106247 <vector148>:
.globl vector148
vector148:
  pushl $0
80106247:	6a 00                	push   $0x0
  pushl $148
80106249:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010624e:	e9 b3 f5 ff ff       	jmp    80105806 <alltraps>

80106253 <vector149>:
.globl vector149
vector149:
  pushl $0
80106253:	6a 00                	push   $0x0
  pushl $149
80106255:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010625a:	e9 a7 f5 ff ff       	jmp    80105806 <alltraps>

8010625f <vector150>:
.globl vector150
vector150:
  pushl $0
8010625f:	6a 00                	push   $0x0
  pushl $150
80106261:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106266:	e9 9b f5 ff ff       	jmp    80105806 <alltraps>

8010626b <vector151>:
.globl vector151
vector151:
  pushl $0
8010626b:	6a 00                	push   $0x0
  pushl $151
8010626d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106272:	e9 8f f5 ff ff       	jmp    80105806 <alltraps>

80106277 <vector152>:
.globl vector152
vector152:
  pushl $0
80106277:	6a 00                	push   $0x0
  pushl $152
80106279:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010627e:	e9 83 f5 ff ff       	jmp    80105806 <alltraps>

80106283 <vector153>:
.globl vector153
vector153:
  pushl $0
80106283:	6a 00                	push   $0x0
  pushl $153
80106285:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010628a:	e9 77 f5 ff ff       	jmp    80105806 <alltraps>

8010628f <vector154>:
.globl vector154
vector154:
  pushl $0
8010628f:	6a 00                	push   $0x0
  pushl $154
80106291:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106296:	e9 6b f5 ff ff       	jmp    80105806 <alltraps>

8010629b <vector155>:
.globl vector155
vector155:
  pushl $0
8010629b:	6a 00                	push   $0x0
  pushl $155
8010629d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801062a2:	e9 5f f5 ff ff       	jmp    80105806 <alltraps>

801062a7 <vector156>:
.globl vector156
vector156:
  pushl $0
801062a7:	6a 00                	push   $0x0
  pushl $156
801062a9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801062ae:	e9 53 f5 ff ff       	jmp    80105806 <alltraps>

801062b3 <vector157>:
.globl vector157
vector157:
  pushl $0
801062b3:	6a 00                	push   $0x0
  pushl $157
801062b5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801062ba:	e9 47 f5 ff ff       	jmp    80105806 <alltraps>

801062bf <vector158>:
.globl vector158
vector158:
  pushl $0
801062bf:	6a 00                	push   $0x0
  pushl $158
801062c1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801062c6:	e9 3b f5 ff ff       	jmp    80105806 <alltraps>

801062cb <vector159>:
.globl vector159
vector159:
  pushl $0
801062cb:	6a 00                	push   $0x0
  pushl $159
801062cd:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801062d2:	e9 2f f5 ff ff       	jmp    80105806 <alltraps>

801062d7 <vector160>:
.globl vector160
vector160:
  pushl $0
801062d7:	6a 00                	push   $0x0
  pushl $160
801062d9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801062de:	e9 23 f5 ff ff       	jmp    80105806 <alltraps>

801062e3 <vector161>:
.globl vector161
vector161:
  pushl $0
801062e3:	6a 00                	push   $0x0
  pushl $161
801062e5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801062ea:	e9 17 f5 ff ff       	jmp    80105806 <alltraps>

801062ef <vector162>:
.globl vector162
vector162:
  pushl $0
801062ef:	6a 00                	push   $0x0
  pushl $162
801062f1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801062f6:	e9 0b f5 ff ff       	jmp    80105806 <alltraps>

801062fb <vector163>:
.globl vector163
vector163:
  pushl $0
801062fb:	6a 00                	push   $0x0
  pushl $163
801062fd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106302:	e9 ff f4 ff ff       	jmp    80105806 <alltraps>

80106307 <vector164>:
.globl vector164
vector164:
  pushl $0
80106307:	6a 00                	push   $0x0
  pushl $164
80106309:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010630e:	e9 f3 f4 ff ff       	jmp    80105806 <alltraps>

80106313 <vector165>:
.globl vector165
vector165:
  pushl $0
80106313:	6a 00                	push   $0x0
  pushl $165
80106315:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010631a:	e9 e7 f4 ff ff       	jmp    80105806 <alltraps>

8010631f <vector166>:
.globl vector166
vector166:
  pushl $0
8010631f:	6a 00                	push   $0x0
  pushl $166
80106321:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106326:	e9 db f4 ff ff       	jmp    80105806 <alltraps>

8010632b <vector167>:
.globl vector167
vector167:
  pushl $0
8010632b:	6a 00                	push   $0x0
  pushl $167
8010632d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106332:	e9 cf f4 ff ff       	jmp    80105806 <alltraps>

80106337 <vector168>:
.globl vector168
vector168:
  pushl $0
80106337:	6a 00                	push   $0x0
  pushl $168
80106339:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010633e:	e9 c3 f4 ff ff       	jmp    80105806 <alltraps>

80106343 <vector169>:
.globl vector169
vector169:
  pushl $0
80106343:	6a 00                	push   $0x0
  pushl $169
80106345:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010634a:	e9 b7 f4 ff ff       	jmp    80105806 <alltraps>

8010634f <vector170>:
.globl vector170
vector170:
  pushl $0
8010634f:	6a 00                	push   $0x0
  pushl $170
80106351:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106356:	e9 ab f4 ff ff       	jmp    80105806 <alltraps>

8010635b <vector171>:
.globl vector171
vector171:
  pushl $0
8010635b:	6a 00                	push   $0x0
  pushl $171
8010635d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106362:	e9 9f f4 ff ff       	jmp    80105806 <alltraps>

80106367 <vector172>:
.globl vector172
vector172:
  pushl $0
80106367:	6a 00                	push   $0x0
  pushl $172
80106369:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010636e:	e9 93 f4 ff ff       	jmp    80105806 <alltraps>

80106373 <vector173>:
.globl vector173
vector173:
  pushl $0
80106373:	6a 00                	push   $0x0
  pushl $173
80106375:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010637a:	e9 87 f4 ff ff       	jmp    80105806 <alltraps>

8010637f <vector174>:
.globl vector174
vector174:
  pushl $0
8010637f:	6a 00                	push   $0x0
  pushl $174
80106381:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106386:	e9 7b f4 ff ff       	jmp    80105806 <alltraps>

8010638b <vector175>:
.globl vector175
vector175:
  pushl $0
8010638b:	6a 00                	push   $0x0
  pushl $175
8010638d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106392:	e9 6f f4 ff ff       	jmp    80105806 <alltraps>

80106397 <vector176>:
.globl vector176
vector176:
  pushl $0
80106397:	6a 00                	push   $0x0
  pushl $176
80106399:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010639e:	e9 63 f4 ff ff       	jmp    80105806 <alltraps>

801063a3 <vector177>:
.globl vector177
vector177:
  pushl $0
801063a3:	6a 00                	push   $0x0
  pushl $177
801063a5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801063aa:	e9 57 f4 ff ff       	jmp    80105806 <alltraps>

801063af <vector178>:
.globl vector178
vector178:
  pushl $0
801063af:	6a 00                	push   $0x0
  pushl $178
801063b1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801063b6:	e9 4b f4 ff ff       	jmp    80105806 <alltraps>

801063bb <vector179>:
.globl vector179
vector179:
  pushl $0
801063bb:	6a 00                	push   $0x0
  pushl $179
801063bd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801063c2:	e9 3f f4 ff ff       	jmp    80105806 <alltraps>

801063c7 <vector180>:
.globl vector180
vector180:
  pushl $0
801063c7:	6a 00                	push   $0x0
  pushl $180
801063c9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801063ce:	e9 33 f4 ff ff       	jmp    80105806 <alltraps>

801063d3 <vector181>:
.globl vector181
vector181:
  pushl $0
801063d3:	6a 00                	push   $0x0
  pushl $181
801063d5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801063da:	e9 27 f4 ff ff       	jmp    80105806 <alltraps>

801063df <vector182>:
.globl vector182
vector182:
  pushl $0
801063df:	6a 00                	push   $0x0
  pushl $182
801063e1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801063e6:	e9 1b f4 ff ff       	jmp    80105806 <alltraps>

801063eb <vector183>:
.globl vector183
vector183:
  pushl $0
801063eb:	6a 00                	push   $0x0
  pushl $183
801063ed:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801063f2:	e9 0f f4 ff ff       	jmp    80105806 <alltraps>

801063f7 <vector184>:
.globl vector184
vector184:
  pushl $0
801063f7:	6a 00                	push   $0x0
  pushl $184
801063f9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801063fe:	e9 03 f4 ff ff       	jmp    80105806 <alltraps>

80106403 <vector185>:
.globl vector185
vector185:
  pushl $0
80106403:	6a 00                	push   $0x0
  pushl $185
80106405:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010640a:	e9 f7 f3 ff ff       	jmp    80105806 <alltraps>

8010640f <vector186>:
.globl vector186
vector186:
  pushl $0
8010640f:	6a 00                	push   $0x0
  pushl $186
80106411:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106416:	e9 eb f3 ff ff       	jmp    80105806 <alltraps>

8010641b <vector187>:
.globl vector187
vector187:
  pushl $0
8010641b:	6a 00                	push   $0x0
  pushl $187
8010641d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106422:	e9 df f3 ff ff       	jmp    80105806 <alltraps>

80106427 <vector188>:
.globl vector188
vector188:
  pushl $0
80106427:	6a 00                	push   $0x0
  pushl $188
80106429:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010642e:	e9 d3 f3 ff ff       	jmp    80105806 <alltraps>

80106433 <vector189>:
.globl vector189
vector189:
  pushl $0
80106433:	6a 00                	push   $0x0
  pushl $189
80106435:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010643a:	e9 c7 f3 ff ff       	jmp    80105806 <alltraps>

8010643f <vector190>:
.globl vector190
vector190:
  pushl $0
8010643f:	6a 00                	push   $0x0
  pushl $190
80106441:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106446:	e9 bb f3 ff ff       	jmp    80105806 <alltraps>

8010644b <vector191>:
.globl vector191
vector191:
  pushl $0
8010644b:	6a 00                	push   $0x0
  pushl $191
8010644d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106452:	e9 af f3 ff ff       	jmp    80105806 <alltraps>

80106457 <vector192>:
.globl vector192
vector192:
  pushl $0
80106457:	6a 00                	push   $0x0
  pushl $192
80106459:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010645e:	e9 a3 f3 ff ff       	jmp    80105806 <alltraps>

80106463 <vector193>:
.globl vector193
vector193:
  pushl $0
80106463:	6a 00                	push   $0x0
  pushl $193
80106465:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010646a:	e9 97 f3 ff ff       	jmp    80105806 <alltraps>

8010646f <vector194>:
.globl vector194
vector194:
  pushl $0
8010646f:	6a 00                	push   $0x0
  pushl $194
80106471:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106476:	e9 8b f3 ff ff       	jmp    80105806 <alltraps>

8010647b <vector195>:
.globl vector195
vector195:
  pushl $0
8010647b:	6a 00                	push   $0x0
  pushl $195
8010647d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106482:	e9 7f f3 ff ff       	jmp    80105806 <alltraps>

80106487 <vector196>:
.globl vector196
vector196:
  pushl $0
80106487:	6a 00                	push   $0x0
  pushl $196
80106489:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010648e:	e9 73 f3 ff ff       	jmp    80105806 <alltraps>

80106493 <vector197>:
.globl vector197
vector197:
  pushl $0
80106493:	6a 00                	push   $0x0
  pushl $197
80106495:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010649a:	e9 67 f3 ff ff       	jmp    80105806 <alltraps>

8010649f <vector198>:
.globl vector198
vector198:
  pushl $0
8010649f:	6a 00                	push   $0x0
  pushl $198
801064a1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801064a6:	e9 5b f3 ff ff       	jmp    80105806 <alltraps>

801064ab <vector199>:
.globl vector199
vector199:
  pushl $0
801064ab:	6a 00                	push   $0x0
  pushl $199
801064ad:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801064b2:	e9 4f f3 ff ff       	jmp    80105806 <alltraps>

801064b7 <vector200>:
.globl vector200
vector200:
  pushl $0
801064b7:	6a 00                	push   $0x0
  pushl $200
801064b9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801064be:	e9 43 f3 ff ff       	jmp    80105806 <alltraps>

801064c3 <vector201>:
.globl vector201
vector201:
  pushl $0
801064c3:	6a 00                	push   $0x0
  pushl $201
801064c5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801064ca:	e9 37 f3 ff ff       	jmp    80105806 <alltraps>

801064cf <vector202>:
.globl vector202
vector202:
  pushl $0
801064cf:	6a 00                	push   $0x0
  pushl $202
801064d1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801064d6:	e9 2b f3 ff ff       	jmp    80105806 <alltraps>

801064db <vector203>:
.globl vector203
vector203:
  pushl $0
801064db:	6a 00                	push   $0x0
  pushl $203
801064dd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801064e2:	e9 1f f3 ff ff       	jmp    80105806 <alltraps>

801064e7 <vector204>:
.globl vector204
vector204:
  pushl $0
801064e7:	6a 00                	push   $0x0
  pushl $204
801064e9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801064ee:	e9 13 f3 ff ff       	jmp    80105806 <alltraps>

801064f3 <vector205>:
.globl vector205
vector205:
  pushl $0
801064f3:	6a 00                	push   $0x0
  pushl $205
801064f5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801064fa:	e9 07 f3 ff ff       	jmp    80105806 <alltraps>

801064ff <vector206>:
.globl vector206
vector206:
  pushl $0
801064ff:	6a 00                	push   $0x0
  pushl $206
80106501:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106506:	e9 fb f2 ff ff       	jmp    80105806 <alltraps>

8010650b <vector207>:
.globl vector207
vector207:
  pushl $0
8010650b:	6a 00                	push   $0x0
  pushl $207
8010650d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106512:	e9 ef f2 ff ff       	jmp    80105806 <alltraps>

80106517 <vector208>:
.globl vector208
vector208:
  pushl $0
80106517:	6a 00                	push   $0x0
  pushl $208
80106519:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010651e:	e9 e3 f2 ff ff       	jmp    80105806 <alltraps>

80106523 <vector209>:
.globl vector209
vector209:
  pushl $0
80106523:	6a 00                	push   $0x0
  pushl $209
80106525:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010652a:	e9 d7 f2 ff ff       	jmp    80105806 <alltraps>

8010652f <vector210>:
.globl vector210
vector210:
  pushl $0
8010652f:	6a 00                	push   $0x0
  pushl $210
80106531:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106536:	e9 cb f2 ff ff       	jmp    80105806 <alltraps>

8010653b <vector211>:
.globl vector211
vector211:
  pushl $0
8010653b:	6a 00                	push   $0x0
  pushl $211
8010653d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106542:	e9 bf f2 ff ff       	jmp    80105806 <alltraps>

80106547 <vector212>:
.globl vector212
vector212:
  pushl $0
80106547:	6a 00                	push   $0x0
  pushl $212
80106549:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010654e:	e9 b3 f2 ff ff       	jmp    80105806 <alltraps>

80106553 <vector213>:
.globl vector213
vector213:
  pushl $0
80106553:	6a 00                	push   $0x0
  pushl $213
80106555:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010655a:	e9 a7 f2 ff ff       	jmp    80105806 <alltraps>

8010655f <vector214>:
.globl vector214
vector214:
  pushl $0
8010655f:	6a 00                	push   $0x0
  pushl $214
80106561:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106566:	e9 9b f2 ff ff       	jmp    80105806 <alltraps>

8010656b <vector215>:
.globl vector215
vector215:
  pushl $0
8010656b:	6a 00                	push   $0x0
  pushl $215
8010656d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106572:	e9 8f f2 ff ff       	jmp    80105806 <alltraps>

80106577 <vector216>:
.globl vector216
vector216:
  pushl $0
80106577:	6a 00                	push   $0x0
  pushl $216
80106579:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010657e:	e9 83 f2 ff ff       	jmp    80105806 <alltraps>

80106583 <vector217>:
.globl vector217
vector217:
  pushl $0
80106583:	6a 00                	push   $0x0
  pushl $217
80106585:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010658a:	e9 77 f2 ff ff       	jmp    80105806 <alltraps>

8010658f <vector218>:
.globl vector218
vector218:
  pushl $0
8010658f:	6a 00                	push   $0x0
  pushl $218
80106591:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106596:	e9 6b f2 ff ff       	jmp    80105806 <alltraps>

8010659b <vector219>:
.globl vector219
vector219:
  pushl $0
8010659b:	6a 00                	push   $0x0
  pushl $219
8010659d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801065a2:	e9 5f f2 ff ff       	jmp    80105806 <alltraps>

801065a7 <vector220>:
.globl vector220
vector220:
  pushl $0
801065a7:	6a 00                	push   $0x0
  pushl $220
801065a9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801065ae:	e9 53 f2 ff ff       	jmp    80105806 <alltraps>

801065b3 <vector221>:
.globl vector221
vector221:
  pushl $0
801065b3:	6a 00                	push   $0x0
  pushl $221
801065b5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801065ba:	e9 47 f2 ff ff       	jmp    80105806 <alltraps>

801065bf <vector222>:
.globl vector222
vector222:
  pushl $0
801065bf:	6a 00                	push   $0x0
  pushl $222
801065c1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801065c6:	e9 3b f2 ff ff       	jmp    80105806 <alltraps>

801065cb <vector223>:
.globl vector223
vector223:
  pushl $0
801065cb:	6a 00                	push   $0x0
  pushl $223
801065cd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801065d2:	e9 2f f2 ff ff       	jmp    80105806 <alltraps>

801065d7 <vector224>:
.globl vector224
vector224:
  pushl $0
801065d7:	6a 00                	push   $0x0
  pushl $224
801065d9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801065de:	e9 23 f2 ff ff       	jmp    80105806 <alltraps>

801065e3 <vector225>:
.globl vector225
vector225:
  pushl $0
801065e3:	6a 00                	push   $0x0
  pushl $225
801065e5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801065ea:	e9 17 f2 ff ff       	jmp    80105806 <alltraps>

801065ef <vector226>:
.globl vector226
vector226:
  pushl $0
801065ef:	6a 00                	push   $0x0
  pushl $226
801065f1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801065f6:	e9 0b f2 ff ff       	jmp    80105806 <alltraps>

801065fb <vector227>:
.globl vector227
vector227:
  pushl $0
801065fb:	6a 00                	push   $0x0
  pushl $227
801065fd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106602:	e9 ff f1 ff ff       	jmp    80105806 <alltraps>

80106607 <vector228>:
.globl vector228
vector228:
  pushl $0
80106607:	6a 00                	push   $0x0
  pushl $228
80106609:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010660e:	e9 f3 f1 ff ff       	jmp    80105806 <alltraps>

80106613 <vector229>:
.globl vector229
vector229:
  pushl $0
80106613:	6a 00                	push   $0x0
  pushl $229
80106615:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010661a:	e9 e7 f1 ff ff       	jmp    80105806 <alltraps>

8010661f <vector230>:
.globl vector230
vector230:
  pushl $0
8010661f:	6a 00                	push   $0x0
  pushl $230
80106621:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106626:	e9 db f1 ff ff       	jmp    80105806 <alltraps>

8010662b <vector231>:
.globl vector231
vector231:
  pushl $0
8010662b:	6a 00                	push   $0x0
  pushl $231
8010662d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106632:	e9 cf f1 ff ff       	jmp    80105806 <alltraps>

80106637 <vector232>:
.globl vector232
vector232:
  pushl $0
80106637:	6a 00                	push   $0x0
  pushl $232
80106639:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010663e:	e9 c3 f1 ff ff       	jmp    80105806 <alltraps>

80106643 <vector233>:
.globl vector233
vector233:
  pushl $0
80106643:	6a 00                	push   $0x0
  pushl $233
80106645:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010664a:	e9 b7 f1 ff ff       	jmp    80105806 <alltraps>

8010664f <vector234>:
.globl vector234
vector234:
  pushl $0
8010664f:	6a 00                	push   $0x0
  pushl $234
80106651:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106656:	e9 ab f1 ff ff       	jmp    80105806 <alltraps>

8010665b <vector235>:
.globl vector235
vector235:
  pushl $0
8010665b:	6a 00                	push   $0x0
  pushl $235
8010665d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106662:	e9 9f f1 ff ff       	jmp    80105806 <alltraps>

80106667 <vector236>:
.globl vector236
vector236:
  pushl $0
80106667:	6a 00                	push   $0x0
  pushl $236
80106669:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010666e:	e9 93 f1 ff ff       	jmp    80105806 <alltraps>

80106673 <vector237>:
.globl vector237
vector237:
  pushl $0
80106673:	6a 00                	push   $0x0
  pushl $237
80106675:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010667a:	e9 87 f1 ff ff       	jmp    80105806 <alltraps>

8010667f <vector238>:
.globl vector238
vector238:
  pushl $0
8010667f:	6a 00                	push   $0x0
  pushl $238
80106681:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106686:	e9 7b f1 ff ff       	jmp    80105806 <alltraps>

8010668b <vector239>:
.globl vector239
vector239:
  pushl $0
8010668b:	6a 00                	push   $0x0
  pushl $239
8010668d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106692:	e9 6f f1 ff ff       	jmp    80105806 <alltraps>

80106697 <vector240>:
.globl vector240
vector240:
  pushl $0
80106697:	6a 00                	push   $0x0
  pushl $240
80106699:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010669e:	e9 63 f1 ff ff       	jmp    80105806 <alltraps>

801066a3 <vector241>:
.globl vector241
vector241:
  pushl $0
801066a3:	6a 00                	push   $0x0
  pushl $241
801066a5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801066aa:	e9 57 f1 ff ff       	jmp    80105806 <alltraps>

801066af <vector242>:
.globl vector242
vector242:
  pushl $0
801066af:	6a 00                	push   $0x0
  pushl $242
801066b1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801066b6:	e9 4b f1 ff ff       	jmp    80105806 <alltraps>

801066bb <vector243>:
.globl vector243
vector243:
  pushl $0
801066bb:	6a 00                	push   $0x0
  pushl $243
801066bd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801066c2:	e9 3f f1 ff ff       	jmp    80105806 <alltraps>

801066c7 <vector244>:
.globl vector244
vector244:
  pushl $0
801066c7:	6a 00                	push   $0x0
  pushl $244
801066c9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801066ce:	e9 33 f1 ff ff       	jmp    80105806 <alltraps>

801066d3 <vector245>:
.globl vector245
vector245:
  pushl $0
801066d3:	6a 00                	push   $0x0
  pushl $245
801066d5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801066da:	e9 27 f1 ff ff       	jmp    80105806 <alltraps>

801066df <vector246>:
.globl vector246
vector246:
  pushl $0
801066df:	6a 00                	push   $0x0
  pushl $246
801066e1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801066e6:	e9 1b f1 ff ff       	jmp    80105806 <alltraps>

801066eb <vector247>:
.globl vector247
vector247:
  pushl $0
801066eb:	6a 00                	push   $0x0
  pushl $247
801066ed:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801066f2:	e9 0f f1 ff ff       	jmp    80105806 <alltraps>

801066f7 <vector248>:
.globl vector248
vector248:
  pushl $0
801066f7:	6a 00                	push   $0x0
  pushl $248
801066f9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801066fe:	e9 03 f1 ff ff       	jmp    80105806 <alltraps>

80106703 <vector249>:
.globl vector249
vector249:
  pushl $0
80106703:	6a 00                	push   $0x0
  pushl $249
80106705:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010670a:	e9 f7 f0 ff ff       	jmp    80105806 <alltraps>

8010670f <vector250>:
.globl vector250
vector250:
  pushl $0
8010670f:	6a 00                	push   $0x0
  pushl $250
80106711:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106716:	e9 eb f0 ff ff       	jmp    80105806 <alltraps>

8010671b <vector251>:
.globl vector251
vector251:
  pushl $0
8010671b:	6a 00                	push   $0x0
  pushl $251
8010671d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106722:	e9 df f0 ff ff       	jmp    80105806 <alltraps>

80106727 <vector252>:
.globl vector252
vector252:
  pushl $0
80106727:	6a 00                	push   $0x0
  pushl $252
80106729:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010672e:	e9 d3 f0 ff ff       	jmp    80105806 <alltraps>

80106733 <vector253>:
.globl vector253
vector253:
  pushl $0
80106733:	6a 00                	push   $0x0
  pushl $253
80106735:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010673a:	e9 c7 f0 ff ff       	jmp    80105806 <alltraps>

8010673f <vector254>:
.globl vector254
vector254:
  pushl $0
8010673f:	6a 00                	push   $0x0
  pushl $254
80106741:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106746:	e9 bb f0 ff ff       	jmp    80105806 <alltraps>

8010674b <vector255>:
.globl vector255
vector255:
  pushl $0
8010674b:	6a 00                	push   $0x0
  pushl $255
8010674d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106752:	e9 af f0 ff ff       	jmp    80105806 <alltraps>
80106757:	66 90                	xchg   %ax,%ax
80106759:	66 90                	xchg   %ax,%ax
8010675b:	66 90                	xchg   %ax,%ax
8010675d:	66 90                	xchg   %ax,%ax
8010675f:	90                   	nop

80106760 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106760:	55                   	push   %ebp
80106761:	89 e5                	mov    %esp,%ebp
80106763:	57                   	push   %edi
80106764:	56                   	push   %esi
80106765:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106766:	89 d3                	mov    %edx,%ebx
{
80106768:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010676a:	c1 eb 16             	shr    $0x16,%ebx
8010676d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106770:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106773:	8b 06                	mov    (%esi),%eax
80106775:	a8 01                	test   $0x1,%al
80106777:	74 27                	je     801067a0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106779:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010677e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106784:	c1 ef 0a             	shr    $0xa,%edi
}
80106787:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
8010678a:	89 fa                	mov    %edi,%edx
8010678c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106792:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106795:	5b                   	pop    %ebx
80106796:	5e                   	pop    %esi
80106797:	5f                   	pop    %edi
80106798:	5d                   	pop    %ebp
80106799:	c3                   	ret    
8010679a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801067a0:	85 c9                	test   %ecx,%ecx
801067a2:	74 2c                	je     801067d0 <walkpgdir+0x70>
801067a4:	e8 37 bd ff ff       	call   801024e0 <kalloc>
801067a9:	85 c0                	test   %eax,%eax
801067ab:	89 c3                	mov    %eax,%ebx
801067ad:	74 21                	je     801067d0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
801067af:	83 ec 04             	sub    $0x4,%esp
801067b2:	68 00 10 00 00       	push   $0x1000
801067b7:	6a 00                	push   $0x0
801067b9:	50                   	push   %eax
801067ba:	e8 21 de ff ff       	call   801045e0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801067bf:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801067c5:	83 c4 10             	add    $0x10,%esp
801067c8:	83 c8 07             	or     $0x7,%eax
801067cb:	89 06                	mov    %eax,(%esi)
801067cd:	eb b5                	jmp    80106784 <walkpgdir+0x24>
801067cf:	90                   	nop
}
801067d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801067d3:	31 c0                	xor    %eax,%eax
}
801067d5:	5b                   	pop    %ebx
801067d6:	5e                   	pop    %esi
801067d7:	5f                   	pop    %edi
801067d8:	5d                   	pop    %ebp
801067d9:	c3                   	ret    
801067da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801067e0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801067e0:	55                   	push   %ebp
801067e1:	89 e5                	mov    %esp,%ebp
801067e3:	57                   	push   %edi
801067e4:	56                   	push   %esi
801067e5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801067e6:	89 d3                	mov    %edx,%ebx
801067e8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
801067ee:	83 ec 1c             	sub    $0x1c,%esp
801067f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801067f4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801067f8:	8b 7d 08             	mov    0x8(%ebp),%edi
801067fb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106800:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106803:	8b 45 0c             	mov    0xc(%ebp),%eax
80106806:	29 df                	sub    %ebx,%edi
80106808:	83 c8 01             	or     $0x1,%eax
8010680b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010680e:	eb 15                	jmp    80106825 <mappages+0x45>
    if(*pte & PTE_P)
80106810:	f6 00 01             	testb  $0x1,(%eax)
80106813:	75 45                	jne    8010685a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80106815:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106818:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
8010681b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010681d:	74 31                	je     80106850 <mappages+0x70>
      break;
    a += PGSIZE;
8010681f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106825:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106828:	b9 01 00 00 00       	mov    $0x1,%ecx
8010682d:	89 da                	mov    %ebx,%edx
8010682f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106832:	e8 29 ff ff ff       	call   80106760 <walkpgdir>
80106837:	85 c0                	test   %eax,%eax
80106839:	75 d5                	jne    80106810 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010683b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010683e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106843:	5b                   	pop    %ebx
80106844:	5e                   	pop    %esi
80106845:	5f                   	pop    %edi
80106846:	5d                   	pop    %ebp
80106847:	c3                   	ret    
80106848:	90                   	nop
80106849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106850:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106853:	31 c0                	xor    %eax,%eax
}
80106855:	5b                   	pop    %ebx
80106856:	5e                   	pop    %esi
80106857:	5f                   	pop    %edi
80106858:	5d                   	pop    %ebp
80106859:	c3                   	ret    
      panic("remap");
8010685a:	83 ec 0c             	sub    $0xc,%esp
8010685d:	68 8c 7b 10 80       	push   $0x80107b8c
80106862:	e8 29 9b ff ff       	call   80100390 <panic>
80106867:	89 f6                	mov    %esi,%esi
80106869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106870 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106870:	55                   	push   %ebp
80106871:	89 e5                	mov    %esp,%ebp
80106873:	57                   	push   %edi
80106874:	56                   	push   %esi
80106875:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106876:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010687c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
8010687e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106884:	83 ec 1c             	sub    $0x1c,%esp
80106887:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010688a:	39 d3                	cmp    %edx,%ebx
8010688c:	73 66                	jae    801068f4 <deallocuvm.part.0+0x84>
8010688e:	89 d6                	mov    %edx,%esi
80106890:	eb 3d                	jmp    801068cf <deallocuvm.part.0+0x5f>
80106892:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106898:	8b 10                	mov    (%eax),%edx
8010689a:	f6 c2 01             	test   $0x1,%dl
8010689d:	74 26                	je     801068c5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010689f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801068a5:	74 58                	je     801068ff <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
801068a7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801068aa:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801068b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
801068b3:	52                   	push   %edx
801068b4:	e8 77 ba ff ff       	call   80102330 <kfree>
      *pte = 0;
801068b9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801068bc:	83 c4 10             	add    $0x10,%esp
801068bf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
801068c5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801068cb:	39 f3                	cmp    %esi,%ebx
801068cd:	73 25                	jae    801068f4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
801068cf:	31 c9                	xor    %ecx,%ecx
801068d1:	89 da                	mov    %ebx,%edx
801068d3:	89 f8                	mov    %edi,%eax
801068d5:	e8 86 fe ff ff       	call   80106760 <walkpgdir>
    if(!pte)
801068da:	85 c0                	test   %eax,%eax
801068dc:	75 ba                	jne    80106898 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801068de:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801068e4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801068ea:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801068f0:	39 f3                	cmp    %esi,%ebx
801068f2:	72 db                	jb     801068cf <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
801068f4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801068f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068fa:	5b                   	pop    %ebx
801068fb:	5e                   	pop    %esi
801068fc:	5f                   	pop    %edi
801068fd:	5d                   	pop    %ebp
801068fe:	c3                   	ret    
        panic("kfree");
801068ff:	83 ec 0c             	sub    $0xc,%esp
80106902:	68 c6 74 10 80       	push   $0x801074c6
80106907:	e8 84 9a ff ff       	call   80100390 <panic>
8010690c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106910 <seginit>:
{
80106910:	55                   	push   %ebp
80106911:	89 e5                	mov    %esp,%ebp
80106913:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106916:	e8 85 ce ff ff       	call   801037a0 <cpuid>
8010691b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80106921:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106926:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010692a:	c7 80 b8 31 11 80 ff 	movl   $0xffff,-0x7feece48(%eax)
80106931:	ff 00 00 
80106934:	c7 80 bc 31 11 80 00 	movl   $0xcf9a00,-0x7feece44(%eax)
8010693b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010693e:	c7 80 c0 31 11 80 ff 	movl   $0xffff,-0x7feece40(%eax)
80106945:	ff 00 00 
80106948:	c7 80 c4 31 11 80 00 	movl   $0xcf9200,-0x7feece3c(%eax)
8010694f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106952:	c7 80 c8 31 11 80 ff 	movl   $0xffff,-0x7feece38(%eax)
80106959:	ff 00 00 
8010695c:	c7 80 cc 31 11 80 00 	movl   $0xcffa00,-0x7feece34(%eax)
80106963:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106966:	c7 80 d0 31 11 80 ff 	movl   $0xffff,-0x7feece30(%eax)
8010696d:	ff 00 00 
80106970:	c7 80 d4 31 11 80 00 	movl   $0xcff200,-0x7feece2c(%eax)
80106977:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010697a:	05 b0 31 11 80       	add    $0x801131b0,%eax
  pd[1] = (uint)p;
8010697f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106983:	c1 e8 10             	shr    $0x10,%eax
80106986:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010698a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010698d:	0f 01 10             	lgdtl  (%eax)
}
80106990:	c9                   	leave  
80106991:	c3                   	ret    
80106992:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069a0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801069a0:	a1 84 5a 11 80       	mov    0x80115a84,%eax
{
801069a5:	55                   	push   %ebp
801069a6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801069a8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801069ad:	0f 22 d8             	mov    %eax,%cr3
}
801069b0:	5d                   	pop    %ebp
801069b1:	c3                   	ret    
801069b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069c0 <switchuvm>:
{
801069c0:	55                   	push   %ebp
801069c1:	89 e5                	mov    %esp,%ebp
801069c3:	57                   	push   %edi
801069c4:	56                   	push   %esi
801069c5:	53                   	push   %ebx
801069c6:	83 ec 1c             	sub    $0x1c,%esp
801069c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
801069cc:	85 db                	test   %ebx,%ebx
801069ce:	0f 84 cb 00 00 00    	je     80106a9f <switchuvm+0xdf>
  if(p->kstack == 0)
801069d4:	8b 43 08             	mov    0x8(%ebx),%eax
801069d7:	85 c0                	test   %eax,%eax
801069d9:	0f 84 da 00 00 00    	je     80106ab9 <switchuvm+0xf9>
  if(p->pgdir == 0)
801069df:	8b 43 04             	mov    0x4(%ebx),%eax
801069e2:	85 c0                	test   %eax,%eax
801069e4:	0f 84 c2 00 00 00    	je     80106aac <switchuvm+0xec>
  pushcli();
801069ea:	e8 11 da ff ff       	call   80104400 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801069ef:	e8 5c cd ff ff       	call   80103750 <mycpu>
801069f4:	89 c6                	mov    %eax,%esi
801069f6:	e8 55 cd ff ff       	call   80103750 <mycpu>
801069fb:	89 c7                	mov    %eax,%edi
801069fd:	e8 4e cd ff ff       	call   80103750 <mycpu>
80106a02:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106a05:	83 c7 08             	add    $0x8,%edi
80106a08:	e8 43 cd ff ff       	call   80103750 <mycpu>
80106a0d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106a10:	83 c0 08             	add    $0x8,%eax
80106a13:	ba 67 00 00 00       	mov    $0x67,%edx
80106a18:	c1 e8 18             	shr    $0x18,%eax
80106a1b:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80106a22:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106a29:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106a2f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106a34:	83 c1 08             	add    $0x8,%ecx
80106a37:	c1 e9 10             	shr    $0x10,%ecx
80106a3a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106a40:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106a45:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106a4c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80106a51:	e8 fa cc ff ff       	call   80103750 <mycpu>
80106a56:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106a5d:	e8 ee cc ff ff       	call   80103750 <mycpu>
80106a62:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106a66:	8b 73 08             	mov    0x8(%ebx),%esi
80106a69:	e8 e2 cc ff ff       	call   80103750 <mycpu>
80106a6e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106a74:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106a77:	e8 d4 cc ff ff       	call   80103750 <mycpu>
80106a7c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106a80:	b8 28 00 00 00       	mov    $0x28,%eax
80106a85:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106a88:	8b 43 04             	mov    0x4(%ebx),%eax
80106a8b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106a90:	0f 22 d8             	mov    %eax,%cr3
}
80106a93:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a96:	5b                   	pop    %ebx
80106a97:	5e                   	pop    %esi
80106a98:	5f                   	pop    %edi
80106a99:	5d                   	pop    %ebp
  popcli();
80106a9a:	e9 a1 d9 ff ff       	jmp    80104440 <popcli>
    panic("switchuvm: no process");
80106a9f:	83 ec 0c             	sub    $0xc,%esp
80106aa2:	68 92 7b 10 80       	push   $0x80107b92
80106aa7:	e8 e4 98 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80106aac:	83 ec 0c             	sub    $0xc,%esp
80106aaf:	68 bd 7b 10 80       	push   $0x80107bbd
80106ab4:	e8 d7 98 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80106ab9:	83 ec 0c             	sub    $0xc,%esp
80106abc:	68 a8 7b 10 80       	push   $0x80107ba8
80106ac1:	e8 ca 98 ff ff       	call   80100390 <panic>
80106ac6:	8d 76 00             	lea    0x0(%esi),%esi
80106ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ad0 <inituvm>:
{
80106ad0:	55                   	push   %ebp
80106ad1:	89 e5                	mov    %esp,%ebp
80106ad3:	57                   	push   %edi
80106ad4:	56                   	push   %esi
80106ad5:	53                   	push   %ebx
80106ad6:	83 ec 1c             	sub    $0x1c,%esp
80106ad9:	8b 75 10             	mov    0x10(%ebp),%esi
80106adc:	8b 45 08             	mov    0x8(%ebp),%eax
80106adf:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106ae2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106ae8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106aeb:	77 49                	ja     80106b36 <inituvm+0x66>
  mem = kalloc();
80106aed:	e8 ee b9 ff ff       	call   801024e0 <kalloc>
  memset(mem, 0, PGSIZE);
80106af2:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80106af5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106af7:	68 00 10 00 00       	push   $0x1000
80106afc:	6a 00                	push   $0x0
80106afe:	50                   	push   %eax
80106aff:	e8 dc da ff ff       	call   801045e0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106b04:	58                   	pop    %eax
80106b05:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106b0b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106b10:	5a                   	pop    %edx
80106b11:	6a 06                	push   $0x6
80106b13:	50                   	push   %eax
80106b14:	31 d2                	xor    %edx,%edx
80106b16:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b19:	e8 c2 fc ff ff       	call   801067e0 <mappages>
  memmove(mem, init, sz);
80106b1e:	89 75 10             	mov    %esi,0x10(%ebp)
80106b21:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106b24:	83 c4 10             	add    $0x10,%esp
80106b27:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106b2a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b2d:	5b                   	pop    %ebx
80106b2e:	5e                   	pop    %esi
80106b2f:	5f                   	pop    %edi
80106b30:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106b31:	e9 5a db ff ff       	jmp    80104690 <memmove>
    panic("inituvm: more than a page");
80106b36:	83 ec 0c             	sub    $0xc,%esp
80106b39:	68 d1 7b 10 80       	push   $0x80107bd1
80106b3e:	e8 4d 98 ff ff       	call   80100390 <panic>
80106b43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b50 <loaduvm>:
{
80106b50:	55                   	push   %ebp
80106b51:	89 e5                	mov    %esp,%ebp
80106b53:	57                   	push   %edi
80106b54:	56                   	push   %esi
80106b55:	53                   	push   %ebx
80106b56:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106b59:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106b60:	0f 85 91 00 00 00    	jne    80106bf7 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106b66:	8b 75 18             	mov    0x18(%ebp),%esi
80106b69:	31 db                	xor    %ebx,%ebx
80106b6b:	85 f6                	test   %esi,%esi
80106b6d:	75 1a                	jne    80106b89 <loaduvm+0x39>
80106b6f:	eb 6f                	jmp    80106be0 <loaduvm+0x90>
80106b71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b78:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b7e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106b84:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106b87:	76 57                	jbe    80106be0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106b89:	8b 55 0c             	mov    0xc(%ebp),%edx
80106b8c:	8b 45 08             	mov    0x8(%ebp),%eax
80106b8f:	31 c9                	xor    %ecx,%ecx
80106b91:	01 da                	add    %ebx,%edx
80106b93:	e8 c8 fb ff ff       	call   80106760 <walkpgdir>
80106b98:	85 c0                	test   %eax,%eax
80106b9a:	74 4e                	je     80106bea <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106b9c:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106b9e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80106ba1:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106ba6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106bab:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106bb1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106bb4:	01 d9                	add    %ebx,%ecx
80106bb6:	05 00 00 00 80       	add    $0x80000000,%eax
80106bbb:	57                   	push   %edi
80106bbc:	51                   	push   %ecx
80106bbd:	50                   	push   %eax
80106bbe:	ff 75 10             	pushl  0x10(%ebp)
80106bc1:	e8 ba ad ff ff       	call   80101980 <readi>
80106bc6:	83 c4 10             	add    $0x10,%esp
80106bc9:	39 f8                	cmp    %edi,%eax
80106bcb:	74 ab                	je     80106b78 <loaduvm+0x28>
}
80106bcd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106bd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106bd5:	5b                   	pop    %ebx
80106bd6:	5e                   	pop    %esi
80106bd7:	5f                   	pop    %edi
80106bd8:	5d                   	pop    %ebp
80106bd9:	c3                   	ret    
80106bda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106be0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106be3:	31 c0                	xor    %eax,%eax
}
80106be5:	5b                   	pop    %ebx
80106be6:	5e                   	pop    %esi
80106be7:	5f                   	pop    %edi
80106be8:	5d                   	pop    %ebp
80106be9:	c3                   	ret    
      panic("loaduvm: address should exist");
80106bea:	83 ec 0c             	sub    $0xc,%esp
80106bed:	68 eb 7b 10 80       	push   $0x80107beb
80106bf2:	e8 99 97 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80106bf7:	83 ec 0c             	sub    $0xc,%esp
80106bfa:	68 8c 7c 10 80       	push   $0x80107c8c
80106bff:	e8 8c 97 ff ff       	call   80100390 <panic>
80106c04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106c10 <allocuvm>:
{
80106c10:	55                   	push   %ebp
80106c11:	89 e5                	mov    %esp,%ebp
80106c13:	57                   	push   %edi
80106c14:	56                   	push   %esi
80106c15:	53                   	push   %ebx
80106c16:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106c19:	8b 7d 10             	mov    0x10(%ebp),%edi
80106c1c:	85 ff                	test   %edi,%edi
80106c1e:	0f 88 8e 00 00 00    	js     80106cb2 <allocuvm+0xa2>
  if(newsz < oldsz)
80106c24:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106c27:	0f 82 93 00 00 00    	jb     80106cc0 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
80106c2d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106c30:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106c36:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106c3c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106c3f:	0f 86 7e 00 00 00    	jbe    80106cc3 <allocuvm+0xb3>
80106c45:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106c48:	8b 7d 08             	mov    0x8(%ebp),%edi
80106c4b:	eb 42                	jmp    80106c8f <allocuvm+0x7f>
80106c4d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106c50:	83 ec 04             	sub    $0x4,%esp
80106c53:	68 00 10 00 00       	push   $0x1000
80106c58:	6a 00                	push   $0x0
80106c5a:	50                   	push   %eax
80106c5b:	e8 80 d9 ff ff       	call   801045e0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106c60:	58                   	pop    %eax
80106c61:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106c67:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106c6c:	5a                   	pop    %edx
80106c6d:	6a 06                	push   $0x6
80106c6f:	50                   	push   %eax
80106c70:	89 da                	mov    %ebx,%edx
80106c72:	89 f8                	mov    %edi,%eax
80106c74:	e8 67 fb ff ff       	call   801067e0 <mappages>
80106c79:	83 c4 10             	add    $0x10,%esp
80106c7c:	85 c0                	test   %eax,%eax
80106c7e:	78 50                	js     80106cd0 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80106c80:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c86:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106c89:	0f 86 81 00 00 00    	jbe    80106d10 <allocuvm+0x100>
    mem = kalloc();
80106c8f:	e8 4c b8 ff ff       	call   801024e0 <kalloc>
    if(mem == 0){
80106c94:	85 c0                	test   %eax,%eax
    mem = kalloc();
80106c96:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106c98:	75 b6                	jne    80106c50 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106c9a:	83 ec 0c             	sub    $0xc,%esp
80106c9d:	68 09 7c 10 80       	push   $0x80107c09
80106ca2:	e8 b9 99 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106ca7:	83 c4 10             	add    $0x10,%esp
80106caa:	8b 45 0c             	mov    0xc(%ebp),%eax
80106cad:	39 45 10             	cmp    %eax,0x10(%ebp)
80106cb0:	77 6e                	ja     80106d20 <allocuvm+0x110>
}
80106cb2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106cb5:	31 ff                	xor    %edi,%edi
}
80106cb7:	89 f8                	mov    %edi,%eax
80106cb9:	5b                   	pop    %ebx
80106cba:	5e                   	pop    %esi
80106cbb:	5f                   	pop    %edi
80106cbc:	5d                   	pop    %ebp
80106cbd:	c3                   	ret    
80106cbe:	66 90                	xchg   %ax,%ax
    return oldsz;
80106cc0:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80106cc3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cc6:	89 f8                	mov    %edi,%eax
80106cc8:	5b                   	pop    %ebx
80106cc9:	5e                   	pop    %esi
80106cca:	5f                   	pop    %edi
80106ccb:	5d                   	pop    %ebp
80106ccc:	c3                   	ret    
80106ccd:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106cd0:	83 ec 0c             	sub    $0xc,%esp
80106cd3:	68 21 7c 10 80       	push   $0x80107c21
80106cd8:	e8 83 99 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106cdd:	83 c4 10             	add    $0x10,%esp
80106ce0:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ce3:	39 45 10             	cmp    %eax,0x10(%ebp)
80106ce6:	76 0d                	jbe    80106cf5 <allocuvm+0xe5>
80106ce8:	89 c1                	mov    %eax,%ecx
80106cea:	8b 55 10             	mov    0x10(%ebp),%edx
80106ced:	8b 45 08             	mov    0x8(%ebp),%eax
80106cf0:	e8 7b fb ff ff       	call   80106870 <deallocuvm.part.0>
      kfree(mem);
80106cf5:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80106cf8:	31 ff                	xor    %edi,%edi
      kfree(mem);
80106cfa:	56                   	push   %esi
80106cfb:	e8 30 b6 ff ff       	call   80102330 <kfree>
      return 0;
80106d00:	83 c4 10             	add    $0x10,%esp
}
80106d03:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d06:	89 f8                	mov    %edi,%eax
80106d08:	5b                   	pop    %ebx
80106d09:	5e                   	pop    %esi
80106d0a:	5f                   	pop    %edi
80106d0b:	5d                   	pop    %ebp
80106d0c:	c3                   	ret    
80106d0d:	8d 76 00             	lea    0x0(%esi),%esi
80106d10:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106d13:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d16:	5b                   	pop    %ebx
80106d17:	89 f8                	mov    %edi,%eax
80106d19:	5e                   	pop    %esi
80106d1a:	5f                   	pop    %edi
80106d1b:	5d                   	pop    %ebp
80106d1c:	c3                   	ret    
80106d1d:	8d 76 00             	lea    0x0(%esi),%esi
80106d20:	89 c1                	mov    %eax,%ecx
80106d22:	8b 55 10             	mov    0x10(%ebp),%edx
80106d25:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80106d28:	31 ff                	xor    %edi,%edi
80106d2a:	e8 41 fb ff ff       	call   80106870 <deallocuvm.part.0>
80106d2f:	eb 92                	jmp    80106cc3 <allocuvm+0xb3>
80106d31:	eb 0d                	jmp    80106d40 <deallocuvm>
80106d33:	90                   	nop
80106d34:	90                   	nop
80106d35:	90                   	nop
80106d36:	90                   	nop
80106d37:	90                   	nop
80106d38:	90                   	nop
80106d39:	90                   	nop
80106d3a:	90                   	nop
80106d3b:	90                   	nop
80106d3c:	90                   	nop
80106d3d:	90                   	nop
80106d3e:	90                   	nop
80106d3f:	90                   	nop

80106d40 <deallocuvm>:
{
80106d40:	55                   	push   %ebp
80106d41:	89 e5                	mov    %esp,%ebp
80106d43:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d46:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106d49:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106d4c:	39 d1                	cmp    %edx,%ecx
80106d4e:	73 10                	jae    80106d60 <deallocuvm+0x20>
}
80106d50:	5d                   	pop    %ebp
80106d51:	e9 1a fb ff ff       	jmp    80106870 <deallocuvm.part.0>
80106d56:	8d 76 00             	lea    0x0(%esi),%esi
80106d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106d60:	89 d0                	mov    %edx,%eax
80106d62:	5d                   	pop    %ebp
80106d63:	c3                   	ret    
80106d64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106d70 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106d70:	55                   	push   %ebp
80106d71:	89 e5                	mov    %esp,%ebp
80106d73:	57                   	push   %edi
80106d74:	56                   	push   %esi
80106d75:	53                   	push   %ebx
80106d76:	83 ec 0c             	sub    $0xc,%esp
80106d79:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106d7c:	85 f6                	test   %esi,%esi
80106d7e:	74 59                	je     80106dd9 <freevm+0x69>
80106d80:	31 c9                	xor    %ecx,%ecx
80106d82:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106d87:	89 f0                	mov    %esi,%eax
80106d89:	e8 e2 fa ff ff       	call   80106870 <deallocuvm.part.0>
80106d8e:	89 f3                	mov    %esi,%ebx
80106d90:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106d96:	eb 0f                	jmp    80106da7 <freevm+0x37>
80106d98:	90                   	nop
80106d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106da0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106da3:	39 fb                	cmp    %edi,%ebx
80106da5:	74 23                	je     80106dca <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106da7:	8b 03                	mov    (%ebx),%eax
80106da9:	a8 01                	test   $0x1,%al
80106dab:	74 f3                	je     80106da0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106dad:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106db2:	83 ec 0c             	sub    $0xc,%esp
80106db5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106db8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106dbd:	50                   	push   %eax
80106dbe:	e8 6d b5 ff ff       	call   80102330 <kfree>
80106dc3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106dc6:	39 fb                	cmp    %edi,%ebx
80106dc8:	75 dd                	jne    80106da7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106dca:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106dcd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106dd0:	5b                   	pop    %ebx
80106dd1:	5e                   	pop    %esi
80106dd2:	5f                   	pop    %edi
80106dd3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106dd4:	e9 57 b5 ff ff       	jmp    80102330 <kfree>
    panic("freevm: no pgdir");
80106dd9:	83 ec 0c             	sub    $0xc,%esp
80106ddc:	68 3d 7c 10 80       	push   $0x80107c3d
80106de1:	e8 aa 95 ff ff       	call   80100390 <panic>
80106de6:	8d 76 00             	lea    0x0(%esi),%esi
80106de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106df0 <setupkvm>:
{
80106df0:	55                   	push   %ebp
80106df1:	89 e5                	mov    %esp,%ebp
80106df3:	56                   	push   %esi
80106df4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106df5:	e8 e6 b6 ff ff       	call   801024e0 <kalloc>
80106dfa:	85 c0                	test   %eax,%eax
80106dfc:	89 c6                	mov    %eax,%esi
80106dfe:	74 42                	je     80106e42 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80106e00:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106e03:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106e08:	68 00 10 00 00       	push   $0x1000
80106e0d:	6a 00                	push   $0x0
80106e0f:	50                   	push   %eax
80106e10:	e8 cb d7 ff ff       	call   801045e0 <memset>
80106e15:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80106e18:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106e1b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106e1e:	83 ec 08             	sub    $0x8,%esp
80106e21:	8b 13                	mov    (%ebx),%edx
80106e23:	ff 73 0c             	pushl  0xc(%ebx)
80106e26:	50                   	push   %eax
80106e27:	29 c1                	sub    %eax,%ecx
80106e29:	89 f0                	mov    %esi,%eax
80106e2b:	e8 b0 f9 ff ff       	call   801067e0 <mappages>
80106e30:	83 c4 10             	add    $0x10,%esp
80106e33:	85 c0                	test   %eax,%eax
80106e35:	78 19                	js     80106e50 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106e37:	83 c3 10             	add    $0x10,%ebx
80106e3a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106e40:	75 d6                	jne    80106e18 <setupkvm+0x28>
}
80106e42:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106e45:	89 f0                	mov    %esi,%eax
80106e47:	5b                   	pop    %ebx
80106e48:	5e                   	pop    %esi
80106e49:	5d                   	pop    %ebp
80106e4a:	c3                   	ret    
80106e4b:	90                   	nop
80106e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80106e50:	83 ec 0c             	sub    $0xc,%esp
80106e53:	56                   	push   %esi
      return 0;
80106e54:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80106e56:	e8 15 ff ff ff       	call   80106d70 <freevm>
      return 0;
80106e5b:	83 c4 10             	add    $0x10,%esp
}
80106e5e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106e61:	89 f0                	mov    %esi,%eax
80106e63:	5b                   	pop    %ebx
80106e64:	5e                   	pop    %esi
80106e65:	5d                   	pop    %ebp
80106e66:	c3                   	ret    
80106e67:	89 f6                	mov    %esi,%esi
80106e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e70 <kvmalloc>:
{
80106e70:	55                   	push   %ebp
80106e71:	89 e5                	mov    %esp,%ebp
80106e73:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106e76:	e8 75 ff ff ff       	call   80106df0 <setupkvm>
80106e7b:	a3 84 5a 11 80       	mov    %eax,0x80115a84
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106e80:	05 00 00 00 80       	add    $0x80000000,%eax
80106e85:	0f 22 d8             	mov    %eax,%cr3
}
80106e88:	c9                   	leave  
80106e89:	c3                   	ret    
80106e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106e90 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106e90:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106e91:	31 c9                	xor    %ecx,%ecx
{
80106e93:	89 e5                	mov    %esp,%ebp
80106e95:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106e98:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e9b:	8b 45 08             	mov    0x8(%ebp),%eax
80106e9e:	e8 bd f8 ff ff       	call   80106760 <walkpgdir>
  if(pte == 0)
80106ea3:	85 c0                	test   %eax,%eax
80106ea5:	74 05                	je     80106eac <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106ea7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106eaa:	c9                   	leave  
80106eab:	c3                   	ret    
    panic("clearpteu");
80106eac:	83 ec 0c             	sub    $0xc,%esp
80106eaf:	68 4e 7c 10 80       	push   $0x80107c4e
80106eb4:	e8 d7 94 ff ff       	call   80100390 <panic>
80106eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ec0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106ec0:	55                   	push   %ebp
80106ec1:	89 e5                	mov    %esp,%ebp
80106ec3:	57                   	push   %edi
80106ec4:	56                   	push   %esi
80106ec5:	53                   	push   %ebx
80106ec6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106ec9:	e8 22 ff ff ff       	call   80106df0 <setupkvm>
80106ece:	85 c0                	test   %eax,%eax
80106ed0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106ed3:	0f 84 9f 00 00 00    	je     80106f78 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106ed9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106edc:	85 c9                	test   %ecx,%ecx
80106ede:	0f 84 94 00 00 00    	je     80106f78 <copyuvm+0xb8>
80106ee4:	31 ff                	xor    %edi,%edi
80106ee6:	eb 4a                	jmp    80106f32 <copyuvm+0x72>
80106ee8:	90                   	nop
80106ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106ef0:	83 ec 04             	sub    $0x4,%esp
80106ef3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80106ef9:	68 00 10 00 00       	push   $0x1000
80106efe:	53                   	push   %ebx
80106eff:	50                   	push   %eax
80106f00:	e8 8b d7 ff ff       	call   80104690 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80106f05:	58                   	pop    %eax
80106f06:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106f0c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106f11:	5a                   	pop    %edx
80106f12:	ff 75 e4             	pushl  -0x1c(%ebp)
80106f15:	50                   	push   %eax
80106f16:	89 fa                	mov    %edi,%edx
80106f18:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106f1b:	e8 c0 f8 ff ff       	call   801067e0 <mappages>
80106f20:	83 c4 10             	add    $0x10,%esp
80106f23:	85 c0                	test   %eax,%eax
80106f25:	78 61                	js     80106f88 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80106f27:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106f2d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80106f30:	76 46                	jbe    80106f78 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106f32:	8b 45 08             	mov    0x8(%ebp),%eax
80106f35:	31 c9                	xor    %ecx,%ecx
80106f37:	89 fa                	mov    %edi,%edx
80106f39:	e8 22 f8 ff ff       	call   80106760 <walkpgdir>
80106f3e:	85 c0                	test   %eax,%eax
80106f40:	74 61                	je     80106fa3 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80106f42:	8b 00                	mov    (%eax),%eax
80106f44:	a8 01                	test   $0x1,%al
80106f46:	74 4e                	je     80106f96 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80106f48:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
80106f4a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
80106f4f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80106f55:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80106f58:	e8 83 b5 ff ff       	call   801024e0 <kalloc>
80106f5d:	85 c0                	test   %eax,%eax
80106f5f:	89 c6                	mov    %eax,%esi
80106f61:	75 8d                	jne    80106ef0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80106f63:	83 ec 0c             	sub    $0xc,%esp
80106f66:	ff 75 e0             	pushl  -0x20(%ebp)
80106f69:	e8 02 fe ff ff       	call   80106d70 <freevm>
  return 0;
80106f6e:	83 c4 10             	add    $0x10,%esp
80106f71:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80106f78:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106f7b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f7e:	5b                   	pop    %ebx
80106f7f:	5e                   	pop    %esi
80106f80:	5f                   	pop    %edi
80106f81:	5d                   	pop    %ebp
80106f82:	c3                   	ret    
80106f83:	90                   	nop
80106f84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80106f88:	83 ec 0c             	sub    $0xc,%esp
80106f8b:	56                   	push   %esi
80106f8c:	e8 9f b3 ff ff       	call   80102330 <kfree>
      goto bad;
80106f91:	83 c4 10             	add    $0x10,%esp
80106f94:	eb cd                	jmp    80106f63 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80106f96:	83 ec 0c             	sub    $0xc,%esp
80106f99:	68 72 7c 10 80       	push   $0x80107c72
80106f9e:	e8 ed 93 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80106fa3:	83 ec 0c             	sub    $0xc,%esp
80106fa6:	68 58 7c 10 80       	push   $0x80107c58
80106fab:	e8 e0 93 ff ff       	call   80100390 <panic>

80106fb0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106fb0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106fb1:	31 c9                	xor    %ecx,%ecx
{
80106fb3:	89 e5                	mov    %esp,%ebp
80106fb5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106fb8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106fbb:	8b 45 08             	mov    0x8(%ebp),%eax
80106fbe:	e8 9d f7 ff ff       	call   80106760 <walkpgdir>
  if((*pte & PTE_P) == 0)
80106fc3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80106fc5:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80106fc6:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80106fc8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80106fcd:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80106fd0:	05 00 00 00 80       	add    $0x80000000,%eax
80106fd5:	83 fa 05             	cmp    $0x5,%edx
80106fd8:	ba 00 00 00 00       	mov    $0x0,%edx
80106fdd:	0f 45 c2             	cmovne %edx,%eax
}
80106fe0:	c3                   	ret    
80106fe1:	eb 0d                	jmp    80106ff0 <copyout>
80106fe3:	90                   	nop
80106fe4:	90                   	nop
80106fe5:	90                   	nop
80106fe6:	90                   	nop
80106fe7:	90                   	nop
80106fe8:	90                   	nop
80106fe9:	90                   	nop
80106fea:	90                   	nop
80106feb:	90                   	nop
80106fec:	90                   	nop
80106fed:	90                   	nop
80106fee:	90                   	nop
80106fef:	90                   	nop

80106ff0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106ff0:	55                   	push   %ebp
80106ff1:	89 e5                	mov    %esp,%ebp
80106ff3:	57                   	push   %edi
80106ff4:	56                   	push   %esi
80106ff5:	53                   	push   %ebx
80106ff6:	83 ec 1c             	sub    $0x1c,%esp
80106ff9:	8b 5d 14             	mov    0x14(%ebp),%ebx
80106ffc:	8b 55 0c             	mov    0xc(%ebp),%edx
80106fff:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107002:	85 db                	test   %ebx,%ebx
80107004:	75 40                	jne    80107046 <copyout+0x56>
80107006:	eb 70                	jmp    80107078 <copyout+0x88>
80107008:	90                   	nop
80107009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107010:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107013:	89 f1                	mov    %esi,%ecx
80107015:	29 d1                	sub    %edx,%ecx
80107017:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010701d:	39 d9                	cmp    %ebx,%ecx
8010701f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107022:	29 f2                	sub    %esi,%edx
80107024:	83 ec 04             	sub    $0x4,%esp
80107027:	01 d0                	add    %edx,%eax
80107029:	51                   	push   %ecx
8010702a:	57                   	push   %edi
8010702b:	50                   	push   %eax
8010702c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010702f:	e8 5c d6 ff ff       	call   80104690 <memmove>
    len -= n;
    buf += n;
80107034:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80107037:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
8010703a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107040:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107042:	29 cb                	sub    %ecx,%ebx
80107044:	74 32                	je     80107078 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107046:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107048:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
8010704b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010704e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107054:	56                   	push   %esi
80107055:	ff 75 08             	pushl  0x8(%ebp)
80107058:	e8 53 ff ff ff       	call   80106fb0 <uva2ka>
    if(pa0 == 0)
8010705d:	83 c4 10             	add    $0x10,%esp
80107060:	85 c0                	test   %eax,%eax
80107062:	75 ac                	jne    80107010 <copyout+0x20>
  }
  return 0;
}
80107064:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107067:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010706c:	5b                   	pop    %ebx
8010706d:	5e                   	pop    %esi
8010706e:	5f                   	pop    %edi
8010706f:	5d                   	pop    %ebp
80107070:	c3                   	ret    
80107071:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107078:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010707b:	31 c0                	xor    %eax,%eax
}
8010707d:	5b                   	pop    %ebx
8010707e:	5e                   	pop    %esi
8010707f:	5f                   	pop    %edi
80107080:	5d                   	pop    %ebp
80107081:	c3                   	ret    
80107082:	66 90                	xchg   %ax,%ax
80107084:	66 90                	xchg   %ax,%ax
80107086:	66 90                	xchg   %ax,%ax
80107088:	66 90                	xchg   %ax,%ax
8010708a:	66 90                	xchg   %ax,%ax
8010708c:	66 90                	xchg   %ax,%ax
8010708e:	66 90                	xchg   %ax,%ax

80107090 <sgenrand>:
static int mti=N+1; /* mti==N+1 means mt[N] is not initialized */

/* initializing the array with a NONZERO seed */
void
sgenrand(unsigned long seed)
{
80107090:	55                   	push   %ebp
80107091:	b8 c4 a5 10 80       	mov    $0x8010a5c4,%eax
80107096:	b9 7c af 10 80       	mov    $0x8010af7c,%ecx
8010709b:	89 e5                	mov    %esp,%ebp
8010709d:	8b 55 08             	mov    0x8(%ebp),%edx
    /* setting initial seeds to mt[N] using         */
    /* the generator Line 25 of Table 1 in          */
    /* [KNUTH 1981, The Art of Computer Programming */
    /*    Vol. 2 (2nd Ed.), pp102]                  */
    mt[0]= seed & 0xffffffff;
801070a0:	89 15 c0 a5 10 80    	mov    %edx,0x8010a5c0
801070a6:	eb 0b                	jmp    801070b3 <sgenrand+0x23>
801070a8:	90                   	nop
801070a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070b0:	83 c0 04             	add    $0x4,%eax
    for (mti=1; mti<N; mti++)
        mt[mti] = (69069 * mt[mti-1]) & 0xffffffff;
801070b3:	69 d2 cd 0d 01 00    	imul   $0x10dcd,%edx,%edx
    for (mti=1; mti<N; mti++)
801070b9:	39 c1                	cmp    %eax,%ecx
        mt[mti] = (69069 * mt[mti-1]) & 0xffffffff;
801070bb:	89 10                	mov    %edx,(%eax)
    for (mti=1; mti<N; mti++)
801070bd:	75 f1                	jne    801070b0 <sgenrand+0x20>
801070bf:	c7 05 60 a4 10 80 70 	movl   $0x270,0x8010a460
801070c6:	02 00 00 
}
801070c9:	5d                   	pop    %ebp
801070ca:	c3                   	ret    
801070cb:	90                   	nop
801070cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801070d0 <genrand>:
{
    unsigned long y;
    static unsigned long mag01[2]={0x0, MATRIX_A};
    /* mag01[x] = x * MATRIX_A  for x=0,1 */

    if (mti >= N) { /* generate N words at one time */
801070d0:	a1 60 a4 10 80       	mov    0x8010a460,%eax
{
801070d5:	55                   	push   %ebp
801070d6:	89 e5                	mov    %esp,%ebp
801070d8:	56                   	push   %esi
801070d9:	53                   	push   %ebx
    if (mti >= N) { /* generate N words at one time */
801070da:	3d 6f 02 00 00       	cmp    $0x26f,%eax
801070df:	0f 8e f9 00 00 00    	jle    801071de <genrand+0x10e>
        int kk;

        if (mti == N+1)   /* if sgenrand() has not been called, */
801070e5:	3d 71 02 00 00       	cmp    $0x271,%eax
801070ea:	0f 84 fa 00 00 00    	je     801071ea <genrand+0x11a>
801070f0:	ba c0 a5 10 80       	mov    $0x8010a5c0,%edx
801070f5:	bb 4c a9 10 80       	mov    $0x8010a94c,%ebx
    mt[0]= seed & 0xffffffff;
801070fa:	89 d1                	mov    %edx,%ecx
801070fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            sgenrand(4357); /* a default initial seed is used   */

        for (kk=0;kk<N-M;kk++) {
            y = (mt[kk]&UPPER_MASK)|(mt[kk+1]&LOWER_MASK);
80107100:	8b 01                	mov    (%ecx),%eax
80107102:	8b 71 04             	mov    0x4(%ecx),%esi
80107105:	83 c1 04             	add    $0x4,%ecx
80107108:	81 e6 ff ff ff 7f    	and    $0x7fffffff,%esi
8010710e:	25 00 00 00 80       	and    $0x80000000,%eax
80107113:	09 f0                	or     %esi,%eax
            mt[kk] = mt[kk+M] ^ (y >> 1) ^ mag01[y & 0x1];
80107115:	89 c6                	mov    %eax,%esi
80107117:	83 e0 01             	and    $0x1,%eax
8010711a:	d1 ee                	shr    %esi
8010711c:	33 b1 30 06 00 00    	xor    0x630(%ecx),%esi
80107122:	33 34 85 b0 7c 10 80 	xor    -0x7fef8350(,%eax,4),%esi
80107129:	89 71 fc             	mov    %esi,-0x4(%ecx)
        for (kk=0;kk<N-M;kk++) {
8010712c:	39 cb                	cmp    %ecx,%ebx
8010712e:	75 d0                	jne    80107100 <genrand+0x30>
80107130:	b9 f0 ab 10 80       	mov    $0x8010abf0,%ecx
80107135:	8d 76 00             	lea    0x0(%esi),%esi
        }
        for (;kk<N-1;kk++) {
            y = (mt[kk]&UPPER_MASK)|(mt[kk+1]&LOWER_MASK);
80107138:	8b 82 8c 03 00 00    	mov    0x38c(%edx),%eax
8010713e:	8b 9a 90 03 00 00    	mov    0x390(%edx),%ebx
80107144:	83 c2 04             	add    $0x4,%edx
80107147:	81 e3 ff ff ff 7f    	and    $0x7fffffff,%ebx
8010714d:	25 00 00 00 80       	and    $0x80000000,%eax
80107152:	09 d8                	or     %ebx,%eax
            mt[kk] = mt[kk+(M-N)] ^ (y >> 1) ^ mag01[y & 0x1];
80107154:	89 c3                	mov    %eax,%ebx
80107156:	83 e0 01             	and    $0x1,%eax
80107159:	d1 eb                	shr    %ebx
8010715b:	33 5a fc             	xor    -0x4(%edx),%ebx
8010715e:	33 1c 85 b0 7c 10 80 	xor    -0x7fef8350(,%eax,4),%ebx
80107165:	89 9a 88 03 00 00    	mov    %ebx,0x388(%edx)
        for (;kk<N-1;kk++) {
8010716b:	39 d1                	cmp    %edx,%ecx
8010716d:	75 c9                	jne    80107138 <genrand+0x68>
        }
        y = (mt[N-1]&UPPER_MASK)|(mt[0]&LOWER_MASK);
8010716f:	a1 c0 a5 10 80       	mov    0x8010a5c0,%eax
80107174:	8b 0d 7c af 10 80    	mov    0x8010af7c,%ecx
8010717a:	89 c2                	mov    %eax,%edx
8010717c:	81 e1 00 00 00 80    	and    $0x80000000,%ecx
80107182:	81 e2 ff ff ff 7f    	and    $0x7fffffff,%edx
80107188:	09 d1                	or     %edx,%ecx
        mt[N-1] = mt[M-1] ^ (y >> 1) ^ mag01[y & 0x1];
8010718a:	89 ca                	mov    %ecx,%edx
8010718c:	83 e1 01             	and    $0x1,%ecx
8010718f:	d1 ea                	shr    %edx
80107191:	33 15 f0 ab 10 80    	xor    0x8010abf0,%edx
80107197:	33 14 8d b0 7c 10 80 	xor    -0x7fef8350(,%ecx,4),%edx
8010719e:	89 15 7c af 10 80    	mov    %edx,0x8010af7c
801071a4:	ba 01 00 00 00       	mov    $0x1,%edx

        mti = 0;
    }

    y = mt[mti++];
801071a9:	89 15 60 a4 10 80    	mov    %edx,0x8010a460
    y ^= TEMPERING_SHIFT_U(y);
801071af:	89 c2                	mov    %eax,%edx
801071b1:	c1 ea 0b             	shr    $0xb,%edx
801071b4:	31 c2                	xor    %eax,%edx
    y ^= TEMPERING_SHIFT_S(y) & TEMPERING_MASK_B;
801071b6:	89 d0                	mov    %edx,%eax
801071b8:	c1 e0 07             	shl    $0x7,%eax
801071bb:	25 80 56 2c 9d       	and    $0x9d2c5680,%eax
801071c0:	31 c2                	xor    %eax,%edx
    y ^= TEMPERING_SHIFT_T(y) & TEMPERING_MASK_C;
801071c2:	89 d0                	mov    %edx,%eax
801071c4:	c1 e0 0f             	shl    $0xf,%eax
801071c7:	25 00 00 c6 ef       	and    $0xefc60000,%eax
801071cc:	31 d0                	xor    %edx,%eax
    y ^= TEMPERING_SHIFT_L(y);
801071ce:	89 c2                	mov    %eax,%edx
801071d0:	c1 ea 12             	shr    $0x12,%edx
801071d3:	31 d0                	xor    %edx,%eax

    // Strip off uppermost bit because we want a long,
    // not an unsigned long
    return y & RAND_MAX;
}
801071d5:	5b                   	pop    %ebx
    return y & RAND_MAX;
801071d6:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
801071db:	5e                   	pop    %esi
801071dc:	5d                   	pop    %ebp
801071dd:	c3                   	ret    
801071de:	8d 50 01             	lea    0x1(%eax),%edx
801071e1:	8b 04 85 c0 a5 10 80 	mov    -0x7fef5a40(,%eax,4),%eax
801071e8:	eb bf                	jmp    801071a9 <genrand+0xd9>
    mt[0]= seed & 0xffffffff;
801071ea:	c7 05 c0 a5 10 80 05 	movl   $0x1105,0x8010a5c0
801071f1:	11 00 00 
801071f4:	b8 c4 a5 10 80       	mov    $0x8010a5c4,%eax
801071f9:	b9 7c af 10 80       	mov    $0x8010af7c,%ecx
801071fe:	ba 05 11 00 00       	mov    $0x1105,%edx
80107203:	eb 06                	jmp    8010720b <genrand+0x13b>
80107205:	8d 76 00             	lea    0x0(%esi),%esi
80107208:	83 c0 04             	add    $0x4,%eax
        mt[mti] = (69069 * mt[mti-1]) & 0xffffffff;
8010720b:	69 d2 cd 0d 01 00    	imul   $0x10dcd,%edx,%edx
    for (mti=1; mti<N; mti++)
80107211:	39 c1                	cmp    %eax,%ecx
        mt[mti] = (69069 * mt[mti-1]) & 0xffffffff;
80107213:	89 10                	mov    %edx,(%eax)
    for (mti=1; mti<N; mti++)
80107215:	75 f1                	jne    80107208 <genrand+0x138>
80107217:	e9 d4 fe ff ff       	jmp    801070f0 <genrand+0x20>
8010721c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107220 <random_at_most>:

// Assumes 0 <= max <= RAND_MAX
// Returns in the half-open interval [0, max]
long random_at_most(long max) {
80107220:	55                   	push   %ebp
    unsigned long
    // max <= RAND_MAX < ULONG_MAX, so this is okay.
            num_bins = (unsigned long) max + 1,
            num_rand = (unsigned long) RAND_MAX + 1,
            bin_size = num_rand / num_bins,
80107221:	31 d2                	xor    %edx,%edx
long random_at_most(long max) {
80107223:	89 e5                	mov    %esp,%ebp
80107225:	56                   	push   %esi
80107226:	53                   	push   %ebx
            num_bins = (unsigned long) max + 1,
80107227:	8b 45 08             	mov    0x8(%ebp),%eax
            bin_size = num_rand / num_bins,
8010722a:	bb 00 00 00 80       	mov    $0x80000000,%ebx
            num_bins = (unsigned long) max + 1,
8010722f:	8d 48 01             	lea    0x1(%eax),%ecx
            bin_size = num_rand / num_bins,
80107232:	89 d8                	mov    %ebx,%eax
80107234:	f7 f1                	div    %ecx
80107236:	89 c6                	mov    %eax,%esi
80107238:	29 d3                	sub    %edx,%ebx
8010723a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            defect   = num_rand % num_bins;

    long x;
    do {
        x = genrand();
80107240:	e8 8b fe ff ff       	call   801070d0 <genrand>
    }
        // This is carefully written not to overflow
    while (num_rand - defect <= (unsigned long)x);
80107245:	39 d8                	cmp    %ebx,%eax
80107247:	73 f7                	jae    80107240 <random_at_most+0x20>

    // Truncated division is intentional
    return x/bin_size;
80107249:	31 d2                	xor    %edx,%edx
8010724b:	f7 f6                	div    %esi
8010724d:	5b                   	pop    %ebx
8010724e:	5e                   	pop    %esi
8010724f:	5d                   	pop    %ebp
80107250:	c3                   	ret    
