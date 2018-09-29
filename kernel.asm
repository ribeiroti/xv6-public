
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
8010002d:	b8 b0 2e 10 80       	mov    $0x80102eb0,%eax
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
8010004c:	68 80 72 10 80       	push   $0x80107280
80100051:	68 80 bf 10 80       	push   $0x8010bf80
80100056:	e8 55 43 00 00       	call   801043b0 <initlock>
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
80100092:	68 87 72 10 80       	push   $0x80107287
80100097:	50                   	push   %eax
80100098:	e8 e3 41 00 00       	call   80104280 <initsleeplock>
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
801000e4:	e8 07 44 00 00       	call   801044f0 <acquire>
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
80100162:	e8 49 44 00 00       	call   801045b0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 4e 41 00 00       	call   801042c0 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 ad 1f 00 00       	call   80102130 <iderw>
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
80100193:	68 8e 72 10 80       	push   $0x8010728e
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
801001ae:	e8 ad 41 00 00       	call   80104360 <holdingsleep>
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
801001c4:	e9 67 1f 00 00       	jmp    80102130 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 9f 72 10 80       	push   $0x8010729f
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
801001ef:	e8 6c 41 00 00       	call   80104360 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 1c 41 00 00       	call   80104320 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 80 bf 10 80 	movl   $0x8010bf80,(%esp)
8010020b:	e8 e0 42 00 00       	call   801044f0 <acquire>
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
8010025c:	e9 4f 43 00 00       	jmp    801045b0 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 a6 72 10 80       	push   $0x801072a6
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
80100280:	e8 eb 14 00 00       	call   80101770 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 5f 42 00 00       	call   801044f0 <acquire>
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
801002c5:	e8 26 3c 00 00       	call   80103ef0 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 60 09 11 80    	mov    0x80110960,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 64 09 11 80    	cmp    0x80110964,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 d0 34 00 00       	call   801037b0 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 a5 10 80       	push   $0x8010a520
801002ef:	e8 bc 42 00 00       	call   801045b0 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 94 13 00 00       	call   80101690 <ilock>
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
8010034d:	e8 5e 42 00 00       	call   801045b0 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 36 13 00 00       	call   80101690 <ilock>
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
801003a9:	e8 92 23 00 00       	call   80102740 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 ad 72 10 80       	push   $0x801072ad
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 5b 7c 10 80 	movl   $0x80107c5b,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 f3 3f 00 00       	call   801043d0 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 c1 72 10 80       	push   $0x801072c1
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
8010043a:	e8 81 58 00 00       	call   80105cc0 <uartputc>
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
801004ec:	e8 cf 57 00 00       	call   80105cc0 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 c3 57 00 00       	call   80105cc0 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 b7 57 00 00       	call   80105cc0 <uartputc>
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
80100524:	e8 87 41 00 00       	call   801046b0 <memmove>
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
80100541:	e8 ba 40 00 00       	call   80104600 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 c5 72 10 80       	push   $0x801072c5
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
801005b1:	0f b6 92 f0 72 10 80 	movzbl -0x7fef8d10(%edx),%edx
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
8010060f:	e8 5c 11 00 00       	call   80101770 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010061b:	e8 d0 3e 00 00       	call   801044f0 <acquire>
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
80100647:	e8 64 3f 00 00       	call   801045b0 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 3b 10 00 00       	call   80101690 <ilock>

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
8010071f:	e8 8c 3e 00 00       	call   801045b0 <release>
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
801007d0:	ba d8 72 10 80       	mov    $0x801072d8,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 a5 10 80       	push   $0x8010a520
801007f0:	e8 fb 3c 00 00       	call   801044f0 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 df 72 10 80       	push   $0x801072df
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
80100823:	e8 c8 3c 00 00       	call   801044f0 <acquire>
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
80100888:	e8 23 3d 00 00       	call   801045b0 <release>
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
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 e0 08 11 80    	mov    %cl,-0x7feef720(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
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
80100916:	e8 85 37 00 00       	call   801040a0 <wakeup>
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
}
80100990:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100993:	5b                   	pop    %ebx
80100994:	5e                   	pop    %esi
80100995:	5f                   	pop    %edi
80100996:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100997:	e9 e4 37 00 00       	jmp    80104180 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 e0 08 11 80 0a 	movb   $0xa,-0x7feef720(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 68 09 11 80       	mov    0x80110968,%eax
801009b6:	e9 4e ff ff ff       	jmp    80100909 <consoleintr+0xf9>
801009bb:	90                   	nop
801009bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009c0 <consoleinit>:

void
consoleinit(void)
{
801009c0:	55                   	push   %ebp
801009c1:	89 e5                	mov    %esp,%ebp
801009c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009c6:	68 e8 72 10 80       	push   $0x801072e8
801009cb:	68 20 a5 10 80       	push   $0x8010a520
801009d0:	e8 db 39 00 00       	call   801043b0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 2c 13 11 80 00 	movl   $0x80100600,0x8011132c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 28 13 11 80 70 	movl   $0x80100270,0x80111328
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009f6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009f9:	e8 e2 18 00 00       	call   801022e0 <ioapicenable>
}
801009fe:	83 c4 10             	add    $0x10,%esp
80100a01:	c9                   	leave  
80100a02:	c3                   	ret    
80100a03:	66 90                	xchg   %ax,%ax
80100a05:	66 90                	xchg   %ax,%ax
80100a07:	66 90                	xchg   %ax,%ax
80100a09:	66 90                	xchg   %ax,%ax
80100a0b:	66 90                	xchg   %ax,%ax
80100a0d:	66 90                	xchg   %ax,%ax
80100a0f:	90                   	nop

80100a10 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a10:	55                   	push   %ebp
80100a11:	89 e5                	mov    %esp,%ebp
80100a13:	57                   	push   %edi
80100a14:	56                   	push   %esi
80100a15:	53                   	push   %ebx
80100a16:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a1c:	e8 8f 2d 00 00       	call   801037b0 <myproc>
80100a21:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a27:	e8 84 21 00 00       	call   80102bb0 <begin_op>

  if((ip = namei(path)) == 0){
80100a2c:	83 ec 0c             	sub    $0xc,%esp
80100a2f:	ff 75 08             	pushl  0x8(%ebp)
80100a32:	e8 b9 14 00 00       	call   80101ef0 <namei>
80100a37:	83 c4 10             	add    $0x10,%esp
80100a3a:	85 c0                	test   %eax,%eax
80100a3c:	0f 84 91 01 00 00    	je     80100bd3 <exec+0x1c3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a42:	83 ec 0c             	sub    $0xc,%esp
80100a45:	89 c3                	mov    %eax,%ebx
80100a47:	50                   	push   %eax
80100a48:	e8 43 0c 00 00       	call   80101690 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a4d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a53:	6a 34                	push   $0x34
80100a55:	6a 00                	push   $0x0
80100a57:	50                   	push   %eax
80100a58:	53                   	push   %ebx
80100a59:	e8 12 0f 00 00       	call   80101970 <readi>
80100a5e:	83 c4 20             	add    $0x20,%esp
80100a61:	83 f8 34             	cmp    $0x34,%eax
80100a64:	74 22                	je     80100a88 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a66:	83 ec 0c             	sub    $0xc,%esp
80100a69:	53                   	push   %ebx
80100a6a:	e8 b1 0e 00 00       	call   80101920 <iunlockput>
    end_op();
80100a6f:	e8 ac 21 00 00       	call   80102c20 <end_op>
80100a74:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a7f:	5b                   	pop    %ebx
80100a80:	5e                   	pop    %esi
80100a81:	5f                   	pop    %edi
80100a82:	5d                   	pop    %ebp
80100a83:	c3                   	ret    
80100a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100a88:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a8f:	45 4c 46 
80100a92:	75 d2                	jne    80100a66 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100a94:	e8 77 63 00 00       	call   80106e10 <setupkvm>
80100a99:	85 c0                	test   %eax,%eax
80100a9b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100aa1:	74 c3                	je     80100a66 <exec+0x56>
  sz = 0;
80100aa3:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100aa5:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100aac:	00 
80100aad:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100ab3:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100ab9:	0f 84 8c 02 00 00    	je     80100d4b <exec+0x33b>
80100abf:	31 f6                	xor    %esi,%esi
80100ac1:	eb 7f                	jmp    80100b42 <exec+0x132>
80100ac3:	90                   	nop
80100ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100ac8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100acf:	75 63                	jne    80100b34 <exec+0x124>
    if(ph.memsz < ph.filesz)
80100ad1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ad7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100add:	0f 82 86 00 00 00    	jb     80100b69 <exec+0x159>
80100ae3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ae9:	72 7e                	jb     80100b69 <exec+0x159>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100aeb:	83 ec 04             	sub    $0x4,%esp
80100aee:	50                   	push   %eax
80100aef:	57                   	push   %edi
80100af0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100af6:	e8 35 61 00 00       	call   80106c30 <allocuvm>
80100afb:	83 c4 10             	add    $0x10,%esp
80100afe:	85 c0                	test   %eax,%eax
80100b00:	89 c7                	mov    %eax,%edi
80100b02:	74 65                	je     80100b69 <exec+0x159>
    if(ph.vaddr % PGSIZE != 0)
80100b04:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b0a:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b0f:	75 58                	jne    80100b69 <exec+0x159>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b11:	83 ec 0c             	sub    $0xc,%esp
80100b14:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b1a:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b20:	53                   	push   %ebx
80100b21:	50                   	push   %eax
80100b22:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b28:	e8 43 60 00 00       	call   80106b70 <loaduvm>
80100b2d:	83 c4 20             	add    $0x20,%esp
80100b30:	85 c0                	test   %eax,%eax
80100b32:	78 35                	js     80100b69 <exec+0x159>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b34:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b3b:	83 c6 01             	add    $0x1,%esi
80100b3e:	39 f0                	cmp    %esi,%eax
80100b40:	7e 3d                	jle    80100b7f <exec+0x16f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b42:	89 f0                	mov    %esi,%eax
80100b44:	6a 20                	push   $0x20
80100b46:	c1 e0 05             	shl    $0x5,%eax
80100b49:	03 85 ec fe ff ff    	add    -0x114(%ebp),%eax
80100b4f:	50                   	push   %eax
80100b50:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b56:	50                   	push   %eax
80100b57:	53                   	push   %ebx
80100b58:	e8 13 0e 00 00       	call   80101970 <readi>
80100b5d:	83 c4 10             	add    $0x10,%esp
80100b60:	83 f8 20             	cmp    $0x20,%eax
80100b63:	0f 84 5f ff ff ff    	je     80100ac8 <exec+0xb8>
    freevm(pgdir);
80100b69:	83 ec 0c             	sub    $0xc,%esp
80100b6c:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b72:	e8 19 62 00 00       	call   80106d90 <freevm>
80100b77:	83 c4 10             	add    $0x10,%esp
80100b7a:	e9 e7 fe ff ff       	jmp    80100a66 <exec+0x56>
80100b7f:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100b85:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100b8b:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100b91:	83 ec 0c             	sub    $0xc,%esp
80100b94:	53                   	push   %ebx
80100b95:	e8 86 0d 00 00       	call   80101920 <iunlockput>
  end_op();
80100b9a:	e8 81 20 00 00       	call   80102c20 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b9f:	83 c4 0c             	add    $0xc,%esp
80100ba2:	56                   	push   %esi
80100ba3:	57                   	push   %edi
80100ba4:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100baa:	e8 81 60 00 00       	call   80106c30 <allocuvm>
80100baf:	83 c4 10             	add    $0x10,%esp
80100bb2:	85 c0                	test   %eax,%eax
80100bb4:	89 c6                	mov    %eax,%esi
80100bb6:	75 3a                	jne    80100bf2 <exec+0x1e2>
    freevm(pgdir);
80100bb8:	83 ec 0c             	sub    $0xc,%esp
80100bbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bc1:	e8 ca 61 00 00       	call   80106d90 <freevm>
80100bc6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bce:	e9 a9 fe ff ff       	jmp    80100a7c <exec+0x6c>
    end_op();
80100bd3:	e8 48 20 00 00       	call   80102c20 <end_op>
    cprintf("exec: fail\n");
80100bd8:	83 ec 0c             	sub    $0xc,%esp
80100bdb:	68 01 73 10 80       	push   $0x80107301
80100be0:	e8 7b fa ff ff       	call   80100660 <cprintf>
    return -1;
80100be5:	83 c4 10             	add    $0x10,%esp
80100be8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bed:	e9 8a fe ff ff       	jmp    80100a7c <exec+0x6c>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bf2:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100bf8:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100bfb:	31 ff                	xor    %edi,%edi
80100bfd:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bff:	50                   	push   %eax
80100c00:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c06:	e8 a5 62 00 00       	call   80106eb0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c0e:	83 c4 10             	add    $0x10,%esp
80100c11:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c17:	8b 00                	mov    (%eax),%eax
80100c19:	85 c0                	test   %eax,%eax
80100c1b:	74 70                	je     80100c8d <exec+0x27d>
80100c1d:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c23:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c29:	eb 0a                	jmp    80100c35 <exec+0x225>
80100c2b:	90                   	nop
80100c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100c30:	83 ff 20             	cmp    $0x20,%edi
80100c33:	74 83                	je     80100bb8 <exec+0x1a8>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c35:	83 ec 0c             	sub    $0xc,%esp
80100c38:	50                   	push   %eax
80100c39:	e8 e2 3b 00 00       	call   80104820 <strlen>
80100c3e:	f7 d0                	not    %eax
80100c40:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c42:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c45:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c46:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c49:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4c:	e8 cf 3b 00 00       	call   80104820 <strlen>
80100c51:	83 c0 01             	add    $0x1,%eax
80100c54:	50                   	push   %eax
80100c55:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c58:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5b:	53                   	push   %ebx
80100c5c:	56                   	push   %esi
80100c5d:	e8 ae 63 00 00       	call   80107010 <copyout>
80100c62:	83 c4 20             	add    $0x20,%esp
80100c65:	85 c0                	test   %eax,%eax
80100c67:	0f 88 4b ff ff ff    	js     80100bb8 <exec+0x1a8>
  for(argc = 0; argv[argc]; argc++) {
80100c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c70:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c77:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c7a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c80:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c83:	85 c0                	test   %eax,%eax
80100c85:	75 a9                	jne    80100c30 <exec+0x220>
80100c87:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c8d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c94:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100c96:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c9d:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100ca1:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100ca8:	ff ff ff 
  ustack[1] = argc;
80100cab:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb1:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100cb3:	83 c0 0c             	add    $0xc,%eax
80100cb6:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cb8:	50                   	push   %eax
80100cb9:	52                   	push   %edx
80100cba:	53                   	push   %ebx
80100cbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cc1:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cc7:	e8 44 63 00 00       	call   80107010 <copyout>
80100ccc:	83 c4 10             	add    $0x10,%esp
80100ccf:	85 c0                	test   %eax,%eax
80100cd1:	0f 88 e1 fe ff ff    	js     80100bb8 <exec+0x1a8>
  for(last=s=path; *s; s++)
80100cd7:	8b 45 08             	mov    0x8(%ebp),%eax
80100cda:	0f b6 00             	movzbl (%eax),%eax
80100cdd:	84 c0                	test   %al,%al
80100cdf:	74 17                	je     80100cf8 <exec+0x2e8>
80100ce1:	8b 55 08             	mov    0x8(%ebp),%edx
80100ce4:	89 d1                	mov    %edx,%ecx
80100ce6:	83 c1 01             	add    $0x1,%ecx
80100ce9:	3c 2f                	cmp    $0x2f,%al
80100ceb:	0f b6 01             	movzbl (%ecx),%eax
80100cee:	0f 44 d1             	cmove  %ecx,%edx
80100cf1:	84 c0                	test   %al,%al
80100cf3:	75 f1                	jne    80100ce6 <exec+0x2d6>
80100cf5:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cf8:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cfe:	50                   	push   %eax
80100cff:	6a 10                	push   $0x10
80100d01:	ff 75 08             	pushl  0x8(%ebp)
80100d04:	89 f8                	mov    %edi,%eax
80100d06:	83 c0 6c             	add    $0x6c,%eax
80100d09:	50                   	push   %eax
80100d0a:	e8 d1 3a 00 00       	call   801047e0 <safestrcpy>
  curproc->pgdir = pgdir;
80100d0f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  oldpgdir = curproc->pgdir;
80100d15:	89 f9                	mov    %edi,%ecx
80100d17:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->tf->eip = elf.entry;  // main
80100d1a:	8b 41 18             	mov    0x18(%ecx),%eax
  curproc->sz = sz;
80100d1d:	89 31                	mov    %esi,(%ecx)
  curproc->pgdir = pgdir;
80100d1f:	89 51 04             	mov    %edx,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100d22:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d28:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d2b:	8b 41 18             	mov    0x18(%ecx),%eax
80100d2e:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d31:	89 0c 24             	mov    %ecx,(%esp)
80100d34:	e8 a7 5c 00 00       	call   801069e0 <switchuvm>
  freevm(oldpgdir);
80100d39:	89 3c 24             	mov    %edi,(%esp)
80100d3c:	e8 4f 60 00 00       	call   80106d90 <freevm>
  return 0;
80100d41:	83 c4 10             	add    $0x10,%esp
80100d44:	31 c0                	xor    %eax,%eax
80100d46:	e9 31 fd ff ff       	jmp    80100a7c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d4b:	be 00 20 00 00       	mov    $0x2000,%esi
80100d50:	e9 3c fe ff ff       	jmp    80100b91 <exec+0x181>
80100d55:	66 90                	xchg   %ax,%ax
80100d57:	66 90                	xchg   %ax,%ax
80100d59:	66 90                	xchg   %ax,%ax
80100d5b:	66 90                	xchg   %ax,%ax
80100d5d:	66 90                	xchg   %ax,%ax
80100d5f:	90                   	nop

80100d60 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d60:	55                   	push   %ebp
80100d61:	89 e5                	mov    %esp,%ebp
80100d63:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d66:	68 0d 73 10 80       	push   $0x8010730d
80100d6b:	68 80 09 11 80       	push   $0x80110980
80100d70:	e8 3b 36 00 00       	call   801043b0 <initlock>
}
80100d75:	83 c4 10             	add    $0x10,%esp
80100d78:	c9                   	leave  
80100d79:	c3                   	ret    
80100d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d80 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d80:	55                   	push   %ebp
80100d81:	89 e5                	mov    %esp,%ebp
80100d83:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d84:	bb b4 09 11 80       	mov    $0x801109b4,%ebx
{
80100d89:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100d8c:	68 80 09 11 80       	push   $0x80110980
80100d91:	e8 5a 37 00 00       	call   801044f0 <acquire>
80100d96:	83 c4 10             	add    $0x10,%esp
80100d99:	eb 10                	jmp    80100dab <filealloc+0x2b>
80100d9b:	90                   	nop
80100d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100da0:	83 c3 18             	add    $0x18,%ebx
80100da3:	81 fb 14 13 11 80    	cmp    $0x80111314,%ebx
80100da9:	73 25                	jae    80100dd0 <filealloc+0x50>
    if(f->ref == 0){
80100dab:	8b 43 04             	mov    0x4(%ebx),%eax
80100dae:	85 c0                	test   %eax,%eax
80100db0:	75 ee                	jne    80100da0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100db2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100db5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dbc:	68 80 09 11 80       	push   $0x80110980
80100dc1:	e8 ea 37 00 00       	call   801045b0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dc6:	89 d8                	mov    %ebx,%eax
      return f;
80100dc8:	83 c4 10             	add    $0x10,%esp
}
80100dcb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dce:	c9                   	leave  
80100dcf:	c3                   	ret    
  release(&ftable.lock);
80100dd0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100dd3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100dd5:	68 80 09 11 80       	push   $0x80110980
80100dda:	e8 d1 37 00 00       	call   801045b0 <release>
}
80100ddf:	89 d8                	mov    %ebx,%eax
  return 0;
80100de1:	83 c4 10             	add    $0x10,%esp
}
80100de4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100de7:	c9                   	leave  
80100de8:	c3                   	ret    
80100de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100df0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100df0:	55                   	push   %ebp
80100df1:	89 e5                	mov    %esp,%ebp
80100df3:	53                   	push   %ebx
80100df4:	83 ec 10             	sub    $0x10,%esp
80100df7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dfa:	68 80 09 11 80       	push   $0x80110980
80100dff:	e8 ec 36 00 00       	call   801044f0 <acquire>
  if(f->ref < 1)
80100e04:	8b 43 04             	mov    0x4(%ebx),%eax
80100e07:	83 c4 10             	add    $0x10,%esp
80100e0a:	85 c0                	test   %eax,%eax
80100e0c:	7e 1a                	jle    80100e28 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e0e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e11:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e14:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e17:	68 80 09 11 80       	push   $0x80110980
80100e1c:	e8 8f 37 00 00       	call   801045b0 <release>
  return f;
}
80100e21:	89 d8                	mov    %ebx,%eax
80100e23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e26:	c9                   	leave  
80100e27:	c3                   	ret    
    panic("filedup");
80100e28:	83 ec 0c             	sub    $0xc,%esp
80100e2b:	68 14 73 10 80       	push   $0x80107314
80100e30:	e8 5b f5 ff ff       	call   80100390 <panic>
80100e35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e40 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e40:	55                   	push   %ebp
80100e41:	89 e5                	mov    %esp,%ebp
80100e43:	57                   	push   %edi
80100e44:	56                   	push   %esi
80100e45:	53                   	push   %ebx
80100e46:	83 ec 28             	sub    $0x28,%esp
80100e49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100e4c:	68 80 09 11 80       	push   $0x80110980
80100e51:	e8 9a 36 00 00       	call   801044f0 <acquire>
  if(f->ref < 1)
80100e56:	8b 43 04             	mov    0x4(%ebx),%eax
80100e59:	83 c4 10             	add    $0x10,%esp
80100e5c:	85 c0                	test   %eax,%eax
80100e5e:	0f 8e 9b 00 00 00    	jle    80100eff <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e64:	83 e8 01             	sub    $0x1,%eax
80100e67:	85 c0                	test   %eax,%eax
80100e69:	89 43 04             	mov    %eax,0x4(%ebx)
80100e6c:	74 1a                	je     80100e88 <fileclose+0x48>
    release(&ftable.lock);
80100e6e:	c7 45 08 80 09 11 80 	movl   $0x80110980,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e75:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e78:	5b                   	pop    %ebx
80100e79:	5e                   	pop    %esi
80100e7a:	5f                   	pop    %edi
80100e7b:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e7c:	e9 2f 37 00 00       	jmp    801045b0 <release>
80100e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100e88:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100e8c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100e8e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100e91:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100e94:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100e9a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e9d:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100ea0:	68 80 09 11 80       	push   $0x80110980
  ff = *f;
80100ea5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100ea8:	e8 03 37 00 00       	call   801045b0 <release>
  if(ff.type == FD_PIPE)
80100ead:	83 c4 10             	add    $0x10,%esp
80100eb0:	83 ff 01             	cmp    $0x1,%edi
80100eb3:	74 13                	je     80100ec8 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100eb5:	83 ff 02             	cmp    $0x2,%edi
80100eb8:	74 26                	je     80100ee0 <fileclose+0xa0>
}
80100eba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ebd:	5b                   	pop    %ebx
80100ebe:	5e                   	pop    %esi
80100ebf:	5f                   	pop    %edi
80100ec0:	5d                   	pop    %ebp
80100ec1:	c3                   	ret    
80100ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100ec8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ecc:	83 ec 08             	sub    $0x8,%esp
80100ecf:	53                   	push   %ebx
80100ed0:	56                   	push   %esi
80100ed1:	e8 7a 24 00 00       	call   80103350 <pipeclose>
80100ed6:	83 c4 10             	add    $0x10,%esp
80100ed9:	eb df                	jmp    80100eba <fileclose+0x7a>
80100edb:	90                   	nop
80100edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100ee0:	e8 cb 1c 00 00       	call   80102bb0 <begin_op>
    iput(ff.ip);
80100ee5:	83 ec 0c             	sub    $0xc,%esp
80100ee8:	ff 75 e0             	pushl  -0x20(%ebp)
80100eeb:	e8 d0 08 00 00       	call   801017c0 <iput>
    end_op();
80100ef0:	83 c4 10             	add    $0x10,%esp
}
80100ef3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ef6:	5b                   	pop    %ebx
80100ef7:	5e                   	pop    %esi
80100ef8:	5f                   	pop    %edi
80100ef9:	5d                   	pop    %ebp
    end_op();
80100efa:	e9 21 1d 00 00       	jmp    80102c20 <end_op>
    panic("fileclose");
80100eff:	83 ec 0c             	sub    $0xc,%esp
80100f02:	68 1c 73 10 80       	push   $0x8010731c
80100f07:	e8 84 f4 ff ff       	call   80100390 <panic>
80100f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f10 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	53                   	push   %ebx
80100f14:	83 ec 04             	sub    $0x4,%esp
80100f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f1a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f1d:	75 31                	jne    80100f50 <filestat+0x40>
    ilock(f->ip);
80100f1f:	83 ec 0c             	sub    $0xc,%esp
80100f22:	ff 73 10             	pushl  0x10(%ebx)
80100f25:	e8 66 07 00 00       	call   80101690 <ilock>
    stati(f->ip, st);
80100f2a:	58                   	pop    %eax
80100f2b:	5a                   	pop    %edx
80100f2c:	ff 75 0c             	pushl  0xc(%ebp)
80100f2f:	ff 73 10             	pushl  0x10(%ebx)
80100f32:	e8 09 0a 00 00       	call   80101940 <stati>
    iunlock(f->ip);
80100f37:	59                   	pop    %ecx
80100f38:	ff 73 10             	pushl  0x10(%ebx)
80100f3b:	e8 30 08 00 00       	call   80101770 <iunlock>
    return 0;
80100f40:	83 c4 10             	add    $0x10,%esp
80100f43:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f48:	c9                   	leave  
80100f49:	c3                   	ret    
80100f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100f50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f55:	eb ee                	jmp    80100f45 <filestat+0x35>
80100f57:	89 f6                	mov    %esi,%esi
80100f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f60 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f60:	55                   	push   %ebp
80100f61:	89 e5                	mov    %esp,%ebp
80100f63:	57                   	push   %edi
80100f64:	56                   	push   %esi
80100f65:	53                   	push   %ebx
80100f66:	83 ec 0c             	sub    $0xc,%esp
80100f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f6f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f72:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f76:	74 60                	je     80100fd8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f78:	8b 03                	mov    (%ebx),%eax
80100f7a:	83 f8 01             	cmp    $0x1,%eax
80100f7d:	74 41                	je     80100fc0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f7f:	83 f8 02             	cmp    $0x2,%eax
80100f82:	75 5b                	jne    80100fdf <fileread+0x7f>
    ilock(f->ip);
80100f84:	83 ec 0c             	sub    $0xc,%esp
80100f87:	ff 73 10             	pushl  0x10(%ebx)
80100f8a:	e8 01 07 00 00       	call   80101690 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f8f:	57                   	push   %edi
80100f90:	ff 73 14             	pushl  0x14(%ebx)
80100f93:	56                   	push   %esi
80100f94:	ff 73 10             	pushl  0x10(%ebx)
80100f97:	e8 d4 09 00 00       	call   80101970 <readi>
80100f9c:	83 c4 20             	add    $0x20,%esp
80100f9f:	85 c0                	test   %eax,%eax
80100fa1:	89 c6                	mov    %eax,%esi
80100fa3:	7e 03                	jle    80100fa8 <fileread+0x48>
      f->off += r;
80100fa5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fa8:	83 ec 0c             	sub    $0xc,%esp
80100fab:	ff 73 10             	pushl  0x10(%ebx)
80100fae:	e8 bd 07 00 00       	call   80101770 <iunlock>
    return r;
80100fb3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100fb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb9:	89 f0                	mov    %esi,%eax
80100fbb:	5b                   	pop    %ebx
80100fbc:	5e                   	pop    %esi
80100fbd:	5f                   	pop    %edi
80100fbe:	5d                   	pop    %ebp
80100fbf:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80100fc0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fc3:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100fc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fc9:	5b                   	pop    %ebx
80100fca:	5e                   	pop    %esi
80100fcb:	5f                   	pop    %edi
80100fcc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100fcd:	e9 2e 25 00 00       	jmp    80103500 <piperead>
80100fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80100fd8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100fdd:	eb d7                	jmp    80100fb6 <fileread+0x56>
  panic("fileread");
80100fdf:	83 ec 0c             	sub    $0xc,%esp
80100fe2:	68 26 73 10 80       	push   $0x80107326
80100fe7:	e8 a4 f3 ff ff       	call   80100390 <panic>
80100fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ff0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100ff0:	55                   	push   %ebp
80100ff1:	89 e5                	mov    %esp,%ebp
80100ff3:	57                   	push   %edi
80100ff4:	56                   	push   %esi
80100ff5:	53                   	push   %ebx
80100ff6:	83 ec 1c             	sub    $0x1c,%esp
80100ff9:	8b 75 08             	mov    0x8(%ebp),%esi
80100ffc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fff:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101003:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101006:	8b 45 10             	mov    0x10(%ebp),%eax
80101009:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010100c:	0f 84 aa 00 00 00    	je     801010bc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101012:	8b 06                	mov    (%esi),%eax
80101014:	83 f8 01             	cmp    $0x1,%eax
80101017:	0f 84 c3 00 00 00    	je     801010e0 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010101d:	83 f8 02             	cmp    $0x2,%eax
80101020:	0f 85 d9 00 00 00    	jne    801010ff <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101026:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101029:	31 ff                	xor    %edi,%edi
    while(i < n){
8010102b:	85 c0                	test   %eax,%eax
8010102d:	7f 34                	jg     80101063 <filewrite+0x73>
8010102f:	e9 9c 00 00 00       	jmp    801010d0 <filewrite+0xe0>
80101034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101038:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010103b:	83 ec 0c             	sub    $0xc,%esp
8010103e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101041:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101044:	e8 27 07 00 00       	call   80101770 <iunlock>
      end_op();
80101049:	e8 d2 1b 00 00       	call   80102c20 <end_op>
8010104e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101051:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101054:	39 c3                	cmp    %eax,%ebx
80101056:	0f 85 96 00 00 00    	jne    801010f2 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010105c:	01 df                	add    %ebx,%edi
    while(i < n){
8010105e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101061:	7e 6d                	jle    801010d0 <filewrite+0xe0>
      int n1 = n - i;
80101063:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101066:	b8 00 06 00 00       	mov    $0x600,%eax
8010106b:	29 fb                	sub    %edi,%ebx
8010106d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101073:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101076:	e8 35 1b 00 00       	call   80102bb0 <begin_op>
      ilock(f->ip);
8010107b:	83 ec 0c             	sub    $0xc,%esp
8010107e:	ff 76 10             	pushl  0x10(%esi)
80101081:	e8 0a 06 00 00       	call   80101690 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101086:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101089:	53                   	push   %ebx
8010108a:	ff 76 14             	pushl  0x14(%esi)
8010108d:	01 f8                	add    %edi,%eax
8010108f:	50                   	push   %eax
80101090:	ff 76 10             	pushl  0x10(%esi)
80101093:	e8 d8 09 00 00       	call   80101a70 <writei>
80101098:	83 c4 20             	add    $0x20,%esp
8010109b:	85 c0                	test   %eax,%eax
8010109d:	7f 99                	jg     80101038 <filewrite+0x48>
      iunlock(f->ip);
8010109f:	83 ec 0c             	sub    $0xc,%esp
801010a2:	ff 76 10             	pushl  0x10(%esi)
801010a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010a8:	e8 c3 06 00 00       	call   80101770 <iunlock>
      end_op();
801010ad:	e8 6e 1b 00 00       	call   80102c20 <end_op>
      if(r < 0)
801010b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010b5:	83 c4 10             	add    $0x10,%esp
801010b8:	85 c0                	test   %eax,%eax
801010ba:	74 98                	je     80101054 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801010bf:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
801010c4:	89 f8                	mov    %edi,%eax
801010c6:	5b                   	pop    %ebx
801010c7:	5e                   	pop    %esi
801010c8:	5f                   	pop    %edi
801010c9:	5d                   	pop    %ebp
801010ca:	c3                   	ret    
801010cb:	90                   	nop
801010cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
801010d0:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010d3:	75 e7                	jne    801010bc <filewrite+0xcc>
}
801010d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d8:	89 f8                	mov    %edi,%eax
801010da:	5b                   	pop    %ebx
801010db:	5e                   	pop    %esi
801010dc:	5f                   	pop    %edi
801010dd:	5d                   	pop    %ebp
801010de:	c3                   	ret    
801010df:	90                   	nop
    return pipewrite(f->pipe, addr, n);
801010e0:	8b 46 0c             	mov    0xc(%esi),%eax
801010e3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010e9:	5b                   	pop    %ebx
801010ea:	5e                   	pop    %esi
801010eb:	5f                   	pop    %edi
801010ec:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801010ed:	e9 fe 22 00 00       	jmp    801033f0 <pipewrite>
        panic("short filewrite");
801010f2:	83 ec 0c             	sub    $0xc,%esp
801010f5:	68 2f 73 10 80       	push   $0x8010732f
801010fa:	e8 91 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
801010ff:	83 ec 0c             	sub    $0xc,%esp
80101102:	68 35 73 10 80       	push   $0x80107335
80101107:	e8 84 f2 ff ff       	call   80100390 <panic>
8010110c:	66 90                	xchg   %ax,%ax
8010110e:	66 90                	xchg   %ax,%ax

80101110 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101110:	55                   	push   %ebp
80101111:	89 e5                	mov    %esp,%ebp
80101113:	57                   	push   %edi
80101114:	56                   	push   %esi
80101115:	53                   	push   %ebx
80101116:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101119:	8b 0d 80 13 11 80    	mov    0x80111380,%ecx
{
8010111f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101122:	85 c9                	test   %ecx,%ecx
80101124:	0f 84 87 00 00 00    	je     801011b1 <balloc+0xa1>
8010112a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101131:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101134:	83 ec 08             	sub    $0x8,%esp
80101137:	89 f0                	mov    %esi,%eax
80101139:	c1 f8 0c             	sar    $0xc,%eax
8010113c:	03 05 98 13 11 80    	add    0x80111398,%eax
80101142:	50                   	push   %eax
80101143:	ff 75 d8             	pushl  -0x28(%ebp)
80101146:	e8 85 ef ff ff       	call   801000d0 <bread>
8010114b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010114e:	a1 80 13 11 80       	mov    0x80111380,%eax
80101153:	83 c4 10             	add    $0x10,%esp
80101156:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101159:	31 c0                	xor    %eax,%eax
8010115b:	eb 2f                	jmp    8010118c <balloc+0x7c>
8010115d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101160:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101162:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101165:	bb 01 00 00 00       	mov    $0x1,%ebx
8010116a:	83 e1 07             	and    $0x7,%ecx
8010116d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010116f:	89 c1                	mov    %eax,%ecx
80101171:	c1 f9 03             	sar    $0x3,%ecx
80101174:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101179:	85 df                	test   %ebx,%edi
8010117b:	89 fa                	mov    %edi,%edx
8010117d:	74 41                	je     801011c0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010117f:	83 c0 01             	add    $0x1,%eax
80101182:	83 c6 01             	add    $0x1,%esi
80101185:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010118a:	74 05                	je     80101191 <balloc+0x81>
8010118c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010118f:	77 cf                	ja     80101160 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101191:	83 ec 0c             	sub    $0xc,%esp
80101194:	ff 75 e4             	pushl  -0x1c(%ebp)
80101197:	e8 44 f0 ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010119c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801011a3:	83 c4 10             	add    $0x10,%esp
801011a6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011a9:	39 05 80 13 11 80    	cmp    %eax,0x80111380
801011af:	77 80                	ja     80101131 <balloc+0x21>
  }
  panic("balloc: out of blocks");
801011b1:	83 ec 0c             	sub    $0xc,%esp
801011b4:	68 3f 73 10 80       	push   $0x8010733f
801011b9:	e8 d2 f1 ff ff       	call   80100390 <panic>
801011be:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801011c0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801011c3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801011c6:	09 da                	or     %ebx,%edx
801011c8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801011cc:	57                   	push   %edi
801011cd:	e8 ae 1b 00 00       	call   80102d80 <log_write>
        brelse(bp);
801011d2:	89 3c 24             	mov    %edi,(%esp)
801011d5:	e8 06 f0 ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
801011da:	58                   	pop    %eax
801011db:	5a                   	pop    %edx
801011dc:	56                   	push   %esi
801011dd:	ff 75 d8             	pushl  -0x28(%ebp)
801011e0:	e8 eb ee ff ff       	call   801000d0 <bread>
801011e5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801011e7:	8d 40 5c             	lea    0x5c(%eax),%eax
801011ea:	83 c4 0c             	add    $0xc,%esp
801011ed:	68 00 02 00 00       	push   $0x200
801011f2:	6a 00                	push   $0x0
801011f4:	50                   	push   %eax
801011f5:	e8 06 34 00 00       	call   80104600 <memset>
  log_write(bp);
801011fa:	89 1c 24             	mov    %ebx,(%esp)
801011fd:	e8 7e 1b 00 00       	call   80102d80 <log_write>
  brelse(bp);
80101202:	89 1c 24             	mov    %ebx,(%esp)
80101205:	e8 d6 ef ff ff       	call   801001e0 <brelse>
}
8010120a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010120d:	89 f0                	mov    %esi,%eax
8010120f:	5b                   	pop    %ebx
80101210:	5e                   	pop    %esi
80101211:	5f                   	pop    %edi
80101212:	5d                   	pop    %ebp
80101213:	c3                   	ret    
80101214:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010121a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101220 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101220:	55                   	push   %ebp
80101221:	89 e5                	mov    %esp,%ebp
80101223:	57                   	push   %edi
80101224:	56                   	push   %esi
80101225:	53                   	push   %ebx
80101226:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101228:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010122a:	bb d4 13 11 80       	mov    $0x801113d4,%ebx
{
8010122f:	83 ec 28             	sub    $0x28,%esp
80101232:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101235:	68 a0 13 11 80       	push   $0x801113a0
8010123a:	e8 b1 32 00 00       	call   801044f0 <acquire>
8010123f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101242:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101245:	eb 17                	jmp    8010125e <iget+0x3e>
80101247:	89 f6                	mov    %esi,%esi
80101249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101250:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101256:	81 fb f4 2f 11 80    	cmp    $0x80112ff4,%ebx
8010125c:	73 22                	jae    80101280 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010125e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101261:	85 c9                	test   %ecx,%ecx
80101263:	7e 04                	jle    80101269 <iget+0x49>
80101265:	39 3b                	cmp    %edi,(%ebx)
80101267:	74 4f                	je     801012b8 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101269:	85 f6                	test   %esi,%esi
8010126b:	75 e3                	jne    80101250 <iget+0x30>
8010126d:	85 c9                	test   %ecx,%ecx
8010126f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101272:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101278:	81 fb f4 2f 11 80    	cmp    $0x80112ff4,%ebx
8010127e:	72 de                	jb     8010125e <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101280:	85 f6                	test   %esi,%esi
80101282:	74 5b                	je     801012df <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101284:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101287:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101289:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010128c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101293:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010129a:	68 a0 13 11 80       	push   $0x801113a0
8010129f:	e8 0c 33 00 00       	call   801045b0 <release>

  return ip;
801012a4:	83 c4 10             	add    $0x10,%esp
}
801012a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012aa:	89 f0                	mov    %esi,%eax
801012ac:	5b                   	pop    %ebx
801012ad:	5e                   	pop    %esi
801012ae:	5f                   	pop    %edi
801012af:	5d                   	pop    %ebp
801012b0:	c3                   	ret    
801012b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012b8:	39 53 04             	cmp    %edx,0x4(%ebx)
801012bb:	75 ac                	jne    80101269 <iget+0x49>
      release(&icache.lock);
801012bd:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801012c0:	83 c1 01             	add    $0x1,%ecx
      return ip;
801012c3:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801012c5:	68 a0 13 11 80       	push   $0x801113a0
      ip->ref++;
801012ca:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012cd:	e8 de 32 00 00       	call   801045b0 <release>
      return ip;
801012d2:	83 c4 10             	add    $0x10,%esp
}
801012d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012d8:	89 f0                	mov    %esi,%eax
801012da:	5b                   	pop    %ebx
801012db:	5e                   	pop    %esi
801012dc:	5f                   	pop    %edi
801012dd:	5d                   	pop    %ebp
801012de:	c3                   	ret    
    panic("iget: no inodes");
801012df:	83 ec 0c             	sub    $0xc,%esp
801012e2:	68 55 73 10 80       	push   $0x80107355
801012e7:	e8 a4 f0 ff ff       	call   80100390 <panic>
801012ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801012f0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801012f0:	55                   	push   %ebp
801012f1:	89 e5                	mov    %esp,%ebp
801012f3:	57                   	push   %edi
801012f4:	56                   	push   %esi
801012f5:	53                   	push   %ebx
801012f6:	89 c6                	mov    %eax,%esi
801012f8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801012fb:	83 fa 0b             	cmp    $0xb,%edx
801012fe:	77 18                	ja     80101318 <bmap+0x28>
80101300:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101303:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101306:	85 db                	test   %ebx,%ebx
80101308:	74 76                	je     80101380 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010130a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010130d:	89 d8                	mov    %ebx,%eax
8010130f:	5b                   	pop    %ebx
80101310:	5e                   	pop    %esi
80101311:	5f                   	pop    %edi
80101312:	5d                   	pop    %ebp
80101313:	c3                   	ret    
80101314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101318:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
8010131b:	83 fb 7f             	cmp    $0x7f,%ebx
8010131e:	0f 87 90 00 00 00    	ja     801013b4 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101324:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
8010132a:	8b 00                	mov    (%eax),%eax
8010132c:	85 d2                	test   %edx,%edx
8010132e:	74 70                	je     801013a0 <bmap+0xb0>
    bp = bread(ip->dev, addr);
80101330:	83 ec 08             	sub    $0x8,%esp
80101333:	52                   	push   %edx
80101334:	50                   	push   %eax
80101335:	e8 96 ed ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
8010133a:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010133e:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
80101341:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
80101343:	8b 1a                	mov    (%edx),%ebx
80101345:	85 db                	test   %ebx,%ebx
80101347:	75 1d                	jne    80101366 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
80101349:	8b 06                	mov    (%esi),%eax
8010134b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010134e:	e8 bd fd ff ff       	call   80101110 <balloc>
80101353:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101356:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101359:	89 c3                	mov    %eax,%ebx
8010135b:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010135d:	57                   	push   %edi
8010135e:	e8 1d 1a 00 00       	call   80102d80 <log_write>
80101363:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101366:	83 ec 0c             	sub    $0xc,%esp
80101369:	57                   	push   %edi
8010136a:	e8 71 ee ff ff       	call   801001e0 <brelse>
8010136f:	83 c4 10             	add    $0x10,%esp
}
80101372:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101375:	89 d8                	mov    %ebx,%eax
80101377:	5b                   	pop    %ebx
80101378:	5e                   	pop    %esi
80101379:	5f                   	pop    %edi
8010137a:	5d                   	pop    %ebp
8010137b:	c3                   	ret    
8010137c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101380:	8b 00                	mov    (%eax),%eax
80101382:	e8 89 fd ff ff       	call   80101110 <balloc>
80101387:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010138a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010138d:	89 c3                	mov    %eax,%ebx
}
8010138f:	89 d8                	mov    %ebx,%eax
80101391:	5b                   	pop    %ebx
80101392:	5e                   	pop    %esi
80101393:	5f                   	pop    %edi
80101394:	5d                   	pop    %ebp
80101395:	c3                   	ret    
80101396:	8d 76 00             	lea    0x0(%esi),%esi
80101399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801013a0:	e8 6b fd ff ff       	call   80101110 <balloc>
801013a5:	89 c2                	mov    %eax,%edx
801013a7:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801013ad:	8b 06                	mov    (%esi),%eax
801013af:	e9 7c ff ff ff       	jmp    80101330 <bmap+0x40>
  panic("bmap: out of range");
801013b4:	83 ec 0c             	sub    $0xc,%esp
801013b7:	68 65 73 10 80       	push   $0x80107365
801013bc:	e8 cf ef ff ff       	call   80100390 <panic>
801013c1:	eb 0d                	jmp    801013d0 <readsb>
801013c3:	90                   	nop
801013c4:	90                   	nop
801013c5:	90                   	nop
801013c6:	90                   	nop
801013c7:	90                   	nop
801013c8:	90                   	nop
801013c9:	90                   	nop
801013ca:	90                   	nop
801013cb:	90                   	nop
801013cc:	90                   	nop
801013cd:	90                   	nop
801013ce:	90                   	nop
801013cf:	90                   	nop

801013d0 <readsb>:
{
801013d0:	55                   	push   %ebp
801013d1:	89 e5                	mov    %esp,%ebp
801013d3:	56                   	push   %esi
801013d4:	53                   	push   %ebx
801013d5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801013d8:	83 ec 08             	sub    $0x8,%esp
801013db:	6a 01                	push   $0x1
801013dd:	ff 75 08             	pushl  0x8(%ebp)
801013e0:	e8 eb ec ff ff       	call   801000d0 <bread>
801013e5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801013e7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013ea:	83 c4 0c             	add    $0xc,%esp
801013ed:	6a 1c                	push   $0x1c
801013ef:	50                   	push   %eax
801013f0:	56                   	push   %esi
801013f1:	e8 ba 32 00 00       	call   801046b0 <memmove>
  brelse(bp);
801013f6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801013f9:	83 c4 10             	add    $0x10,%esp
}
801013fc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801013ff:	5b                   	pop    %ebx
80101400:	5e                   	pop    %esi
80101401:	5d                   	pop    %ebp
  brelse(bp);
80101402:	e9 d9 ed ff ff       	jmp    801001e0 <brelse>
80101407:	89 f6                	mov    %esi,%esi
80101409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101410 <bfree>:
{
80101410:	55                   	push   %ebp
80101411:	89 e5                	mov    %esp,%ebp
80101413:	56                   	push   %esi
80101414:	53                   	push   %ebx
80101415:	89 d3                	mov    %edx,%ebx
80101417:	89 c6                	mov    %eax,%esi
  readsb(dev, &sb);
80101419:	83 ec 08             	sub    $0x8,%esp
8010141c:	68 80 13 11 80       	push   $0x80111380
80101421:	50                   	push   %eax
80101422:	e8 a9 ff ff ff       	call   801013d0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101427:	58                   	pop    %eax
80101428:	5a                   	pop    %edx
80101429:	89 da                	mov    %ebx,%edx
8010142b:	c1 ea 0c             	shr    $0xc,%edx
8010142e:	03 15 98 13 11 80    	add    0x80111398,%edx
80101434:	52                   	push   %edx
80101435:	56                   	push   %esi
80101436:	e8 95 ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010143b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010143d:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
80101440:	ba 01 00 00 00       	mov    $0x1,%edx
80101445:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101448:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010144e:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101451:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101453:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101458:	85 d1                	test   %edx,%ecx
8010145a:	74 25                	je     80101481 <bfree+0x71>
  bp->data[bi/8] &= ~m;
8010145c:	f7 d2                	not    %edx
8010145e:	89 c6                	mov    %eax,%esi
  log_write(bp);
80101460:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101463:	21 ca                	and    %ecx,%edx
80101465:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101469:	56                   	push   %esi
8010146a:	e8 11 19 00 00       	call   80102d80 <log_write>
  brelse(bp);
8010146f:	89 34 24             	mov    %esi,(%esp)
80101472:	e8 69 ed ff ff       	call   801001e0 <brelse>
}
80101477:	83 c4 10             	add    $0x10,%esp
8010147a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010147d:	5b                   	pop    %ebx
8010147e:	5e                   	pop    %esi
8010147f:	5d                   	pop    %ebp
80101480:	c3                   	ret    
    panic("freeing free block");
80101481:	83 ec 0c             	sub    $0xc,%esp
80101484:	68 78 73 10 80       	push   $0x80107378
80101489:	e8 02 ef ff ff       	call   80100390 <panic>
8010148e:	66 90                	xchg   %ax,%ax

80101490 <iinit>:
{
80101490:	55                   	push   %ebp
80101491:	89 e5                	mov    %esp,%ebp
80101493:	53                   	push   %ebx
80101494:	bb e0 13 11 80       	mov    $0x801113e0,%ebx
80101499:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010149c:	68 8b 73 10 80       	push   $0x8010738b
801014a1:	68 a0 13 11 80       	push   $0x801113a0
801014a6:	e8 05 2f 00 00       	call   801043b0 <initlock>
801014ab:	83 c4 10             	add    $0x10,%esp
801014ae:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801014b0:	83 ec 08             	sub    $0x8,%esp
801014b3:	68 92 73 10 80       	push   $0x80107392
801014b8:	53                   	push   %ebx
801014b9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014bf:	e8 bc 2d 00 00       	call   80104280 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014c4:	83 c4 10             	add    $0x10,%esp
801014c7:	81 fb 00 30 11 80    	cmp    $0x80113000,%ebx
801014cd:	75 e1                	jne    801014b0 <iinit+0x20>
  readsb(dev, &sb);
801014cf:	83 ec 08             	sub    $0x8,%esp
801014d2:	68 80 13 11 80       	push   $0x80111380
801014d7:	ff 75 08             	pushl  0x8(%ebp)
801014da:	e8 f1 fe ff ff       	call   801013d0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014df:	ff 35 98 13 11 80    	pushl  0x80111398
801014e5:	ff 35 94 13 11 80    	pushl  0x80111394
801014eb:	ff 35 90 13 11 80    	pushl  0x80111390
801014f1:	ff 35 8c 13 11 80    	pushl  0x8011138c
801014f7:	ff 35 88 13 11 80    	pushl  0x80111388
801014fd:	ff 35 84 13 11 80    	pushl  0x80111384
80101503:	ff 35 80 13 11 80    	pushl  0x80111380
80101509:	68 f8 73 10 80       	push   $0x801073f8
8010150e:	e8 4d f1 ff ff       	call   80100660 <cprintf>
}
80101513:	83 c4 30             	add    $0x30,%esp
80101516:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101519:	c9                   	leave  
8010151a:	c3                   	ret    
8010151b:	90                   	nop
8010151c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101520 <ialloc>:
{
80101520:	55                   	push   %ebp
80101521:	89 e5                	mov    %esp,%ebp
80101523:	57                   	push   %edi
80101524:	56                   	push   %esi
80101525:	53                   	push   %ebx
80101526:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101529:	83 3d 88 13 11 80 01 	cmpl   $0x1,0x80111388
{
80101530:	8b 45 0c             	mov    0xc(%ebp),%eax
80101533:	8b 75 08             	mov    0x8(%ebp),%esi
80101536:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101539:	0f 86 91 00 00 00    	jbe    801015d0 <ialloc+0xb0>
8010153f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101544:	eb 21                	jmp    80101567 <ialloc+0x47>
80101546:	8d 76 00             	lea    0x0(%esi),%esi
80101549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101550:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101553:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101556:	57                   	push   %edi
80101557:	e8 84 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010155c:	83 c4 10             	add    $0x10,%esp
8010155f:	39 1d 88 13 11 80    	cmp    %ebx,0x80111388
80101565:	76 69                	jbe    801015d0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101567:	89 d8                	mov    %ebx,%eax
80101569:	83 ec 08             	sub    $0x8,%esp
8010156c:	c1 e8 03             	shr    $0x3,%eax
8010156f:	03 05 94 13 11 80    	add    0x80111394,%eax
80101575:	50                   	push   %eax
80101576:	56                   	push   %esi
80101577:	e8 54 eb ff ff       	call   801000d0 <bread>
8010157c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010157e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101580:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
80101583:	83 e0 07             	and    $0x7,%eax
80101586:	c1 e0 06             	shl    $0x6,%eax
80101589:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010158d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101591:	75 bd                	jne    80101550 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101593:	83 ec 04             	sub    $0x4,%esp
80101596:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101599:	6a 40                	push   $0x40
8010159b:	6a 00                	push   $0x0
8010159d:	51                   	push   %ecx
8010159e:	e8 5d 30 00 00       	call   80104600 <memset>
      dip->type = type;
801015a3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801015a7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801015aa:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801015ad:	89 3c 24             	mov    %edi,(%esp)
801015b0:	e8 cb 17 00 00       	call   80102d80 <log_write>
      brelse(bp);
801015b5:	89 3c 24             	mov    %edi,(%esp)
801015b8:	e8 23 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801015bd:	83 c4 10             	add    $0x10,%esp
}
801015c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801015c3:	89 da                	mov    %ebx,%edx
801015c5:	89 f0                	mov    %esi,%eax
}
801015c7:	5b                   	pop    %ebx
801015c8:	5e                   	pop    %esi
801015c9:	5f                   	pop    %edi
801015ca:	5d                   	pop    %ebp
      return iget(dev, inum);
801015cb:	e9 50 fc ff ff       	jmp    80101220 <iget>
  panic("ialloc: no inodes");
801015d0:	83 ec 0c             	sub    $0xc,%esp
801015d3:	68 98 73 10 80       	push   $0x80107398
801015d8:	e8 b3 ed ff ff       	call   80100390 <panic>
801015dd:	8d 76 00             	lea    0x0(%esi),%esi

801015e0 <iupdate>:
{
801015e0:	55                   	push   %ebp
801015e1:	89 e5                	mov    %esp,%ebp
801015e3:	56                   	push   %esi
801015e4:	53                   	push   %ebx
801015e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015e8:	83 ec 08             	sub    $0x8,%esp
801015eb:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015ee:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015f1:	c1 e8 03             	shr    $0x3,%eax
801015f4:	03 05 94 13 11 80    	add    0x80111394,%eax
801015fa:	50                   	push   %eax
801015fb:	ff 73 a4             	pushl  -0x5c(%ebx)
801015fe:	e8 cd ea ff ff       	call   801000d0 <bread>
80101603:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101605:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101608:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010160c:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010160f:	83 e0 07             	and    $0x7,%eax
80101612:	c1 e0 06             	shl    $0x6,%eax
80101615:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101619:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010161c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101620:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101623:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101627:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010162b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010162f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101633:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101637:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010163a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010163d:	6a 34                	push   $0x34
8010163f:	53                   	push   %ebx
80101640:	50                   	push   %eax
80101641:	e8 6a 30 00 00       	call   801046b0 <memmove>
  log_write(bp);
80101646:	89 34 24             	mov    %esi,(%esp)
80101649:	e8 32 17 00 00       	call   80102d80 <log_write>
  brelse(bp);
8010164e:	89 75 08             	mov    %esi,0x8(%ebp)
80101651:	83 c4 10             	add    $0x10,%esp
}
80101654:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101657:	5b                   	pop    %ebx
80101658:	5e                   	pop    %esi
80101659:	5d                   	pop    %ebp
  brelse(bp);
8010165a:	e9 81 eb ff ff       	jmp    801001e0 <brelse>
8010165f:	90                   	nop

80101660 <idup>:
{
80101660:	55                   	push   %ebp
80101661:	89 e5                	mov    %esp,%ebp
80101663:	53                   	push   %ebx
80101664:	83 ec 10             	sub    $0x10,%esp
80101667:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010166a:	68 a0 13 11 80       	push   $0x801113a0
8010166f:	e8 7c 2e 00 00       	call   801044f0 <acquire>
  ip->ref++;
80101674:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101678:	c7 04 24 a0 13 11 80 	movl   $0x801113a0,(%esp)
8010167f:	e8 2c 2f 00 00       	call   801045b0 <release>
}
80101684:	89 d8                	mov    %ebx,%eax
80101686:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101689:	c9                   	leave  
8010168a:	c3                   	ret    
8010168b:	90                   	nop
8010168c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101690 <ilock>:
{
80101690:	55                   	push   %ebp
80101691:	89 e5                	mov    %esp,%ebp
80101693:	56                   	push   %esi
80101694:	53                   	push   %ebx
80101695:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101698:	85 db                	test   %ebx,%ebx
8010169a:	0f 84 b7 00 00 00    	je     80101757 <ilock+0xc7>
801016a0:	8b 53 08             	mov    0x8(%ebx),%edx
801016a3:	85 d2                	test   %edx,%edx
801016a5:	0f 8e ac 00 00 00    	jle    80101757 <ilock+0xc7>
  acquiresleep(&ip->lock);
801016ab:	8d 43 0c             	lea    0xc(%ebx),%eax
801016ae:	83 ec 0c             	sub    $0xc,%esp
801016b1:	50                   	push   %eax
801016b2:	e8 09 2c 00 00       	call   801042c0 <acquiresleep>
  if(ip->valid == 0){
801016b7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801016ba:	83 c4 10             	add    $0x10,%esp
801016bd:	85 c0                	test   %eax,%eax
801016bf:	74 0f                	je     801016d0 <ilock+0x40>
}
801016c1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016c4:	5b                   	pop    %ebx
801016c5:	5e                   	pop    %esi
801016c6:	5d                   	pop    %ebp
801016c7:	c3                   	ret    
801016c8:	90                   	nop
801016c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016d0:	8b 43 04             	mov    0x4(%ebx),%eax
801016d3:	83 ec 08             	sub    $0x8,%esp
801016d6:	c1 e8 03             	shr    $0x3,%eax
801016d9:	03 05 94 13 11 80    	add    0x80111394,%eax
801016df:	50                   	push   %eax
801016e0:	ff 33                	pushl  (%ebx)
801016e2:	e8 e9 e9 ff ff       	call   801000d0 <bread>
801016e7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016e9:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016ec:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016ef:	83 e0 07             	and    $0x7,%eax
801016f2:	c1 e0 06             	shl    $0x6,%eax
801016f5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801016f9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016fc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801016ff:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101703:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101707:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010170b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010170f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101713:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101717:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010171b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010171e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101721:	6a 34                	push   $0x34
80101723:	50                   	push   %eax
80101724:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101727:	50                   	push   %eax
80101728:	e8 83 2f 00 00       	call   801046b0 <memmove>
    brelse(bp);
8010172d:	89 34 24             	mov    %esi,(%esp)
80101730:	e8 ab ea ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101735:	83 c4 10             	add    $0x10,%esp
80101738:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010173d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101744:	0f 85 77 ff ff ff    	jne    801016c1 <ilock+0x31>
      panic("ilock: no type");
8010174a:	83 ec 0c             	sub    $0xc,%esp
8010174d:	68 b0 73 10 80       	push   $0x801073b0
80101752:	e8 39 ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101757:	83 ec 0c             	sub    $0xc,%esp
8010175a:	68 aa 73 10 80       	push   $0x801073aa
8010175f:	e8 2c ec ff ff       	call   80100390 <panic>
80101764:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010176a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101770 <iunlock>:
{
80101770:	55                   	push   %ebp
80101771:	89 e5                	mov    %esp,%ebp
80101773:	56                   	push   %esi
80101774:	53                   	push   %ebx
80101775:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101778:	85 db                	test   %ebx,%ebx
8010177a:	74 28                	je     801017a4 <iunlock+0x34>
8010177c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010177f:	83 ec 0c             	sub    $0xc,%esp
80101782:	56                   	push   %esi
80101783:	e8 d8 2b 00 00       	call   80104360 <holdingsleep>
80101788:	83 c4 10             	add    $0x10,%esp
8010178b:	85 c0                	test   %eax,%eax
8010178d:	74 15                	je     801017a4 <iunlock+0x34>
8010178f:	8b 43 08             	mov    0x8(%ebx),%eax
80101792:	85 c0                	test   %eax,%eax
80101794:	7e 0e                	jle    801017a4 <iunlock+0x34>
  releasesleep(&ip->lock);
80101796:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101799:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010179c:	5b                   	pop    %ebx
8010179d:	5e                   	pop    %esi
8010179e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010179f:	e9 7c 2b 00 00       	jmp    80104320 <releasesleep>
    panic("iunlock");
801017a4:	83 ec 0c             	sub    $0xc,%esp
801017a7:	68 bf 73 10 80       	push   $0x801073bf
801017ac:	e8 df eb ff ff       	call   80100390 <panic>
801017b1:	eb 0d                	jmp    801017c0 <iput>
801017b3:	90                   	nop
801017b4:	90                   	nop
801017b5:	90                   	nop
801017b6:	90                   	nop
801017b7:	90                   	nop
801017b8:	90                   	nop
801017b9:	90                   	nop
801017ba:	90                   	nop
801017bb:	90                   	nop
801017bc:	90                   	nop
801017bd:	90                   	nop
801017be:	90                   	nop
801017bf:	90                   	nop

801017c0 <iput>:
{
801017c0:	55                   	push   %ebp
801017c1:	89 e5                	mov    %esp,%ebp
801017c3:	57                   	push   %edi
801017c4:	56                   	push   %esi
801017c5:	53                   	push   %ebx
801017c6:	83 ec 28             	sub    $0x28,%esp
801017c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801017cc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801017cf:	57                   	push   %edi
801017d0:	e8 eb 2a 00 00       	call   801042c0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801017d5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801017d8:	83 c4 10             	add    $0x10,%esp
801017db:	85 d2                	test   %edx,%edx
801017dd:	74 07                	je     801017e6 <iput+0x26>
801017df:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801017e4:	74 32                	je     80101818 <iput+0x58>
  releasesleep(&ip->lock);
801017e6:	83 ec 0c             	sub    $0xc,%esp
801017e9:	57                   	push   %edi
801017ea:	e8 31 2b 00 00       	call   80104320 <releasesleep>
  acquire(&icache.lock);
801017ef:	c7 04 24 a0 13 11 80 	movl   $0x801113a0,(%esp)
801017f6:	e8 f5 2c 00 00       	call   801044f0 <acquire>
  ip->ref--;
801017fb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801017ff:	83 c4 10             	add    $0x10,%esp
80101802:	c7 45 08 a0 13 11 80 	movl   $0x801113a0,0x8(%ebp)
}
80101809:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010180c:	5b                   	pop    %ebx
8010180d:	5e                   	pop    %esi
8010180e:	5f                   	pop    %edi
8010180f:	5d                   	pop    %ebp
  release(&icache.lock);
80101810:	e9 9b 2d 00 00       	jmp    801045b0 <release>
80101815:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101818:	83 ec 0c             	sub    $0xc,%esp
8010181b:	68 a0 13 11 80       	push   $0x801113a0
80101820:	e8 cb 2c 00 00       	call   801044f0 <acquire>
    int r = ip->ref;
80101825:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101828:	c7 04 24 a0 13 11 80 	movl   $0x801113a0,(%esp)
8010182f:	e8 7c 2d 00 00       	call   801045b0 <release>
    if(r == 1){
80101834:	83 c4 10             	add    $0x10,%esp
80101837:	83 fe 01             	cmp    $0x1,%esi
8010183a:	75 aa                	jne    801017e6 <iput+0x26>
8010183c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101842:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101845:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101848:	89 cf                	mov    %ecx,%edi
8010184a:	eb 0b                	jmp    80101857 <iput+0x97>
8010184c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101850:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101853:	39 fe                	cmp    %edi,%esi
80101855:	74 19                	je     80101870 <iput+0xb0>
    if(ip->addrs[i]){
80101857:	8b 16                	mov    (%esi),%edx
80101859:	85 d2                	test   %edx,%edx
8010185b:	74 f3                	je     80101850 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010185d:	8b 03                	mov    (%ebx),%eax
8010185f:	e8 ac fb ff ff       	call   80101410 <bfree>
      ip->addrs[i] = 0;
80101864:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010186a:	eb e4                	jmp    80101850 <iput+0x90>
8010186c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101870:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101876:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101879:	85 c0                	test   %eax,%eax
8010187b:	75 33                	jne    801018b0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010187d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101880:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101887:	53                   	push   %ebx
80101888:	e8 53 fd ff ff       	call   801015e0 <iupdate>
      ip->type = 0;
8010188d:	31 c0                	xor    %eax,%eax
8010188f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101893:	89 1c 24             	mov    %ebx,(%esp)
80101896:	e8 45 fd ff ff       	call   801015e0 <iupdate>
      ip->valid = 0;
8010189b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801018a2:	83 c4 10             	add    $0x10,%esp
801018a5:	e9 3c ff ff ff       	jmp    801017e6 <iput+0x26>
801018aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018b0:	83 ec 08             	sub    $0x8,%esp
801018b3:	50                   	push   %eax
801018b4:	ff 33                	pushl  (%ebx)
801018b6:	e8 15 e8 ff ff       	call   801000d0 <bread>
801018bb:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801018c1:	89 7d e0             	mov    %edi,-0x20(%ebp)
801018c4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801018c7:	8d 70 5c             	lea    0x5c(%eax),%esi
801018ca:	83 c4 10             	add    $0x10,%esp
801018cd:	89 cf                	mov    %ecx,%edi
801018cf:	eb 0e                	jmp    801018df <iput+0x11f>
801018d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018d8:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
801018db:	39 fe                	cmp    %edi,%esi
801018dd:	74 0f                	je     801018ee <iput+0x12e>
      if(a[j])
801018df:	8b 16                	mov    (%esi),%edx
801018e1:	85 d2                	test   %edx,%edx
801018e3:	74 f3                	je     801018d8 <iput+0x118>
        bfree(ip->dev, a[j]);
801018e5:	8b 03                	mov    (%ebx),%eax
801018e7:	e8 24 fb ff ff       	call   80101410 <bfree>
801018ec:	eb ea                	jmp    801018d8 <iput+0x118>
    brelse(bp);
801018ee:	83 ec 0c             	sub    $0xc,%esp
801018f1:	ff 75 e4             	pushl  -0x1c(%ebp)
801018f4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801018f7:	e8 e4 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018fc:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101902:	8b 03                	mov    (%ebx),%eax
80101904:	e8 07 fb ff ff       	call   80101410 <bfree>
    ip->addrs[NDIRECT] = 0;
80101909:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101910:	00 00 00 
80101913:	83 c4 10             	add    $0x10,%esp
80101916:	e9 62 ff ff ff       	jmp    8010187d <iput+0xbd>
8010191b:	90                   	nop
8010191c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101920 <iunlockput>:
{
80101920:	55                   	push   %ebp
80101921:	89 e5                	mov    %esp,%ebp
80101923:	53                   	push   %ebx
80101924:	83 ec 10             	sub    $0x10,%esp
80101927:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010192a:	53                   	push   %ebx
8010192b:	e8 40 fe ff ff       	call   80101770 <iunlock>
  iput(ip);
80101930:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101933:	83 c4 10             	add    $0x10,%esp
}
80101936:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101939:	c9                   	leave  
  iput(ip);
8010193a:	e9 81 fe ff ff       	jmp    801017c0 <iput>
8010193f:	90                   	nop

80101940 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101940:	55                   	push   %ebp
80101941:	89 e5                	mov    %esp,%ebp
80101943:	8b 55 08             	mov    0x8(%ebp),%edx
80101946:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101949:	8b 0a                	mov    (%edx),%ecx
8010194b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010194e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101951:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101954:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101958:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010195b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010195f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101963:	8b 52 58             	mov    0x58(%edx),%edx
80101966:	89 50 10             	mov    %edx,0x10(%eax)
}
80101969:	5d                   	pop    %ebp
8010196a:	c3                   	ret    
8010196b:	90                   	nop
8010196c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101970 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101970:	55                   	push   %ebp
80101971:	89 e5                	mov    %esp,%ebp
80101973:	57                   	push   %edi
80101974:	56                   	push   %esi
80101975:	53                   	push   %ebx
80101976:	83 ec 1c             	sub    $0x1c,%esp
80101979:	8b 45 08             	mov    0x8(%ebp),%eax
8010197c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010197f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101982:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101987:	89 75 e0             	mov    %esi,-0x20(%ebp)
8010198a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010198d:	8b 75 10             	mov    0x10(%ebp),%esi
80101990:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101993:	0f 84 a7 00 00 00    	je     80101a40 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101999:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010199c:	8b 40 58             	mov    0x58(%eax),%eax
8010199f:	39 c6                	cmp    %eax,%esi
801019a1:	0f 87 ba 00 00 00    	ja     80101a61 <readi+0xf1>
801019a7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019aa:	89 f9                	mov    %edi,%ecx
801019ac:	01 f1                	add    %esi,%ecx
801019ae:	0f 82 ad 00 00 00    	jb     80101a61 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019b4:	89 c2                	mov    %eax,%edx
801019b6:	29 f2                	sub    %esi,%edx
801019b8:	39 c8                	cmp    %ecx,%eax
801019ba:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019bd:	31 ff                	xor    %edi,%edi
801019bf:	85 d2                	test   %edx,%edx
    n = ip->size - off;
801019c1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019c4:	74 6c                	je     80101a32 <readi+0xc2>
801019c6:	8d 76 00             	lea    0x0(%esi),%esi
801019c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019d0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019d3:	89 f2                	mov    %esi,%edx
801019d5:	c1 ea 09             	shr    $0x9,%edx
801019d8:	89 d8                	mov    %ebx,%eax
801019da:	e8 11 f9 ff ff       	call   801012f0 <bmap>
801019df:	83 ec 08             	sub    $0x8,%esp
801019e2:	50                   	push   %eax
801019e3:	ff 33                	pushl  (%ebx)
801019e5:	e8 e6 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801019ea:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019ed:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019ef:	89 f0                	mov    %esi,%eax
801019f1:	25 ff 01 00 00       	and    $0x1ff,%eax
801019f6:	b9 00 02 00 00       	mov    $0x200,%ecx
801019fb:	83 c4 0c             	add    $0xc,%esp
801019fe:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101a00:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101a04:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101a07:	29 fb                	sub    %edi,%ebx
80101a09:	39 d9                	cmp    %ebx,%ecx
80101a0b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a0e:	53                   	push   %ebx
80101a0f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a10:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101a12:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a15:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a17:	e8 94 2c 00 00       	call   801046b0 <memmove>
    brelse(bp);
80101a1c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a1f:	89 14 24             	mov    %edx,(%esp)
80101a22:	e8 b9 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a27:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a2a:	83 c4 10             	add    $0x10,%esp
80101a2d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a30:	77 9e                	ja     801019d0 <readi+0x60>
  }
  return n;
80101a32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a35:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a38:	5b                   	pop    %ebx
80101a39:	5e                   	pop    %esi
80101a3a:	5f                   	pop    %edi
80101a3b:	5d                   	pop    %ebp
80101a3c:	c3                   	ret    
80101a3d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a40:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a44:	66 83 f8 09          	cmp    $0x9,%ax
80101a48:	77 17                	ja     80101a61 <readi+0xf1>
80101a4a:	8b 04 c5 20 13 11 80 	mov    -0x7feeece0(,%eax,8),%eax
80101a51:	85 c0                	test   %eax,%eax
80101a53:	74 0c                	je     80101a61 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101a55:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101a58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a5b:	5b                   	pop    %ebx
80101a5c:	5e                   	pop    %esi
80101a5d:	5f                   	pop    %edi
80101a5e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101a5f:	ff e0                	jmp    *%eax
      return -1;
80101a61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a66:	eb cd                	jmp    80101a35 <readi+0xc5>
80101a68:	90                   	nop
80101a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101a70 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a70:	55                   	push   %ebp
80101a71:	89 e5                	mov    %esp,%ebp
80101a73:	57                   	push   %edi
80101a74:	56                   	push   %esi
80101a75:	53                   	push   %ebx
80101a76:	83 ec 1c             	sub    $0x1c,%esp
80101a79:	8b 45 08             	mov    0x8(%ebp),%eax
80101a7c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a7f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a82:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a87:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a8a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a8d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a90:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101a93:	0f 84 b7 00 00 00    	je     80101b50 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a99:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a9c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a9f:	0f 82 eb 00 00 00    	jb     80101b90 <writei+0x120>
80101aa5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101aa8:	31 d2                	xor    %edx,%edx
80101aaa:	89 f8                	mov    %edi,%eax
80101aac:	01 f0                	add    %esi,%eax
80101aae:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101ab1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101ab6:	0f 87 d4 00 00 00    	ja     80101b90 <writei+0x120>
80101abc:	85 d2                	test   %edx,%edx
80101abe:	0f 85 cc 00 00 00    	jne    80101b90 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ac4:	85 ff                	test   %edi,%edi
80101ac6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101acd:	74 72                	je     80101b41 <writei+0xd1>
80101acf:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ad0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101ad3:	89 f2                	mov    %esi,%edx
80101ad5:	c1 ea 09             	shr    $0x9,%edx
80101ad8:	89 f8                	mov    %edi,%eax
80101ada:	e8 11 f8 ff ff       	call   801012f0 <bmap>
80101adf:	83 ec 08             	sub    $0x8,%esp
80101ae2:	50                   	push   %eax
80101ae3:	ff 37                	pushl  (%edi)
80101ae5:	e8 e6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101aea:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101aed:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101af0:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101af2:	89 f0                	mov    %esi,%eax
80101af4:	b9 00 02 00 00       	mov    $0x200,%ecx
80101af9:	83 c4 0c             	add    $0xc,%esp
80101afc:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b01:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101b03:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b07:	39 d9                	cmp    %ebx,%ecx
80101b09:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b0c:	53                   	push   %ebx
80101b0d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b10:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101b12:	50                   	push   %eax
80101b13:	e8 98 2b 00 00       	call   801046b0 <memmove>
    log_write(bp);
80101b18:	89 3c 24             	mov    %edi,(%esp)
80101b1b:	e8 60 12 00 00       	call   80102d80 <log_write>
    brelse(bp);
80101b20:	89 3c 24             	mov    %edi,(%esp)
80101b23:	e8 b8 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b28:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b2b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b2e:	83 c4 10             	add    $0x10,%esp
80101b31:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b34:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101b37:	77 97                	ja     80101ad0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101b39:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b3c:	3b 70 58             	cmp    0x58(%eax),%esi
80101b3f:	77 37                	ja     80101b78 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b41:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b44:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b47:	5b                   	pop    %ebx
80101b48:	5e                   	pop    %esi
80101b49:	5f                   	pop    %edi
80101b4a:	5d                   	pop    %ebp
80101b4b:	c3                   	ret    
80101b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b50:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b54:	66 83 f8 09          	cmp    $0x9,%ax
80101b58:	77 36                	ja     80101b90 <writei+0x120>
80101b5a:	8b 04 c5 24 13 11 80 	mov    -0x7feeecdc(,%eax,8),%eax
80101b61:	85 c0                	test   %eax,%eax
80101b63:	74 2b                	je     80101b90 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101b65:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b6b:	5b                   	pop    %ebx
80101b6c:	5e                   	pop    %esi
80101b6d:	5f                   	pop    %edi
80101b6e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101b6f:	ff e0                	jmp    *%eax
80101b71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101b78:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b7b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101b7e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b81:	50                   	push   %eax
80101b82:	e8 59 fa ff ff       	call   801015e0 <iupdate>
80101b87:	83 c4 10             	add    $0x10,%esp
80101b8a:	eb b5                	jmp    80101b41 <writei+0xd1>
80101b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101b90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b95:	eb ad                	jmp    80101b44 <writei+0xd4>
80101b97:	89 f6                	mov    %esi,%esi
80101b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ba0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101ba0:	55                   	push   %ebp
80101ba1:	89 e5                	mov    %esp,%ebp
80101ba3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101ba6:	6a 0e                	push   $0xe
80101ba8:	ff 75 0c             	pushl  0xc(%ebp)
80101bab:	ff 75 08             	pushl  0x8(%ebp)
80101bae:	e8 6d 2b 00 00       	call   80104720 <strncmp>
}
80101bb3:	c9                   	leave  
80101bb4:	c3                   	ret    
80101bb5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bc0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bc0:	55                   	push   %ebp
80101bc1:	89 e5                	mov    %esp,%ebp
80101bc3:	57                   	push   %edi
80101bc4:	56                   	push   %esi
80101bc5:	53                   	push   %ebx
80101bc6:	83 ec 1c             	sub    $0x1c,%esp
80101bc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bcc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101bd1:	0f 85 85 00 00 00    	jne    80101c5c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101bd7:	8b 53 58             	mov    0x58(%ebx),%edx
80101bda:	31 ff                	xor    %edi,%edi
80101bdc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bdf:	85 d2                	test   %edx,%edx
80101be1:	74 3e                	je     80101c21 <dirlookup+0x61>
80101be3:	90                   	nop
80101be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101be8:	6a 10                	push   $0x10
80101bea:	57                   	push   %edi
80101beb:	56                   	push   %esi
80101bec:	53                   	push   %ebx
80101bed:	e8 7e fd ff ff       	call   80101970 <readi>
80101bf2:	83 c4 10             	add    $0x10,%esp
80101bf5:	83 f8 10             	cmp    $0x10,%eax
80101bf8:	75 55                	jne    80101c4f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101bfa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101bff:	74 18                	je     80101c19 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101c01:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c04:	83 ec 04             	sub    $0x4,%esp
80101c07:	6a 0e                	push   $0xe
80101c09:	50                   	push   %eax
80101c0a:	ff 75 0c             	pushl  0xc(%ebp)
80101c0d:	e8 0e 2b 00 00       	call   80104720 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101c12:	83 c4 10             	add    $0x10,%esp
80101c15:	85 c0                	test   %eax,%eax
80101c17:	74 17                	je     80101c30 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101c19:	83 c7 10             	add    $0x10,%edi
80101c1c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101c1f:	72 c7                	jb     80101be8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101c21:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101c24:	31 c0                	xor    %eax,%eax
}
80101c26:	5b                   	pop    %ebx
80101c27:	5e                   	pop    %esi
80101c28:	5f                   	pop    %edi
80101c29:	5d                   	pop    %ebp
80101c2a:	c3                   	ret    
80101c2b:	90                   	nop
80101c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101c30:	8b 45 10             	mov    0x10(%ebp),%eax
80101c33:	85 c0                	test   %eax,%eax
80101c35:	74 05                	je     80101c3c <dirlookup+0x7c>
        *poff = off;
80101c37:	8b 45 10             	mov    0x10(%ebp),%eax
80101c3a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c3c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c40:	8b 03                	mov    (%ebx),%eax
80101c42:	e8 d9 f5 ff ff       	call   80101220 <iget>
}
80101c47:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c4a:	5b                   	pop    %ebx
80101c4b:	5e                   	pop    %esi
80101c4c:	5f                   	pop    %edi
80101c4d:	5d                   	pop    %ebp
80101c4e:	c3                   	ret    
      panic("dirlookup read");
80101c4f:	83 ec 0c             	sub    $0xc,%esp
80101c52:	68 d9 73 10 80       	push   $0x801073d9
80101c57:	e8 34 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101c5c:	83 ec 0c             	sub    $0xc,%esp
80101c5f:	68 c7 73 10 80       	push   $0x801073c7
80101c64:	e8 27 e7 ff ff       	call   80100390 <panic>
80101c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101c70 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c70:	55                   	push   %ebp
80101c71:	89 e5                	mov    %esp,%ebp
80101c73:	57                   	push   %edi
80101c74:	56                   	push   %esi
80101c75:	53                   	push   %ebx
80101c76:	89 cf                	mov    %ecx,%edi
80101c78:	89 c3                	mov    %eax,%ebx
80101c7a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c7d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101c80:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101c83:	0f 84 67 01 00 00    	je     80101df0 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c89:	e8 22 1b 00 00       	call   801037b0 <myproc>
  acquire(&icache.lock);
80101c8e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101c91:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101c94:	68 a0 13 11 80       	push   $0x801113a0
80101c99:	e8 52 28 00 00       	call   801044f0 <acquire>
  ip->ref++;
80101c9e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101ca2:	c7 04 24 a0 13 11 80 	movl   $0x801113a0,(%esp)
80101ca9:	e8 02 29 00 00       	call   801045b0 <release>
80101cae:	83 c4 10             	add    $0x10,%esp
80101cb1:	eb 08                	jmp    80101cbb <namex+0x4b>
80101cb3:	90                   	nop
80101cb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101cb8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101cbb:	0f b6 03             	movzbl (%ebx),%eax
80101cbe:	3c 2f                	cmp    $0x2f,%al
80101cc0:	74 f6                	je     80101cb8 <namex+0x48>
  if(*path == 0)
80101cc2:	84 c0                	test   %al,%al
80101cc4:	0f 84 ee 00 00 00    	je     80101db8 <namex+0x148>
  while(*path != '/' && *path != 0)
80101cca:	0f b6 03             	movzbl (%ebx),%eax
80101ccd:	3c 2f                	cmp    $0x2f,%al
80101ccf:	0f 84 b3 00 00 00    	je     80101d88 <namex+0x118>
80101cd5:	84 c0                	test   %al,%al
80101cd7:	89 da                	mov    %ebx,%edx
80101cd9:	75 09                	jne    80101ce4 <namex+0x74>
80101cdb:	e9 a8 00 00 00       	jmp    80101d88 <namex+0x118>
80101ce0:	84 c0                	test   %al,%al
80101ce2:	74 0a                	je     80101cee <namex+0x7e>
    path++;
80101ce4:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101ce7:	0f b6 02             	movzbl (%edx),%eax
80101cea:	3c 2f                	cmp    $0x2f,%al
80101cec:	75 f2                	jne    80101ce0 <namex+0x70>
80101cee:	89 d1                	mov    %edx,%ecx
80101cf0:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101cf2:	83 f9 0d             	cmp    $0xd,%ecx
80101cf5:	0f 8e 91 00 00 00    	jle    80101d8c <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101cfb:	83 ec 04             	sub    $0x4,%esp
80101cfe:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d01:	6a 0e                	push   $0xe
80101d03:	53                   	push   %ebx
80101d04:	57                   	push   %edi
80101d05:	e8 a6 29 00 00       	call   801046b0 <memmove>
    path++;
80101d0a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101d0d:	83 c4 10             	add    $0x10,%esp
    path++;
80101d10:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101d12:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d15:	75 11                	jne    80101d28 <namex+0xb8>
80101d17:	89 f6                	mov    %esi,%esi
80101d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d20:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d23:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d26:	74 f8                	je     80101d20 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d28:	83 ec 0c             	sub    $0xc,%esp
80101d2b:	56                   	push   %esi
80101d2c:	e8 5f f9 ff ff       	call   80101690 <ilock>
    if(ip->type != T_DIR){
80101d31:	83 c4 10             	add    $0x10,%esp
80101d34:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d39:	0f 85 91 00 00 00    	jne    80101dd0 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d3f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d42:	85 d2                	test   %edx,%edx
80101d44:	74 09                	je     80101d4f <namex+0xdf>
80101d46:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d49:	0f 84 b7 00 00 00    	je     80101e06 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d4f:	83 ec 04             	sub    $0x4,%esp
80101d52:	6a 00                	push   $0x0
80101d54:	57                   	push   %edi
80101d55:	56                   	push   %esi
80101d56:	e8 65 fe ff ff       	call   80101bc0 <dirlookup>
80101d5b:	83 c4 10             	add    $0x10,%esp
80101d5e:	85 c0                	test   %eax,%eax
80101d60:	74 6e                	je     80101dd0 <namex+0x160>
  iunlock(ip);
80101d62:	83 ec 0c             	sub    $0xc,%esp
80101d65:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d68:	56                   	push   %esi
80101d69:	e8 02 fa ff ff       	call   80101770 <iunlock>
  iput(ip);
80101d6e:	89 34 24             	mov    %esi,(%esp)
80101d71:	e8 4a fa ff ff       	call   801017c0 <iput>
80101d76:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d79:	83 c4 10             	add    $0x10,%esp
80101d7c:	89 c6                	mov    %eax,%esi
80101d7e:	e9 38 ff ff ff       	jmp    80101cbb <namex+0x4b>
80101d83:	90                   	nop
80101d84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101d88:	89 da                	mov    %ebx,%edx
80101d8a:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101d8c:	83 ec 04             	sub    $0x4,%esp
80101d8f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101d92:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101d95:	51                   	push   %ecx
80101d96:	53                   	push   %ebx
80101d97:	57                   	push   %edi
80101d98:	e8 13 29 00 00       	call   801046b0 <memmove>
    name[len] = 0;
80101d9d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101da0:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101da3:	83 c4 10             	add    $0x10,%esp
80101da6:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101daa:	89 d3                	mov    %edx,%ebx
80101dac:	e9 61 ff ff ff       	jmp    80101d12 <namex+0xa2>
80101db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101db8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101dbb:	85 c0                	test   %eax,%eax
80101dbd:	75 5d                	jne    80101e1c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101dbf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dc2:	89 f0                	mov    %esi,%eax
80101dc4:	5b                   	pop    %ebx
80101dc5:	5e                   	pop    %esi
80101dc6:	5f                   	pop    %edi
80101dc7:	5d                   	pop    %ebp
80101dc8:	c3                   	ret    
80101dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101dd0:	83 ec 0c             	sub    $0xc,%esp
80101dd3:	56                   	push   %esi
80101dd4:	e8 97 f9 ff ff       	call   80101770 <iunlock>
  iput(ip);
80101dd9:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101ddc:	31 f6                	xor    %esi,%esi
  iput(ip);
80101dde:	e8 dd f9 ff ff       	call   801017c0 <iput>
      return 0;
80101de3:	83 c4 10             	add    $0x10,%esp
}
80101de6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101de9:	89 f0                	mov    %esi,%eax
80101deb:	5b                   	pop    %ebx
80101dec:	5e                   	pop    %esi
80101ded:	5f                   	pop    %edi
80101dee:	5d                   	pop    %ebp
80101def:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101df0:	ba 01 00 00 00       	mov    $0x1,%edx
80101df5:	b8 01 00 00 00       	mov    $0x1,%eax
80101dfa:	e8 21 f4 ff ff       	call   80101220 <iget>
80101dff:	89 c6                	mov    %eax,%esi
80101e01:	e9 b5 fe ff ff       	jmp    80101cbb <namex+0x4b>
      iunlock(ip);
80101e06:	83 ec 0c             	sub    $0xc,%esp
80101e09:	56                   	push   %esi
80101e0a:	e8 61 f9 ff ff       	call   80101770 <iunlock>
      return ip;
80101e0f:	83 c4 10             	add    $0x10,%esp
}
80101e12:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e15:	89 f0                	mov    %esi,%eax
80101e17:	5b                   	pop    %ebx
80101e18:	5e                   	pop    %esi
80101e19:	5f                   	pop    %edi
80101e1a:	5d                   	pop    %ebp
80101e1b:	c3                   	ret    
    iput(ip);
80101e1c:	83 ec 0c             	sub    $0xc,%esp
80101e1f:	56                   	push   %esi
    return 0;
80101e20:	31 f6                	xor    %esi,%esi
    iput(ip);
80101e22:	e8 99 f9 ff ff       	call   801017c0 <iput>
    return 0;
80101e27:	83 c4 10             	add    $0x10,%esp
80101e2a:	eb 93                	jmp    80101dbf <namex+0x14f>
80101e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e30 <dirlink>:
{
80101e30:	55                   	push   %ebp
80101e31:	89 e5                	mov    %esp,%ebp
80101e33:	57                   	push   %edi
80101e34:	56                   	push   %esi
80101e35:	53                   	push   %ebx
80101e36:	83 ec 20             	sub    $0x20,%esp
80101e39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e3c:	6a 00                	push   $0x0
80101e3e:	ff 75 0c             	pushl  0xc(%ebp)
80101e41:	53                   	push   %ebx
80101e42:	e8 79 fd ff ff       	call   80101bc0 <dirlookup>
80101e47:	83 c4 10             	add    $0x10,%esp
80101e4a:	85 c0                	test   %eax,%eax
80101e4c:	75 67                	jne    80101eb5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e4e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e51:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e54:	85 ff                	test   %edi,%edi
80101e56:	74 29                	je     80101e81 <dirlink+0x51>
80101e58:	31 ff                	xor    %edi,%edi
80101e5a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e5d:	eb 09                	jmp    80101e68 <dirlink+0x38>
80101e5f:	90                   	nop
80101e60:	83 c7 10             	add    $0x10,%edi
80101e63:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e66:	73 19                	jae    80101e81 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e68:	6a 10                	push   $0x10
80101e6a:	57                   	push   %edi
80101e6b:	56                   	push   %esi
80101e6c:	53                   	push   %ebx
80101e6d:	e8 fe fa ff ff       	call   80101970 <readi>
80101e72:	83 c4 10             	add    $0x10,%esp
80101e75:	83 f8 10             	cmp    $0x10,%eax
80101e78:	75 4e                	jne    80101ec8 <dirlink+0x98>
    if(de.inum == 0)
80101e7a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e7f:	75 df                	jne    80101e60 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101e81:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e84:	83 ec 04             	sub    $0x4,%esp
80101e87:	6a 0e                	push   $0xe
80101e89:	ff 75 0c             	pushl  0xc(%ebp)
80101e8c:	50                   	push   %eax
80101e8d:	e8 ee 28 00 00       	call   80104780 <strncpy>
  de.inum = inum;
80101e92:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e95:	6a 10                	push   $0x10
80101e97:	57                   	push   %edi
80101e98:	56                   	push   %esi
80101e99:	53                   	push   %ebx
  de.inum = inum;
80101e9a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e9e:	e8 cd fb ff ff       	call   80101a70 <writei>
80101ea3:	83 c4 20             	add    $0x20,%esp
80101ea6:	83 f8 10             	cmp    $0x10,%eax
80101ea9:	75 2a                	jne    80101ed5 <dirlink+0xa5>
  return 0;
80101eab:	31 c0                	xor    %eax,%eax
}
80101ead:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101eb0:	5b                   	pop    %ebx
80101eb1:	5e                   	pop    %esi
80101eb2:	5f                   	pop    %edi
80101eb3:	5d                   	pop    %ebp
80101eb4:	c3                   	ret    
    iput(ip);
80101eb5:	83 ec 0c             	sub    $0xc,%esp
80101eb8:	50                   	push   %eax
80101eb9:	e8 02 f9 ff ff       	call   801017c0 <iput>
    return -1;
80101ebe:	83 c4 10             	add    $0x10,%esp
80101ec1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ec6:	eb e5                	jmp    80101ead <dirlink+0x7d>
      panic("dirlink read");
80101ec8:	83 ec 0c             	sub    $0xc,%esp
80101ecb:	68 e8 73 10 80       	push   $0x801073e8
80101ed0:	e8 bb e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101ed5:	83 ec 0c             	sub    $0xc,%esp
80101ed8:	68 42 7a 10 80       	push   $0x80107a42
80101edd:	e8 ae e4 ff ff       	call   80100390 <panic>
80101ee2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ef0 <namei>:

struct inode*
namei(char *path)
{
80101ef0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ef1:	31 d2                	xor    %edx,%edx
{
80101ef3:	89 e5                	mov    %esp,%ebp
80101ef5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101ef8:	8b 45 08             	mov    0x8(%ebp),%eax
80101efb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101efe:	e8 6d fd ff ff       	call   80101c70 <namex>
}
80101f03:	c9                   	leave  
80101f04:	c3                   	ret    
80101f05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f10 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f10:	55                   	push   %ebp
  return namex(path, 1, name);
80101f11:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101f16:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f18:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f1b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f1e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101f1f:	e9 4c fd ff ff       	jmp    80101c70 <namex>
80101f24:	66 90                	xchg   %ax,%ax
80101f26:	66 90                	xchg   %ax,%ax
80101f28:	66 90                	xchg   %ax,%ax
80101f2a:	66 90                	xchg   %ax,%ax
80101f2c:	66 90                	xchg   %ax,%ax
80101f2e:	66 90                	xchg   %ax,%ax

80101f30 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f30:	55                   	push   %ebp
80101f31:	89 e5                	mov    %esp,%ebp
80101f33:	57                   	push   %edi
80101f34:	56                   	push   %esi
80101f35:	53                   	push   %ebx
80101f36:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80101f39:	85 c0                	test   %eax,%eax
80101f3b:	0f 84 b4 00 00 00    	je     80101ff5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f41:	8b 58 08             	mov    0x8(%eax),%ebx
80101f44:	89 c6                	mov    %eax,%esi
80101f46:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f4c:	0f 87 96 00 00 00    	ja     80101fe8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f52:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80101f57:	89 f6                	mov    %esi,%esi
80101f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101f60:	89 ca                	mov    %ecx,%edx
80101f62:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f63:	83 e0 c0             	and    $0xffffffc0,%eax
80101f66:	3c 40                	cmp    $0x40,%al
80101f68:	75 f6                	jne    80101f60 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f6a:	31 ff                	xor    %edi,%edi
80101f6c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f71:	89 f8                	mov    %edi,%eax
80101f73:	ee                   	out    %al,(%dx)
80101f74:	b8 01 00 00 00       	mov    $0x1,%eax
80101f79:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f7e:	ee                   	out    %al,(%dx)
80101f7f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f84:	89 d8                	mov    %ebx,%eax
80101f86:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101f87:	89 d8                	mov    %ebx,%eax
80101f89:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f8e:	c1 f8 08             	sar    $0x8,%eax
80101f91:	ee                   	out    %al,(%dx)
80101f92:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101f97:	89 f8                	mov    %edi,%eax
80101f99:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101f9a:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80101f9e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101fa3:	c1 e0 04             	shl    $0x4,%eax
80101fa6:	83 e0 10             	and    $0x10,%eax
80101fa9:	83 c8 e0             	or     $0xffffffe0,%eax
80101fac:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101fad:	f6 06 04             	testb  $0x4,(%esi)
80101fb0:	75 16                	jne    80101fc8 <idestart+0x98>
80101fb2:	b8 20 00 00 00       	mov    $0x20,%eax
80101fb7:	89 ca                	mov    %ecx,%edx
80101fb9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fbd:	5b                   	pop    %ebx
80101fbe:	5e                   	pop    %esi
80101fbf:	5f                   	pop    %edi
80101fc0:	5d                   	pop    %ebp
80101fc1:	c3                   	ret    
80101fc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101fc8:	b8 30 00 00 00       	mov    $0x30,%eax
80101fcd:	89 ca                	mov    %ecx,%edx
80101fcf:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80101fd0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80101fd5:	83 c6 5c             	add    $0x5c,%esi
80101fd8:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101fdd:	fc                   	cld    
80101fde:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80101fe0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fe3:	5b                   	pop    %ebx
80101fe4:	5e                   	pop    %esi
80101fe5:	5f                   	pop    %edi
80101fe6:	5d                   	pop    %ebp
80101fe7:	c3                   	ret    
    panic("incorrect blockno");
80101fe8:	83 ec 0c             	sub    $0xc,%esp
80101feb:	68 54 74 10 80       	push   $0x80107454
80101ff0:	e8 9b e3 ff ff       	call   80100390 <panic>
    panic("idestart");
80101ff5:	83 ec 0c             	sub    $0xc,%esp
80101ff8:	68 4b 74 10 80       	push   $0x8010744b
80101ffd:	e8 8e e3 ff ff       	call   80100390 <panic>
80102002:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102010 <ideinit>:
{
80102010:	55                   	push   %ebp
80102011:	89 e5                	mov    %esp,%ebp
80102013:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102016:	68 66 74 10 80       	push   $0x80107466
8010201b:	68 80 a5 10 80       	push   $0x8010a580
80102020:	e8 8b 23 00 00       	call   801043b0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102025:	58                   	pop    %eax
80102026:	a1 f0 31 11 80       	mov    0x801131f0,%eax
8010202b:	5a                   	pop    %edx
8010202c:	83 e8 01             	sub    $0x1,%eax
8010202f:	50                   	push   %eax
80102030:	6a 0e                	push   $0xe
80102032:	e8 a9 02 00 00       	call   801022e0 <ioapicenable>
80102037:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010203a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010203f:	90                   	nop
80102040:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102041:	83 e0 c0             	and    $0xffffffc0,%eax
80102044:	3c 40                	cmp    $0x40,%al
80102046:	75 f8                	jne    80102040 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102048:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010204d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102052:	ee                   	out    %al,(%dx)
80102053:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102058:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010205d:	eb 06                	jmp    80102065 <ideinit+0x55>
8010205f:	90                   	nop
  for(i=0; i<1000; i++){
80102060:	83 e9 01             	sub    $0x1,%ecx
80102063:	74 0f                	je     80102074 <ideinit+0x64>
80102065:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102066:	84 c0                	test   %al,%al
80102068:	74 f6                	je     80102060 <ideinit+0x50>
      havedisk1 = 1;
8010206a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102071:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102074:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102079:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010207e:	ee                   	out    %al,(%dx)
}
8010207f:	c9                   	leave  
80102080:	c3                   	ret    
80102081:	eb 0d                	jmp    80102090 <ideintr>
80102083:	90                   	nop
80102084:	90                   	nop
80102085:	90                   	nop
80102086:	90                   	nop
80102087:	90                   	nop
80102088:	90                   	nop
80102089:	90                   	nop
8010208a:	90                   	nop
8010208b:	90                   	nop
8010208c:	90                   	nop
8010208d:	90                   	nop
8010208e:	90                   	nop
8010208f:	90                   	nop

80102090 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102090:	55                   	push   %ebp
80102091:	89 e5                	mov    %esp,%ebp
80102093:	57                   	push   %edi
80102094:	56                   	push   %esi
80102095:	53                   	push   %ebx
80102096:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102099:	68 80 a5 10 80       	push   $0x8010a580
8010209e:	e8 4d 24 00 00       	call   801044f0 <acquire>

  if((b = idequeue) == 0){
801020a3:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
801020a9:	83 c4 10             	add    $0x10,%esp
801020ac:	85 db                	test   %ebx,%ebx
801020ae:	74 67                	je     80102117 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801020b0:	8b 43 58             	mov    0x58(%ebx),%eax
801020b3:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020b8:	8b 3b                	mov    (%ebx),%edi
801020ba:	f7 c7 04 00 00 00    	test   $0x4,%edi
801020c0:	75 31                	jne    801020f3 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020c2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020c7:	89 f6                	mov    %esi,%esi
801020c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801020d0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020d1:	89 c6                	mov    %eax,%esi
801020d3:	83 e6 c0             	and    $0xffffffc0,%esi
801020d6:	89 f1                	mov    %esi,%ecx
801020d8:	80 f9 40             	cmp    $0x40,%cl
801020db:	75 f3                	jne    801020d0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020dd:	a8 21                	test   $0x21,%al
801020df:	75 12                	jne    801020f3 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
801020e1:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801020e4:	b9 80 00 00 00       	mov    $0x80,%ecx
801020e9:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020ee:	fc                   	cld    
801020ef:	f3 6d                	rep insl (%dx),%es:(%edi)
801020f1:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020f3:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
801020f6:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801020f9:	89 f9                	mov    %edi,%ecx
801020fb:	83 c9 02             	or     $0x2,%ecx
801020fe:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102100:	53                   	push   %ebx
80102101:	e8 9a 1f 00 00       	call   801040a0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102106:	a1 64 a5 10 80       	mov    0x8010a564,%eax
8010210b:	83 c4 10             	add    $0x10,%esp
8010210e:	85 c0                	test   %eax,%eax
80102110:	74 05                	je     80102117 <ideintr+0x87>
    idestart(idequeue);
80102112:	e8 19 fe ff ff       	call   80101f30 <idestart>
    release(&idelock);
80102117:	83 ec 0c             	sub    $0xc,%esp
8010211a:	68 80 a5 10 80       	push   $0x8010a580
8010211f:	e8 8c 24 00 00       	call   801045b0 <release>

  release(&idelock);
}
80102124:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102127:	5b                   	pop    %ebx
80102128:	5e                   	pop    %esi
80102129:	5f                   	pop    %edi
8010212a:	5d                   	pop    %ebp
8010212b:	c3                   	ret    
8010212c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102130 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102130:	55                   	push   %ebp
80102131:	89 e5                	mov    %esp,%ebp
80102133:	53                   	push   %ebx
80102134:	83 ec 10             	sub    $0x10,%esp
80102137:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010213a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010213d:	50                   	push   %eax
8010213e:	e8 1d 22 00 00       	call   80104360 <holdingsleep>
80102143:	83 c4 10             	add    $0x10,%esp
80102146:	85 c0                	test   %eax,%eax
80102148:	0f 84 c6 00 00 00    	je     80102214 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010214e:	8b 03                	mov    (%ebx),%eax
80102150:	83 e0 06             	and    $0x6,%eax
80102153:	83 f8 02             	cmp    $0x2,%eax
80102156:	0f 84 ab 00 00 00    	je     80102207 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010215c:	8b 53 04             	mov    0x4(%ebx),%edx
8010215f:	85 d2                	test   %edx,%edx
80102161:	74 0d                	je     80102170 <iderw+0x40>
80102163:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102168:	85 c0                	test   %eax,%eax
8010216a:	0f 84 b1 00 00 00    	je     80102221 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102170:	83 ec 0c             	sub    $0xc,%esp
80102173:	68 80 a5 10 80       	push   $0x8010a580
80102178:	e8 73 23 00 00       	call   801044f0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010217d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
80102183:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102186:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010218d:	85 d2                	test   %edx,%edx
8010218f:	75 09                	jne    8010219a <iderw+0x6a>
80102191:	eb 6d                	jmp    80102200 <iderw+0xd0>
80102193:	90                   	nop
80102194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102198:	89 c2                	mov    %eax,%edx
8010219a:	8b 42 58             	mov    0x58(%edx),%eax
8010219d:	85 c0                	test   %eax,%eax
8010219f:	75 f7                	jne    80102198 <iderw+0x68>
801021a1:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801021a4:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801021a6:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
801021ac:	74 42                	je     801021f0 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021ae:	8b 03                	mov    (%ebx),%eax
801021b0:	83 e0 06             	and    $0x6,%eax
801021b3:	83 f8 02             	cmp    $0x2,%eax
801021b6:	74 23                	je     801021db <iderw+0xab>
801021b8:	90                   	nop
801021b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801021c0:	83 ec 08             	sub    $0x8,%esp
801021c3:	68 80 a5 10 80       	push   $0x8010a580
801021c8:	53                   	push   %ebx
801021c9:	e8 22 1d 00 00       	call   80103ef0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021ce:	8b 03                	mov    (%ebx),%eax
801021d0:	83 c4 10             	add    $0x10,%esp
801021d3:	83 e0 06             	and    $0x6,%eax
801021d6:	83 f8 02             	cmp    $0x2,%eax
801021d9:	75 e5                	jne    801021c0 <iderw+0x90>
  }


  release(&idelock);
801021db:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801021e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021e5:	c9                   	leave  
  release(&idelock);
801021e6:	e9 c5 23 00 00       	jmp    801045b0 <release>
801021eb:	90                   	nop
801021ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801021f0:	89 d8                	mov    %ebx,%eax
801021f2:	e8 39 fd ff ff       	call   80101f30 <idestart>
801021f7:	eb b5                	jmp    801021ae <iderw+0x7e>
801021f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102200:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
80102205:	eb 9d                	jmp    801021a4 <iderw+0x74>
    panic("iderw: nothing to do");
80102207:	83 ec 0c             	sub    $0xc,%esp
8010220a:	68 80 74 10 80       	push   $0x80107480
8010220f:	e8 7c e1 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102214:	83 ec 0c             	sub    $0xc,%esp
80102217:	68 6a 74 10 80       	push   $0x8010746a
8010221c:	e8 6f e1 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102221:	83 ec 0c             	sub    $0xc,%esp
80102224:	68 95 74 10 80       	push   $0x80107495
80102229:	e8 62 e1 ff ff       	call   80100390 <panic>
8010222e:	66 90                	xchg   %ax,%ax

80102230 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102230:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102231:	c7 05 f4 2f 11 80 00 	movl   $0xfec00000,0x80112ff4
80102238:	00 c0 fe 
{
8010223b:	89 e5                	mov    %esp,%ebp
8010223d:	56                   	push   %esi
8010223e:	53                   	push   %ebx
  ioapic->reg = reg;
8010223f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102246:	00 00 00 
  return ioapic->data;
80102249:	a1 f4 2f 11 80       	mov    0x80112ff4,%eax
8010224e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102251:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102257:	8b 0d f4 2f 11 80    	mov    0x80112ff4,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010225d:	0f b6 15 20 31 11 80 	movzbl 0x80113120,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102264:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102267:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010226a:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010226d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102270:	39 c2                	cmp    %eax,%edx
80102272:	74 16                	je     8010228a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102274:	83 ec 0c             	sub    $0xc,%esp
80102277:	68 b4 74 10 80       	push   $0x801074b4
8010227c:	e8 df e3 ff ff       	call   80100660 <cprintf>
80102281:	8b 0d f4 2f 11 80    	mov    0x80112ff4,%ecx
80102287:	83 c4 10             	add    $0x10,%esp
8010228a:	83 c3 21             	add    $0x21,%ebx
{
8010228d:	ba 10 00 00 00       	mov    $0x10,%edx
80102292:	b8 20 00 00 00       	mov    $0x20,%eax
80102297:	89 f6                	mov    %esi,%esi
80102299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
801022a0:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
801022a2:	8b 0d f4 2f 11 80    	mov    0x80112ff4,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801022a8:	89 c6                	mov    %eax,%esi
801022aa:	81 ce 00 00 01 00    	or     $0x10000,%esi
801022b0:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022b3:	89 71 10             	mov    %esi,0x10(%ecx)
801022b6:	8d 72 01             	lea    0x1(%edx),%esi
801022b9:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
801022bc:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
801022be:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
801022c0:	8b 0d f4 2f 11 80    	mov    0x80112ff4,%ecx
801022c6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801022cd:	75 d1                	jne    801022a0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801022cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022d2:	5b                   	pop    %ebx
801022d3:	5e                   	pop    %esi
801022d4:	5d                   	pop    %ebp
801022d5:	c3                   	ret    
801022d6:	8d 76 00             	lea    0x0(%esi),%esi
801022d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022e0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801022e0:	55                   	push   %ebp
  ioapic->reg = reg;
801022e1:	8b 0d f4 2f 11 80    	mov    0x80112ff4,%ecx
{
801022e7:	89 e5                	mov    %esp,%ebp
801022e9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022ec:	8d 50 20             	lea    0x20(%eax),%edx
801022ef:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801022f3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022f5:	8b 0d f4 2f 11 80    	mov    0x80112ff4,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022fb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022fe:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102301:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102304:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102306:	a1 f4 2f 11 80       	mov    0x80112ff4,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010230b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010230e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102311:	5d                   	pop    %ebp
80102312:	c3                   	ret    
80102313:	66 90                	xchg   %ax,%ax
80102315:	66 90                	xchg   %ax,%ax
80102317:	66 90                	xchg   %ax,%ax
80102319:	66 90                	xchg   %ax,%ax
8010231b:	66 90                	xchg   %ax,%ax
8010231d:	66 90                	xchg   %ax,%ax
8010231f:	90                   	nop

80102320 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102320:	55                   	push   %ebp
80102321:	89 e5                	mov    %esp,%ebp
80102323:	53                   	push   %ebx
80102324:	83 ec 04             	sub    $0x4,%esp
80102327:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010232a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102330:	75 70                	jne    801023a2 <kfree+0x82>
80102332:	81 fb 88 5a 11 80    	cmp    $0x80115a88,%ebx
80102338:	72 68                	jb     801023a2 <kfree+0x82>
8010233a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102340:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102345:	77 5b                	ja     801023a2 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102347:	83 ec 04             	sub    $0x4,%esp
8010234a:	68 00 10 00 00       	push   $0x1000
8010234f:	6a 01                	push   $0x1
80102351:	53                   	push   %ebx
80102352:	e8 a9 22 00 00       	call   80104600 <memset>

  if(kmem.use_lock)
80102357:	8b 15 34 30 11 80    	mov    0x80113034,%edx
8010235d:	83 c4 10             	add    $0x10,%esp
80102360:	85 d2                	test   %edx,%edx
80102362:	75 2c                	jne    80102390 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102364:	a1 38 30 11 80       	mov    0x80113038,%eax
80102369:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010236b:	a1 34 30 11 80       	mov    0x80113034,%eax
  kmem.freelist = r;
80102370:	89 1d 38 30 11 80    	mov    %ebx,0x80113038
  if(kmem.use_lock)
80102376:	85 c0                	test   %eax,%eax
80102378:	75 06                	jne    80102380 <kfree+0x60>
    release(&kmem.lock);
}
8010237a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010237d:	c9                   	leave  
8010237e:	c3                   	ret    
8010237f:	90                   	nop
    release(&kmem.lock);
80102380:	c7 45 08 00 30 11 80 	movl   $0x80113000,0x8(%ebp)
}
80102387:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010238a:	c9                   	leave  
    release(&kmem.lock);
8010238b:	e9 20 22 00 00       	jmp    801045b0 <release>
    acquire(&kmem.lock);
80102390:	83 ec 0c             	sub    $0xc,%esp
80102393:	68 00 30 11 80       	push   $0x80113000
80102398:	e8 53 21 00 00       	call   801044f0 <acquire>
8010239d:	83 c4 10             	add    $0x10,%esp
801023a0:	eb c2                	jmp    80102364 <kfree+0x44>
    panic("kfree");
801023a2:	83 ec 0c             	sub    $0xc,%esp
801023a5:	68 e6 74 10 80       	push   $0x801074e6
801023aa:	e8 e1 df ff ff       	call   80100390 <panic>
801023af:	90                   	nop

801023b0 <freerange>:
{
801023b0:	55                   	push   %ebp
801023b1:	89 e5                	mov    %esp,%ebp
801023b3:	56                   	push   %esi
801023b4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801023b5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801023b8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801023bb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023c1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023c7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023cd:	39 de                	cmp    %ebx,%esi
801023cf:	72 23                	jb     801023f4 <freerange+0x44>
801023d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801023d8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023de:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023e1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023e7:	50                   	push   %eax
801023e8:	e8 33 ff ff ff       	call   80102320 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023ed:	83 c4 10             	add    $0x10,%esp
801023f0:	39 f3                	cmp    %esi,%ebx
801023f2:	76 e4                	jbe    801023d8 <freerange+0x28>
}
801023f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023f7:	5b                   	pop    %ebx
801023f8:	5e                   	pop    %esi
801023f9:	5d                   	pop    %ebp
801023fa:	c3                   	ret    
801023fb:	90                   	nop
801023fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102400 <kinit1>:
{
80102400:	55                   	push   %ebp
80102401:	89 e5                	mov    %esp,%ebp
80102403:	56                   	push   %esi
80102404:	53                   	push   %ebx
80102405:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102408:	83 ec 08             	sub    $0x8,%esp
8010240b:	68 ec 74 10 80       	push   $0x801074ec
80102410:	68 00 30 11 80       	push   $0x80113000
80102415:	e8 96 1f 00 00       	call   801043b0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010241a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010241d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102420:	c7 05 34 30 11 80 00 	movl   $0x0,0x80113034
80102427:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010242a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102430:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102436:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010243c:	39 de                	cmp    %ebx,%esi
8010243e:	72 1c                	jb     8010245c <kinit1+0x5c>
    kfree(p);
80102440:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102446:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102449:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010244f:	50                   	push   %eax
80102450:	e8 cb fe ff ff       	call   80102320 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102455:	83 c4 10             	add    $0x10,%esp
80102458:	39 de                	cmp    %ebx,%esi
8010245a:	73 e4                	jae    80102440 <kinit1+0x40>
}
8010245c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010245f:	5b                   	pop    %ebx
80102460:	5e                   	pop    %esi
80102461:	5d                   	pop    %ebp
80102462:	c3                   	ret    
80102463:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102470 <kinit2>:
{
80102470:	55                   	push   %ebp
80102471:	89 e5                	mov    %esp,%ebp
80102473:	56                   	push   %esi
80102474:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102475:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102478:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010247b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102481:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102487:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010248d:	39 de                	cmp    %ebx,%esi
8010248f:	72 23                	jb     801024b4 <kinit2+0x44>
80102491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102498:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010249e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024a1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024a7:	50                   	push   %eax
801024a8:	e8 73 fe ff ff       	call   80102320 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024ad:	83 c4 10             	add    $0x10,%esp
801024b0:	39 de                	cmp    %ebx,%esi
801024b2:	73 e4                	jae    80102498 <kinit2+0x28>
  kmem.use_lock = 1;
801024b4:	c7 05 34 30 11 80 01 	movl   $0x1,0x80113034
801024bb:	00 00 00 
}
801024be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024c1:	5b                   	pop    %ebx
801024c2:	5e                   	pop    %esi
801024c3:	5d                   	pop    %ebp
801024c4:	c3                   	ret    
801024c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024d0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801024d0:	a1 34 30 11 80       	mov    0x80113034,%eax
801024d5:	85 c0                	test   %eax,%eax
801024d7:	75 1f                	jne    801024f8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024d9:	a1 38 30 11 80       	mov    0x80113038,%eax
  if(r)
801024de:	85 c0                	test   %eax,%eax
801024e0:	74 0e                	je     801024f0 <kalloc+0x20>
    kmem.freelist = r->next;
801024e2:	8b 10                	mov    (%eax),%edx
801024e4:	89 15 38 30 11 80    	mov    %edx,0x80113038
801024ea:	c3                   	ret    
801024eb:	90                   	nop
801024ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801024f0:	f3 c3                	repz ret 
801024f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
801024f8:	55                   	push   %ebp
801024f9:	89 e5                	mov    %esp,%ebp
801024fb:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801024fe:	68 00 30 11 80       	push   $0x80113000
80102503:	e8 e8 1f 00 00       	call   801044f0 <acquire>
  r = kmem.freelist;
80102508:	a1 38 30 11 80       	mov    0x80113038,%eax
  if(r)
8010250d:	83 c4 10             	add    $0x10,%esp
80102510:	8b 15 34 30 11 80    	mov    0x80113034,%edx
80102516:	85 c0                	test   %eax,%eax
80102518:	74 08                	je     80102522 <kalloc+0x52>
    kmem.freelist = r->next;
8010251a:	8b 08                	mov    (%eax),%ecx
8010251c:	89 0d 38 30 11 80    	mov    %ecx,0x80113038
  if(kmem.use_lock)
80102522:	85 d2                	test   %edx,%edx
80102524:	74 16                	je     8010253c <kalloc+0x6c>
    release(&kmem.lock);
80102526:	83 ec 0c             	sub    $0xc,%esp
80102529:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010252c:	68 00 30 11 80       	push   $0x80113000
80102531:	e8 7a 20 00 00       	call   801045b0 <release>
  return (char*)r;
80102536:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102539:	83 c4 10             	add    $0x10,%esp
}
8010253c:	c9                   	leave  
8010253d:	c3                   	ret    
8010253e:	66 90                	xchg   %ax,%ax

80102540 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102540:	ba 64 00 00 00       	mov    $0x64,%edx
80102545:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102546:	a8 01                	test   $0x1,%al
80102548:	0f 84 c2 00 00 00    	je     80102610 <kbdgetc+0xd0>
8010254e:	ba 60 00 00 00       	mov    $0x60,%edx
80102553:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102554:	0f b6 d0             	movzbl %al,%edx
80102557:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx

  if(data == 0xE0){
8010255d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102563:	0f 84 7f 00 00 00    	je     801025e8 <kbdgetc+0xa8>
{
80102569:	55                   	push   %ebp
8010256a:	89 e5                	mov    %esp,%ebp
8010256c:	53                   	push   %ebx
8010256d:	89 cb                	mov    %ecx,%ebx
8010256f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102572:	84 c0                	test   %al,%al
80102574:	78 4a                	js     801025c0 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102576:	85 db                	test   %ebx,%ebx
80102578:	74 09                	je     80102583 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010257a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
8010257d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102580:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102583:	0f b6 82 20 76 10 80 	movzbl -0x7fef89e0(%edx),%eax
8010258a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010258c:	0f b6 82 20 75 10 80 	movzbl -0x7fef8ae0(%edx),%eax
80102593:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102595:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102597:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
8010259d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801025a0:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025a3:	8b 04 85 00 75 10 80 	mov    -0x7fef8b00(,%eax,4),%eax
801025aa:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801025ae:	74 31                	je     801025e1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
801025b0:	8d 50 9f             	lea    -0x61(%eax),%edx
801025b3:	83 fa 19             	cmp    $0x19,%edx
801025b6:	77 40                	ja     801025f8 <kbdgetc+0xb8>
      c += 'A' - 'a';
801025b8:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025bb:	5b                   	pop    %ebx
801025bc:	5d                   	pop    %ebp
801025bd:	c3                   	ret    
801025be:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
801025c0:	83 e0 7f             	and    $0x7f,%eax
801025c3:	85 db                	test   %ebx,%ebx
801025c5:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801025c8:	0f b6 82 20 76 10 80 	movzbl -0x7fef89e0(%edx),%eax
801025cf:	83 c8 40             	or     $0x40,%eax
801025d2:	0f b6 c0             	movzbl %al,%eax
801025d5:	f7 d0                	not    %eax
801025d7:	21 c1                	and    %eax,%ecx
    return 0;
801025d9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801025db:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
}
801025e1:	5b                   	pop    %ebx
801025e2:	5d                   	pop    %ebp
801025e3:	c3                   	ret    
801025e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801025e8:	83 c9 40             	or     $0x40,%ecx
    return 0;
801025eb:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801025ed:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
    return 0;
801025f3:	c3                   	ret    
801025f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801025f8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801025fb:	8d 50 20             	lea    0x20(%eax),%edx
}
801025fe:	5b                   	pop    %ebx
      c += 'a' - 'A';
801025ff:	83 f9 1a             	cmp    $0x1a,%ecx
80102602:	0f 42 c2             	cmovb  %edx,%eax
}
80102605:	5d                   	pop    %ebp
80102606:	c3                   	ret    
80102607:	89 f6                	mov    %esi,%esi
80102609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102610:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102615:	c3                   	ret    
80102616:	8d 76 00             	lea    0x0(%esi),%esi
80102619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102620 <kbdintr>:

void
kbdintr(void)
{
80102620:	55                   	push   %ebp
80102621:	89 e5                	mov    %esp,%ebp
80102623:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102626:	68 40 25 10 80       	push   $0x80102540
8010262b:	e8 e0 e1 ff ff       	call   80100810 <consoleintr>
}
80102630:	83 c4 10             	add    $0x10,%esp
80102633:	c9                   	leave  
80102634:	c3                   	ret    
80102635:	66 90                	xchg   %ax,%ax
80102637:	66 90                	xchg   %ax,%ax
80102639:	66 90                	xchg   %ax,%ax
8010263b:	66 90                	xchg   %ax,%ax
8010263d:	66 90                	xchg   %ax,%ax
8010263f:	90                   	nop

80102640 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102640:	a1 3c 30 11 80       	mov    0x8011303c,%eax
{
80102645:	55                   	push   %ebp
80102646:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102648:	85 c0                	test   %eax,%eax
8010264a:	0f 84 c8 00 00 00    	je     80102718 <lapicinit+0xd8>
  lapic[index] = value;
80102650:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102657:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010265a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010265d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102664:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102667:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010266a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102671:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102674:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102677:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010267e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102681:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102684:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010268b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010268e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102691:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102698:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010269b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010269e:	8b 50 30             	mov    0x30(%eax),%edx
801026a1:	c1 ea 10             	shr    $0x10,%edx
801026a4:	80 fa 03             	cmp    $0x3,%dl
801026a7:	77 77                	ja     80102720 <lapicinit+0xe0>
  lapic[index] = value;
801026a9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026b0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026b3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026b6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026bd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026c0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026c3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026ca:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026cd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026d0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801026d7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026da:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026dd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801026e4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026e7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026ea:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801026f1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801026f4:	8b 50 20             	mov    0x20(%eax),%edx
801026f7:	89 f6                	mov    %esi,%esi
801026f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102700:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102706:	80 e6 10             	and    $0x10,%dh
80102709:	75 f5                	jne    80102700 <lapicinit+0xc0>
  lapic[index] = value;
8010270b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102712:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102715:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102718:	5d                   	pop    %ebp
80102719:	c3                   	ret    
8010271a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102720:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102727:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010272a:	8b 50 20             	mov    0x20(%eax),%edx
8010272d:	e9 77 ff ff ff       	jmp    801026a9 <lapicinit+0x69>
80102732:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102740 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102740:	8b 15 3c 30 11 80    	mov    0x8011303c,%edx
{
80102746:	55                   	push   %ebp
80102747:	31 c0                	xor    %eax,%eax
80102749:	89 e5                	mov    %esp,%ebp
  if (!lapic)
8010274b:	85 d2                	test   %edx,%edx
8010274d:	74 06                	je     80102755 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
8010274f:	8b 42 20             	mov    0x20(%edx),%eax
80102752:	c1 e8 18             	shr    $0x18,%eax
}
80102755:	5d                   	pop    %ebp
80102756:	c3                   	ret    
80102757:	89 f6                	mov    %esi,%esi
80102759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102760 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102760:	a1 3c 30 11 80       	mov    0x8011303c,%eax
{
80102765:	55                   	push   %ebp
80102766:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102768:	85 c0                	test   %eax,%eax
8010276a:	74 0d                	je     80102779 <lapiceoi+0x19>
  lapic[index] = value;
8010276c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102773:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102776:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102779:	5d                   	pop    %ebp
8010277a:	c3                   	ret    
8010277b:	90                   	nop
8010277c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102780 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102780:	55                   	push   %ebp
80102781:	89 e5                	mov    %esp,%ebp
}
80102783:	5d                   	pop    %ebp
80102784:	c3                   	ret    
80102785:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102790 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102790:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102791:	b8 0f 00 00 00       	mov    $0xf,%eax
80102796:	ba 70 00 00 00       	mov    $0x70,%edx
8010279b:	89 e5                	mov    %esp,%ebp
8010279d:	53                   	push   %ebx
8010279e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801027a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801027a4:	ee                   	out    %al,(%dx)
801027a5:	b8 0a 00 00 00       	mov    $0xa,%eax
801027aa:	ba 71 00 00 00       	mov    $0x71,%edx
801027af:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801027b0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801027b2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
801027b5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801027bb:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801027bd:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
801027c0:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
801027c3:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
801027c5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
801027c8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801027ce:	a1 3c 30 11 80       	mov    0x8011303c,%eax
801027d3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027d9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027dc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801027e3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027e6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027e9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801027f0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027f3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027f6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027fc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027ff:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102805:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102808:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010280e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102811:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102817:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010281a:	5b                   	pop    %ebx
8010281b:	5d                   	pop    %ebp
8010281c:	c3                   	ret    
8010281d:	8d 76 00             	lea    0x0(%esi),%esi

80102820 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102820:	55                   	push   %ebp
80102821:	b8 0b 00 00 00       	mov    $0xb,%eax
80102826:	ba 70 00 00 00       	mov    $0x70,%edx
8010282b:	89 e5                	mov    %esp,%ebp
8010282d:	57                   	push   %edi
8010282e:	56                   	push   %esi
8010282f:	53                   	push   %ebx
80102830:	83 ec 4c             	sub    $0x4c,%esp
80102833:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102834:	ba 71 00 00 00       	mov    $0x71,%edx
80102839:	ec                   	in     (%dx),%al
8010283a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010283d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102842:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102845:	8d 76 00             	lea    0x0(%esi),%esi
80102848:	31 c0                	xor    %eax,%eax
8010284a:	89 da                	mov    %ebx,%edx
8010284c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010284d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102852:	89 ca                	mov    %ecx,%edx
80102854:	ec                   	in     (%dx),%al
80102855:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102858:	89 da                	mov    %ebx,%edx
8010285a:	b8 02 00 00 00       	mov    $0x2,%eax
8010285f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102860:	89 ca                	mov    %ecx,%edx
80102862:	ec                   	in     (%dx),%al
80102863:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102866:	89 da                	mov    %ebx,%edx
80102868:	b8 04 00 00 00       	mov    $0x4,%eax
8010286d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010286e:	89 ca                	mov    %ecx,%edx
80102870:	ec                   	in     (%dx),%al
80102871:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102874:	89 da                	mov    %ebx,%edx
80102876:	b8 07 00 00 00       	mov    $0x7,%eax
8010287b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010287c:	89 ca                	mov    %ecx,%edx
8010287e:	ec                   	in     (%dx),%al
8010287f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102882:	89 da                	mov    %ebx,%edx
80102884:	b8 08 00 00 00       	mov    $0x8,%eax
80102889:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010288a:	89 ca                	mov    %ecx,%edx
8010288c:	ec                   	in     (%dx),%al
8010288d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010288f:	89 da                	mov    %ebx,%edx
80102891:	b8 09 00 00 00       	mov    $0x9,%eax
80102896:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102897:	89 ca                	mov    %ecx,%edx
80102899:	ec                   	in     (%dx),%al
8010289a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010289c:	89 da                	mov    %ebx,%edx
8010289e:	b8 0a 00 00 00       	mov    $0xa,%eax
801028a3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028a4:	89 ca                	mov    %ecx,%edx
801028a6:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801028a7:	84 c0                	test   %al,%al
801028a9:	78 9d                	js     80102848 <cmostime+0x28>
  return inb(CMOS_RETURN);
801028ab:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
801028af:	89 fa                	mov    %edi,%edx
801028b1:	0f b6 fa             	movzbl %dl,%edi
801028b4:	89 f2                	mov    %esi,%edx
801028b6:	0f b6 f2             	movzbl %dl,%esi
801028b9:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028bc:	89 da                	mov    %ebx,%edx
801028be:	89 75 cc             	mov    %esi,-0x34(%ebp)
801028c1:	89 45 b8             	mov    %eax,-0x48(%ebp)
801028c4:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801028c8:	89 45 bc             	mov    %eax,-0x44(%ebp)
801028cb:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801028cf:	89 45 c0             	mov    %eax,-0x40(%ebp)
801028d2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801028d6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801028d9:	31 c0                	xor    %eax,%eax
801028db:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028dc:	89 ca                	mov    %ecx,%edx
801028de:	ec                   	in     (%dx),%al
801028df:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028e2:	89 da                	mov    %ebx,%edx
801028e4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801028e7:	b8 02 00 00 00       	mov    $0x2,%eax
801028ec:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ed:	89 ca                	mov    %ecx,%edx
801028ef:	ec                   	in     (%dx),%al
801028f0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028f3:	89 da                	mov    %ebx,%edx
801028f5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801028f8:	b8 04 00 00 00       	mov    $0x4,%eax
801028fd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028fe:	89 ca                	mov    %ecx,%edx
80102900:	ec                   	in     (%dx),%al
80102901:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102904:	89 da                	mov    %ebx,%edx
80102906:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102909:	b8 07 00 00 00       	mov    $0x7,%eax
8010290e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010290f:	89 ca                	mov    %ecx,%edx
80102911:	ec                   	in     (%dx),%al
80102912:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102915:	89 da                	mov    %ebx,%edx
80102917:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010291a:	b8 08 00 00 00       	mov    $0x8,%eax
8010291f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102920:	89 ca                	mov    %ecx,%edx
80102922:	ec                   	in     (%dx),%al
80102923:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102926:	89 da                	mov    %ebx,%edx
80102928:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010292b:	b8 09 00 00 00       	mov    $0x9,%eax
80102930:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102931:	89 ca                	mov    %ecx,%edx
80102933:	ec                   	in     (%dx),%al
80102934:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102937:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
8010293a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010293d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102940:	6a 18                	push   $0x18
80102942:	50                   	push   %eax
80102943:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102946:	50                   	push   %eax
80102947:	e8 04 1d 00 00       	call   80104650 <memcmp>
8010294c:	83 c4 10             	add    $0x10,%esp
8010294f:	85 c0                	test   %eax,%eax
80102951:	0f 85 f1 fe ff ff    	jne    80102848 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102957:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
8010295b:	75 78                	jne    801029d5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010295d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102960:	89 c2                	mov    %eax,%edx
80102962:	83 e0 0f             	and    $0xf,%eax
80102965:	c1 ea 04             	shr    $0x4,%edx
80102968:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010296b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010296e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102971:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102974:	89 c2                	mov    %eax,%edx
80102976:	83 e0 0f             	and    $0xf,%eax
80102979:	c1 ea 04             	shr    $0x4,%edx
8010297c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010297f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102982:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102985:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102988:	89 c2                	mov    %eax,%edx
8010298a:	83 e0 0f             	and    $0xf,%eax
8010298d:	c1 ea 04             	shr    $0x4,%edx
80102990:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102993:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102996:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102999:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010299c:	89 c2                	mov    %eax,%edx
8010299e:	83 e0 0f             	and    $0xf,%eax
801029a1:	c1 ea 04             	shr    $0x4,%edx
801029a4:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029a7:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029aa:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
801029ad:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029b0:	89 c2                	mov    %eax,%edx
801029b2:	83 e0 0f             	and    $0xf,%eax
801029b5:	c1 ea 04             	shr    $0x4,%edx
801029b8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029bb:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029be:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801029c1:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029c4:	89 c2                	mov    %eax,%edx
801029c6:	83 e0 0f             	and    $0xf,%eax
801029c9:	c1 ea 04             	shr    $0x4,%edx
801029cc:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029cf:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029d2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801029d5:	8b 75 08             	mov    0x8(%ebp),%esi
801029d8:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029db:	89 06                	mov    %eax,(%esi)
801029dd:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029e0:	89 46 04             	mov    %eax,0x4(%esi)
801029e3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029e6:	89 46 08             	mov    %eax,0x8(%esi)
801029e9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029ec:	89 46 0c             	mov    %eax,0xc(%esi)
801029ef:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029f2:	89 46 10             	mov    %eax,0x10(%esi)
801029f5:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029f8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
801029fb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102a02:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a05:	5b                   	pop    %ebx
80102a06:	5e                   	pop    %esi
80102a07:	5f                   	pop    %edi
80102a08:	5d                   	pop    %ebp
80102a09:	c3                   	ret    
80102a0a:	66 90                	xchg   %ax,%ax
80102a0c:	66 90                	xchg   %ax,%ax
80102a0e:	66 90                	xchg   %ax,%ax

80102a10 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a10:	8b 0d 88 30 11 80    	mov    0x80113088,%ecx
80102a16:	85 c9                	test   %ecx,%ecx
80102a18:	0f 8e 8a 00 00 00    	jle    80102aa8 <install_trans+0x98>
{
80102a1e:	55                   	push   %ebp
80102a1f:	89 e5                	mov    %esp,%ebp
80102a21:	57                   	push   %edi
80102a22:	56                   	push   %esi
80102a23:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102a24:	31 db                	xor    %ebx,%ebx
{
80102a26:	83 ec 0c             	sub    $0xc,%esp
80102a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102a30:	a1 74 30 11 80       	mov    0x80113074,%eax
80102a35:	83 ec 08             	sub    $0x8,%esp
80102a38:	01 d8                	add    %ebx,%eax
80102a3a:	83 c0 01             	add    $0x1,%eax
80102a3d:	50                   	push   %eax
80102a3e:	ff 35 84 30 11 80    	pushl  0x80113084
80102a44:	e8 87 d6 ff ff       	call   801000d0 <bread>
80102a49:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a4b:	58                   	pop    %eax
80102a4c:	5a                   	pop    %edx
80102a4d:	ff 34 9d 8c 30 11 80 	pushl  -0x7feecf74(,%ebx,4)
80102a54:	ff 35 84 30 11 80    	pushl  0x80113084
  for (tail = 0; tail < log.lh.n; tail++) {
80102a5a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a5d:	e8 6e d6 ff ff       	call   801000d0 <bread>
80102a62:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a64:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a67:	83 c4 0c             	add    $0xc,%esp
80102a6a:	68 00 02 00 00       	push   $0x200
80102a6f:	50                   	push   %eax
80102a70:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a73:	50                   	push   %eax
80102a74:	e8 37 1c 00 00       	call   801046b0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a79:	89 34 24             	mov    %esi,(%esp)
80102a7c:	e8 1f d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102a81:	89 3c 24             	mov    %edi,(%esp)
80102a84:	e8 57 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102a89:	89 34 24             	mov    %esi,(%esp)
80102a8c:	e8 4f d7 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102a91:	83 c4 10             	add    $0x10,%esp
80102a94:	39 1d 88 30 11 80    	cmp    %ebx,0x80113088
80102a9a:	7f 94                	jg     80102a30 <install_trans+0x20>
  }
}
80102a9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a9f:	5b                   	pop    %ebx
80102aa0:	5e                   	pop    %esi
80102aa1:	5f                   	pop    %edi
80102aa2:	5d                   	pop    %ebp
80102aa3:	c3                   	ret    
80102aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102aa8:	f3 c3                	repz ret 
80102aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102ab0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102ab0:	55                   	push   %ebp
80102ab1:	89 e5                	mov    %esp,%ebp
80102ab3:	56                   	push   %esi
80102ab4:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102ab5:	83 ec 08             	sub    $0x8,%esp
80102ab8:	ff 35 74 30 11 80    	pushl  0x80113074
80102abe:	ff 35 84 30 11 80    	pushl  0x80113084
80102ac4:	e8 07 d6 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102ac9:	8b 1d 88 30 11 80    	mov    0x80113088,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102acf:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ad2:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102ad4:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102ad6:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102ad9:	7e 16                	jle    80102af1 <write_head+0x41>
80102adb:	c1 e3 02             	shl    $0x2,%ebx
80102ade:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102ae0:	8b 8a 8c 30 11 80    	mov    -0x7feecf74(%edx),%ecx
80102ae6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102aea:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102aed:	39 da                	cmp    %ebx,%edx
80102aef:	75 ef                	jne    80102ae0 <write_head+0x30>
  }
  bwrite(buf);
80102af1:	83 ec 0c             	sub    $0xc,%esp
80102af4:	56                   	push   %esi
80102af5:	e8 a6 d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102afa:	89 34 24             	mov    %esi,(%esp)
80102afd:	e8 de d6 ff ff       	call   801001e0 <brelse>
}
80102b02:	83 c4 10             	add    $0x10,%esp
80102b05:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b08:	5b                   	pop    %ebx
80102b09:	5e                   	pop    %esi
80102b0a:	5d                   	pop    %ebp
80102b0b:	c3                   	ret    
80102b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102b10 <initlog>:
{
80102b10:	55                   	push   %ebp
80102b11:	89 e5                	mov    %esp,%ebp
80102b13:	53                   	push   %ebx
80102b14:	83 ec 2c             	sub    $0x2c,%esp
80102b17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102b1a:	68 20 77 10 80       	push   $0x80107720
80102b1f:	68 40 30 11 80       	push   $0x80113040
80102b24:	e8 87 18 00 00       	call   801043b0 <initlock>
  readsb(dev, &sb);
80102b29:	58                   	pop    %eax
80102b2a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102b2d:	5a                   	pop    %edx
80102b2e:	50                   	push   %eax
80102b2f:	53                   	push   %ebx
80102b30:	e8 9b e8 ff ff       	call   801013d0 <readsb>
  log.size = sb.nlog;
80102b35:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102b38:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102b3b:	59                   	pop    %ecx
  log.dev = dev;
80102b3c:	89 1d 84 30 11 80    	mov    %ebx,0x80113084
  log.size = sb.nlog;
80102b42:	89 15 78 30 11 80    	mov    %edx,0x80113078
  log.start = sb.logstart;
80102b48:	a3 74 30 11 80       	mov    %eax,0x80113074
  struct buf *buf = bread(log.dev, log.start);
80102b4d:	5a                   	pop    %edx
80102b4e:	50                   	push   %eax
80102b4f:	53                   	push   %ebx
80102b50:	e8 7b d5 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102b55:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b58:	83 c4 10             	add    $0x10,%esp
80102b5b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102b5d:	89 1d 88 30 11 80    	mov    %ebx,0x80113088
  for (i = 0; i < log.lh.n; i++) {
80102b63:	7e 1c                	jle    80102b81 <initlog+0x71>
80102b65:	c1 e3 02             	shl    $0x2,%ebx
80102b68:	31 d2                	xor    %edx,%edx
80102b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102b70:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b74:	83 c2 04             	add    $0x4,%edx
80102b77:	89 8a 88 30 11 80    	mov    %ecx,-0x7feecf78(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102b7d:	39 d3                	cmp    %edx,%ebx
80102b7f:	75 ef                	jne    80102b70 <initlog+0x60>
  brelse(buf);
80102b81:	83 ec 0c             	sub    $0xc,%esp
80102b84:	50                   	push   %eax
80102b85:	e8 56 d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102b8a:	e8 81 fe ff ff       	call   80102a10 <install_trans>
  log.lh.n = 0;
80102b8f:	c7 05 88 30 11 80 00 	movl   $0x0,0x80113088
80102b96:	00 00 00 
  write_head(); // clear the log
80102b99:	e8 12 ff ff ff       	call   80102ab0 <write_head>
}
80102b9e:	83 c4 10             	add    $0x10,%esp
80102ba1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ba4:	c9                   	leave  
80102ba5:	c3                   	ret    
80102ba6:	8d 76 00             	lea    0x0(%esi),%esi
80102ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102bb0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102bb0:	55                   	push   %ebp
80102bb1:	89 e5                	mov    %esp,%ebp
80102bb3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102bb6:	68 40 30 11 80       	push   $0x80113040
80102bbb:	e8 30 19 00 00       	call   801044f0 <acquire>
80102bc0:	83 c4 10             	add    $0x10,%esp
80102bc3:	eb 18                	jmp    80102bdd <begin_op+0x2d>
80102bc5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102bc8:	83 ec 08             	sub    $0x8,%esp
80102bcb:	68 40 30 11 80       	push   $0x80113040
80102bd0:	68 40 30 11 80       	push   $0x80113040
80102bd5:	e8 16 13 00 00       	call   80103ef0 <sleep>
80102bda:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102bdd:	a1 80 30 11 80       	mov    0x80113080,%eax
80102be2:	85 c0                	test   %eax,%eax
80102be4:	75 e2                	jne    80102bc8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102be6:	a1 7c 30 11 80       	mov    0x8011307c,%eax
80102beb:	8b 15 88 30 11 80    	mov    0x80113088,%edx
80102bf1:	83 c0 01             	add    $0x1,%eax
80102bf4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102bf7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102bfa:	83 fa 1e             	cmp    $0x1e,%edx
80102bfd:	7f c9                	jg     80102bc8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102bff:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102c02:	a3 7c 30 11 80       	mov    %eax,0x8011307c
      release(&log.lock);
80102c07:	68 40 30 11 80       	push   $0x80113040
80102c0c:	e8 9f 19 00 00       	call   801045b0 <release>
      break;
    }
  }
}
80102c11:	83 c4 10             	add    $0x10,%esp
80102c14:	c9                   	leave  
80102c15:	c3                   	ret    
80102c16:	8d 76 00             	lea    0x0(%esi),%esi
80102c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c20 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102c20:	55                   	push   %ebp
80102c21:	89 e5                	mov    %esp,%ebp
80102c23:	57                   	push   %edi
80102c24:	56                   	push   %esi
80102c25:	53                   	push   %ebx
80102c26:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102c29:	68 40 30 11 80       	push   $0x80113040
80102c2e:	e8 bd 18 00 00       	call   801044f0 <acquire>
  log.outstanding -= 1;
80102c33:	a1 7c 30 11 80       	mov    0x8011307c,%eax
  if(log.committing)
80102c38:	8b 35 80 30 11 80    	mov    0x80113080,%esi
80102c3e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102c41:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102c44:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102c46:	89 1d 7c 30 11 80    	mov    %ebx,0x8011307c
  if(log.committing)
80102c4c:	0f 85 1a 01 00 00    	jne    80102d6c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102c52:	85 db                	test   %ebx,%ebx
80102c54:	0f 85 ee 00 00 00    	jne    80102d48 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102c5a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102c5d:	c7 05 80 30 11 80 01 	movl   $0x1,0x80113080
80102c64:	00 00 00 
  release(&log.lock);
80102c67:	68 40 30 11 80       	push   $0x80113040
80102c6c:	e8 3f 19 00 00       	call   801045b0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c71:	8b 0d 88 30 11 80    	mov    0x80113088,%ecx
80102c77:	83 c4 10             	add    $0x10,%esp
80102c7a:	85 c9                	test   %ecx,%ecx
80102c7c:	0f 8e 85 00 00 00    	jle    80102d07 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c82:	a1 74 30 11 80       	mov    0x80113074,%eax
80102c87:	83 ec 08             	sub    $0x8,%esp
80102c8a:	01 d8                	add    %ebx,%eax
80102c8c:	83 c0 01             	add    $0x1,%eax
80102c8f:	50                   	push   %eax
80102c90:	ff 35 84 30 11 80    	pushl  0x80113084
80102c96:	e8 35 d4 ff ff       	call   801000d0 <bread>
80102c9b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c9d:	58                   	pop    %eax
80102c9e:	5a                   	pop    %edx
80102c9f:	ff 34 9d 8c 30 11 80 	pushl  -0x7feecf74(,%ebx,4)
80102ca6:	ff 35 84 30 11 80    	pushl  0x80113084
  for (tail = 0; tail < log.lh.n; tail++) {
80102cac:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102caf:	e8 1c d4 ff ff       	call   801000d0 <bread>
80102cb4:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102cb6:	8d 40 5c             	lea    0x5c(%eax),%eax
80102cb9:	83 c4 0c             	add    $0xc,%esp
80102cbc:	68 00 02 00 00       	push   $0x200
80102cc1:	50                   	push   %eax
80102cc2:	8d 46 5c             	lea    0x5c(%esi),%eax
80102cc5:	50                   	push   %eax
80102cc6:	e8 e5 19 00 00       	call   801046b0 <memmove>
    bwrite(to);  // write the log
80102ccb:	89 34 24             	mov    %esi,(%esp)
80102cce:	e8 cd d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102cd3:	89 3c 24             	mov    %edi,(%esp)
80102cd6:	e8 05 d5 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102cdb:	89 34 24             	mov    %esi,(%esp)
80102cde:	e8 fd d4 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102ce3:	83 c4 10             	add    $0x10,%esp
80102ce6:	3b 1d 88 30 11 80    	cmp    0x80113088,%ebx
80102cec:	7c 94                	jl     80102c82 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102cee:	e8 bd fd ff ff       	call   80102ab0 <write_head>
    install_trans(); // Now install writes to home locations
80102cf3:	e8 18 fd ff ff       	call   80102a10 <install_trans>
    log.lh.n = 0;
80102cf8:	c7 05 88 30 11 80 00 	movl   $0x0,0x80113088
80102cff:	00 00 00 
    write_head();    // Erase the transaction from the log
80102d02:	e8 a9 fd ff ff       	call   80102ab0 <write_head>
    acquire(&log.lock);
80102d07:	83 ec 0c             	sub    $0xc,%esp
80102d0a:	68 40 30 11 80       	push   $0x80113040
80102d0f:	e8 dc 17 00 00       	call   801044f0 <acquire>
    wakeup(&log);
80102d14:	c7 04 24 40 30 11 80 	movl   $0x80113040,(%esp)
    log.committing = 0;
80102d1b:	c7 05 80 30 11 80 00 	movl   $0x0,0x80113080
80102d22:	00 00 00 
    wakeup(&log);
80102d25:	e8 76 13 00 00       	call   801040a0 <wakeup>
    release(&log.lock);
80102d2a:	c7 04 24 40 30 11 80 	movl   $0x80113040,(%esp)
80102d31:	e8 7a 18 00 00       	call   801045b0 <release>
80102d36:	83 c4 10             	add    $0x10,%esp
}
80102d39:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d3c:	5b                   	pop    %ebx
80102d3d:	5e                   	pop    %esi
80102d3e:	5f                   	pop    %edi
80102d3f:	5d                   	pop    %ebp
80102d40:	c3                   	ret    
80102d41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102d48:	83 ec 0c             	sub    $0xc,%esp
80102d4b:	68 40 30 11 80       	push   $0x80113040
80102d50:	e8 4b 13 00 00       	call   801040a0 <wakeup>
  release(&log.lock);
80102d55:	c7 04 24 40 30 11 80 	movl   $0x80113040,(%esp)
80102d5c:	e8 4f 18 00 00       	call   801045b0 <release>
80102d61:	83 c4 10             	add    $0x10,%esp
}
80102d64:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d67:	5b                   	pop    %ebx
80102d68:	5e                   	pop    %esi
80102d69:	5f                   	pop    %edi
80102d6a:	5d                   	pop    %ebp
80102d6b:	c3                   	ret    
    panic("log.committing");
80102d6c:	83 ec 0c             	sub    $0xc,%esp
80102d6f:	68 24 77 10 80       	push   $0x80107724
80102d74:	e8 17 d6 ff ff       	call   80100390 <panic>
80102d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d80 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d80:	55                   	push   %ebp
80102d81:	89 e5                	mov    %esp,%ebp
80102d83:	53                   	push   %ebx
80102d84:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d87:	8b 15 88 30 11 80    	mov    0x80113088,%edx
{
80102d8d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d90:	83 fa 1d             	cmp    $0x1d,%edx
80102d93:	0f 8f 9d 00 00 00    	jg     80102e36 <log_write+0xb6>
80102d99:	a1 78 30 11 80       	mov    0x80113078,%eax
80102d9e:	83 e8 01             	sub    $0x1,%eax
80102da1:	39 c2                	cmp    %eax,%edx
80102da3:	0f 8d 8d 00 00 00    	jge    80102e36 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102da9:	a1 7c 30 11 80       	mov    0x8011307c,%eax
80102dae:	85 c0                	test   %eax,%eax
80102db0:	0f 8e 8d 00 00 00    	jle    80102e43 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102db6:	83 ec 0c             	sub    $0xc,%esp
80102db9:	68 40 30 11 80       	push   $0x80113040
80102dbe:	e8 2d 17 00 00       	call   801044f0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102dc3:	8b 0d 88 30 11 80    	mov    0x80113088,%ecx
80102dc9:	83 c4 10             	add    $0x10,%esp
80102dcc:	83 f9 00             	cmp    $0x0,%ecx
80102dcf:	7e 57                	jle    80102e28 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102dd1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102dd4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102dd6:	3b 15 8c 30 11 80    	cmp    0x8011308c,%edx
80102ddc:	75 0b                	jne    80102de9 <log_write+0x69>
80102dde:	eb 38                	jmp    80102e18 <log_write+0x98>
80102de0:	39 14 85 8c 30 11 80 	cmp    %edx,-0x7feecf74(,%eax,4)
80102de7:	74 2f                	je     80102e18 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102de9:	83 c0 01             	add    $0x1,%eax
80102dec:	39 c1                	cmp    %eax,%ecx
80102dee:	75 f0                	jne    80102de0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102df0:	89 14 85 8c 30 11 80 	mov    %edx,-0x7feecf74(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102df7:	83 c0 01             	add    $0x1,%eax
80102dfa:	a3 88 30 11 80       	mov    %eax,0x80113088
  b->flags |= B_DIRTY; // prevent eviction
80102dff:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102e02:	c7 45 08 40 30 11 80 	movl   $0x80113040,0x8(%ebp)
}
80102e09:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e0c:	c9                   	leave  
  release(&log.lock);
80102e0d:	e9 9e 17 00 00       	jmp    801045b0 <release>
80102e12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102e18:	89 14 85 8c 30 11 80 	mov    %edx,-0x7feecf74(,%eax,4)
80102e1f:	eb de                	jmp    80102dff <log_write+0x7f>
80102e21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e28:	8b 43 08             	mov    0x8(%ebx),%eax
80102e2b:	a3 8c 30 11 80       	mov    %eax,0x8011308c
  if (i == log.lh.n)
80102e30:	75 cd                	jne    80102dff <log_write+0x7f>
80102e32:	31 c0                	xor    %eax,%eax
80102e34:	eb c1                	jmp    80102df7 <log_write+0x77>
    panic("too big a transaction");
80102e36:	83 ec 0c             	sub    $0xc,%esp
80102e39:	68 33 77 10 80       	push   $0x80107733
80102e3e:	e8 4d d5 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102e43:	83 ec 0c             	sub    $0xc,%esp
80102e46:	68 49 77 10 80       	push   $0x80107749
80102e4b:	e8 40 d5 ff ff       	call   80100390 <panic>

80102e50 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102e50:	55                   	push   %ebp
80102e51:	89 e5                	mov    %esp,%ebp
80102e53:	53                   	push   %ebx
80102e54:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102e57:	e8 34 09 00 00       	call   80103790 <cpuid>
80102e5c:	89 c3                	mov    %eax,%ebx
80102e5e:	e8 2d 09 00 00       	call   80103790 <cpuid>
80102e63:	83 ec 04             	sub    $0x4,%esp
80102e66:	53                   	push   %ebx
80102e67:	50                   	push   %eax
80102e68:	68 64 77 10 80       	push   $0x80107764
80102e6d:	e8 ee d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e72:	e8 59 2a 00 00       	call   801058d0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e77:	e8 c4 08 00 00       	call   80103740 <mycpu>
80102e7c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e7e:	b8 01 00 00 00       	mov    $0x1,%eax
80102e83:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102e8a:	e8 21 0c 00 00       	call   80103ab0 <scheduler>
80102e8f:	90                   	nop

80102e90 <mpenter>:
{
80102e90:	55                   	push   %ebp
80102e91:	89 e5                	mov    %esp,%ebp
80102e93:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102e96:	e8 25 3b 00 00       	call   801069c0 <switchkvm>
  seginit();
80102e9b:	e8 90 3a 00 00       	call   80106930 <seginit>
  lapicinit();
80102ea0:	e8 9b f7 ff ff       	call   80102640 <lapicinit>
  mpmain();
80102ea5:	e8 a6 ff ff ff       	call   80102e50 <mpmain>
80102eaa:	66 90                	xchg   %ax,%ax
80102eac:	66 90                	xchg   %ax,%ax
80102eae:	66 90                	xchg   %ax,%ax

80102eb0 <main>:
{
80102eb0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102eb4:	83 e4 f0             	and    $0xfffffff0,%esp
80102eb7:	ff 71 fc             	pushl  -0x4(%ecx)
80102eba:	55                   	push   %ebp
80102ebb:	89 e5                	mov    %esp,%ebp
80102ebd:	53                   	push   %ebx
80102ebe:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102ebf:	83 ec 08             	sub    $0x8,%esp
80102ec2:	68 00 00 40 80       	push   $0x80400000
80102ec7:	68 88 5a 11 80       	push   $0x80115a88
80102ecc:	e8 2f f5 ff ff       	call   80102400 <kinit1>
  kvmalloc();      // kernel page table
80102ed1:	e8 ba 3f 00 00       	call   80106e90 <kvmalloc>
  mpinit();        // detect other processors
80102ed6:	e8 75 01 00 00       	call   80103050 <mpinit>
  lapicinit();     // interrupt controller
80102edb:	e8 60 f7 ff ff       	call   80102640 <lapicinit>
  seginit();       // segment descriptors
80102ee0:	e8 4b 3a 00 00       	call   80106930 <seginit>
  picinit();       // disable pic
80102ee5:	e8 36 03 00 00       	call   80103220 <picinit>
  ioapicinit();    // another interrupt controller
80102eea:	e8 41 f3 ff ff       	call   80102230 <ioapicinit>
  consoleinit();   // console hardware
80102eef:	e8 cc da ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102ef4:	e8 07 2d 00 00       	call   80105c00 <uartinit>
  pinit();         // process table
80102ef9:	e8 22 08 00 00       	call   80103720 <pinit>
  tvinit();        // trap vectors
80102efe:	e8 4d 29 00 00       	call   80105850 <tvinit>
  binit();         // buffer cache
80102f03:	e8 38 d1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102f08:	e8 53 de ff ff       	call   80100d60 <fileinit>
  ideinit();       // disk 
80102f0d:	e8 fe f0 ff ff       	call   80102010 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f12:	83 c4 0c             	add    $0xc,%esp
80102f15:	68 8a 00 00 00       	push   $0x8a
80102f1a:	68 90 a4 10 80       	push   $0x8010a490
80102f1f:	68 00 70 00 80       	push   $0x80007000
80102f24:	e8 87 17 00 00       	call   801046b0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f29:	69 05 f0 31 11 80 b0 	imul   $0xb0,0x801131f0,%eax
80102f30:	00 00 00 
80102f33:	83 c4 10             	add    $0x10,%esp
80102f36:	05 40 31 11 80       	add    $0x80113140,%eax
80102f3b:	3d 40 31 11 80       	cmp    $0x80113140,%eax
80102f40:	76 71                	jbe    80102fb3 <main+0x103>
80102f42:	bb 40 31 11 80       	mov    $0x80113140,%ebx
80102f47:	89 f6                	mov    %esi,%esi
80102f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80102f50:	e8 eb 07 00 00       	call   80103740 <mycpu>
80102f55:	39 d8                	cmp    %ebx,%eax
80102f57:	74 41                	je     80102f9a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102f59:	e8 72 f5 ff ff       	call   801024d0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f5e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80102f63:	c7 05 f8 6f 00 80 90 	movl   $0x80102e90,0x80006ff8
80102f6a:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f6d:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102f74:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f77:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
80102f7c:	0f b6 03             	movzbl (%ebx),%eax
80102f7f:	83 ec 08             	sub    $0x8,%esp
80102f82:	68 00 70 00 00       	push   $0x7000
80102f87:	50                   	push   %eax
80102f88:	e8 03 f8 ff ff       	call   80102790 <lapicstartap>
80102f8d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102f90:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102f96:	85 c0                	test   %eax,%eax
80102f98:	74 f6                	je     80102f90 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
80102f9a:	69 05 f0 31 11 80 b0 	imul   $0xb0,0x801131f0,%eax
80102fa1:	00 00 00 
80102fa4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102faa:	05 40 31 11 80       	add    $0x80113140,%eax
80102faf:	39 c3                	cmp    %eax,%ebx
80102fb1:	72 9d                	jb     80102f50 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102fb3:	83 ec 08             	sub    $0x8,%esp
80102fb6:	68 00 00 00 8e       	push   $0x8e000000
80102fbb:	68 00 00 40 80       	push   $0x80400000
80102fc0:	e8 ab f4 ff ff       	call   80102470 <kinit2>
  userinit();      // first user process
80102fc5:	e8 16 08 00 00       	call   801037e0 <userinit>
  mpmain();        // finish this processor's setup
80102fca:	e8 81 fe ff ff       	call   80102e50 <mpmain>
80102fcf:	90                   	nop

80102fd0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fd0:	55                   	push   %ebp
80102fd1:	89 e5                	mov    %esp,%ebp
80102fd3:	57                   	push   %edi
80102fd4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102fd5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80102fdb:	53                   	push   %ebx
  e = addr+len;
80102fdc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80102fdf:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80102fe2:	39 de                	cmp    %ebx,%esi
80102fe4:	72 10                	jb     80102ff6 <mpsearch1+0x26>
80102fe6:	eb 50                	jmp    80103038 <mpsearch1+0x68>
80102fe8:	90                   	nop
80102fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ff0:	39 fb                	cmp    %edi,%ebx
80102ff2:	89 fe                	mov    %edi,%esi
80102ff4:	76 42                	jbe    80103038 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102ff6:	83 ec 04             	sub    $0x4,%esp
80102ff9:	8d 7e 10             	lea    0x10(%esi),%edi
80102ffc:	6a 04                	push   $0x4
80102ffe:	68 78 77 10 80       	push   $0x80107778
80103003:	56                   	push   %esi
80103004:	e8 47 16 00 00       	call   80104650 <memcmp>
80103009:	83 c4 10             	add    $0x10,%esp
8010300c:	85 c0                	test   %eax,%eax
8010300e:	75 e0                	jne    80102ff0 <mpsearch1+0x20>
80103010:	89 f1                	mov    %esi,%ecx
80103012:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103018:	0f b6 11             	movzbl (%ecx),%edx
8010301b:	83 c1 01             	add    $0x1,%ecx
8010301e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103020:	39 f9                	cmp    %edi,%ecx
80103022:	75 f4                	jne    80103018 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103024:	84 c0                	test   %al,%al
80103026:	75 c8                	jne    80102ff0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103028:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010302b:	89 f0                	mov    %esi,%eax
8010302d:	5b                   	pop    %ebx
8010302e:	5e                   	pop    %esi
8010302f:	5f                   	pop    %edi
80103030:	5d                   	pop    %ebp
80103031:	c3                   	ret    
80103032:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103038:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010303b:	31 f6                	xor    %esi,%esi
}
8010303d:	89 f0                	mov    %esi,%eax
8010303f:	5b                   	pop    %ebx
80103040:	5e                   	pop    %esi
80103041:	5f                   	pop    %edi
80103042:	5d                   	pop    %ebp
80103043:	c3                   	ret    
80103044:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010304a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103050 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103050:	55                   	push   %ebp
80103051:	89 e5                	mov    %esp,%ebp
80103053:	57                   	push   %edi
80103054:	56                   	push   %esi
80103055:	53                   	push   %ebx
80103056:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103059:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103060:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103067:	c1 e0 08             	shl    $0x8,%eax
8010306a:	09 d0                	or     %edx,%eax
8010306c:	c1 e0 04             	shl    $0x4,%eax
8010306f:	85 c0                	test   %eax,%eax
80103071:	75 1b                	jne    8010308e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103073:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010307a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103081:	c1 e0 08             	shl    $0x8,%eax
80103084:	09 d0                	or     %edx,%eax
80103086:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103089:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010308e:	ba 00 04 00 00       	mov    $0x400,%edx
80103093:	e8 38 ff ff ff       	call   80102fd0 <mpsearch1>
80103098:	85 c0                	test   %eax,%eax
8010309a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010309d:	0f 84 35 01 00 00    	je     801031d8 <mpinit+0x188>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801030a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801030a6:	8b 58 04             	mov    0x4(%eax),%ebx
801030a9:	85 db                	test   %ebx,%ebx
801030ab:	0f 84 47 01 00 00    	je     801031f8 <mpinit+0x1a8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801030b1:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
801030b7:	83 ec 04             	sub    $0x4,%esp
801030ba:	6a 04                	push   $0x4
801030bc:	68 95 77 10 80       	push   $0x80107795
801030c1:	56                   	push   %esi
801030c2:	e8 89 15 00 00       	call   80104650 <memcmp>
801030c7:	83 c4 10             	add    $0x10,%esp
801030ca:	85 c0                	test   %eax,%eax
801030cc:	0f 85 26 01 00 00    	jne    801031f8 <mpinit+0x1a8>
  if(conf->version != 1 && conf->version != 4)
801030d2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801030d9:	3c 01                	cmp    $0x1,%al
801030db:	0f 95 c2             	setne  %dl
801030de:	3c 04                	cmp    $0x4,%al
801030e0:	0f 95 c0             	setne  %al
801030e3:	20 c2                	and    %al,%dl
801030e5:	0f 85 0d 01 00 00    	jne    801031f8 <mpinit+0x1a8>
  if(sum((uchar*)conf, conf->length) != 0)
801030eb:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
801030f2:	66 85 ff             	test   %di,%di
801030f5:	74 1a                	je     80103111 <mpinit+0xc1>
801030f7:	89 f0                	mov    %esi,%eax
801030f9:	01 f7                	add    %esi,%edi
  sum = 0;
801030fb:	31 d2                	xor    %edx,%edx
801030fd:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103100:	0f b6 08             	movzbl (%eax),%ecx
80103103:	83 c0 01             	add    $0x1,%eax
80103106:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103108:	39 c7                	cmp    %eax,%edi
8010310a:	75 f4                	jne    80103100 <mpinit+0xb0>
8010310c:	84 d2                	test   %dl,%dl
8010310e:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103111:	85 f6                	test   %esi,%esi
80103113:	0f 84 df 00 00 00    	je     801031f8 <mpinit+0x1a8>
80103119:	84 d2                	test   %dl,%dl
8010311b:	0f 85 d7 00 00 00    	jne    801031f8 <mpinit+0x1a8>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103121:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103127:	a3 3c 30 11 80       	mov    %eax,0x8011303c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010312c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103133:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103139:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010313e:	01 d6                	add    %edx,%esi
80103140:	39 c6                	cmp    %eax,%esi
80103142:	76 23                	jbe    80103167 <mpinit+0x117>
    switch(*p){
80103144:	0f b6 10             	movzbl (%eax),%edx
80103147:	80 fa 04             	cmp    $0x4,%dl
8010314a:	0f 87 c2 00 00 00    	ja     80103212 <mpinit+0x1c2>
80103150:	ff 24 95 bc 77 10 80 	jmp    *-0x7fef8844(,%edx,4)
80103157:	89 f6                	mov    %esi,%esi
80103159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103160:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103163:	39 c6                	cmp    %eax,%esi
80103165:	77 dd                	ja     80103144 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103167:	85 db                	test   %ebx,%ebx
80103169:	0f 84 96 00 00 00    	je     80103205 <mpinit+0x1b5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010316f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103172:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103176:	74 15                	je     8010318d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103178:	b8 70 00 00 00       	mov    $0x70,%eax
8010317d:	ba 22 00 00 00       	mov    $0x22,%edx
80103182:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103183:	ba 23 00 00 00       	mov    $0x23,%edx
80103188:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103189:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010318c:	ee                   	out    %al,(%dx)
  }
}
8010318d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103190:	5b                   	pop    %ebx
80103191:	5e                   	pop    %esi
80103192:	5f                   	pop    %edi
80103193:	5d                   	pop    %ebp
80103194:	c3                   	ret    
80103195:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103198:	8b 0d f0 31 11 80    	mov    0x801131f0,%ecx
8010319e:	85 c9                	test   %ecx,%ecx
801031a0:	7f 19                	jg     801031bb <mpinit+0x16b>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031a2:	0f b6 50 01          	movzbl 0x1(%eax),%edx
801031a6:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
801031ac:	83 c1 01             	add    $0x1,%ecx
801031af:	89 0d f0 31 11 80    	mov    %ecx,0x801131f0
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031b5:	88 97 40 31 11 80    	mov    %dl,-0x7feecec0(%edi)
      p += sizeof(struct mpproc);
801031bb:	83 c0 14             	add    $0x14,%eax
      continue;
801031be:	eb 80                	jmp    80103140 <mpinit+0xf0>
      ioapicid = ioapic->apicno;
801031c0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801031c4:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801031c7:	88 15 20 31 11 80    	mov    %dl,0x80113120
      continue;
801031cd:	e9 6e ff ff ff       	jmp    80103140 <mpinit+0xf0>
801031d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
801031d8:	ba 00 00 01 00       	mov    $0x10000,%edx
801031dd:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801031e2:	e8 e9 fd ff ff       	call   80102fd0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031e7:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
801031e9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031ec:	0f 85 b1 fe ff ff    	jne    801030a3 <mpinit+0x53>
801031f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
801031f8:	83 ec 0c             	sub    $0xc,%esp
801031fb:	68 7d 77 10 80       	push   $0x8010777d
80103200:	e8 8b d1 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
80103205:	83 ec 0c             	sub    $0xc,%esp
80103208:	68 9c 77 10 80       	push   $0x8010779c
8010320d:	e8 7e d1 ff ff       	call   80100390 <panic>
      ismp = 0;
80103212:	31 db                	xor    %ebx,%ebx
80103214:	e9 2e ff ff ff       	jmp    80103147 <mpinit+0xf7>
80103219:	66 90                	xchg   %ax,%ax
8010321b:	66 90                	xchg   %ax,%ax
8010321d:	66 90                	xchg   %ax,%ax
8010321f:	90                   	nop

80103220 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103220:	55                   	push   %ebp
80103221:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103226:	ba 21 00 00 00       	mov    $0x21,%edx
8010322b:	89 e5                	mov    %esp,%ebp
8010322d:	ee                   	out    %al,(%dx)
8010322e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103233:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103234:	5d                   	pop    %ebp
80103235:	c3                   	ret    
80103236:	66 90                	xchg   %ax,%ax
80103238:	66 90                	xchg   %ax,%ax
8010323a:	66 90                	xchg   %ax,%ax
8010323c:	66 90                	xchg   %ax,%ax
8010323e:	66 90                	xchg   %ax,%ax

80103240 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103240:	55                   	push   %ebp
80103241:	89 e5                	mov    %esp,%ebp
80103243:	57                   	push   %edi
80103244:	56                   	push   %esi
80103245:	53                   	push   %ebx
80103246:	83 ec 0c             	sub    $0xc,%esp
80103249:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010324c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010324f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103255:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010325b:	e8 20 db ff ff       	call   80100d80 <filealloc>
80103260:	85 c0                	test   %eax,%eax
80103262:	89 03                	mov    %eax,(%ebx)
80103264:	74 22                	je     80103288 <pipealloc+0x48>
80103266:	e8 15 db ff ff       	call   80100d80 <filealloc>
8010326b:	85 c0                	test   %eax,%eax
8010326d:	89 06                	mov    %eax,(%esi)
8010326f:	74 3f                	je     801032b0 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103271:	e8 5a f2 ff ff       	call   801024d0 <kalloc>
80103276:	85 c0                	test   %eax,%eax
80103278:	89 c7                	mov    %eax,%edi
8010327a:	75 54                	jne    801032d0 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010327c:	8b 03                	mov    (%ebx),%eax
8010327e:	85 c0                	test   %eax,%eax
80103280:	75 34                	jne    801032b6 <pipealloc+0x76>
80103282:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103288:	8b 06                	mov    (%esi),%eax
8010328a:	85 c0                	test   %eax,%eax
8010328c:	74 0c                	je     8010329a <pipealloc+0x5a>
    fileclose(*f1);
8010328e:	83 ec 0c             	sub    $0xc,%esp
80103291:	50                   	push   %eax
80103292:	e8 a9 db ff ff       	call   80100e40 <fileclose>
80103297:	83 c4 10             	add    $0x10,%esp
  return -1;
}
8010329a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010329d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801032a2:	5b                   	pop    %ebx
801032a3:	5e                   	pop    %esi
801032a4:	5f                   	pop    %edi
801032a5:	5d                   	pop    %ebp
801032a6:	c3                   	ret    
801032a7:	89 f6                	mov    %esi,%esi
801032a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
801032b0:	8b 03                	mov    (%ebx),%eax
801032b2:	85 c0                	test   %eax,%eax
801032b4:	74 e4                	je     8010329a <pipealloc+0x5a>
    fileclose(*f0);
801032b6:	83 ec 0c             	sub    $0xc,%esp
801032b9:	50                   	push   %eax
801032ba:	e8 81 db ff ff       	call   80100e40 <fileclose>
  if(*f1)
801032bf:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
801032c1:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801032c4:	85 c0                	test   %eax,%eax
801032c6:	75 c6                	jne    8010328e <pipealloc+0x4e>
801032c8:	eb d0                	jmp    8010329a <pipealloc+0x5a>
801032ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
801032d0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801032d3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801032da:	00 00 00 
  p->writeopen = 1;
801032dd:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801032e4:	00 00 00 
  p->nwrite = 0;
801032e7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801032ee:	00 00 00 
  p->nread = 0;
801032f1:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801032f8:	00 00 00 
  initlock(&p->lock, "pipe");
801032fb:	68 d0 77 10 80       	push   $0x801077d0
80103300:	50                   	push   %eax
80103301:	e8 aa 10 00 00       	call   801043b0 <initlock>
  (*f0)->type = FD_PIPE;
80103306:	8b 03                	mov    (%ebx),%eax
  return 0;
80103308:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010330b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103311:	8b 03                	mov    (%ebx),%eax
80103313:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103317:	8b 03                	mov    (%ebx),%eax
80103319:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010331d:	8b 03                	mov    (%ebx),%eax
8010331f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103322:	8b 06                	mov    (%esi),%eax
80103324:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010332a:	8b 06                	mov    (%esi),%eax
8010332c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103330:	8b 06                	mov    (%esi),%eax
80103332:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103336:	8b 06                	mov    (%esi),%eax
80103338:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010333b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010333e:	31 c0                	xor    %eax,%eax
}
80103340:	5b                   	pop    %ebx
80103341:	5e                   	pop    %esi
80103342:	5f                   	pop    %edi
80103343:	5d                   	pop    %ebp
80103344:	c3                   	ret    
80103345:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103350 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103350:	55                   	push   %ebp
80103351:	89 e5                	mov    %esp,%ebp
80103353:	56                   	push   %esi
80103354:	53                   	push   %ebx
80103355:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103358:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010335b:	83 ec 0c             	sub    $0xc,%esp
8010335e:	53                   	push   %ebx
8010335f:	e8 8c 11 00 00       	call   801044f0 <acquire>
  if(writable){
80103364:	83 c4 10             	add    $0x10,%esp
80103367:	85 f6                	test   %esi,%esi
80103369:	74 45                	je     801033b0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010336b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103371:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103374:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010337b:	00 00 00 
    wakeup(&p->nread);
8010337e:	50                   	push   %eax
8010337f:	e8 1c 0d 00 00       	call   801040a0 <wakeup>
80103384:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103387:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010338d:	85 d2                	test   %edx,%edx
8010338f:	75 0a                	jne    8010339b <pipeclose+0x4b>
80103391:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103397:	85 c0                	test   %eax,%eax
80103399:	74 35                	je     801033d0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010339b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010339e:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033a1:	5b                   	pop    %ebx
801033a2:	5e                   	pop    %esi
801033a3:	5d                   	pop    %ebp
    release(&p->lock);
801033a4:	e9 07 12 00 00       	jmp    801045b0 <release>
801033a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801033b0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801033b6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
801033b9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801033c0:	00 00 00 
    wakeup(&p->nwrite);
801033c3:	50                   	push   %eax
801033c4:	e8 d7 0c 00 00       	call   801040a0 <wakeup>
801033c9:	83 c4 10             	add    $0x10,%esp
801033cc:	eb b9                	jmp    80103387 <pipeclose+0x37>
801033ce:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801033d0:	83 ec 0c             	sub    $0xc,%esp
801033d3:	53                   	push   %ebx
801033d4:	e8 d7 11 00 00       	call   801045b0 <release>
    kfree((char*)p);
801033d9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801033dc:	83 c4 10             	add    $0x10,%esp
}
801033df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033e2:	5b                   	pop    %ebx
801033e3:	5e                   	pop    %esi
801033e4:	5d                   	pop    %ebp
    kfree((char*)p);
801033e5:	e9 36 ef ff ff       	jmp    80102320 <kfree>
801033ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801033f0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801033f0:	55                   	push   %ebp
801033f1:	89 e5                	mov    %esp,%ebp
801033f3:	57                   	push   %edi
801033f4:	56                   	push   %esi
801033f5:	53                   	push   %ebx
801033f6:	83 ec 28             	sub    $0x28,%esp
801033f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801033fc:	53                   	push   %ebx
801033fd:	e8 ee 10 00 00       	call   801044f0 <acquire>
  for(i = 0; i < n; i++){
80103402:	8b 45 10             	mov    0x10(%ebp),%eax
80103405:	83 c4 10             	add    $0x10,%esp
80103408:	85 c0                	test   %eax,%eax
8010340a:	0f 8e c9 00 00 00    	jle    801034d9 <pipewrite+0xe9>
80103410:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103413:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103419:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010341f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103422:	03 4d 10             	add    0x10(%ebp),%ecx
80103425:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103428:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010342e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103434:	39 d0                	cmp    %edx,%eax
80103436:	75 71                	jne    801034a9 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103438:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010343e:	85 c0                	test   %eax,%eax
80103440:	74 4e                	je     80103490 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103442:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103448:	eb 3a                	jmp    80103484 <pipewrite+0x94>
8010344a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103450:	83 ec 0c             	sub    $0xc,%esp
80103453:	57                   	push   %edi
80103454:	e8 47 0c 00 00       	call   801040a0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103459:	5a                   	pop    %edx
8010345a:	59                   	pop    %ecx
8010345b:	53                   	push   %ebx
8010345c:	56                   	push   %esi
8010345d:	e8 8e 0a 00 00       	call   80103ef0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103462:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103468:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010346e:	83 c4 10             	add    $0x10,%esp
80103471:	05 00 02 00 00       	add    $0x200,%eax
80103476:	39 c2                	cmp    %eax,%edx
80103478:	75 36                	jne    801034b0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010347a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103480:	85 c0                	test   %eax,%eax
80103482:	74 0c                	je     80103490 <pipewrite+0xa0>
80103484:	e8 27 03 00 00       	call   801037b0 <myproc>
80103489:	8b 40 24             	mov    0x24(%eax),%eax
8010348c:	85 c0                	test   %eax,%eax
8010348e:	74 c0                	je     80103450 <pipewrite+0x60>
        release(&p->lock);
80103490:	83 ec 0c             	sub    $0xc,%esp
80103493:	53                   	push   %ebx
80103494:	e8 17 11 00 00       	call   801045b0 <release>
        return -1;
80103499:	83 c4 10             	add    $0x10,%esp
8010349c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801034a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034a4:	5b                   	pop    %ebx
801034a5:	5e                   	pop    %esi
801034a6:	5f                   	pop    %edi
801034a7:	5d                   	pop    %ebp
801034a8:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034a9:	89 c2                	mov    %eax,%edx
801034ab:	90                   	nop
801034ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034b0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801034b3:	8d 42 01             	lea    0x1(%edx),%eax
801034b6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801034bc:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801034c2:	83 c6 01             	add    $0x1,%esi
801034c5:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
801034c9:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801034cc:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034cf:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801034d3:	0f 85 4f ff ff ff    	jne    80103428 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801034d9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801034df:	83 ec 0c             	sub    $0xc,%esp
801034e2:	50                   	push   %eax
801034e3:	e8 b8 0b 00 00       	call   801040a0 <wakeup>
  release(&p->lock);
801034e8:	89 1c 24             	mov    %ebx,(%esp)
801034eb:	e8 c0 10 00 00       	call   801045b0 <release>
  return n;
801034f0:	83 c4 10             	add    $0x10,%esp
801034f3:	8b 45 10             	mov    0x10(%ebp),%eax
801034f6:	eb a9                	jmp    801034a1 <pipewrite+0xb1>
801034f8:	90                   	nop
801034f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103500 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103500:	55                   	push   %ebp
80103501:	89 e5                	mov    %esp,%ebp
80103503:	57                   	push   %edi
80103504:	56                   	push   %esi
80103505:	53                   	push   %ebx
80103506:	83 ec 18             	sub    $0x18,%esp
80103509:	8b 75 08             	mov    0x8(%ebp),%esi
8010350c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010350f:	56                   	push   %esi
80103510:	e8 db 0f 00 00       	call   801044f0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103515:	83 c4 10             	add    $0x10,%esp
80103518:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010351e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103524:	75 6a                	jne    80103590 <piperead+0x90>
80103526:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010352c:	85 db                	test   %ebx,%ebx
8010352e:	0f 84 c4 00 00 00    	je     801035f8 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103534:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010353a:	eb 2d                	jmp    80103569 <piperead+0x69>
8010353c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103540:	83 ec 08             	sub    $0x8,%esp
80103543:	56                   	push   %esi
80103544:	53                   	push   %ebx
80103545:	e8 a6 09 00 00       	call   80103ef0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010354a:	83 c4 10             	add    $0x10,%esp
8010354d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103553:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103559:	75 35                	jne    80103590 <piperead+0x90>
8010355b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103561:	85 d2                	test   %edx,%edx
80103563:	0f 84 8f 00 00 00    	je     801035f8 <piperead+0xf8>
    if(myproc()->killed){
80103569:	e8 42 02 00 00       	call   801037b0 <myproc>
8010356e:	8b 48 24             	mov    0x24(%eax),%ecx
80103571:	85 c9                	test   %ecx,%ecx
80103573:	74 cb                	je     80103540 <piperead+0x40>
      release(&p->lock);
80103575:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103578:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010357d:	56                   	push   %esi
8010357e:	e8 2d 10 00 00       	call   801045b0 <release>
      return -1;
80103583:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103586:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103589:	89 d8                	mov    %ebx,%eax
8010358b:	5b                   	pop    %ebx
8010358c:	5e                   	pop    %esi
8010358d:	5f                   	pop    %edi
8010358e:	5d                   	pop    %ebp
8010358f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103590:	8b 45 10             	mov    0x10(%ebp),%eax
80103593:	85 c0                	test   %eax,%eax
80103595:	7e 61                	jle    801035f8 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103597:	31 db                	xor    %ebx,%ebx
80103599:	eb 13                	jmp    801035ae <piperead+0xae>
8010359b:	90                   	nop
8010359c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035a0:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801035a6:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801035ac:	74 1f                	je     801035cd <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
801035ae:	8d 41 01             	lea    0x1(%ecx),%eax
801035b1:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801035b7:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
801035bd:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
801035c2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035c5:	83 c3 01             	add    $0x1,%ebx
801035c8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801035cb:	75 d3                	jne    801035a0 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801035cd:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801035d3:	83 ec 0c             	sub    $0xc,%esp
801035d6:	50                   	push   %eax
801035d7:	e8 c4 0a 00 00       	call   801040a0 <wakeup>
  release(&p->lock);
801035dc:	89 34 24             	mov    %esi,(%esp)
801035df:	e8 cc 0f 00 00       	call   801045b0 <release>
  return i;
801035e4:	83 c4 10             	add    $0x10,%esp
}
801035e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035ea:	89 d8                	mov    %ebx,%eax
801035ec:	5b                   	pop    %ebx
801035ed:	5e                   	pop    %esi
801035ee:	5f                   	pop    %edi
801035ef:	5d                   	pop    %ebp
801035f0:	c3                   	ret    
801035f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035f8:	31 db                	xor    %ebx,%ebx
801035fa:	eb d1                	jmp    801035cd <piperead+0xcd>
801035fc:	66 90                	xchg   %ax,%ax
801035fe:	66 90                	xchg   %ax,%ax

80103600 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103600:	55                   	push   %ebp
80103601:	89 e5                	mov    %esp,%ebp
80103603:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103604:	bb 34 32 11 80       	mov    $0x80113234,%ebx
{
80103609:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010360c:	68 00 32 11 80       	push   $0x80113200
80103611:	e8 da 0e 00 00       	call   801044f0 <acquire>
80103616:	83 c4 10             	add    $0x10,%esp
80103619:	eb 10                	jmp    8010362b <allocproc+0x2b>
8010361b:	90                   	nop
8010361c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103620:	83 eb 80             	sub    $0xffffff80,%ebx
80103623:	81 fb 34 52 11 80    	cmp    $0x80115234,%ebx
80103629:	73 75                	jae    801036a0 <allocproc+0xa0>
    if(p->state == UNUSED)
8010362b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010362e:	85 c0                	test   %eax,%eax
80103630:	75 ee                	jne    80103620 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103632:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
80103637:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
8010363a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103641:	8d 50 01             	lea    0x1(%eax),%edx
80103644:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103647:	68 00 32 11 80       	push   $0x80113200
  p->pid = nextpid++;
8010364c:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
80103652:	e8 59 0f 00 00       	call   801045b0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103657:	e8 74 ee ff ff       	call   801024d0 <kalloc>
8010365c:	83 c4 10             	add    $0x10,%esp
8010365f:	85 c0                	test   %eax,%eax
80103661:	89 43 08             	mov    %eax,0x8(%ebx)
80103664:	74 53                	je     801036b9 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103666:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010366c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010366f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103674:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103677:	c7 40 14 3e 58 10 80 	movl   $0x8010583e,0x14(%eax)
  p->context = (struct context*)sp;
8010367e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103681:	6a 14                	push   $0x14
80103683:	6a 00                	push   $0x0
80103685:	50                   	push   %eax
80103686:	e8 75 0f 00 00       	call   80104600 <memset>
  p->context->eip = (uint)forkret;
8010368b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010368e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103691:	c7 40 10 d0 36 10 80 	movl   $0x801036d0,0x10(%eax)
}
80103698:	89 d8                	mov    %ebx,%eax
8010369a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010369d:	c9                   	leave  
8010369e:	c3                   	ret    
8010369f:	90                   	nop
  release(&ptable.lock);
801036a0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801036a3:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801036a5:	68 00 32 11 80       	push   $0x80113200
801036aa:	e8 01 0f 00 00       	call   801045b0 <release>
}
801036af:	89 d8                	mov    %ebx,%eax
  return 0;
801036b1:	83 c4 10             	add    $0x10,%esp
}
801036b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801036b7:	c9                   	leave  
801036b8:	c3                   	ret    
    p->state = UNUSED;
801036b9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801036c0:	31 db                	xor    %ebx,%ebx
801036c2:	eb d4                	jmp    80103698 <allocproc+0x98>
801036c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801036ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801036d0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801036d0:	55                   	push   %ebp
801036d1:	89 e5                	mov    %esp,%ebp
801036d3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801036d6:	68 00 32 11 80       	push   $0x80113200
801036db:	e8 d0 0e 00 00       	call   801045b0 <release>

  if (first) {
801036e0:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801036e5:	83 c4 10             	add    $0x10,%esp
801036e8:	85 c0                	test   %eax,%eax
801036ea:	75 04                	jne    801036f0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801036ec:	c9                   	leave  
801036ed:	c3                   	ret    
801036ee:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
801036f0:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
801036f3:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
801036fa:	00 00 00 
    iinit(ROOTDEV);
801036fd:	6a 01                	push   $0x1
801036ff:	e8 8c dd ff ff       	call   80101490 <iinit>
    initlog(ROOTDEV);
80103704:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010370b:	e8 00 f4 ff ff       	call   80102b10 <initlog>
80103710:	83 c4 10             	add    $0x10,%esp
}
80103713:	c9                   	leave  
80103714:	c3                   	ret    
80103715:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103720 <pinit>:
{
80103720:	55                   	push   %ebp
80103721:	89 e5                	mov    %esp,%ebp
80103723:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103726:	68 d5 77 10 80       	push   $0x801077d5
8010372b:	68 00 32 11 80       	push   $0x80113200
80103730:	e8 7b 0c 00 00       	call   801043b0 <initlock>
}
80103735:	83 c4 10             	add    $0x10,%esp
80103738:	c9                   	leave  
80103739:	c3                   	ret    
8010373a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103740 <mycpu>:
{
80103740:	55                   	push   %ebp
80103741:	89 e5                	mov    %esp,%ebp
80103743:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103746:	9c                   	pushf  
80103747:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103748:	f6 c4 02             	test   $0x2,%ah
8010374b:	75 32                	jne    8010377f <mycpu+0x3f>
  apicid = lapicid();
8010374d:	e8 ee ef ff ff       	call   80102740 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103752:	8b 15 f0 31 11 80    	mov    0x801131f0,%edx
80103758:	85 d2                	test   %edx,%edx
8010375a:	7e 0b                	jle    80103767 <mycpu+0x27>
    if (cpus[i].apicid == apicid)
8010375c:	0f b6 15 40 31 11 80 	movzbl 0x80113140,%edx
80103763:	39 d0                	cmp    %edx,%eax
80103765:	74 11                	je     80103778 <mycpu+0x38>
  panic("unknown apicid\n");
80103767:	83 ec 0c             	sub    $0xc,%esp
8010376a:	68 dc 77 10 80       	push   $0x801077dc
8010376f:	e8 1c cc ff ff       	call   80100390 <panic>
80103774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80103778:	b8 40 31 11 80       	mov    $0x80113140,%eax
8010377d:	c9                   	leave  
8010377e:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
8010377f:	83 ec 0c             	sub    $0xc,%esp
80103782:	68 c4 78 10 80       	push   $0x801078c4
80103787:	e8 04 cc ff ff       	call   80100390 <panic>
8010378c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103790 <cpuid>:
cpuid() {
80103790:	55                   	push   %ebp
80103791:	89 e5                	mov    %esp,%ebp
80103793:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103796:	e8 a5 ff ff ff       	call   80103740 <mycpu>
8010379b:	2d 40 31 11 80       	sub    $0x80113140,%eax
}
801037a0:	c9                   	leave  
  return mycpu()-cpus;
801037a1:	c1 f8 04             	sar    $0x4,%eax
801037a4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801037aa:	c3                   	ret    
801037ab:	90                   	nop
801037ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801037b0 <myproc>:
myproc(void) {
801037b0:	55                   	push   %ebp
801037b1:	89 e5                	mov    %esp,%ebp
801037b3:	53                   	push   %ebx
801037b4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801037b7:	e8 64 0c 00 00       	call   80104420 <pushcli>
  c = mycpu();
801037bc:	e8 7f ff ff ff       	call   80103740 <mycpu>
  p = c->proc;
801037c1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801037c7:	e8 94 0c 00 00       	call   80104460 <popcli>
}
801037cc:	83 c4 04             	add    $0x4,%esp
801037cf:	89 d8                	mov    %ebx,%eax
801037d1:	5b                   	pop    %ebx
801037d2:	5d                   	pop    %ebp
801037d3:	c3                   	ret    
801037d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801037da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801037e0 <userinit>:
{
801037e0:	55                   	push   %ebp
801037e1:	89 e5                	mov    %esp,%ebp
801037e3:	53                   	push   %ebx
801037e4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
801037e7:	e8 14 fe ff ff       	call   80103600 <allocproc>
801037ec:	89 c3                	mov    %eax,%ebx
  initproc = p;
801037ee:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
801037f3:	e8 18 36 00 00       	call   80106e10 <setupkvm>
801037f8:	85 c0                	test   %eax,%eax
801037fa:	89 43 04             	mov    %eax,0x4(%ebx)
801037fd:	0f 84 bd 00 00 00    	je     801038c0 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103803:	83 ec 04             	sub    $0x4,%esp
80103806:	68 2c 00 00 00       	push   $0x2c
8010380b:	68 64 a4 10 80       	push   $0x8010a464
80103810:	50                   	push   %eax
80103811:	e8 da 32 00 00       	call   80106af0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103816:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103819:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010381f:	6a 4c                	push   $0x4c
80103821:	6a 00                	push   $0x0
80103823:	ff 73 18             	pushl  0x18(%ebx)
80103826:	e8 d5 0d 00 00       	call   80104600 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010382b:	8b 43 18             	mov    0x18(%ebx),%eax
8010382e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103833:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103838:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010383b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010383f:	8b 43 18             	mov    0x18(%ebx),%eax
80103842:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103846:	8b 43 18             	mov    0x18(%ebx),%eax
80103849:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010384d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103851:	8b 43 18             	mov    0x18(%ebx),%eax
80103854:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103858:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010385c:	8b 43 18             	mov    0x18(%ebx),%eax
8010385f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103866:	8b 43 18             	mov    0x18(%ebx),%eax
80103869:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103870:	8b 43 18             	mov    0x18(%ebx),%eax
80103873:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010387a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010387d:	6a 10                	push   $0x10
8010387f:	68 05 78 10 80       	push   $0x80107805
80103884:	50                   	push   %eax
80103885:	e8 56 0f 00 00       	call   801047e0 <safestrcpy>
  p->cwd = namei("/");
8010388a:	c7 04 24 0e 78 10 80 	movl   $0x8010780e,(%esp)
80103891:	e8 5a e6 ff ff       	call   80101ef0 <namei>
80103896:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103899:	c7 04 24 00 32 11 80 	movl   $0x80113200,(%esp)
801038a0:	e8 4b 0c 00 00       	call   801044f0 <acquire>
  p->state = RUNNABLE;
801038a5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
801038ac:	c7 04 24 00 32 11 80 	movl   $0x80113200,(%esp)
801038b3:	e8 f8 0c 00 00       	call   801045b0 <release>
}
801038b8:	83 c4 10             	add    $0x10,%esp
801038bb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801038be:	c9                   	leave  
801038bf:	c3                   	ret    
    panic("userinit: out of memory?");
801038c0:	83 ec 0c             	sub    $0xc,%esp
801038c3:	68 ec 77 10 80       	push   $0x801077ec
801038c8:	e8 c3 ca ff ff       	call   80100390 <panic>
801038cd:	8d 76 00             	lea    0x0(%esi),%esi

801038d0 <growproc>:
{
801038d0:	55                   	push   %ebp
801038d1:	89 e5                	mov    %esp,%ebp
801038d3:	56                   	push   %esi
801038d4:	53                   	push   %ebx
801038d5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801038d8:	e8 43 0b 00 00       	call   80104420 <pushcli>
  c = mycpu();
801038dd:	e8 5e fe ff ff       	call   80103740 <mycpu>
  p = c->proc;
801038e2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801038e8:	e8 73 0b 00 00       	call   80104460 <popcli>
  if(n > 0){
801038ed:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
801038f0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
801038f2:	7f 1c                	jg     80103910 <growproc+0x40>
  } else if(n < 0){
801038f4:	75 3a                	jne    80103930 <growproc+0x60>
  switchuvm(curproc);
801038f6:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
801038f9:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801038fb:	53                   	push   %ebx
801038fc:	e8 df 30 00 00       	call   801069e0 <switchuvm>
  return 0;
80103901:	83 c4 10             	add    $0x10,%esp
80103904:	31 c0                	xor    %eax,%eax
}
80103906:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103909:	5b                   	pop    %ebx
8010390a:	5e                   	pop    %esi
8010390b:	5d                   	pop    %ebp
8010390c:	c3                   	ret    
8010390d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103910:	83 ec 04             	sub    $0x4,%esp
80103913:	01 c6                	add    %eax,%esi
80103915:	56                   	push   %esi
80103916:	50                   	push   %eax
80103917:	ff 73 04             	pushl  0x4(%ebx)
8010391a:	e8 11 33 00 00       	call   80106c30 <allocuvm>
8010391f:	83 c4 10             	add    $0x10,%esp
80103922:	85 c0                	test   %eax,%eax
80103924:	75 d0                	jne    801038f6 <growproc+0x26>
      return -1;
80103926:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010392b:	eb d9                	jmp    80103906 <growproc+0x36>
8010392d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103930:	83 ec 04             	sub    $0x4,%esp
80103933:	01 c6                	add    %eax,%esi
80103935:	56                   	push   %esi
80103936:	50                   	push   %eax
80103937:	ff 73 04             	pushl  0x4(%ebx)
8010393a:	e8 21 34 00 00       	call   80106d60 <deallocuvm>
8010393f:	83 c4 10             	add    $0x10,%esp
80103942:	85 c0                	test   %eax,%eax
80103944:	75 b0                	jne    801038f6 <growproc+0x26>
80103946:	eb de                	jmp    80103926 <growproc+0x56>
80103948:	90                   	nop
80103949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103950 <fork>:
{
80103950:	55                   	push   %ebp
80103951:	89 e5                	mov    %esp,%ebp
80103953:	57                   	push   %edi
80103954:	56                   	push   %esi
80103955:	53                   	push   %ebx
80103956:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103959:	e8 c2 0a 00 00       	call   80104420 <pushcli>
  c = mycpu();
8010395e:	e8 dd fd ff ff       	call   80103740 <mycpu>
  p = c->proc;
80103963:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103969:	e8 f2 0a 00 00       	call   80104460 <popcli>
  if((np = allocproc()) == 0){
8010396e:	e8 8d fc ff ff       	call   80103600 <allocproc>
80103973:	85 c0                	test   %eax,%eax
80103975:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103978:	0f 84 c7 00 00 00    	je     80103a45 <fork+0xf5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
8010397e:	83 ec 08             	sub    $0x8,%esp
80103981:	ff 33                	pushl  (%ebx)
80103983:	ff 73 04             	pushl  0x4(%ebx)
80103986:	89 c7                	mov    %eax,%edi
80103988:	e8 53 35 00 00       	call   80106ee0 <copyuvm>
8010398d:	83 c4 10             	add    $0x10,%esp
80103990:	85 c0                	test   %eax,%eax
80103992:	89 47 04             	mov    %eax,0x4(%edi)
80103995:	0f 84 b1 00 00 00    	je     80103a4c <fork+0xfc>
  np->tickets = tickets;
8010399b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010399e:	8b 45 08             	mov    0x8(%ebp),%eax
801039a1:	89 41 7c             	mov    %eax,0x7c(%ecx)
  np->sz = curproc->sz;
801039a4:	8b 03                	mov    (%ebx),%eax
  *np->tf = *curproc->tf;
801039a6:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
801039a9:	89 59 14             	mov    %ebx,0x14(%ecx)
  np->sz = curproc->sz;
801039ac:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
801039ae:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
801039b0:	8b 73 18             	mov    0x18(%ebx),%esi
801039b3:	b9 13 00 00 00       	mov    $0x13,%ecx
801039b8:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
801039ba:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
801039bc:	8b 40 18             	mov    0x18(%eax),%eax
801039bf:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
801039c6:	8d 76 00             	lea    0x0(%esi),%esi
801039c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(curproc->ofile[i])
801039d0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
801039d4:	85 c0                	test   %eax,%eax
801039d6:	74 13                	je     801039eb <fork+0x9b>
      np->ofile[i] = filedup(curproc->ofile[i]);
801039d8:	83 ec 0c             	sub    $0xc,%esp
801039db:	50                   	push   %eax
801039dc:	e8 0f d4 ff ff       	call   80100df0 <filedup>
801039e1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801039e4:	83 c4 10             	add    $0x10,%esp
801039e7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
801039eb:	83 c6 01             	add    $0x1,%esi
801039ee:	83 fe 10             	cmp    $0x10,%esi
801039f1:	75 dd                	jne    801039d0 <fork+0x80>
  np->cwd = idup(curproc->cwd);
801039f3:	83 ec 0c             	sub    $0xc,%esp
801039f6:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801039f9:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
801039fc:	e8 5f dc ff ff       	call   80101660 <idup>
80103a01:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a04:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103a07:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a0a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103a0d:	6a 10                	push   $0x10
80103a0f:	53                   	push   %ebx
80103a10:	50                   	push   %eax
80103a11:	e8 ca 0d 00 00       	call   801047e0 <safestrcpy>
  pid = np->pid;
80103a16:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103a19:	c7 04 24 00 32 11 80 	movl   $0x80113200,(%esp)
80103a20:	e8 cb 0a 00 00       	call   801044f0 <acquire>
  np->state = RUNNABLE;
80103a25:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103a2c:	c7 04 24 00 32 11 80 	movl   $0x80113200,(%esp)
80103a33:	e8 78 0b 00 00       	call   801045b0 <release>
  return pid;
80103a38:	83 c4 10             	add    $0x10,%esp
}
80103a3b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a3e:	89 d8                	mov    %ebx,%eax
80103a40:	5b                   	pop    %ebx
80103a41:	5e                   	pop    %esi
80103a42:	5f                   	pop    %edi
80103a43:	5d                   	pop    %ebp
80103a44:	c3                   	ret    
    return -1;
80103a45:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103a4a:	eb ef                	jmp    80103a3b <fork+0xeb>
    kfree(np->kstack);
80103a4c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103a4f:	83 ec 0c             	sub    $0xc,%esp
80103a52:	ff 73 08             	pushl  0x8(%ebx)
80103a55:	e8 c6 e8 ff ff       	call   80102320 <kfree>
    np->kstack = 0;
80103a5a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103a61:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103a68:	83 c4 10             	add    $0x10,%esp
80103a6b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103a70:	eb c9                	jmp    80103a3b <fork+0xeb>
80103a72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a80 <tickets_total>:
int tickets_total(void){
80103a80:	55                   	push   %ebp
  int total = 0;
80103a81:	31 c0                	xor    %eax,%eax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103a83:	ba 34 32 11 80       	mov    $0x80113234,%edx
int tickets_total(void){
80103a88:	89 e5                	mov    %esp,%ebp
80103a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p->state==RUNNABLE){
80103a90:	83 7a 0c 03          	cmpl   $0x3,0xc(%edx)
80103a94:	75 03                	jne    80103a99 <tickets_total+0x19>
      total += p->tickets;
80103a96:	03 42 7c             	add    0x7c(%edx),%eax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103a99:	83 ea 80             	sub    $0xffffff80,%edx
80103a9c:	81 fa 34 52 11 80    	cmp    $0x80115234,%edx
80103aa2:	72 ec                	jb     80103a90 <tickets_total+0x10>
}
80103aa4:	5d                   	pop    %ebp
80103aa5:	c3                   	ret    
80103aa6:	8d 76 00             	lea    0x0(%esi),%esi
80103aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ab0 <scheduler>:
void scheduler(void){
80103ab0:	55                   	push   %ebp
80103ab1:	89 e5                	mov    %esp,%ebp
80103ab3:	57                   	push   %edi
80103ab4:	56                   	push   %esi
80103ab5:	53                   	push   %ebx
80103ab6:	81 ec 3c 01 00 00    	sub    $0x13c,%esp
  struct cpu *c = mycpu();
80103abc:	e8 7f fc ff ff       	call   80103740 <mycpu>
80103ac1:	8d 55 e8             	lea    -0x18(%ebp),%edx
80103ac4:	89 85 c8 fe ff ff    	mov    %eax,-0x138(%ebp)
80103aca:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
        occurrences[i] = 0;
80103ad0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103ad6:	83 c0 04             	add    $0x4,%eax
    for (int i = 0; i < NPROC; i++) {
80103ad9:	39 c2                	cmp    %eax,%edx
80103adb:	75 f3                	jne    80103ad0 <scheduler+0x20>
  c->proc = 0;
80103add:	8b bd c8 fe ff ff    	mov    -0x138(%ebp),%edi
    golden_ticket = random_at_most(ticks);
80103ae3:	83 ec 0c             	sub    $0xc,%esp
  c->proc = 0;
80103ae6:	c7 87 ac 00 00 00 00 	movl   $0x0,0xac(%edi)
80103aed:	00 00 00 
    golden_ticket = random_at_most(ticks);
80103af0:	ff 35 80 5a 11 80    	pushl  0x80115a80
80103af6:	e8 45 37 00 00       	call   80107240 <random_at_most>
80103afb:	8d 47 04             	lea    0x4(%edi),%eax
80103afe:	83 c4 10             	add    $0x10,%esp
    int d = 0;
80103b01:	c7 85 dc fe ff ff 00 	movl   $0x0,-0x124(%ebp)
80103b08:	00 00 00 
80103b0b:	89 85 c4 fe ff ff    	mov    %eax,-0x13c(%ebp)
80103b11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("sti");
80103b18:	fb                   	sti    
      acquire(&ptable.lock);
80103b19:	83 ec 0c             	sub    $0xc,%esp
  int total = 0;
80103b1c:	31 db                	xor    %ebx,%ebx
      acquire(&ptable.lock);
80103b1e:	68 00 32 11 80       	push   $0x80113200
80103b23:	e8 c8 09 00 00       	call   801044f0 <acquire>
      d++;
80103b28:	83 85 dc fe ff ff 01 	addl   $0x1,-0x124(%ebp)
80103b2f:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103b32:	b8 34 32 11 80       	mov    $0x80113234,%eax
80103b37:	89 f6                	mov    %esi,%esi
80103b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(p->state==RUNNABLE){
80103b40:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103b44:	75 03                	jne    80103b49 <scheduler+0x99>
      total += p->tickets;
80103b46:	03 58 7c             	add    0x7c(%eax),%ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103b49:	83 e8 80             	sub    $0xffffff80,%eax
80103b4c:	3d 34 52 11 80       	cmp    $0x80115234,%eax
80103b51:	72 ed                	jb     80103b40 <scheduler+0x90>
      golden_ticket = random_at_most(total_no_tickets);
80103b53:	83 ec 0c             	sub    $0xc,%esp
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b56:	be 34 32 11 80       	mov    $0x80113234,%esi
      golden_ticket = random_at_most(total_no_tickets);
80103b5b:	53                   	push   %ebx
80103b5c:	e8 df 36 00 00       	call   80107240 <random_at_most>
80103b61:	83 c4 10             	add    $0x10,%esp
80103b64:	89 85 d4 fe ff ff    	mov    %eax,-0x12c(%ebp)
      count = 0;
80103b6a:	31 c9                	xor    %ecx,%ecx
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b6c:	89 c2                	mov    %eax,%edx
          if(p->state != RUNNABLE){
80103b6e:	83 7e 0c 03          	cmpl   $0x3,0xc(%esi)
80103b72:	8b 7e 7c             	mov    0x7c(%esi),%edi
80103b75:	8d 04 0f             	lea    (%edi,%ecx,1),%eax
80103b78:	0f 85 1a 01 00 00    	jne    80103c98 <scheduler+0x1e8>
          if (golden_ticket < count || golden_ticket > (count + p->tickets)){
80103b7e:	39 ca                	cmp    %ecx,%edx
80103b80:	0f 8c 12 01 00 00    	jl     80103c98 <scheduler+0x1e8>
80103b86:	39 c2                	cmp    %eax,%edx
80103b88:	0f 8f 0a 01 00 00    	jg     80103c98 <scheduler+0x1e8>
80103b8e:	89 85 cc fe ff ff    	mov    %eax,-0x134(%ebp)
          occurrences[p->pid]++;
80103b94:	8b 46 10             	mov    0x10(%esi),%eax
80103b97:	8b 94 85 e8 fe ff ff 	mov    -0x118(%ebp,%eax,4),%edx
80103b9e:	89 85 d0 fe ff ff    	mov    %eax,-0x130(%ebp)
80103ba4:	83 c2 01             	add    $0x1,%edx
80103ba7:	89 94 85 e8 fe ff ff 	mov    %edx,-0x118(%ebp,%eax,4)
80103bae:	89 95 d8 fe ff ff    	mov    %edx,-0x128(%ebp)
          if(d % 100 == 0) {
80103bb4:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
80103bb9:	f7 a5 dc fe ff ff    	mull   -0x124(%ebp)
80103bbf:	c1 ea 05             	shr    $0x5,%edx
80103bc2:	6b c2 64             	imul   $0x64,%edx,%eax
80103bc5:	39 85 dc fe ff ff    	cmp    %eax,-0x124(%ebp)
80103bcb:	75 72                	jne    80103c3f <scheduler+0x18f>
              p->pid, golden_ticket, count, (count + p->tickets), p->tickets, occurrences[p->pid], (int)(((float)occurrences[p->pid]/total_no_tickets)*100));
80103bcd:	db 85 d8 fe ff ff    	fildl  -0x128(%ebp)
80103bd3:	8b 95 d8 fe ff ff    	mov    -0x128(%ebp),%edx
              cprintf("PID: %d | Golden: %d | Intervalo: [%d:%d] | QTD_T: %d | OC: %d | %d%\n", \
80103bd9:	d9 bd e6 fe ff ff    	fnstcw -0x11a(%ebp)
              p->pid, golden_ticket, count, (count + p->tickets), p->tickets, occurrences[p->pid], (int)(((float)occurrences[p->pid]/total_no_tickets)*100));
80103bdf:	89 9d d8 fe ff ff    	mov    %ebx,-0x128(%ebp)
              cprintf("PID: %d | Golden: %d | Intervalo: [%d:%d] | QTD_T: %d | OC: %d | %d%\n", \
80103be5:	0f b7 85 e6 fe ff ff 	movzwl -0x11a(%ebp),%eax
              p->pid, golden_ticket, count, (count + p->tickets), p->tickets, occurrences[p->pid], (int)(((float)occurrences[p->pid]/total_no_tickets)*100));
80103bec:	db 85 d8 fe ff ff    	fildl  -0x128(%ebp)
80103bf2:	de f9                	fdivrp %st,%st(1)
              cprintf("PID: %d | Golden: %d | Intervalo: [%d:%d] | QTD_T: %d | OC: %d | %d%\n", \
80103bf4:	80 cc 0c             	or     $0xc,%ah
80103bf7:	66 89 85 e4 fe ff ff 	mov    %ax,-0x11c(%ebp)
              p->pid, golden_ticket, count, (count + p->tickets), p->tickets, occurrences[p->pid], (int)(((float)occurrences[p->pid]/total_no_tickets)*100));
80103bfe:	d8 0d 4c 79 10 80    	fmuls  0x8010794c
              cprintf("PID: %d | Golden: %d | Intervalo: [%d:%d] | QTD_T: %d | OC: %d | %d%\n", \
80103c04:	d9 ad e4 fe ff ff    	fldcw  -0x11c(%ebp)
80103c0a:	db 9d e0 fe ff ff    	fistpl -0x120(%ebp)
80103c10:	d9 ad e6 fe ff ff    	fldcw  -0x11a(%ebp)
80103c16:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
80103c1c:	50                   	push   %eax
80103c1d:	52                   	push   %edx
80103c1e:	57                   	push   %edi
80103c1f:	ff b5 cc fe ff ff    	pushl  -0x134(%ebp)
80103c25:	51                   	push   %ecx
80103c26:	ff b5 d4 fe ff ff    	pushl  -0x12c(%ebp)
80103c2c:	ff b5 d0 fe ff ff    	pushl  -0x130(%ebp)
80103c32:	68 ec 78 10 80       	push   $0x801078ec
80103c37:	e8 24 ca ff ff       	call   80100660 <cprintf>
80103c3c:	83 c4 20             	add    $0x20,%esp
          c->proc = p;
80103c3f:	8b bd c8 fe ff ff    	mov    -0x138(%ebp),%edi
          switchuvm(p);
80103c45:	83 ec 0c             	sub    $0xc,%esp
          c->proc = p;
80103c48:	89 b7 ac 00 00 00    	mov    %esi,0xac(%edi)
          switchuvm(p);
80103c4e:	56                   	push   %esi
80103c4f:	e8 8c 2d 00 00       	call   801069e0 <switchuvm>
          swtch(&(c->scheduler), p->context);
80103c54:	58                   	pop    %eax
80103c55:	5a                   	pop    %edx
80103c56:	ff 76 1c             	pushl  0x1c(%esi)
80103c59:	ff b5 c4 fe ff ff    	pushl  -0x13c(%ebp)
          p->state = RUNNING;
80103c5f:	c7 46 0c 04 00 00 00 	movl   $0x4,0xc(%esi)
          swtch(&(c->scheduler), p->context);
80103c66:	e8 d0 0b 00 00       	call   8010483b <swtch>
          switchkvm();
80103c6b:	e8 50 2d 00 00       	call   801069c0 <switchkvm>
          c->proc = 0;
80103c70:	c7 87 ac 00 00 00 00 	movl   $0x0,0xac(%edi)
80103c77:	00 00 00 
          break;
80103c7a:	83 c4 10             	add    $0x10,%esp
    release(&ptable.lock);
80103c7d:	83 ec 0c             	sub    $0xc,%esp
80103c80:	68 00 32 11 80       	push   $0x80113200
80103c85:	e8 26 09 00 00       	call   801045b0 <release>
      sti();
80103c8a:	83 c4 10             	add    $0x10,%esp
80103c8d:	e9 86 fe ff ff       	jmp    80103b18 <scheduler+0x68>
80103c92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c98:	83 ee 80             	sub    $0xffffff80,%esi
80103c9b:	89 c1                	mov    %eax,%ecx
80103c9d:	81 fe 34 52 11 80    	cmp    $0x80115234,%esi
80103ca3:	0f 82 c5 fe ff ff    	jb     80103b6e <scheduler+0xbe>
80103ca9:	eb d2                	jmp    80103c7d <scheduler+0x1cd>
80103cab:	90                   	nop
80103cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103cb0 <sched>:
{
80103cb0:	55                   	push   %ebp
80103cb1:	89 e5                	mov    %esp,%ebp
80103cb3:	56                   	push   %esi
80103cb4:	53                   	push   %ebx
  pushcli();
80103cb5:	e8 66 07 00 00       	call   80104420 <pushcli>
  c = mycpu();
80103cba:	e8 81 fa ff ff       	call   80103740 <mycpu>
  p = c->proc;
80103cbf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103cc5:	e8 96 07 00 00       	call   80104460 <popcli>
  if(!holding(&ptable.lock))
80103cca:	83 ec 0c             	sub    $0xc,%esp
80103ccd:	68 00 32 11 80       	push   $0x80113200
80103cd2:	e8 e9 07 00 00       	call   801044c0 <holding>
80103cd7:	83 c4 10             	add    $0x10,%esp
80103cda:	85 c0                	test   %eax,%eax
80103cdc:	74 4f                	je     80103d2d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103cde:	e8 5d fa ff ff       	call   80103740 <mycpu>
80103ce3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103cea:	75 68                	jne    80103d54 <sched+0xa4>
  if(p->state == RUNNING)
80103cec:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103cf0:	74 55                	je     80103d47 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103cf2:	9c                   	pushf  
80103cf3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103cf4:	f6 c4 02             	test   $0x2,%ah
80103cf7:	75 41                	jne    80103d3a <sched+0x8a>
  intena = mycpu()->intena;
80103cf9:	e8 42 fa ff ff       	call   80103740 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103cfe:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103d01:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103d07:	e8 34 fa ff ff       	call   80103740 <mycpu>
80103d0c:	83 ec 08             	sub    $0x8,%esp
80103d0f:	ff 70 04             	pushl  0x4(%eax)
80103d12:	53                   	push   %ebx
80103d13:	e8 23 0b 00 00       	call   8010483b <swtch>
  mycpu()->intena = intena;
80103d18:	e8 23 fa ff ff       	call   80103740 <mycpu>
}
80103d1d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103d20:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103d26:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d29:	5b                   	pop    %ebx
80103d2a:	5e                   	pop    %esi
80103d2b:	5d                   	pop    %ebp
80103d2c:	c3                   	ret    
    panic("sched ptable.lock");
80103d2d:	83 ec 0c             	sub    $0xc,%esp
80103d30:	68 10 78 10 80       	push   $0x80107810
80103d35:	e8 56 c6 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103d3a:	83 ec 0c             	sub    $0xc,%esp
80103d3d:	68 3c 78 10 80       	push   $0x8010783c
80103d42:	e8 49 c6 ff ff       	call   80100390 <panic>
    panic("sched running");
80103d47:	83 ec 0c             	sub    $0xc,%esp
80103d4a:	68 2e 78 10 80       	push   $0x8010782e
80103d4f:	e8 3c c6 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103d54:	83 ec 0c             	sub    $0xc,%esp
80103d57:	68 22 78 10 80       	push   $0x80107822
80103d5c:	e8 2f c6 ff ff       	call   80100390 <panic>
80103d61:	eb 0d                	jmp    80103d70 <exit>
80103d63:	90                   	nop
80103d64:	90                   	nop
80103d65:	90                   	nop
80103d66:	90                   	nop
80103d67:	90                   	nop
80103d68:	90                   	nop
80103d69:	90                   	nop
80103d6a:	90                   	nop
80103d6b:	90                   	nop
80103d6c:	90                   	nop
80103d6d:	90                   	nop
80103d6e:	90                   	nop
80103d6f:	90                   	nop

80103d70 <exit>:
{
80103d70:	55                   	push   %ebp
80103d71:	89 e5                	mov    %esp,%ebp
80103d73:	57                   	push   %edi
80103d74:	56                   	push   %esi
80103d75:	53                   	push   %ebx
80103d76:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103d79:	e8 a2 06 00 00       	call   80104420 <pushcli>
  c = mycpu();
80103d7e:	e8 bd f9 ff ff       	call   80103740 <mycpu>
  p = c->proc;
80103d83:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103d89:	e8 d2 06 00 00       	call   80104460 <popcli>
  if(curproc == initproc)
80103d8e:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103d94:	8d 5e 28             	lea    0x28(%esi),%ebx
80103d97:	8d 7e 68             	lea    0x68(%esi),%edi
80103d9a:	0f 84 e7 00 00 00    	je     80103e87 <exit+0x117>
    if(curproc->ofile[fd]){
80103da0:	8b 03                	mov    (%ebx),%eax
80103da2:	85 c0                	test   %eax,%eax
80103da4:	74 12                	je     80103db8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103da6:	83 ec 0c             	sub    $0xc,%esp
80103da9:	50                   	push   %eax
80103daa:	e8 91 d0 ff ff       	call   80100e40 <fileclose>
      curproc->ofile[fd] = 0;
80103daf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103db5:	83 c4 10             	add    $0x10,%esp
80103db8:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103dbb:	39 fb                	cmp    %edi,%ebx
80103dbd:	75 e1                	jne    80103da0 <exit+0x30>
  begin_op();
80103dbf:	e8 ec ed ff ff       	call   80102bb0 <begin_op>
  iput(curproc->cwd);
80103dc4:	83 ec 0c             	sub    $0xc,%esp
80103dc7:	ff 76 68             	pushl  0x68(%esi)
80103dca:	e8 f1 d9 ff ff       	call   801017c0 <iput>
  end_op();
80103dcf:	e8 4c ee ff ff       	call   80102c20 <end_op>
  curproc->cwd = 0;
80103dd4:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80103ddb:	c7 04 24 00 32 11 80 	movl   $0x80113200,(%esp)
80103de2:	e8 09 07 00 00       	call   801044f0 <acquire>
  wakeup1(curproc->parent);
80103de7:	8b 56 14             	mov    0x14(%esi),%edx
80103dea:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ded:	b8 34 32 11 80       	mov    $0x80113234,%eax
80103df2:	eb 0e                	jmp    80103e02 <exit+0x92>
80103df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103df8:	83 e8 80             	sub    $0xffffff80,%eax
80103dfb:	3d 34 52 11 80       	cmp    $0x80115234,%eax
80103e00:	73 1c                	jae    80103e1e <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103e02:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e06:	75 f0                	jne    80103df8 <exit+0x88>
80103e08:	3b 50 20             	cmp    0x20(%eax),%edx
80103e0b:	75 eb                	jne    80103df8 <exit+0x88>
      p->state = RUNNABLE;
80103e0d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e14:	83 e8 80             	sub    $0xffffff80,%eax
80103e17:	3d 34 52 11 80       	cmp    $0x80115234,%eax
80103e1c:	72 e4                	jb     80103e02 <exit+0x92>
      p->parent = initproc;
80103e1e:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e24:	ba 34 32 11 80       	mov    $0x80113234,%edx
80103e29:	eb 10                	jmp    80103e3b <exit+0xcb>
80103e2b:	90                   	nop
80103e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e30:	83 ea 80             	sub    $0xffffff80,%edx
80103e33:	81 fa 34 52 11 80    	cmp    $0x80115234,%edx
80103e39:	73 33                	jae    80103e6e <exit+0xfe>
    if(p->parent == curproc){
80103e3b:	39 72 14             	cmp    %esi,0x14(%edx)
80103e3e:	75 f0                	jne    80103e30 <exit+0xc0>
      if(p->state == ZOMBIE)
80103e40:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103e44:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103e47:	75 e7                	jne    80103e30 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e49:	b8 34 32 11 80       	mov    $0x80113234,%eax
80103e4e:	eb 0a                	jmp    80103e5a <exit+0xea>
80103e50:	83 e8 80             	sub    $0xffffff80,%eax
80103e53:	3d 34 52 11 80       	cmp    $0x80115234,%eax
80103e58:	73 d6                	jae    80103e30 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103e5a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e5e:	75 f0                	jne    80103e50 <exit+0xe0>
80103e60:	3b 48 20             	cmp    0x20(%eax),%ecx
80103e63:	75 eb                	jne    80103e50 <exit+0xe0>
      p->state = RUNNABLE;
80103e65:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103e6c:	eb e2                	jmp    80103e50 <exit+0xe0>
  curproc->state = ZOMBIE;
80103e6e:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103e75:	e8 36 fe ff ff       	call   80103cb0 <sched>
  panic("zombie exit");
80103e7a:	83 ec 0c             	sub    $0xc,%esp
80103e7d:	68 5d 78 10 80       	push   $0x8010785d
80103e82:	e8 09 c5 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103e87:	83 ec 0c             	sub    $0xc,%esp
80103e8a:	68 50 78 10 80       	push   $0x80107850
80103e8f:	e8 fc c4 ff ff       	call   80100390 <panic>
80103e94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103ea0 <yield>:
{
80103ea0:	55                   	push   %ebp
80103ea1:	89 e5                	mov    %esp,%ebp
80103ea3:	53                   	push   %ebx
80103ea4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103ea7:	68 00 32 11 80       	push   $0x80113200
80103eac:	e8 3f 06 00 00       	call   801044f0 <acquire>
  pushcli();
80103eb1:	e8 6a 05 00 00       	call   80104420 <pushcli>
  c = mycpu();
80103eb6:	e8 85 f8 ff ff       	call   80103740 <mycpu>
  p = c->proc;
80103ebb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ec1:	e8 9a 05 00 00       	call   80104460 <popcli>
  myproc()->state = RUNNABLE;
80103ec6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103ecd:	e8 de fd ff ff       	call   80103cb0 <sched>
  release(&ptable.lock);
80103ed2:	c7 04 24 00 32 11 80 	movl   $0x80113200,(%esp)
80103ed9:	e8 d2 06 00 00       	call   801045b0 <release>
}
80103ede:	83 c4 10             	add    $0x10,%esp
80103ee1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ee4:	c9                   	leave  
80103ee5:	c3                   	ret    
80103ee6:	8d 76 00             	lea    0x0(%esi),%esi
80103ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ef0 <sleep>:
{
80103ef0:	55                   	push   %ebp
80103ef1:	89 e5                	mov    %esp,%ebp
80103ef3:	57                   	push   %edi
80103ef4:	56                   	push   %esi
80103ef5:	53                   	push   %ebx
80103ef6:	83 ec 0c             	sub    $0xc,%esp
80103ef9:	8b 7d 08             	mov    0x8(%ebp),%edi
80103efc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103eff:	e8 1c 05 00 00       	call   80104420 <pushcli>
  c = mycpu();
80103f04:	e8 37 f8 ff ff       	call   80103740 <mycpu>
  p = c->proc;
80103f09:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f0f:	e8 4c 05 00 00       	call   80104460 <popcli>
  if(p == 0)
80103f14:	85 db                	test   %ebx,%ebx
80103f16:	0f 84 87 00 00 00    	je     80103fa3 <sleep+0xb3>
  if(lk == 0)
80103f1c:	85 f6                	test   %esi,%esi
80103f1e:	74 76                	je     80103f96 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103f20:	81 fe 00 32 11 80    	cmp    $0x80113200,%esi
80103f26:	74 50                	je     80103f78 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103f28:	83 ec 0c             	sub    $0xc,%esp
80103f2b:	68 00 32 11 80       	push   $0x80113200
80103f30:	e8 bb 05 00 00       	call   801044f0 <acquire>
    release(lk);
80103f35:	89 34 24             	mov    %esi,(%esp)
80103f38:	e8 73 06 00 00       	call   801045b0 <release>
  p->chan = chan;
80103f3d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f40:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103f47:	e8 64 fd ff ff       	call   80103cb0 <sched>
  p->chan = 0;
80103f4c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103f53:	c7 04 24 00 32 11 80 	movl   $0x80113200,(%esp)
80103f5a:	e8 51 06 00 00       	call   801045b0 <release>
    acquire(lk);
80103f5f:	89 75 08             	mov    %esi,0x8(%ebp)
80103f62:	83 c4 10             	add    $0x10,%esp
}
80103f65:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f68:	5b                   	pop    %ebx
80103f69:	5e                   	pop    %esi
80103f6a:	5f                   	pop    %edi
80103f6b:	5d                   	pop    %ebp
    acquire(lk);
80103f6c:	e9 7f 05 00 00       	jmp    801044f0 <acquire>
80103f71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103f78:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f7b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103f82:	e8 29 fd ff ff       	call   80103cb0 <sched>
  p->chan = 0;
80103f87:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103f8e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f91:	5b                   	pop    %ebx
80103f92:	5e                   	pop    %esi
80103f93:	5f                   	pop    %edi
80103f94:	5d                   	pop    %ebp
80103f95:	c3                   	ret    
    panic("sleep without lk");
80103f96:	83 ec 0c             	sub    $0xc,%esp
80103f99:	68 6f 78 10 80       	push   $0x8010786f
80103f9e:	e8 ed c3 ff ff       	call   80100390 <panic>
    panic("sleep");
80103fa3:	83 ec 0c             	sub    $0xc,%esp
80103fa6:	68 69 78 10 80       	push   $0x80107869
80103fab:	e8 e0 c3 ff ff       	call   80100390 <panic>

80103fb0 <wait>:
{
80103fb0:	55                   	push   %ebp
80103fb1:	89 e5                	mov    %esp,%ebp
80103fb3:	56                   	push   %esi
80103fb4:	53                   	push   %ebx
  pushcli();
80103fb5:	e8 66 04 00 00       	call   80104420 <pushcli>
  c = mycpu();
80103fba:	e8 81 f7 ff ff       	call   80103740 <mycpu>
  p = c->proc;
80103fbf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103fc5:	e8 96 04 00 00       	call   80104460 <popcli>
  acquire(&ptable.lock);
80103fca:	83 ec 0c             	sub    $0xc,%esp
80103fcd:	68 00 32 11 80       	push   $0x80113200
80103fd2:	e8 19 05 00 00       	call   801044f0 <acquire>
80103fd7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103fda:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fdc:	bb 34 32 11 80       	mov    $0x80113234,%ebx
80103fe1:	eb 10                	jmp    80103ff3 <wait+0x43>
80103fe3:	90                   	nop
80103fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103fe8:	83 eb 80             	sub    $0xffffff80,%ebx
80103feb:	81 fb 34 52 11 80    	cmp    $0x80115234,%ebx
80103ff1:	73 1b                	jae    8010400e <wait+0x5e>
      if(p->parent != curproc)
80103ff3:	39 73 14             	cmp    %esi,0x14(%ebx)
80103ff6:	75 f0                	jne    80103fe8 <wait+0x38>
      if(p->state == ZOMBIE){
80103ff8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103ffc:	74 32                	je     80104030 <wait+0x80>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ffe:	83 eb 80             	sub    $0xffffff80,%ebx
      havekids = 1;
80104001:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104006:	81 fb 34 52 11 80    	cmp    $0x80115234,%ebx
8010400c:	72 e5                	jb     80103ff3 <wait+0x43>
    if(!havekids || curproc->killed){
8010400e:	85 c0                	test   %eax,%eax
80104010:	74 74                	je     80104086 <wait+0xd6>
80104012:	8b 46 24             	mov    0x24(%esi),%eax
80104015:	85 c0                	test   %eax,%eax
80104017:	75 6d                	jne    80104086 <wait+0xd6>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104019:	83 ec 08             	sub    $0x8,%esp
8010401c:	68 00 32 11 80       	push   $0x80113200
80104021:	56                   	push   %esi
80104022:	e8 c9 fe ff ff       	call   80103ef0 <sleep>
    havekids = 0;
80104027:	83 c4 10             	add    $0x10,%esp
8010402a:	eb ae                	jmp    80103fda <wait+0x2a>
8010402c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80104030:	83 ec 0c             	sub    $0xc,%esp
80104033:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80104036:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104039:	e8 e2 e2 ff ff       	call   80102320 <kfree>
        freevm(p->pgdir);
8010403e:	5a                   	pop    %edx
8010403f:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80104042:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104049:	e8 42 2d 00 00       	call   80106d90 <freevm>
        release(&ptable.lock);
8010404e:	c7 04 24 00 32 11 80 	movl   $0x80113200,(%esp)
        p->pid = 0;
80104055:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
8010405c:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104063:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104067:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
8010406e:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104075:	e8 36 05 00 00       	call   801045b0 <release>
        return pid;
8010407a:	83 c4 10             	add    $0x10,%esp
}
8010407d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104080:	89 f0                	mov    %esi,%eax
80104082:	5b                   	pop    %ebx
80104083:	5e                   	pop    %esi
80104084:	5d                   	pop    %ebp
80104085:	c3                   	ret    
      release(&ptable.lock);
80104086:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104089:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010408e:	68 00 32 11 80       	push   $0x80113200
80104093:	e8 18 05 00 00       	call   801045b0 <release>
      return -1;
80104098:	83 c4 10             	add    $0x10,%esp
8010409b:	eb e0                	jmp    8010407d <wait+0xcd>
8010409d:	8d 76 00             	lea    0x0(%esi),%esi

801040a0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801040a0:	55                   	push   %ebp
801040a1:	89 e5                	mov    %esp,%ebp
801040a3:	53                   	push   %ebx
801040a4:	83 ec 10             	sub    $0x10,%esp
801040a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801040aa:	68 00 32 11 80       	push   $0x80113200
801040af:	e8 3c 04 00 00       	call   801044f0 <acquire>
801040b4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040b7:	b8 34 32 11 80       	mov    $0x80113234,%eax
801040bc:	eb 0c                	jmp    801040ca <wakeup+0x2a>
801040be:	66 90                	xchg   %ax,%ax
801040c0:	83 e8 80             	sub    $0xffffff80,%eax
801040c3:	3d 34 52 11 80       	cmp    $0x80115234,%eax
801040c8:	73 1c                	jae    801040e6 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
801040ca:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801040ce:	75 f0                	jne    801040c0 <wakeup+0x20>
801040d0:	3b 58 20             	cmp    0x20(%eax),%ebx
801040d3:	75 eb                	jne    801040c0 <wakeup+0x20>
      p->state = RUNNABLE;
801040d5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040dc:	83 e8 80             	sub    $0xffffff80,%eax
801040df:	3d 34 52 11 80       	cmp    $0x80115234,%eax
801040e4:	72 e4                	jb     801040ca <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
801040e6:	c7 45 08 00 32 11 80 	movl   $0x80113200,0x8(%ebp)
}
801040ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040f0:	c9                   	leave  
  release(&ptable.lock);
801040f1:	e9 ba 04 00 00       	jmp    801045b0 <release>
801040f6:	8d 76 00             	lea    0x0(%esi),%esi
801040f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104100 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104100:	55                   	push   %ebp
80104101:	89 e5                	mov    %esp,%ebp
80104103:	53                   	push   %ebx
80104104:	83 ec 10             	sub    $0x10,%esp
80104107:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010410a:	68 00 32 11 80       	push   $0x80113200
8010410f:	e8 dc 03 00 00       	call   801044f0 <acquire>
80104114:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104117:	b8 34 32 11 80       	mov    $0x80113234,%eax
8010411c:	eb 0c                	jmp    8010412a <kill+0x2a>
8010411e:	66 90                	xchg   %ax,%ax
80104120:	83 e8 80             	sub    $0xffffff80,%eax
80104123:	3d 34 52 11 80       	cmp    $0x80115234,%eax
80104128:	73 36                	jae    80104160 <kill+0x60>
    if(p->pid == pid){
8010412a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010412d:	75 f1                	jne    80104120 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010412f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104133:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010413a:	75 07                	jne    80104143 <kill+0x43>
        p->state = RUNNABLE;
8010413c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104143:	83 ec 0c             	sub    $0xc,%esp
80104146:	68 00 32 11 80       	push   $0x80113200
8010414b:	e8 60 04 00 00       	call   801045b0 <release>
      return 0;
80104150:	83 c4 10             	add    $0x10,%esp
80104153:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104155:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104158:	c9                   	leave  
80104159:	c3                   	ret    
8010415a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104160:	83 ec 0c             	sub    $0xc,%esp
80104163:	68 00 32 11 80       	push   $0x80113200
80104168:	e8 43 04 00 00       	call   801045b0 <release>
  return -1;
8010416d:	83 c4 10             	add    $0x10,%esp
80104170:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104175:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104178:	c9                   	leave  
80104179:	c3                   	ret    
8010417a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104180 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104180:	55                   	push   %ebp
80104181:	89 e5                	mov    %esp,%ebp
80104183:	57                   	push   %edi
80104184:	56                   	push   %esi
80104185:	53                   	push   %ebx

  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104186:	bb 34 32 11 80       	mov    $0x80113234,%ebx
{
8010418b:	83 ec 3c             	sub    $0x3c,%esp
8010418e:	eb 29                	jmp    801041b9 <procdump+0x39>


      //----------------------------------------------


    if(p->state == SLEEPING){
80104190:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104194:	0f 84 89 00 00 00    	je     80104223 <procdump+0xa3>
      getcallerpcs((uint*)p->context->ebp+2, pc);
        for(int i=0; i<10 && pc[i] != 0; i++)
          cprintf(" %p", pc[i]);
    }

    cprintf("\n");
8010419a:	83 ec 0c             	sub    $0xc,%esp
8010419d:	68 5b 7c 10 80       	push   $0x80107c5b
801041a2:	e8 b9 c4 ff ff       	call   80100660 <cprintf>
801041a7:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041aa:	83 eb 80             	sub    $0xffffff80,%ebx
801041ad:	81 fb 34 52 11 80    	cmp    $0x80115234,%ebx
801041b3:	0f 83 b7 00 00 00    	jae    80104270 <procdump+0xf0>
      if(p->state == UNUSED)
801041b9:	8b 43 0c             	mov    0xc(%ebx),%eax
801041bc:	85 c0                	test   %eax,%eax
801041be:	74 ea                	je     801041aa <procdump+0x2a>
      if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801041c0:	83 f8 05             	cmp    $0x5,%eax
        state = "???";
801041c3:	bf 80 78 10 80       	mov    $0x80107880,%edi
      if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801041c8:	77 11                	ja     801041db <procdump+0x5b>
801041ca:	8b 3c 85 34 79 10 80 	mov    -0x7fef86cc(,%eax,4),%edi
        state = "???";
801041d1:	b8 80 78 10 80       	mov    $0x80107880,%eax
801041d6:	85 ff                	test   %edi,%edi
801041d8:	0f 44 f8             	cmove  %eax,%edi
      if(!strncmp(p->name, "lottery", strlen("lottery"))){
801041db:	83 ec 0c             	sub    $0xc,%esp
801041de:	8d 73 6c             	lea    0x6c(%ebx),%esi
801041e1:	68 84 78 10 80       	push   $0x80107884
801041e6:	e8 35 06 00 00       	call   80104820 <strlen>
801041eb:	83 c4 0c             	add    $0xc,%esp
801041ee:	50                   	push   %eax
801041ef:	68 84 78 10 80       	push   $0x80107884
801041f4:	56                   	push   %esi
801041f5:	e8 26 05 00 00       	call   80104720 <strncmp>
801041fa:	83 c4 10             	add    $0x10,%esp
801041fd:	85 c0                	test   %eax,%eax
801041ff:	75 8f                	jne    80104190 <procdump+0x10>
          cprintf("%d %s %s %d", p->pid, state, p->name, p->tickets);
80104201:	83 ec 0c             	sub    $0xc,%esp
80104204:	ff 73 7c             	pushl  0x7c(%ebx)
80104207:	56                   	push   %esi
80104208:	57                   	push   %edi
80104209:	ff 73 10             	pushl  0x10(%ebx)
8010420c:	68 8c 78 10 80       	push   $0x8010788c
80104211:	e8 4a c4 ff ff       	call   80100660 <cprintf>
80104216:	83 c4 20             	add    $0x20,%esp
    if(p->state == SLEEPING){
80104219:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
8010421d:	0f 85 77 ff ff ff    	jne    8010419a <procdump+0x1a>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104223:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104226:	83 ec 08             	sub    $0x8,%esp
80104229:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010422c:	50                   	push   %eax
8010422d:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104230:	8b 40 0c             	mov    0xc(%eax),%eax
80104233:	83 c0 08             	add    $0x8,%eax
80104236:	50                   	push   %eax
80104237:	e8 94 01 00 00       	call   801043d0 <getcallerpcs>
8010423c:	83 c4 10             	add    $0x10,%esp
8010423f:	90                   	nop
        for(int i=0; i<10 && pc[i] != 0; i++)
80104240:	8b 17                	mov    (%edi),%edx
80104242:	85 d2                	test   %edx,%edx
80104244:	0f 84 50 ff ff ff    	je     8010419a <procdump+0x1a>
          cprintf(" %p", pc[i]);
8010424a:	83 ec 08             	sub    $0x8,%esp
8010424d:	83 c7 04             	add    $0x4,%edi
80104250:	52                   	push   %edx
80104251:	68 c1 72 10 80       	push   $0x801072c1
80104256:	e8 05 c4 ff ff       	call   80100660 <cprintf>
        for(int i=0; i<10 && pc[i] != 0; i++)
8010425b:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010425e:	83 c4 10             	add    $0x10,%esp
80104261:	39 f8                	cmp    %edi,%eax
80104263:	75 db                	jne    80104240 <procdump+0xc0>
80104265:	e9 30 ff ff ff       	jmp    8010419a <procdump+0x1a>
8010426a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
}
80104270:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104273:	5b                   	pop    %ebx
80104274:	5e                   	pop    %esi
80104275:	5f                   	pop    %edi
80104276:	5d                   	pop    %ebp
80104277:	c3                   	ret    
80104278:	66 90                	xchg   %ax,%ax
8010427a:	66 90                	xchg   %ax,%ax
8010427c:	66 90                	xchg   %ax,%ax
8010427e:	66 90                	xchg   %ax,%ax

80104280 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104280:	55                   	push   %ebp
80104281:	89 e5                	mov    %esp,%ebp
80104283:	53                   	push   %ebx
80104284:	83 ec 0c             	sub    $0xc,%esp
80104287:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010428a:	68 50 79 10 80       	push   $0x80107950
8010428f:	8d 43 04             	lea    0x4(%ebx),%eax
80104292:	50                   	push   %eax
80104293:	e8 18 01 00 00       	call   801043b0 <initlock>
  lk->name = name;
80104298:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010429b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801042a1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801042a4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801042ab:	89 43 38             	mov    %eax,0x38(%ebx)
}
801042ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042b1:	c9                   	leave  
801042b2:	c3                   	ret    
801042b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801042b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042c0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801042c0:	55                   	push   %ebp
801042c1:	89 e5                	mov    %esp,%ebp
801042c3:	56                   	push   %esi
801042c4:	53                   	push   %ebx
801042c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801042c8:	83 ec 0c             	sub    $0xc,%esp
801042cb:	8d 73 04             	lea    0x4(%ebx),%esi
801042ce:	56                   	push   %esi
801042cf:	e8 1c 02 00 00       	call   801044f0 <acquire>
  while (lk->locked) {
801042d4:	8b 13                	mov    (%ebx),%edx
801042d6:	83 c4 10             	add    $0x10,%esp
801042d9:	85 d2                	test   %edx,%edx
801042db:	74 16                	je     801042f3 <acquiresleep+0x33>
801042dd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801042e0:	83 ec 08             	sub    $0x8,%esp
801042e3:	56                   	push   %esi
801042e4:	53                   	push   %ebx
801042e5:	e8 06 fc ff ff       	call   80103ef0 <sleep>
  while (lk->locked) {
801042ea:	8b 03                	mov    (%ebx),%eax
801042ec:	83 c4 10             	add    $0x10,%esp
801042ef:	85 c0                	test   %eax,%eax
801042f1:	75 ed                	jne    801042e0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801042f3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801042f9:	e8 b2 f4 ff ff       	call   801037b0 <myproc>
801042fe:	8b 40 10             	mov    0x10(%eax),%eax
80104301:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104304:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104307:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010430a:	5b                   	pop    %ebx
8010430b:	5e                   	pop    %esi
8010430c:	5d                   	pop    %ebp
  release(&lk->lk);
8010430d:	e9 9e 02 00 00       	jmp    801045b0 <release>
80104312:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104320 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104320:	55                   	push   %ebp
80104321:	89 e5                	mov    %esp,%ebp
80104323:	56                   	push   %esi
80104324:	53                   	push   %ebx
80104325:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104328:	83 ec 0c             	sub    $0xc,%esp
8010432b:	8d 73 04             	lea    0x4(%ebx),%esi
8010432e:	56                   	push   %esi
8010432f:	e8 bc 01 00 00       	call   801044f0 <acquire>
  lk->locked = 0;
80104334:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010433a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104341:	89 1c 24             	mov    %ebx,(%esp)
80104344:	e8 57 fd ff ff       	call   801040a0 <wakeup>
  release(&lk->lk);
80104349:	89 75 08             	mov    %esi,0x8(%ebp)
8010434c:	83 c4 10             	add    $0x10,%esp
}
8010434f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104352:	5b                   	pop    %ebx
80104353:	5e                   	pop    %esi
80104354:	5d                   	pop    %ebp
  release(&lk->lk);
80104355:	e9 56 02 00 00       	jmp    801045b0 <release>
8010435a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104360 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104360:	55                   	push   %ebp
80104361:	89 e5                	mov    %esp,%ebp
80104363:	57                   	push   %edi
80104364:	56                   	push   %esi
80104365:	53                   	push   %ebx
80104366:	31 ff                	xor    %edi,%edi
80104368:	83 ec 18             	sub    $0x18,%esp
8010436b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010436e:	8d 73 04             	lea    0x4(%ebx),%esi
80104371:	56                   	push   %esi
80104372:	e8 79 01 00 00       	call   801044f0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104377:	8b 03                	mov    (%ebx),%eax
80104379:	83 c4 10             	add    $0x10,%esp
8010437c:	85 c0                	test   %eax,%eax
8010437e:	74 13                	je     80104393 <holdingsleep+0x33>
80104380:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104383:	e8 28 f4 ff ff       	call   801037b0 <myproc>
80104388:	39 58 10             	cmp    %ebx,0x10(%eax)
8010438b:	0f 94 c0             	sete   %al
8010438e:	0f b6 c0             	movzbl %al,%eax
80104391:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104393:	83 ec 0c             	sub    $0xc,%esp
80104396:	56                   	push   %esi
80104397:	e8 14 02 00 00       	call   801045b0 <release>
  return r;
}
8010439c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010439f:	89 f8                	mov    %edi,%eax
801043a1:	5b                   	pop    %ebx
801043a2:	5e                   	pop    %esi
801043a3:	5f                   	pop    %edi
801043a4:	5d                   	pop    %ebp
801043a5:	c3                   	ret    
801043a6:	66 90                	xchg   %ax,%ax
801043a8:	66 90                	xchg   %ax,%ax
801043aa:	66 90                	xchg   %ax,%ax
801043ac:	66 90                	xchg   %ax,%ax
801043ae:	66 90                	xchg   %ax,%ax

801043b0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801043b0:	55                   	push   %ebp
801043b1:	89 e5                	mov    %esp,%ebp
801043b3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801043b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801043b9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801043bf:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801043c2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801043c9:	5d                   	pop    %ebp
801043ca:	c3                   	ret    
801043cb:	90                   	nop
801043cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043d0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801043d0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801043d1:	31 d2                	xor    %edx,%edx
{
801043d3:	89 e5                	mov    %esp,%ebp
801043d5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801043d6:	8b 45 08             	mov    0x8(%ebp),%eax
{
801043d9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801043dc:	83 e8 08             	sub    $0x8,%eax
801043df:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801043e0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801043e6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801043ec:	77 1a                	ja     80104408 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801043ee:	8b 58 04             	mov    0x4(%eax),%ebx
801043f1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801043f4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801043f7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801043f9:	83 fa 0a             	cmp    $0xa,%edx
801043fc:	75 e2                	jne    801043e0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801043fe:	5b                   	pop    %ebx
801043ff:	5d                   	pop    %ebp
80104400:	c3                   	ret    
80104401:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104408:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010440b:	83 c1 28             	add    $0x28,%ecx
8010440e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104410:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104416:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104419:	39 c1                	cmp    %eax,%ecx
8010441b:	75 f3                	jne    80104410 <getcallerpcs+0x40>
}
8010441d:	5b                   	pop    %ebx
8010441e:	5d                   	pop    %ebp
8010441f:	c3                   	ret    

80104420 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104420:	55                   	push   %ebp
80104421:	89 e5                	mov    %esp,%ebp
80104423:	53                   	push   %ebx
80104424:	83 ec 04             	sub    $0x4,%esp
80104427:	9c                   	pushf  
80104428:	5b                   	pop    %ebx
  asm volatile("cli");
80104429:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010442a:	e8 11 f3 ff ff       	call   80103740 <mycpu>
8010442f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104435:	85 c0                	test   %eax,%eax
80104437:	75 11                	jne    8010444a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104439:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010443f:	e8 fc f2 ff ff       	call   80103740 <mycpu>
80104444:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010444a:	e8 f1 f2 ff ff       	call   80103740 <mycpu>
8010444f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104456:	83 c4 04             	add    $0x4,%esp
80104459:	5b                   	pop    %ebx
8010445a:	5d                   	pop    %ebp
8010445b:	c3                   	ret    
8010445c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104460 <popcli>:

void
popcli(void)
{
80104460:	55                   	push   %ebp
80104461:	89 e5                	mov    %esp,%ebp
80104463:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104466:	9c                   	pushf  
80104467:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104468:	f6 c4 02             	test   $0x2,%ah
8010446b:	75 35                	jne    801044a2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010446d:	e8 ce f2 ff ff       	call   80103740 <mycpu>
80104472:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104479:	78 34                	js     801044af <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010447b:	e8 c0 f2 ff ff       	call   80103740 <mycpu>
80104480:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104486:	85 d2                	test   %edx,%edx
80104488:	74 06                	je     80104490 <popcli+0x30>
    sti();
}
8010448a:	c9                   	leave  
8010448b:	c3                   	ret    
8010448c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104490:	e8 ab f2 ff ff       	call   80103740 <mycpu>
80104495:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010449b:	85 c0                	test   %eax,%eax
8010449d:	74 eb                	je     8010448a <popcli+0x2a>
  asm volatile("sti");
8010449f:	fb                   	sti    
}
801044a0:	c9                   	leave  
801044a1:	c3                   	ret    
    panic("popcli - interruptible");
801044a2:	83 ec 0c             	sub    $0xc,%esp
801044a5:	68 5b 79 10 80       	push   $0x8010795b
801044aa:	e8 e1 be ff ff       	call   80100390 <panic>
    panic("popcli");
801044af:	83 ec 0c             	sub    $0xc,%esp
801044b2:	68 72 79 10 80       	push   $0x80107972
801044b7:	e8 d4 be ff ff       	call   80100390 <panic>
801044bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801044c0 <holding>:
{
801044c0:	55                   	push   %ebp
801044c1:	89 e5                	mov    %esp,%ebp
801044c3:	56                   	push   %esi
801044c4:	53                   	push   %ebx
801044c5:	8b 75 08             	mov    0x8(%ebp),%esi
801044c8:	31 db                	xor    %ebx,%ebx
  pushcli();
801044ca:	e8 51 ff ff ff       	call   80104420 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801044cf:	8b 06                	mov    (%esi),%eax
801044d1:	85 c0                	test   %eax,%eax
801044d3:	74 10                	je     801044e5 <holding+0x25>
801044d5:	8b 5e 08             	mov    0x8(%esi),%ebx
801044d8:	e8 63 f2 ff ff       	call   80103740 <mycpu>
801044dd:	39 c3                	cmp    %eax,%ebx
801044df:	0f 94 c3             	sete   %bl
801044e2:	0f b6 db             	movzbl %bl,%ebx
  popcli();
801044e5:	e8 76 ff ff ff       	call   80104460 <popcli>
}
801044ea:	89 d8                	mov    %ebx,%eax
801044ec:	5b                   	pop    %ebx
801044ed:	5e                   	pop    %esi
801044ee:	5d                   	pop    %ebp
801044ef:	c3                   	ret    

801044f0 <acquire>:
{
801044f0:	55                   	push   %ebp
801044f1:	89 e5                	mov    %esp,%ebp
801044f3:	56                   	push   %esi
801044f4:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
801044f5:	e8 26 ff ff ff       	call   80104420 <pushcli>
  if(holding(lk))
801044fa:	8b 5d 08             	mov    0x8(%ebp),%ebx
801044fd:	83 ec 0c             	sub    $0xc,%esp
80104500:	53                   	push   %ebx
80104501:	e8 ba ff ff ff       	call   801044c0 <holding>
80104506:	83 c4 10             	add    $0x10,%esp
80104509:	85 c0                	test   %eax,%eax
8010450b:	0f 85 83 00 00 00    	jne    80104594 <acquire+0xa4>
80104511:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104513:	ba 01 00 00 00       	mov    $0x1,%edx
80104518:	eb 09                	jmp    80104523 <acquire+0x33>
8010451a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104520:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104523:	89 d0                	mov    %edx,%eax
80104525:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104528:	85 c0                	test   %eax,%eax
8010452a:	75 f4                	jne    80104520 <acquire+0x30>
  __sync_synchronize();
8010452c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104531:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104534:	e8 07 f2 ff ff       	call   80103740 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104539:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
8010453c:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
8010453f:	89 e8                	mov    %ebp,%eax
80104541:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104548:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
8010454e:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104554:	77 1a                	ja     80104570 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104556:	8b 48 04             	mov    0x4(%eax),%ecx
80104559:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
8010455c:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
8010455f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104561:	83 fe 0a             	cmp    $0xa,%esi
80104564:	75 e2                	jne    80104548 <acquire+0x58>
}
80104566:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104569:	5b                   	pop    %ebx
8010456a:	5e                   	pop    %esi
8010456b:	5d                   	pop    %ebp
8010456c:	c3                   	ret    
8010456d:	8d 76 00             	lea    0x0(%esi),%esi
80104570:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104573:	83 c2 28             	add    $0x28,%edx
80104576:	8d 76 00             	lea    0x0(%esi),%esi
80104579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104580:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104586:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104589:	39 d0                	cmp    %edx,%eax
8010458b:	75 f3                	jne    80104580 <acquire+0x90>
}
8010458d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104590:	5b                   	pop    %ebx
80104591:	5e                   	pop    %esi
80104592:	5d                   	pop    %ebp
80104593:	c3                   	ret    
    panic("acquire");
80104594:	83 ec 0c             	sub    $0xc,%esp
80104597:	68 79 79 10 80       	push   $0x80107979
8010459c:	e8 ef bd ff ff       	call   80100390 <panic>
801045a1:	eb 0d                	jmp    801045b0 <release>
801045a3:	90                   	nop
801045a4:	90                   	nop
801045a5:	90                   	nop
801045a6:	90                   	nop
801045a7:	90                   	nop
801045a8:	90                   	nop
801045a9:	90                   	nop
801045aa:	90                   	nop
801045ab:	90                   	nop
801045ac:	90                   	nop
801045ad:	90                   	nop
801045ae:	90                   	nop
801045af:	90                   	nop

801045b0 <release>:
{
801045b0:	55                   	push   %ebp
801045b1:	89 e5                	mov    %esp,%ebp
801045b3:	53                   	push   %ebx
801045b4:	83 ec 10             	sub    $0x10,%esp
801045b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
801045ba:	53                   	push   %ebx
801045bb:	e8 00 ff ff ff       	call   801044c0 <holding>
801045c0:	83 c4 10             	add    $0x10,%esp
801045c3:	85 c0                	test   %eax,%eax
801045c5:	74 22                	je     801045e9 <release+0x39>
  lk->pcs[0] = 0;
801045c7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801045ce:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801045d5:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801045da:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801045e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045e3:	c9                   	leave  
  popcli();
801045e4:	e9 77 fe ff ff       	jmp    80104460 <popcli>
    panic("release");
801045e9:	83 ec 0c             	sub    $0xc,%esp
801045ec:	68 81 79 10 80       	push   $0x80107981
801045f1:	e8 9a bd ff ff       	call   80100390 <panic>
801045f6:	66 90                	xchg   %ax,%ax
801045f8:	66 90                	xchg   %ax,%ax
801045fa:	66 90                	xchg   %ax,%ax
801045fc:	66 90                	xchg   %ax,%ax
801045fe:	66 90                	xchg   %ax,%ax

80104600 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104600:	55                   	push   %ebp
80104601:	89 e5                	mov    %esp,%ebp
80104603:	57                   	push   %edi
80104604:	53                   	push   %ebx
80104605:	8b 55 08             	mov    0x8(%ebp),%edx
80104608:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010460b:	f6 c2 03             	test   $0x3,%dl
8010460e:	75 05                	jne    80104615 <memset+0x15>
80104610:	f6 c1 03             	test   $0x3,%cl
80104613:	74 13                	je     80104628 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104615:	89 d7                	mov    %edx,%edi
80104617:	8b 45 0c             	mov    0xc(%ebp),%eax
8010461a:	fc                   	cld    
8010461b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010461d:	5b                   	pop    %ebx
8010461e:	89 d0                	mov    %edx,%eax
80104620:	5f                   	pop    %edi
80104621:	5d                   	pop    %ebp
80104622:	c3                   	ret    
80104623:	90                   	nop
80104624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104628:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010462c:	c1 e9 02             	shr    $0x2,%ecx
8010462f:	89 f8                	mov    %edi,%eax
80104631:	89 fb                	mov    %edi,%ebx
80104633:	c1 e0 18             	shl    $0x18,%eax
80104636:	c1 e3 10             	shl    $0x10,%ebx
80104639:	09 d8                	or     %ebx,%eax
8010463b:	09 f8                	or     %edi,%eax
8010463d:	c1 e7 08             	shl    $0x8,%edi
80104640:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104642:	89 d7                	mov    %edx,%edi
80104644:	fc                   	cld    
80104645:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104647:	5b                   	pop    %ebx
80104648:	89 d0                	mov    %edx,%eax
8010464a:	5f                   	pop    %edi
8010464b:	5d                   	pop    %ebp
8010464c:	c3                   	ret    
8010464d:	8d 76 00             	lea    0x0(%esi),%esi

80104650 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	57                   	push   %edi
80104654:	56                   	push   %esi
80104655:	53                   	push   %ebx
80104656:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104659:	8b 75 08             	mov    0x8(%ebp),%esi
8010465c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010465f:	85 db                	test   %ebx,%ebx
80104661:	74 29                	je     8010468c <memcmp+0x3c>
    if(*s1 != *s2)
80104663:	0f b6 16             	movzbl (%esi),%edx
80104666:	0f b6 0f             	movzbl (%edi),%ecx
80104669:	38 d1                	cmp    %dl,%cl
8010466b:	75 2b                	jne    80104698 <memcmp+0x48>
8010466d:	b8 01 00 00 00       	mov    $0x1,%eax
80104672:	eb 14                	jmp    80104688 <memcmp+0x38>
80104674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104678:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
8010467c:	83 c0 01             	add    $0x1,%eax
8010467f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104684:	38 ca                	cmp    %cl,%dl
80104686:	75 10                	jne    80104698 <memcmp+0x48>
  while(n-- > 0){
80104688:	39 d8                	cmp    %ebx,%eax
8010468a:	75 ec                	jne    80104678 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010468c:	5b                   	pop    %ebx
  return 0;
8010468d:	31 c0                	xor    %eax,%eax
}
8010468f:	5e                   	pop    %esi
80104690:	5f                   	pop    %edi
80104691:	5d                   	pop    %ebp
80104692:	c3                   	ret    
80104693:	90                   	nop
80104694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104698:	0f b6 c2             	movzbl %dl,%eax
}
8010469b:	5b                   	pop    %ebx
      return *s1 - *s2;
8010469c:	29 c8                	sub    %ecx,%eax
}
8010469e:	5e                   	pop    %esi
8010469f:	5f                   	pop    %edi
801046a0:	5d                   	pop    %ebp
801046a1:	c3                   	ret    
801046a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046b0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
801046b3:	56                   	push   %esi
801046b4:	53                   	push   %ebx
801046b5:	8b 45 08             	mov    0x8(%ebp),%eax
801046b8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801046bb:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801046be:	39 c3                	cmp    %eax,%ebx
801046c0:	73 26                	jae    801046e8 <memmove+0x38>
801046c2:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
801046c5:	39 c8                	cmp    %ecx,%eax
801046c7:	73 1f                	jae    801046e8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
801046c9:	85 f6                	test   %esi,%esi
801046cb:	8d 56 ff             	lea    -0x1(%esi),%edx
801046ce:	74 0f                	je     801046df <memmove+0x2f>
      *--d = *--s;
801046d0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801046d4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
801046d7:	83 ea 01             	sub    $0x1,%edx
801046da:	83 fa ff             	cmp    $0xffffffff,%edx
801046dd:	75 f1                	jne    801046d0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801046df:	5b                   	pop    %ebx
801046e0:	5e                   	pop    %esi
801046e1:	5d                   	pop    %ebp
801046e2:	c3                   	ret    
801046e3:	90                   	nop
801046e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
801046e8:	31 d2                	xor    %edx,%edx
801046ea:	85 f6                	test   %esi,%esi
801046ec:	74 f1                	je     801046df <memmove+0x2f>
801046ee:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
801046f0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801046f4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801046f7:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
801046fa:	39 d6                	cmp    %edx,%esi
801046fc:	75 f2                	jne    801046f0 <memmove+0x40>
}
801046fe:	5b                   	pop    %ebx
801046ff:	5e                   	pop    %esi
80104700:	5d                   	pop    %ebp
80104701:	c3                   	ret    
80104702:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104710 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104710:	55                   	push   %ebp
80104711:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104713:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104714:	eb 9a                	jmp    801046b0 <memmove>
80104716:	8d 76 00             	lea    0x0(%esi),%esi
80104719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104720 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	57                   	push   %edi
80104724:	56                   	push   %esi
80104725:	8b 7d 10             	mov    0x10(%ebp),%edi
80104728:	53                   	push   %ebx
80104729:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010472c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010472f:	85 ff                	test   %edi,%edi
80104731:	74 2f                	je     80104762 <strncmp+0x42>
80104733:	0f b6 01             	movzbl (%ecx),%eax
80104736:	0f b6 1e             	movzbl (%esi),%ebx
80104739:	84 c0                	test   %al,%al
8010473b:	74 37                	je     80104774 <strncmp+0x54>
8010473d:	38 c3                	cmp    %al,%bl
8010473f:	75 33                	jne    80104774 <strncmp+0x54>
80104741:	01 f7                	add    %esi,%edi
80104743:	eb 13                	jmp    80104758 <strncmp+0x38>
80104745:	8d 76 00             	lea    0x0(%esi),%esi
80104748:	0f b6 01             	movzbl (%ecx),%eax
8010474b:	84 c0                	test   %al,%al
8010474d:	74 21                	je     80104770 <strncmp+0x50>
8010474f:	0f b6 1a             	movzbl (%edx),%ebx
80104752:	89 d6                	mov    %edx,%esi
80104754:	38 d8                	cmp    %bl,%al
80104756:	75 1c                	jne    80104774 <strncmp+0x54>
    n--, p++, q++;
80104758:	8d 56 01             	lea    0x1(%esi),%edx
8010475b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
8010475e:	39 fa                	cmp    %edi,%edx
80104760:	75 e6                	jne    80104748 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104762:	5b                   	pop    %ebx
    return 0;
80104763:	31 c0                	xor    %eax,%eax
}
80104765:	5e                   	pop    %esi
80104766:	5f                   	pop    %edi
80104767:	5d                   	pop    %ebp
80104768:	c3                   	ret    
80104769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104770:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104774:	29 d8                	sub    %ebx,%eax
}
80104776:	5b                   	pop    %ebx
80104777:	5e                   	pop    %esi
80104778:	5f                   	pop    %edi
80104779:	5d                   	pop    %ebp
8010477a:	c3                   	ret    
8010477b:	90                   	nop
8010477c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104780 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	56                   	push   %esi
80104784:	53                   	push   %ebx
80104785:	8b 45 08             	mov    0x8(%ebp),%eax
80104788:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010478b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010478e:	89 c2                	mov    %eax,%edx
80104790:	eb 19                	jmp    801047ab <strncpy+0x2b>
80104792:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104798:	83 c3 01             	add    $0x1,%ebx
8010479b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010479f:	83 c2 01             	add    $0x1,%edx
801047a2:	84 c9                	test   %cl,%cl
801047a4:	88 4a ff             	mov    %cl,-0x1(%edx)
801047a7:	74 09                	je     801047b2 <strncpy+0x32>
801047a9:	89 f1                	mov    %esi,%ecx
801047ab:	85 c9                	test   %ecx,%ecx
801047ad:	8d 71 ff             	lea    -0x1(%ecx),%esi
801047b0:	7f e6                	jg     80104798 <strncpy+0x18>
    ;
  while(n-- > 0)
801047b2:	31 c9                	xor    %ecx,%ecx
801047b4:	85 f6                	test   %esi,%esi
801047b6:	7e 17                	jle    801047cf <strncpy+0x4f>
801047b8:	90                   	nop
801047b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
801047c0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
801047c4:	89 f3                	mov    %esi,%ebx
801047c6:	83 c1 01             	add    $0x1,%ecx
801047c9:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
801047cb:	85 db                	test   %ebx,%ebx
801047cd:	7f f1                	jg     801047c0 <strncpy+0x40>
  return os;
}
801047cf:	5b                   	pop    %ebx
801047d0:	5e                   	pop    %esi
801047d1:	5d                   	pop    %ebp
801047d2:	c3                   	ret    
801047d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801047d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047e0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	56                   	push   %esi
801047e4:	53                   	push   %ebx
801047e5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801047e8:	8b 45 08             	mov    0x8(%ebp),%eax
801047eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
801047ee:	85 c9                	test   %ecx,%ecx
801047f0:	7e 26                	jle    80104818 <safestrcpy+0x38>
801047f2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801047f6:	89 c1                	mov    %eax,%ecx
801047f8:	eb 17                	jmp    80104811 <safestrcpy+0x31>
801047fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104800:	83 c2 01             	add    $0x1,%edx
80104803:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104807:	83 c1 01             	add    $0x1,%ecx
8010480a:	84 db                	test   %bl,%bl
8010480c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010480f:	74 04                	je     80104815 <safestrcpy+0x35>
80104811:	39 f2                	cmp    %esi,%edx
80104813:	75 eb                	jne    80104800 <safestrcpy+0x20>
    ;
  *s = 0;
80104815:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104818:	5b                   	pop    %ebx
80104819:	5e                   	pop    %esi
8010481a:	5d                   	pop    %ebp
8010481b:	c3                   	ret    
8010481c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104820 <strlen>:

int
strlen(const char *s)
{
80104820:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104821:	31 c0                	xor    %eax,%eax
{
80104823:	89 e5                	mov    %esp,%ebp
80104825:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104828:	80 3a 00             	cmpb   $0x0,(%edx)
8010482b:	74 0c                	je     80104839 <strlen+0x19>
8010482d:	8d 76 00             	lea    0x0(%esi),%esi
80104830:	83 c0 01             	add    $0x1,%eax
80104833:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104837:	75 f7                	jne    80104830 <strlen+0x10>
    ;
  return n;
}
80104839:	5d                   	pop    %ebp
8010483a:	c3                   	ret    

8010483b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010483b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010483f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104843:	55                   	push   %ebp
  pushl %ebx
80104844:	53                   	push   %ebx
  pushl %esi
80104845:	56                   	push   %esi
  pushl %edi
80104846:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104847:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104849:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010484b:	5f                   	pop    %edi
  popl %esi
8010484c:	5e                   	pop    %esi
  popl %ebx
8010484d:	5b                   	pop    %ebx
  popl %ebp
8010484e:	5d                   	pop    %ebp
  ret
8010484f:	c3                   	ret    

80104850 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104850:	55                   	push   %ebp
80104851:	89 e5                	mov    %esp,%ebp
80104853:	53                   	push   %ebx
80104854:	83 ec 04             	sub    $0x4,%esp
80104857:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010485a:	e8 51 ef ff ff       	call   801037b0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010485f:	8b 00                	mov    (%eax),%eax
80104861:	39 d8                	cmp    %ebx,%eax
80104863:	76 1b                	jbe    80104880 <fetchint+0x30>
80104865:	8d 53 04             	lea    0x4(%ebx),%edx
80104868:	39 d0                	cmp    %edx,%eax
8010486a:	72 14                	jb     80104880 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010486c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010486f:	8b 13                	mov    (%ebx),%edx
80104871:	89 10                	mov    %edx,(%eax)
  return 0;
80104873:	31 c0                	xor    %eax,%eax
}
80104875:	83 c4 04             	add    $0x4,%esp
80104878:	5b                   	pop    %ebx
80104879:	5d                   	pop    %ebp
8010487a:	c3                   	ret    
8010487b:	90                   	nop
8010487c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104880:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104885:	eb ee                	jmp    80104875 <fetchint+0x25>
80104887:	89 f6                	mov    %esi,%esi
80104889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104890 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104890:	55                   	push   %ebp
80104891:	89 e5                	mov    %esp,%ebp
80104893:	53                   	push   %ebx
80104894:	83 ec 04             	sub    $0x4,%esp
80104897:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010489a:	e8 11 ef ff ff       	call   801037b0 <myproc>

  if(addr >= curproc->sz)
8010489f:	39 18                	cmp    %ebx,(%eax)
801048a1:	76 29                	jbe    801048cc <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
801048a3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801048a6:	89 da                	mov    %ebx,%edx
801048a8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
801048aa:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
801048ac:	39 c3                	cmp    %eax,%ebx
801048ae:	73 1c                	jae    801048cc <fetchstr+0x3c>
    if(*s == 0)
801048b0:	80 3b 00             	cmpb   $0x0,(%ebx)
801048b3:	75 10                	jne    801048c5 <fetchstr+0x35>
801048b5:	eb 39                	jmp    801048f0 <fetchstr+0x60>
801048b7:	89 f6                	mov    %esi,%esi
801048b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801048c0:	80 3a 00             	cmpb   $0x0,(%edx)
801048c3:	74 1b                	je     801048e0 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
801048c5:	83 c2 01             	add    $0x1,%edx
801048c8:	39 d0                	cmp    %edx,%eax
801048ca:	77 f4                	ja     801048c0 <fetchstr+0x30>
    return -1;
801048cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
801048d1:	83 c4 04             	add    $0x4,%esp
801048d4:	5b                   	pop    %ebx
801048d5:	5d                   	pop    %ebp
801048d6:	c3                   	ret    
801048d7:	89 f6                	mov    %esi,%esi
801048d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801048e0:	83 c4 04             	add    $0x4,%esp
801048e3:	89 d0                	mov    %edx,%eax
801048e5:	29 d8                	sub    %ebx,%eax
801048e7:	5b                   	pop    %ebx
801048e8:	5d                   	pop    %ebp
801048e9:	c3                   	ret    
801048ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
801048f0:	31 c0                	xor    %eax,%eax
      return s - *pp;
801048f2:	eb dd                	jmp    801048d1 <fetchstr+0x41>
801048f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104900 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	56                   	push   %esi
80104904:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104905:	e8 a6 ee ff ff       	call   801037b0 <myproc>
8010490a:	8b 40 18             	mov    0x18(%eax),%eax
8010490d:	8b 55 08             	mov    0x8(%ebp),%edx
80104910:	8b 40 44             	mov    0x44(%eax),%eax
80104913:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104916:	e8 95 ee ff ff       	call   801037b0 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010491b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010491d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104920:	39 c6                	cmp    %eax,%esi
80104922:	73 1c                	jae    80104940 <argint+0x40>
80104924:	8d 53 08             	lea    0x8(%ebx),%edx
80104927:	39 d0                	cmp    %edx,%eax
80104929:	72 15                	jb     80104940 <argint+0x40>
  *ip = *(int*)(addr);
8010492b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010492e:	8b 53 04             	mov    0x4(%ebx),%edx
80104931:	89 10                	mov    %edx,(%eax)
  return 0;
80104933:	31 c0                	xor    %eax,%eax
}
80104935:	5b                   	pop    %ebx
80104936:	5e                   	pop    %esi
80104937:	5d                   	pop    %ebp
80104938:	c3                   	ret    
80104939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104940:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104945:	eb ee                	jmp    80104935 <argint+0x35>
80104947:	89 f6                	mov    %esi,%esi
80104949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104950 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	56                   	push   %esi
80104954:	53                   	push   %ebx
80104955:	83 ec 10             	sub    $0x10,%esp
80104958:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010495b:	e8 50 ee ff ff       	call   801037b0 <myproc>
80104960:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104962:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104965:	83 ec 08             	sub    $0x8,%esp
80104968:	50                   	push   %eax
80104969:	ff 75 08             	pushl  0x8(%ebp)
8010496c:	e8 8f ff ff ff       	call   80104900 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104971:	83 c4 10             	add    $0x10,%esp
80104974:	85 c0                	test   %eax,%eax
80104976:	78 28                	js     801049a0 <argptr+0x50>
80104978:	85 db                	test   %ebx,%ebx
8010497a:	78 24                	js     801049a0 <argptr+0x50>
8010497c:	8b 16                	mov    (%esi),%edx
8010497e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104981:	39 c2                	cmp    %eax,%edx
80104983:	76 1b                	jbe    801049a0 <argptr+0x50>
80104985:	01 c3                	add    %eax,%ebx
80104987:	39 da                	cmp    %ebx,%edx
80104989:	72 15                	jb     801049a0 <argptr+0x50>
    return -1;
  *pp = (char*)i;
8010498b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010498e:	89 02                	mov    %eax,(%edx)
  return 0;
80104990:	31 c0                	xor    %eax,%eax
}
80104992:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104995:	5b                   	pop    %ebx
80104996:	5e                   	pop    %esi
80104997:	5d                   	pop    %ebp
80104998:	c3                   	ret    
80104999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801049a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049a5:	eb eb                	jmp    80104992 <argptr+0x42>
801049a7:	89 f6                	mov    %esi,%esi
801049a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049b0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801049b0:	55                   	push   %ebp
801049b1:	89 e5                	mov    %esp,%ebp
801049b3:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
801049b6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801049b9:	50                   	push   %eax
801049ba:	ff 75 08             	pushl  0x8(%ebp)
801049bd:	e8 3e ff ff ff       	call   80104900 <argint>
801049c2:	83 c4 10             	add    $0x10,%esp
801049c5:	85 c0                	test   %eax,%eax
801049c7:	78 17                	js     801049e0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
801049c9:	83 ec 08             	sub    $0x8,%esp
801049cc:	ff 75 0c             	pushl  0xc(%ebp)
801049cf:	ff 75 f4             	pushl  -0xc(%ebp)
801049d2:	e8 b9 fe ff ff       	call   80104890 <fetchstr>
801049d7:	83 c4 10             	add    $0x10,%esp
}
801049da:	c9                   	leave  
801049db:	c3                   	ret    
801049dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801049e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801049e5:	c9                   	leave  
801049e6:	c3                   	ret    
801049e7:	89 f6                	mov    %esi,%esi
801049e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049f0 <syscall>:
[SYS_lottery] sys_lottery,
};

void
syscall(void)
{
801049f0:	55                   	push   %ebp
801049f1:	89 e5                	mov    %esp,%ebp
801049f3:	53                   	push   %ebx
801049f4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
801049f7:	e8 b4 ed ff ff       	call   801037b0 <myproc>
801049fc:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
801049fe:	8b 40 18             	mov    0x18(%eax),%eax
80104a01:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104a04:	8d 50 ff             	lea    -0x1(%eax),%edx
80104a07:	83 fa 15             	cmp    $0x15,%edx
80104a0a:	77 1c                	ja     80104a28 <syscall+0x38>
80104a0c:	8b 14 85 c0 79 10 80 	mov    -0x7fef8640(,%eax,4),%edx
80104a13:	85 d2                	test   %edx,%edx
80104a15:	74 11                	je     80104a28 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104a17:	ff d2                	call   *%edx
80104a19:	8b 53 18             	mov    0x18(%ebx),%edx
80104a1c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104a1f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a22:	c9                   	leave  
80104a23:	c3                   	ret    
80104a24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104a28:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104a29:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104a2c:	50                   	push   %eax
80104a2d:	ff 73 10             	pushl  0x10(%ebx)
80104a30:	68 89 79 10 80       	push   $0x80107989
80104a35:	e8 26 bc ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
80104a3a:	8b 43 18             	mov    0x18(%ebx),%eax
80104a3d:	83 c4 10             	add    $0x10,%esp
80104a40:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104a47:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a4a:	c9                   	leave  
80104a4b:	c3                   	ret    
80104a4c:	66 90                	xchg   %ax,%ax
80104a4e:	66 90                	xchg   %ax,%ax

80104a50 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a50:	55                   	push   %ebp
80104a51:	89 e5                	mov    %esp,%ebp
80104a53:	57                   	push   %edi
80104a54:	56                   	push   %esi
80104a55:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a56:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80104a59:	83 ec 44             	sub    $0x44,%esp
80104a5c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104a5f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104a62:	56                   	push   %esi
80104a63:	50                   	push   %eax
{
80104a64:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104a67:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104a6a:	e8 a1 d4 ff ff       	call   80101f10 <nameiparent>
80104a6f:	83 c4 10             	add    $0x10,%esp
80104a72:	85 c0                	test   %eax,%eax
80104a74:	0f 84 46 01 00 00    	je     80104bc0 <create+0x170>
    return 0;
  ilock(dp);
80104a7a:	83 ec 0c             	sub    $0xc,%esp
80104a7d:	89 c3                	mov    %eax,%ebx
80104a7f:	50                   	push   %eax
80104a80:	e8 0b cc ff ff       	call   80101690 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104a85:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104a88:	83 c4 0c             	add    $0xc,%esp
80104a8b:	50                   	push   %eax
80104a8c:	56                   	push   %esi
80104a8d:	53                   	push   %ebx
80104a8e:	e8 2d d1 ff ff       	call   80101bc0 <dirlookup>
80104a93:	83 c4 10             	add    $0x10,%esp
80104a96:	85 c0                	test   %eax,%eax
80104a98:	89 c7                	mov    %eax,%edi
80104a9a:	74 34                	je     80104ad0 <create+0x80>
    iunlockput(dp);
80104a9c:	83 ec 0c             	sub    $0xc,%esp
80104a9f:	53                   	push   %ebx
80104aa0:	e8 7b ce ff ff       	call   80101920 <iunlockput>
    ilock(ip);
80104aa5:	89 3c 24             	mov    %edi,(%esp)
80104aa8:	e8 e3 cb ff ff       	call   80101690 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104aad:	83 c4 10             	add    $0x10,%esp
80104ab0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104ab5:	0f 85 95 00 00 00    	jne    80104b50 <create+0x100>
80104abb:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104ac0:	0f 85 8a 00 00 00    	jne    80104b50 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104ac6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ac9:	89 f8                	mov    %edi,%eax
80104acb:	5b                   	pop    %ebx
80104acc:	5e                   	pop    %esi
80104acd:	5f                   	pop    %edi
80104ace:	5d                   	pop    %ebp
80104acf:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80104ad0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104ad4:	83 ec 08             	sub    $0x8,%esp
80104ad7:	50                   	push   %eax
80104ad8:	ff 33                	pushl  (%ebx)
80104ada:	e8 41 ca ff ff       	call   80101520 <ialloc>
80104adf:	83 c4 10             	add    $0x10,%esp
80104ae2:	85 c0                	test   %eax,%eax
80104ae4:	89 c7                	mov    %eax,%edi
80104ae6:	0f 84 e8 00 00 00    	je     80104bd4 <create+0x184>
  ilock(ip);
80104aec:	83 ec 0c             	sub    $0xc,%esp
80104aef:	50                   	push   %eax
80104af0:	e8 9b cb ff ff       	call   80101690 <ilock>
  ip->major = major;
80104af5:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104af9:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104afd:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104b01:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104b05:	b8 01 00 00 00       	mov    $0x1,%eax
80104b0a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104b0e:	89 3c 24             	mov    %edi,(%esp)
80104b11:	e8 ca ca ff ff       	call   801015e0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104b16:	83 c4 10             	add    $0x10,%esp
80104b19:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104b1e:	74 50                	je     80104b70 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104b20:	83 ec 04             	sub    $0x4,%esp
80104b23:	ff 77 04             	pushl  0x4(%edi)
80104b26:	56                   	push   %esi
80104b27:	53                   	push   %ebx
80104b28:	e8 03 d3 ff ff       	call   80101e30 <dirlink>
80104b2d:	83 c4 10             	add    $0x10,%esp
80104b30:	85 c0                	test   %eax,%eax
80104b32:	0f 88 8f 00 00 00    	js     80104bc7 <create+0x177>
  iunlockput(dp);
80104b38:	83 ec 0c             	sub    $0xc,%esp
80104b3b:	53                   	push   %ebx
80104b3c:	e8 df cd ff ff       	call   80101920 <iunlockput>
  return ip;
80104b41:	83 c4 10             	add    $0x10,%esp
}
80104b44:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b47:	89 f8                	mov    %edi,%eax
80104b49:	5b                   	pop    %ebx
80104b4a:	5e                   	pop    %esi
80104b4b:	5f                   	pop    %edi
80104b4c:	5d                   	pop    %ebp
80104b4d:	c3                   	ret    
80104b4e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104b50:	83 ec 0c             	sub    $0xc,%esp
80104b53:	57                   	push   %edi
    return 0;
80104b54:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104b56:	e8 c5 cd ff ff       	call   80101920 <iunlockput>
    return 0;
80104b5b:	83 c4 10             	add    $0x10,%esp
}
80104b5e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b61:	89 f8                	mov    %edi,%eax
80104b63:	5b                   	pop    %ebx
80104b64:	5e                   	pop    %esi
80104b65:	5f                   	pop    %edi
80104b66:	5d                   	pop    %ebp
80104b67:	c3                   	ret    
80104b68:	90                   	nop
80104b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80104b70:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104b75:	83 ec 0c             	sub    $0xc,%esp
80104b78:	53                   	push   %ebx
80104b79:	e8 62 ca ff ff       	call   801015e0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104b7e:	83 c4 0c             	add    $0xc,%esp
80104b81:	ff 77 04             	pushl  0x4(%edi)
80104b84:	68 38 7a 10 80       	push   $0x80107a38
80104b89:	57                   	push   %edi
80104b8a:	e8 a1 d2 ff ff       	call   80101e30 <dirlink>
80104b8f:	83 c4 10             	add    $0x10,%esp
80104b92:	85 c0                	test   %eax,%eax
80104b94:	78 1c                	js     80104bb2 <create+0x162>
80104b96:	83 ec 04             	sub    $0x4,%esp
80104b99:	ff 73 04             	pushl  0x4(%ebx)
80104b9c:	68 37 7a 10 80       	push   $0x80107a37
80104ba1:	57                   	push   %edi
80104ba2:	e8 89 d2 ff ff       	call   80101e30 <dirlink>
80104ba7:	83 c4 10             	add    $0x10,%esp
80104baa:	85 c0                	test   %eax,%eax
80104bac:	0f 89 6e ff ff ff    	jns    80104b20 <create+0xd0>
      panic("create dots");
80104bb2:	83 ec 0c             	sub    $0xc,%esp
80104bb5:	68 2b 7a 10 80       	push   $0x80107a2b
80104bba:	e8 d1 b7 ff ff       	call   80100390 <panic>
80104bbf:	90                   	nop
    return 0;
80104bc0:	31 ff                	xor    %edi,%edi
80104bc2:	e9 ff fe ff ff       	jmp    80104ac6 <create+0x76>
    panic("create: dirlink");
80104bc7:	83 ec 0c             	sub    $0xc,%esp
80104bca:	68 3a 7a 10 80       	push   $0x80107a3a
80104bcf:	e8 bc b7 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80104bd4:	83 ec 0c             	sub    $0xc,%esp
80104bd7:	68 1c 7a 10 80       	push   $0x80107a1c
80104bdc:	e8 af b7 ff ff       	call   80100390 <panic>
80104be1:	eb 0d                	jmp    80104bf0 <argfd.constprop.0>
80104be3:	90                   	nop
80104be4:	90                   	nop
80104be5:	90                   	nop
80104be6:	90                   	nop
80104be7:	90                   	nop
80104be8:	90                   	nop
80104be9:	90                   	nop
80104bea:	90                   	nop
80104beb:	90                   	nop
80104bec:	90                   	nop
80104bed:	90                   	nop
80104bee:	90                   	nop
80104bef:	90                   	nop

80104bf0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104bf0:	55                   	push   %ebp
80104bf1:	89 e5                	mov    %esp,%ebp
80104bf3:	56                   	push   %esi
80104bf4:	53                   	push   %ebx
80104bf5:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104bf7:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104bfa:	89 d6                	mov    %edx,%esi
80104bfc:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104bff:	50                   	push   %eax
80104c00:	6a 00                	push   $0x0
80104c02:	e8 f9 fc ff ff       	call   80104900 <argint>
80104c07:	83 c4 10             	add    $0x10,%esp
80104c0a:	85 c0                	test   %eax,%eax
80104c0c:	78 2a                	js     80104c38 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104c0e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104c12:	77 24                	ja     80104c38 <argfd.constprop.0+0x48>
80104c14:	e8 97 eb ff ff       	call   801037b0 <myproc>
80104c19:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c1c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104c20:	85 c0                	test   %eax,%eax
80104c22:	74 14                	je     80104c38 <argfd.constprop.0+0x48>
  if(pfd)
80104c24:	85 db                	test   %ebx,%ebx
80104c26:	74 02                	je     80104c2a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104c28:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80104c2a:	89 06                	mov    %eax,(%esi)
  return 0;
80104c2c:	31 c0                	xor    %eax,%eax
}
80104c2e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c31:	5b                   	pop    %ebx
80104c32:	5e                   	pop    %esi
80104c33:	5d                   	pop    %ebp
80104c34:	c3                   	ret    
80104c35:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104c38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c3d:	eb ef                	jmp    80104c2e <argfd.constprop.0+0x3e>
80104c3f:	90                   	nop

80104c40 <sys_dup>:
{
80104c40:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104c41:	31 c0                	xor    %eax,%eax
{
80104c43:	89 e5                	mov    %esp,%ebp
80104c45:	56                   	push   %esi
80104c46:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104c47:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104c4a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104c4d:	e8 9e ff ff ff       	call   80104bf0 <argfd.constprop.0>
80104c52:	85 c0                	test   %eax,%eax
80104c54:	78 42                	js     80104c98 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80104c56:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104c59:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104c5b:	e8 50 eb ff ff       	call   801037b0 <myproc>
80104c60:	eb 0e                	jmp    80104c70 <sys_dup+0x30>
80104c62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104c68:	83 c3 01             	add    $0x1,%ebx
80104c6b:	83 fb 10             	cmp    $0x10,%ebx
80104c6e:	74 28                	je     80104c98 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80104c70:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104c74:	85 d2                	test   %edx,%edx
80104c76:	75 f0                	jne    80104c68 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80104c78:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104c7c:	83 ec 0c             	sub    $0xc,%esp
80104c7f:	ff 75 f4             	pushl  -0xc(%ebp)
80104c82:	e8 69 c1 ff ff       	call   80100df0 <filedup>
  return fd;
80104c87:	83 c4 10             	add    $0x10,%esp
}
80104c8a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c8d:	89 d8                	mov    %ebx,%eax
80104c8f:	5b                   	pop    %ebx
80104c90:	5e                   	pop    %esi
80104c91:	5d                   	pop    %ebp
80104c92:	c3                   	ret    
80104c93:	90                   	nop
80104c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c98:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104c9b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104ca0:	89 d8                	mov    %ebx,%eax
80104ca2:	5b                   	pop    %ebx
80104ca3:	5e                   	pop    %esi
80104ca4:	5d                   	pop    %ebp
80104ca5:	c3                   	ret    
80104ca6:	8d 76 00             	lea    0x0(%esi),%esi
80104ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104cb0 <sys_read>:
{
80104cb0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104cb1:	31 c0                	xor    %eax,%eax
{
80104cb3:	89 e5                	mov    %esp,%ebp
80104cb5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104cb8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104cbb:	e8 30 ff ff ff       	call   80104bf0 <argfd.constprop.0>
80104cc0:	85 c0                	test   %eax,%eax
80104cc2:	78 4c                	js     80104d10 <sys_read+0x60>
80104cc4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104cc7:	83 ec 08             	sub    $0x8,%esp
80104cca:	50                   	push   %eax
80104ccb:	6a 02                	push   $0x2
80104ccd:	e8 2e fc ff ff       	call   80104900 <argint>
80104cd2:	83 c4 10             	add    $0x10,%esp
80104cd5:	85 c0                	test   %eax,%eax
80104cd7:	78 37                	js     80104d10 <sys_read+0x60>
80104cd9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104cdc:	83 ec 04             	sub    $0x4,%esp
80104cdf:	ff 75 f0             	pushl  -0x10(%ebp)
80104ce2:	50                   	push   %eax
80104ce3:	6a 01                	push   $0x1
80104ce5:	e8 66 fc ff ff       	call   80104950 <argptr>
80104cea:	83 c4 10             	add    $0x10,%esp
80104ced:	85 c0                	test   %eax,%eax
80104cef:	78 1f                	js     80104d10 <sys_read+0x60>
  return fileread(f, p, n);
80104cf1:	83 ec 04             	sub    $0x4,%esp
80104cf4:	ff 75 f0             	pushl  -0x10(%ebp)
80104cf7:	ff 75 f4             	pushl  -0xc(%ebp)
80104cfa:	ff 75 ec             	pushl  -0x14(%ebp)
80104cfd:	e8 5e c2 ff ff       	call   80100f60 <fileread>
80104d02:	83 c4 10             	add    $0x10,%esp
}
80104d05:	c9                   	leave  
80104d06:	c3                   	ret    
80104d07:	89 f6                	mov    %esi,%esi
80104d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104d10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d15:	c9                   	leave  
80104d16:	c3                   	ret    
80104d17:	89 f6                	mov    %esi,%esi
80104d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d20 <sys_write>:
{
80104d20:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d21:	31 c0                	xor    %eax,%eax
{
80104d23:	89 e5                	mov    %esp,%ebp
80104d25:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d28:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d2b:	e8 c0 fe ff ff       	call   80104bf0 <argfd.constprop.0>
80104d30:	85 c0                	test   %eax,%eax
80104d32:	78 4c                	js     80104d80 <sys_write+0x60>
80104d34:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d37:	83 ec 08             	sub    $0x8,%esp
80104d3a:	50                   	push   %eax
80104d3b:	6a 02                	push   $0x2
80104d3d:	e8 be fb ff ff       	call   80104900 <argint>
80104d42:	83 c4 10             	add    $0x10,%esp
80104d45:	85 c0                	test   %eax,%eax
80104d47:	78 37                	js     80104d80 <sys_write+0x60>
80104d49:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d4c:	83 ec 04             	sub    $0x4,%esp
80104d4f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d52:	50                   	push   %eax
80104d53:	6a 01                	push   $0x1
80104d55:	e8 f6 fb ff ff       	call   80104950 <argptr>
80104d5a:	83 c4 10             	add    $0x10,%esp
80104d5d:	85 c0                	test   %eax,%eax
80104d5f:	78 1f                	js     80104d80 <sys_write+0x60>
  return filewrite(f, p, n);
80104d61:	83 ec 04             	sub    $0x4,%esp
80104d64:	ff 75 f0             	pushl  -0x10(%ebp)
80104d67:	ff 75 f4             	pushl  -0xc(%ebp)
80104d6a:	ff 75 ec             	pushl  -0x14(%ebp)
80104d6d:	e8 7e c2 ff ff       	call   80100ff0 <filewrite>
80104d72:	83 c4 10             	add    $0x10,%esp
}
80104d75:	c9                   	leave  
80104d76:	c3                   	ret    
80104d77:	89 f6                	mov    %esi,%esi
80104d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104d80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d85:	c9                   	leave  
80104d86:	c3                   	ret    
80104d87:	89 f6                	mov    %esi,%esi
80104d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d90 <sys_close>:
{
80104d90:	55                   	push   %ebp
80104d91:	89 e5                	mov    %esp,%ebp
80104d93:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104d96:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104d99:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d9c:	e8 4f fe ff ff       	call   80104bf0 <argfd.constprop.0>
80104da1:	85 c0                	test   %eax,%eax
80104da3:	78 2b                	js     80104dd0 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80104da5:	e8 06 ea ff ff       	call   801037b0 <myproc>
80104daa:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104dad:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104db0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104db7:	00 
  fileclose(f);
80104db8:	ff 75 f4             	pushl  -0xc(%ebp)
80104dbb:	e8 80 c0 ff ff       	call   80100e40 <fileclose>
  return 0;
80104dc0:	83 c4 10             	add    $0x10,%esp
80104dc3:	31 c0                	xor    %eax,%eax
}
80104dc5:	c9                   	leave  
80104dc6:	c3                   	ret    
80104dc7:	89 f6                	mov    %esi,%esi
80104dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104dd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104dd5:	c9                   	leave  
80104dd6:	c3                   	ret    
80104dd7:	89 f6                	mov    %esi,%esi
80104dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104de0 <sys_fstat>:
{
80104de0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104de1:	31 c0                	xor    %eax,%eax
{
80104de3:	89 e5                	mov    %esp,%ebp
80104de5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104de8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104deb:	e8 00 fe ff ff       	call   80104bf0 <argfd.constprop.0>
80104df0:	85 c0                	test   %eax,%eax
80104df2:	78 2c                	js     80104e20 <sys_fstat+0x40>
80104df4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104df7:	83 ec 04             	sub    $0x4,%esp
80104dfa:	6a 14                	push   $0x14
80104dfc:	50                   	push   %eax
80104dfd:	6a 01                	push   $0x1
80104dff:	e8 4c fb ff ff       	call   80104950 <argptr>
80104e04:	83 c4 10             	add    $0x10,%esp
80104e07:	85 c0                	test   %eax,%eax
80104e09:	78 15                	js     80104e20 <sys_fstat+0x40>
  return filestat(f, st);
80104e0b:	83 ec 08             	sub    $0x8,%esp
80104e0e:	ff 75 f4             	pushl  -0xc(%ebp)
80104e11:	ff 75 f0             	pushl  -0x10(%ebp)
80104e14:	e8 f7 c0 ff ff       	call   80100f10 <filestat>
80104e19:	83 c4 10             	add    $0x10,%esp
}
80104e1c:	c9                   	leave  
80104e1d:	c3                   	ret    
80104e1e:	66 90                	xchg   %ax,%ax
    return -1;
80104e20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e25:	c9                   	leave  
80104e26:	c3                   	ret    
80104e27:	89 f6                	mov    %esi,%esi
80104e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e30 <sys_link>:
{
80104e30:	55                   	push   %ebp
80104e31:	89 e5                	mov    %esp,%ebp
80104e33:	57                   	push   %edi
80104e34:	56                   	push   %esi
80104e35:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e36:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104e39:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e3c:	50                   	push   %eax
80104e3d:	6a 00                	push   $0x0
80104e3f:	e8 6c fb ff ff       	call   801049b0 <argstr>
80104e44:	83 c4 10             	add    $0x10,%esp
80104e47:	85 c0                	test   %eax,%eax
80104e49:	0f 88 fb 00 00 00    	js     80104f4a <sys_link+0x11a>
80104e4f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104e52:	83 ec 08             	sub    $0x8,%esp
80104e55:	50                   	push   %eax
80104e56:	6a 01                	push   $0x1
80104e58:	e8 53 fb ff ff       	call   801049b0 <argstr>
80104e5d:	83 c4 10             	add    $0x10,%esp
80104e60:	85 c0                	test   %eax,%eax
80104e62:	0f 88 e2 00 00 00    	js     80104f4a <sys_link+0x11a>
  begin_op();
80104e68:	e8 43 dd ff ff       	call   80102bb0 <begin_op>
  if((ip = namei(old)) == 0){
80104e6d:	83 ec 0c             	sub    $0xc,%esp
80104e70:	ff 75 d4             	pushl  -0x2c(%ebp)
80104e73:	e8 78 d0 ff ff       	call   80101ef0 <namei>
80104e78:	83 c4 10             	add    $0x10,%esp
80104e7b:	85 c0                	test   %eax,%eax
80104e7d:	89 c3                	mov    %eax,%ebx
80104e7f:	0f 84 ea 00 00 00    	je     80104f6f <sys_link+0x13f>
  ilock(ip);
80104e85:	83 ec 0c             	sub    $0xc,%esp
80104e88:	50                   	push   %eax
80104e89:	e8 02 c8 ff ff       	call   80101690 <ilock>
  if(ip->type == T_DIR){
80104e8e:	83 c4 10             	add    $0x10,%esp
80104e91:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104e96:	0f 84 bb 00 00 00    	je     80104f57 <sys_link+0x127>
  ip->nlink++;
80104e9c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104ea1:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80104ea4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104ea7:	53                   	push   %ebx
80104ea8:	e8 33 c7 ff ff       	call   801015e0 <iupdate>
  iunlock(ip);
80104ead:	89 1c 24             	mov    %ebx,(%esp)
80104eb0:	e8 bb c8 ff ff       	call   80101770 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104eb5:	58                   	pop    %eax
80104eb6:	5a                   	pop    %edx
80104eb7:	57                   	push   %edi
80104eb8:	ff 75 d0             	pushl  -0x30(%ebp)
80104ebb:	e8 50 d0 ff ff       	call   80101f10 <nameiparent>
80104ec0:	83 c4 10             	add    $0x10,%esp
80104ec3:	85 c0                	test   %eax,%eax
80104ec5:	89 c6                	mov    %eax,%esi
80104ec7:	74 5b                	je     80104f24 <sys_link+0xf4>
  ilock(dp);
80104ec9:	83 ec 0c             	sub    $0xc,%esp
80104ecc:	50                   	push   %eax
80104ecd:	e8 be c7 ff ff       	call   80101690 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104ed2:	83 c4 10             	add    $0x10,%esp
80104ed5:	8b 03                	mov    (%ebx),%eax
80104ed7:	39 06                	cmp    %eax,(%esi)
80104ed9:	75 3d                	jne    80104f18 <sys_link+0xe8>
80104edb:	83 ec 04             	sub    $0x4,%esp
80104ede:	ff 73 04             	pushl  0x4(%ebx)
80104ee1:	57                   	push   %edi
80104ee2:	56                   	push   %esi
80104ee3:	e8 48 cf ff ff       	call   80101e30 <dirlink>
80104ee8:	83 c4 10             	add    $0x10,%esp
80104eeb:	85 c0                	test   %eax,%eax
80104eed:	78 29                	js     80104f18 <sys_link+0xe8>
  iunlockput(dp);
80104eef:	83 ec 0c             	sub    $0xc,%esp
80104ef2:	56                   	push   %esi
80104ef3:	e8 28 ca ff ff       	call   80101920 <iunlockput>
  iput(ip);
80104ef8:	89 1c 24             	mov    %ebx,(%esp)
80104efb:	e8 c0 c8 ff ff       	call   801017c0 <iput>
  end_op();
80104f00:	e8 1b dd ff ff       	call   80102c20 <end_op>
  return 0;
80104f05:	83 c4 10             	add    $0x10,%esp
80104f08:	31 c0                	xor    %eax,%eax
}
80104f0a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f0d:	5b                   	pop    %ebx
80104f0e:	5e                   	pop    %esi
80104f0f:	5f                   	pop    %edi
80104f10:	5d                   	pop    %ebp
80104f11:	c3                   	ret    
80104f12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80104f18:	83 ec 0c             	sub    $0xc,%esp
80104f1b:	56                   	push   %esi
80104f1c:	e8 ff c9 ff ff       	call   80101920 <iunlockput>
    goto bad;
80104f21:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80104f24:	83 ec 0c             	sub    $0xc,%esp
80104f27:	53                   	push   %ebx
80104f28:	e8 63 c7 ff ff       	call   80101690 <ilock>
  ip->nlink--;
80104f2d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f32:	89 1c 24             	mov    %ebx,(%esp)
80104f35:	e8 a6 c6 ff ff       	call   801015e0 <iupdate>
  iunlockput(ip);
80104f3a:	89 1c 24             	mov    %ebx,(%esp)
80104f3d:	e8 de c9 ff ff       	call   80101920 <iunlockput>
  end_op();
80104f42:	e8 d9 dc ff ff       	call   80102c20 <end_op>
  return -1;
80104f47:	83 c4 10             	add    $0x10,%esp
}
80104f4a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104f4d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f52:	5b                   	pop    %ebx
80104f53:	5e                   	pop    %esi
80104f54:	5f                   	pop    %edi
80104f55:	5d                   	pop    %ebp
80104f56:	c3                   	ret    
    iunlockput(ip);
80104f57:	83 ec 0c             	sub    $0xc,%esp
80104f5a:	53                   	push   %ebx
80104f5b:	e8 c0 c9 ff ff       	call   80101920 <iunlockput>
    end_op();
80104f60:	e8 bb dc ff ff       	call   80102c20 <end_op>
    return -1;
80104f65:	83 c4 10             	add    $0x10,%esp
80104f68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f6d:	eb 9b                	jmp    80104f0a <sys_link+0xda>
    end_op();
80104f6f:	e8 ac dc ff ff       	call   80102c20 <end_op>
    return -1;
80104f74:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f79:	eb 8f                	jmp    80104f0a <sys_link+0xda>
80104f7b:	90                   	nop
80104f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f80 <sys_unlink>:
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	57                   	push   %edi
80104f84:	56                   	push   %esi
80104f85:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80104f86:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80104f89:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
80104f8c:	50                   	push   %eax
80104f8d:	6a 00                	push   $0x0
80104f8f:	e8 1c fa ff ff       	call   801049b0 <argstr>
80104f94:	83 c4 10             	add    $0x10,%esp
80104f97:	85 c0                	test   %eax,%eax
80104f99:	0f 88 77 01 00 00    	js     80105116 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
80104f9f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80104fa2:	e8 09 dc ff ff       	call   80102bb0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104fa7:	83 ec 08             	sub    $0x8,%esp
80104faa:	53                   	push   %ebx
80104fab:	ff 75 c0             	pushl  -0x40(%ebp)
80104fae:	e8 5d cf ff ff       	call   80101f10 <nameiparent>
80104fb3:	83 c4 10             	add    $0x10,%esp
80104fb6:	85 c0                	test   %eax,%eax
80104fb8:	89 c6                	mov    %eax,%esi
80104fba:	0f 84 60 01 00 00    	je     80105120 <sys_unlink+0x1a0>
  ilock(dp);
80104fc0:	83 ec 0c             	sub    $0xc,%esp
80104fc3:	50                   	push   %eax
80104fc4:	e8 c7 c6 ff ff       	call   80101690 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104fc9:	58                   	pop    %eax
80104fca:	5a                   	pop    %edx
80104fcb:	68 38 7a 10 80       	push   $0x80107a38
80104fd0:	53                   	push   %ebx
80104fd1:	e8 ca cb ff ff       	call   80101ba0 <namecmp>
80104fd6:	83 c4 10             	add    $0x10,%esp
80104fd9:	85 c0                	test   %eax,%eax
80104fdb:	0f 84 03 01 00 00    	je     801050e4 <sys_unlink+0x164>
80104fe1:	83 ec 08             	sub    $0x8,%esp
80104fe4:	68 37 7a 10 80       	push   $0x80107a37
80104fe9:	53                   	push   %ebx
80104fea:	e8 b1 cb ff ff       	call   80101ba0 <namecmp>
80104fef:	83 c4 10             	add    $0x10,%esp
80104ff2:	85 c0                	test   %eax,%eax
80104ff4:	0f 84 ea 00 00 00    	je     801050e4 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
80104ffa:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104ffd:	83 ec 04             	sub    $0x4,%esp
80105000:	50                   	push   %eax
80105001:	53                   	push   %ebx
80105002:	56                   	push   %esi
80105003:	e8 b8 cb ff ff       	call   80101bc0 <dirlookup>
80105008:	83 c4 10             	add    $0x10,%esp
8010500b:	85 c0                	test   %eax,%eax
8010500d:	89 c3                	mov    %eax,%ebx
8010500f:	0f 84 cf 00 00 00    	je     801050e4 <sys_unlink+0x164>
  ilock(ip);
80105015:	83 ec 0c             	sub    $0xc,%esp
80105018:	50                   	push   %eax
80105019:	e8 72 c6 ff ff       	call   80101690 <ilock>
  if(ip->nlink < 1)
8010501e:	83 c4 10             	add    $0x10,%esp
80105021:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105026:	0f 8e 10 01 00 00    	jle    8010513c <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010502c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105031:	74 6d                	je     801050a0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105033:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105036:	83 ec 04             	sub    $0x4,%esp
80105039:	6a 10                	push   $0x10
8010503b:	6a 00                	push   $0x0
8010503d:	50                   	push   %eax
8010503e:	e8 bd f5 ff ff       	call   80104600 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105043:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105046:	6a 10                	push   $0x10
80105048:	ff 75 c4             	pushl  -0x3c(%ebp)
8010504b:	50                   	push   %eax
8010504c:	56                   	push   %esi
8010504d:	e8 1e ca ff ff       	call   80101a70 <writei>
80105052:	83 c4 20             	add    $0x20,%esp
80105055:	83 f8 10             	cmp    $0x10,%eax
80105058:	0f 85 eb 00 00 00    	jne    80105149 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
8010505e:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105063:	0f 84 97 00 00 00    	je     80105100 <sys_unlink+0x180>
  iunlockput(dp);
80105069:	83 ec 0c             	sub    $0xc,%esp
8010506c:	56                   	push   %esi
8010506d:	e8 ae c8 ff ff       	call   80101920 <iunlockput>
  ip->nlink--;
80105072:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105077:	89 1c 24             	mov    %ebx,(%esp)
8010507a:	e8 61 c5 ff ff       	call   801015e0 <iupdate>
  iunlockput(ip);
8010507f:	89 1c 24             	mov    %ebx,(%esp)
80105082:	e8 99 c8 ff ff       	call   80101920 <iunlockput>
  end_op();
80105087:	e8 94 db ff ff       	call   80102c20 <end_op>
  return 0;
8010508c:	83 c4 10             	add    $0x10,%esp
8010508f:	31 c0                	xor    %eax,%eax
}
80105091:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105094:	5b                   	pop    %ebx
80105095:	5e                   	pop    %esi
80105096:	5f                   	pop    %edi
80105097:	5d                   	pop    %ebp
80105098:	c3                   	ret    
80105099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801050a0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801050a4:	76 8d                	jbe    80105033 <sys_unlink+0xb3>
801050a6:	bf 20 00 00 00       	mov    $0x20,%edi
801050ab:	eb 0f                	jmp    801050bc <sys_unlink+0x13c>
801050ad:	8d 76 00             	lea    0x0(%esi),%esi
801050b0:	83 c7 10             	add    $0x10,%edi
801050b3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801050b6:	0f 83 77 ff ff ff    	jae    80105033 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801050bc:	8d 45 d8             	lea    -0x28(%ebp),%eax
801050bf:	6a 10                	push   $0x10
801050c1:	57                   	push   %edi
801050c2:	50                   	push   %eax
801050c3:	53                   	push   %ebx
801050c4:	e8 a7 c8 ff ff       	call   80101970 <readi>
801050c9:	83 c4 10             	add    $0x10,%esp
801050cc:	83 f8 10             	cmp    $0x10,%eax
801050cf:	75 5e                	jne    8010512f <sys_unlink+0x1af>
    if(de.inum != 0)
801050d1:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801050d6:	74 d8                	je     801050b0 <sys_unlink+0x130>
    iunlockput(ip);
801050d8:	83 ec 0c             	sub    $0xc,%esp
801050db:	53                   	push   %ebx
801050dc:	e8 3f c8 ff ff       	call   80101920 <iunlockput>
    goto bad;
801050e1:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
801050e4:	83 ec 0c             	sub    $0xc,%esp
801050e7:	56                   	push   %esi
801050e8:	e8 33 c8 ff ff       	call   80101920 <iunlockput>
  end_op();
801050ed:	e8 2e db ff ff       	call   80102c20 <end_op>
  return -1;
801050f2:	83 c4 10             	add    $0x10,%esp
801050f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050fa:	eb 95                	jmp    80105091 <sys_unlink+0x111>
801050fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105100:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105105:	83 ec 0c             	sub    $0xc,%esp
80105108:	56                   	push   %esi
80105109:	e8 d2 c4 ff ff       	call   801015e0 <iupdate>
8010510e:	83 c4 10             	add    $0x10,%esp
80105111:	e9 53 ff ff ff       	jmp    80105069 <sys_unlink+0xe9>
    return -1;
80105116:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010511b:	e9 71 ff ff ff       	jmp    80105091 <sys_unlink+0x111>
    end_op();
80105120:	e8 fb da ff ff       	call   80102c20 <end_op>
    return -1;
80105125:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010512a:	e9 62 ff ff ff       	jmp    80105091 <sys_unlink+0x111>
      panic("isdirempty: readi");
8010512f:	83 ec 0c             	sub    $0xc,%esp
80105132:	68 5c 7a 10 80       	push   $0x80107a5c
80105137:	e8 54 b2 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
8010513c:	83 ec 0c             	sub    $0xc,%esp
8010513f:	68 4a 7a 10 80       	push   $0x80107a4a
80105144:	e8 47 b2 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105149:	83 ec 0c             	sub    $0xc,%esp
8010514c:	68 6e 7a 10 80       	push   $0x80107a6e
80105151:	e8 3a b2 ff ff       	call   80100390 <panic>
80105156:	8d 76 00             	lea    0x0(%esi),%esi
80105159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105160 <sys_open>:

int
sys_open(void)
{
80105160:	55                   	push   %ebp
80105161:	89 e5                	mov    %esp,%ebp
80105163:	57                   	push   %edi
80105164:	56                   	push   %esi
80105165:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105166:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105169:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010516c:	50                   	push   %eax
8010516d:	6a 00                	push   $0x0
8010516f:	e8 3c f8 ff ff       	call   801049b0 <argstr>
80105174:	83 c4 10             	add    $0x10,%esp
80105177:	85 c0                	test   %eax,%eax
80105179:	0f 88 1d 01 00 00    	js     8010529c <sys_open+0x13c>
8010517f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105182:	83 ec 08             	sub    $0x8,%esp
80105185:	50                   	push   %eax
80105186:	6a 01                	push   $0x1
80105188:	e8 73 f7 ff ff       	call   80104900 <argint>
8010518d:	83 c4 10             	add    $0x10,%esp
80105190:	85 c0                	test   %eax,%eax
80105192:	0f 88 04 01 00 00    	js     8010529c <sys_open+0x13c>
    return -1;

  begin_op();
80105198:	e8 13 da ff ff       	call   80102bb0 <begin_op>

  if(omode & O_CREATE){
8010519d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801051a1:	0f 85 a9 00 00 00    	jne    80105250 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801051a7:	83 ec 0c             	sub    $0xc,%esp
801051aa:	ff 75 e0             	pushl  -0x20(%ebp)
801051ad:	e8 3e cd ff ff       	call   80101ef0 <namei>
801051b2:	83 c4 10             	add    $0x10,%esp
801051b5:	85 c0                	test   %eax,%eax
801051b7:	89 c6                	mov    %eax,%esi
801051b9:	0f 84 b2 00 00 00    	je     80105271 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
801051bf:	83 ec 0c             	sub    $0xc,%esp
801051c2:	50                   	push   %eax
801051c3:	e8 c8 c4 ff ff       	call   80101690 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801051c8:	83 c4 10             	add    $0x10,%esp
801051cb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801051d0:	0f 84 aa 00 00 00    	je     80105280 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801051d6:	e8 a5 bb ff ff       	call   80100d80 <filealloc>
801051db:	85 c0                	test   %eax,%eax
801051dd:	89 c7                	mov    %eax,%edi
801051df:	0f 84 a6 00 00 00    	je     8010528b <sys_open+0x12b>
  struct proc *curproc = myproc();
801051e5:	e8 c6 e5 ff ff       	call   801037b0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801051ea:	31 db                	xor    %ebx,%ebx
801051ec:	eb 0e                	jmp    801051fc <sys_open+0x9c>
801051ee:	66 90                	xchg   %ax,%ax
801051f0:	83 c3 01             	add    $0x1,%ebx
801051f3:	83 fb 10             	cmp    $0x10,%ebx
801051f6:	0f 84 ac 00 00 00    	je     801052a8 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
801051fc:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105200:	85 d2                	test   %edx,%edx
80105202:	75 ec                	jne    801051f0 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105204:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105207:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010520b:	56                   	push   %esi
8010520c:	e8 5f c5 ff ff       	call   80101770 <iunlock>
  end_op();
80105211:	e8 0a da ff ff       	call   80102c20 <end_op>

  f->type = FD_INODE;
80105216:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010521c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010521f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105222:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105225:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010522c:	89 d0                	mov    %edx,%eax
8010522e:	f7 d0                	not    %eax
80105230:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105233:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105236:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105239:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
8010523d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105240:	89 d8                	mov    %ebx,%eax
80105242:	5b                   	pop    %ebx
80105243:	5e                   	pop    %esi
80105244:	5f                   	pop    %edi
80105245:	5d                   	pop    %ebp
80105246:	c3                   	ret    
80105247:	89 f6                	mov    %esi,%esi
80105249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105250:	83 ec 0c             	sub    $0xc,%esp
80105253:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105256:	31 c9                	xor    %ecx,%ecx
80105258:	6a 00                	push   $0x0
8010525a:	ba 02 00 00 00       	mov    $0x2,%edx
8010525f:	e8 ec f7 ff ff       	call   80104a50 <create>
    if(ip == 0){
80105264:	83 c4 10             	add    $0x10,%esp
80105267:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105269:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010526b:	0f 85 65 ff ff ff    	jne    801051d6 <sys_open+0x76>
      end_op();
80105271:	e8 aa d9 ff ff       	call   80102c20 <end_op>
      return -1;
80105276:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010527b:	eb c0                	jmp    8010523d <sys_open+0xdd>
8010527d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105280:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105283:	85 c9                	test   %ecx,%ecx
80105285:	0f 84 4b ff ff ff    	je     801051d6 <sys_open+0x76>
    iunlockput(ip);
8010528b:	83 ec 0c             	sub    $0xc,%esp
8010528e:	56                   	push   %esi
8010528f:	e8 8c c6 ff ff       	call   80101920 <iunlockput>
    end_op();
80105294:	e8 87 d9 ff ff       	call   80102c20 <end_op>
    return -1;
80105299:	83 c4 10             	add    $0x10,%esp
8010529c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801052a1:	eb 9a                	jmp    8010523d <sys_open+0xdd>
801052a3:	90                   	nop
801052a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
801052a8:	83 ec 0c             	sub    $0xc,%esp
801052ab:	57                   	push   %edi
801052ac:	e8 8f bb ff ff       	call   80100e40 <fileclose>
801052b1:	83 c4 10             	add    $0x10,%esp
801052b4:	eb d5                	jmp    8010528b <sys_open+0x12b>
801052b6:	8d 76 00             	lea    0x0(%esi),%esi
801052b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052c0 <sys_mkdir>:

int
sys_mkdir(void)
{
801052c0:	55                   	push   %ebp
801052c1:	89 e5                	mov    %esp,%ebp
801052c3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801052c6:	e8 e5 d8 ff ff       	call   80102bb0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801052cb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052ce:	83 ec 08             	sub    $0x8,%esp
801052d1:	50                   	push   %eax
801052d2:	6a 00                	push   $0x0
801052d4:	e8 d7 f6 ff ff       	call   801049b0 <argstr>
801052d9:	83 c4 10             	add    $0x10,%esp
801052dc:	85 c0                	test   %eax,%eax
801052de:	78 30                	js     80105310 <sys_mkdir+0x50>
801052e0:	83 ec 0c             	sub    $0xc,%esp
801052e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052e6:	31 c9                	xor    %ecx,%ecx
801052e8:	6a 00                	push   $0x0
801052ea:	ba 01 00 00 00       	mov    $0x1,%edx
801052ef:	e8 5c f7 ff ff       	call   80104a50 <create>
801052f4:	83 c4 10             	add    $0x10,%esp
801052f7:	85 c0                	test   %eax,%eax
801052f9:	74 15                	je     80105310 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801052fb:	83 ec 0c             	sub    $0xc,%esp
801052fe:	50                   	push   %eax
801052ff:	e8 1c c6 ff ff       	call   80101920 <iunlockput>
  end_op();
80105304:	e8 17 d9 ff ff       	call   80102c20 <end_op>
  return 0;
80105309:	83 c4 10             	add    $0x10,%esp
8010530c:	31 c0                	xor    %eax,%eax
}
8010530e:	c9                   	leave  
8010530f:	c3                   	ret    
    end_op();
80105310:	e8 0b d9 ff ff       	call   80102c20 <end_op>
    return -1;
80105315:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010531a:	c9                   	leave  
8010531b:	c3                   	ret    
8010531c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105320 <sys_mknod>:

int
sys_mknod(void)
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105326:	e8 85 d8 ff ff       	call   80102bb0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010532b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010532e:	83 ec 08             	sub    $0x8,%esp
80105331:	50                   	push   %eax
80105332:	6a 00                	push   $0x0
80105334:	e8 77 f6 ff ff       	call   801049b0 <argstr>
80105339:	83 c4 10             	add    $0x10,%esp
8010533c:	85 c0                	test   %eax,%eax
8010533e:	78 60                	js     801053a0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105340:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105343:	83 ec 08             	sub    $0x8,%esp
80105346:	50                   	push   %eax
80105347:	6a 01                	push   $0x1
80105349:	e8 b2 f5 ff ff       	call   80104900 <argint>
  if((argstr(0, &path)) < 0 ||
8010534e:	83 c4 10             	add    $0x10,%esp
80105351:	85 c0                	test   %eax,%eax
80105353:	78 4b                	js     801053a0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105355:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105358:	83 ec 08             	sub    $0x8,%esp
8010535b:	50                   	push   %eax
8010535c:	6a 02                	push   $0x2
8010535e:	e8 9d f5 ff ff       	call   80104900 <argint>
     argint(1, &major) < 0 ||
80105363:	83 c4 10             	add    $0x10,%esp
80105366:	85 c0                	test   %eax,%eax
80105368:	78 36                	js     801053a0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010536a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
8010536e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105371:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105375:	ba 03 00 00 00       	mov    $0x3,%edx
8010537a:	50                   	push   %eax
8010537b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010537e:	e8 cd f6 ff ff       	call   80104a50 <create>
80105383:	83 c4 10             	add    $0x10,%esp
80105386:	85 c0                	test   %eax,%eax
80105388:	74 16                	je     801053a0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010538a:	83 ec 0c             	sub    $0xc,%esp
8010538d:	50                   	push   %eax
8010538e:	e8 8d c5 ff ff       	call   80101920 <iunlockput>
  end_op();
80105393:	e8 88 d8 ff ff       	call   80102c20 <end_op>
  return 0;
80105398:	83 c4 10             	add    $0x10,%esp
8010539b:	31 c0                	xor    %eax,%eax
}
8010539d:	c9                   	leave  
8010539e:	c3                   	ret    
8010539f:	90                   	nop
    end_op();
801053a0:	e8 7b d8 ff ff       	call   80102c20 <end_op>
    return -1;
801053a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053aa:	c9                   	leave  
801053ab:	c3                   	ret    
801053ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053b0 <sys_chdir>:

int
sys_chdir(void)
{
801053b0:	55                   	push   %ebp
801053b1:	89 e5                	mov    %esp,%ebp
801053b3:	56                   	push   %esi
801053b4:	53                   	push   %ebx
801053b5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801053b8:	e8 f3 e3 ff ff       	call   801037b0 <myproc>
801053bd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801053bf:	e8 ec d7 ff ff       	call   80102bb0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801053c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053c7:	83 ec 08             	sub    $0x8,%esp
801053ca:	50                   	push   %eax
801053cb:	6a 00                	push   $0x0
801053cd:	e8 de f5 ff ff       	call   801049b0 <argstr>
801053d2:	83 c4 10             	add    $0x10,%esp
801053d5:	85 c0                	test   %eax,%eax
801053d7:	78 77                	js     80105450 <sys_chdir+0xa0>
801053d9:	83 ec 0c             	sub    $0xc,%esp
801053dc:	ff 75 f4             	pushl  -0xc(%ebp)
801053df:	e8 0c cb ff ff       	call   80101ef0 <namei>
801053e4:	83 c4 10             	add    $0x10,%esp
801053e7:	85 c0                	test   %eax,%eax
801053e9:	89 c3                	mov    %eax,%ebx
801053eb:	74 63                	je     80105450 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801053ed:	83 ec 0c             	sub    $0xc,%esp
801053f0:	50                   	push   %eax
801053f1:	e8 9a c2 ff ff       	call   80101690 <ilock>
  if(ip->type != T_DIR){
801053f6:	83 c4 10             	add    $0x10,%esp
801053f9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801053fe:	75 30                	jne    80105430 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105400:	83 ec 0c             	sub    $0xc,%esp
80105403:	53                   	push   %ebx
80105404:	e8 67 c3 ff ff       	call   80101770 <iunlock>
  iput(curproc->cwd);
80105409:	58                   	pop    %eax
8010540a:	ff 76 68             	pushl  0x68(%esi)
8010540d:	e8 ae c3 ff ff       	call   801017c0 <iput>
  end_op();
80105412:	e8 09 d8 ff ff       	call   80102c20 <end_op>
  curproc->cwd = ip;
80105417:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010541a:	83 c4 10             	add    $0x10,%esp
8010541d:	31 c0                	xor    %eax,%eax
}
8010541f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105422:	5b                   	pop    %ebx
80105423:	5e                   	pop    %esi
80105424:	5d                   	pop    %ebp
80105425:	c3                   	ret    
80105426:	8d 76 00             	lea    0x0(%esi),%esi
80105429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105430:	83 ec 0c             	sub    $0xc,%esp
80105433:	53                   	push   %ebx
80105434:	e8 e7 c4 ff ff       	call   80101920 <iunlockput>
    end_op();
80105439:	e8 e2 d7 ff ff       	call   80102c20 <end_op>
    return -1;
8010543e:	83 c4 10             	add    $0x10,%esp
80105441:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105446:	eb d7                	jmp    8010541f <sys_chdir+0x6f>
80105448:	90                   	nop
80105449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105450:	e8 cb d7 ff ff       	call   80102c20 <end_op>
    return -1;
80105455:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010545a:	eb c3                	jmp    8010541f <sys_chdir+0x6f>
8010545c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105460 <sys_exec>:

int
sys_exec(void)
{
80105460:	55                   	push   %ebp
80105461:	89 e5                	mov    %esp,%ebp
80105463:	57                   	push   %edi
80105464:	56                   	push   %esi
80105465:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105466:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010546c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105472:	50                   	push   %eax
80105473:	6a 00                	push   $0x0
80105475:	e8 36 f5 ff ff       	call   801049b0 <argstr>
8010547a:	83 c4 10             	add    $0x10,%esp
8010547d:	85 c0                	test   %eax,%eax
8010547f:	0f 88 87 00 00 00    	js     8010550c <sys_exec+0xac>
80105485:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010548b:	83 ec 08             	sub    $0x8,%esp
8010548e:	50                   	push   %eax
8010548f:	6a 01                	push   $0x1
80105491:	e8 6a f4 ff ff       	call   80104900 <argint>
80105496:	83 c4 10             	add    $0x10,%esp
80105499:	85 c0                	test   %eax,%eax
8010549b:	78 6f                	js     8010550c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010549d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801054a3:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
801054a6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801054a8:	68 80 00 00 00       	push   $0x80
801054ad:	6a 00                	push   $0x0
801054af:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801054b5:	50                   	push   %eax
801054b6:	e8 45 f1 ff ff       	call   80104600 <memset>
801054bb:	83 c4 10             	add    $0x10,%esp
801054be:	eb 2c                	jmp    801054ec <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
801054c0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801054c6:	85 c0                	test   %eax,%eax
801054c8:	74 56                	je     80105520 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801054ca:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801054d0:	83 ec 08             	sub    $0x8,%esp
801054d3:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801054d6:	52                   	push   %edx
801054d7:	50                   	push   %eax
801054d8:	e8 b3 f3 ff ff       	call   80104890 <fetchstr>
801054dd:	83 c4 10             	add    $0x10,%esp
801054e0:	85 c0                	test   %eax,%eax
801054e2:	78 28                	js     8010550c <sys_exec+0xac>
  for(i=0;; i++){
801054e4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801054e7:	83 fb 20             	cmp    $0x20,%ebx
801054ea:	74 20                	je     8010550c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801054ec:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801054f2:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
801054f9:	83 ec 08             	sub    $0x8,%esp
801054fc:	57                   	push   %edi
801054fd:	01 f0                	add    %esi,%eax
801054ff:	50                   	push   %eax
80105500:	e8 4b f3 ff ff       	call   80104850 <fetchint>
80105505:	83 c4 10             	add    $0x10,%esp
80105508:	85 c0                	test   %eax,%eax
8010550a:	79 b4                	jns    801054c0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010550c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010550f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105514:	5b                   	pop    %ebx
80105515:	5e                   	pop    %esi
80105516:	5f                   	pop    %edi
80105517:	5d                   	pop    %ebp
80105518:	c3                   	ret    
80105519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105520:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105526:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105529:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105530:	00 00 00 00 
  return exec(path, argv);
80105534:	50                   	push   %eax
80105535:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010553b:	e8 d0 b4 ff ff       	call   80100a10 <exec>
80105540:	83 c4 10             	add    $0x10,%esp
}
80105543:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105546:	5b                   	pop    %ebx
80105547:	5e                   	pop    %esi
80105548:	5f                   	pop    %edi
80105549:	5d                   	pop    %ebp
8010554a:	c3                   	ret    
8010554b:	90                   	nop
8010554c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105550 <sys_pipe>:

int
sys_pipe(void)
{
80105550:	55                   	push   %ebp
80105551:	89 e5                	mov    %esp,%ebp
80105553:	57                   	push   %edi
80105554:	56                   	push   %esi
80105555:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105556:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105559:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010555c:	6a 08                	push   $0x8
8010555e:	50                   	push   %eax
8010555f:	6a 00                	push   $0x0
80105561:	e8 ea f3 ff ff       	call   80104950 <argptr>
80105566:	83 c4 10             	add    $0x10,%esp
80105569:	85 c0                	test   %eax,%eax
8010556b:	0f 88 ae 00 00 00    	js     8010561f <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105571:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105574:	83 ec 08             	sub    $0x8,%esp
80105577:	50                   	push   %eax
80105578:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010557b:	50                   	push   %eax
8010557c:	e8 bf dc ff ff       	call   80103240 <pipealloc>
80105581:	83 c4 10             	add    $0x10,%esp
80105584:	85 c0                	test   %eax,%eax
80105586:	0f 88 93 00 00 00    	js     8010561f <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010558c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010558f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105591:	e8 1a e2 ff ff       	call   801037b0 <myproc>
80105596:	eb 10                	jmp    801055a8 <sys_pipe+0x58>
80105598:	90                   	nop
80105599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
801055a0:	83 c3 01             	add    $0x1,%ebx
801055a3:	83 fb 10             	cmp    $0x10,%ebx
801055a6:	74 60                	je     80105608 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
801055a8:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801055ac:	85 f6                	test   %esi,%esi
801055ae:	75 f0                	jne    801055a0 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
801055b0:	8d 73 08             	lea    0x8(%ebx),%esi
801055b3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801055b7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801055ba:	e8 f1 e1 ff ff       	call   801037b0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801055bf:	31 d2                	xor    %edx,%edx
801055c1:	eb 0d                	jmp    801055d0 <sys_pipe+0x80>
801055c3:	90                   	nop
801055c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801055c8:	83 c2 01             	add    $0x1,%edx
801055cb:	83 fa 10             	cmp    $0x10,%edx
801055ce:	74 28                	je     801055f8 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
801055d0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801055d4:	85 c9                	test   %ecx,%ecx
801055d6:	75 f0                	jne    801055c8 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
801055d8:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801055dc:	8b 45 dc             	mov    -0x24(%ebp),%eax
801055df:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801055e1:	8b 45 dc             	mov    -0x24(%ebp),%eax
801055e4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801055e7:	31 c0                	xor    %eax,%eax
}
801055e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055ec:	5b                   	pop    %ebx
801055ed:	5e                   	pop    %esi
801055ee:	5f                   	pop    %edi
801055ef:	5d                   	pop    %ebp
801055f0:	c3                   	ret    
801055f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
801055f8:	e8 b3 e1 ff ff       	call   801037b0 <myproc>
801055fd:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105604:	00 
80105605:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80105608:	83 ec 0c             	sub    $0xc,%esp
8010560b:	ff 75 e0             	pushl  -0x20(%ebp)
8010560e:	e8 2d b8 ff ff       	call   80100e40 <fileclose>
    fileclose(wf);
80105613:	58                   	pop    %eax
80105614:	ff 75 e4             	pushl  -0x1c(%ebp)
80105617:	e8 24 b8 ff ff       	call   80100e40 <fileclose>
    return -1;
8010561c:	83 c4 10             	add    $0x10,%esp
8010561f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105624:	eb c3                	jmp    801055e9 <sys_pipe+0x99>
80105626:	66 90                	xchg   %ax,%ax
80105628:	66 90                	xchg   %ax,%ax
8010562a:	66 90                	xchg   %ax,%ax
8010562c:	66 90                	xchg   %ax,%ax
8010562e:	66 90                	xchg   %ax,%ax

80105630 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105630:	55                   	push   %ebp
80105631:	89 e5                	mov    %esp,%ebp
80105633:	83 ec 20             	sub    $0x20,%esp
  int tickets;

  if(argint(0, &tickets) < 0)
80105636:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105639:	50                   	push   %eax
8010563a:	6a 00                	push   $0x0
8010563c:	e8 bf f2 ff ff       	call   80104900 <argint>
80105641:	83 c4 10             	add    $0x10,%esp
80105644:	85 c0                	test   %eax,%eax
80105646:	78 18                	js     80105660 <sys_fork+0x30>
    return -1;
  return fork(tickets);
80105648:	83 ec 0c             	sub    $0xc,%esp
8010564b:	ff 75 f4             	pushl  -0xc(%ebp)
8010564e:	e8 fd e2 ff ff       	call   80103950 <fork>
80105653:	83 c4 10             	add    $0x10,%esp
}
80105656:	c9                   	leave  
80105657:	c3                   	ret    
80105658:	90                   	nop
80105659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105660:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105665:	c9                   	leave  
80105666:	c3                   	ret    
80105667:	89 f6                	mov    %esi,%esi
80105669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105670 <sys_exit>:

int
sys_exit(void)
{
80105670:	55                   	push   %ebp
80105671:	89 e5                	mov    %esp,%ebp
80105673:	83 ec 08             	sub    $0x8,%esp
  exit();
80105676:	e8 f5 e6 ff ff       	call   80103d70 <exit>
  return 0;  // not reached
}
8010567b:	31 c0                	xor    %eax,%eax
8010567d:	c9                   	leave  
8010567e:	c3                   	ret    
8010567f:	90                   	nop

80105680 <sys_wait>:

int
sys_wait(void)
{
80105680:	55                   	push   %ebp
80105681:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105683:	5d                   	pop    %ebp
  return wait();
80105684:	e9 27 e9 ff ff       	jmp    80103fb0 <wait>
80105689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105690 <sys_kill>:

int
sys_kill(void)
{
80105690:	55                   	push   %ebp
80105691:	89 e5                	mov    %esp,%ebp
80105693:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105696:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105699:	50                   	push   %eax
8010569a:	6a 00                	push   $0x0
8010569c:	e8 5f f2 ff ff       	call   80104900 <argint>
801056a1:	83 c4 10             	add    $0x10,%esp
801056a4:	85 c0                	test   %eax,%eax
801056a6:	78 18                	js     801056c0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801056a8:	83 ec 0c             	sub    $0xc,%esp
801056ab:	ff 75 f4             	pushl  -0xc(%ebp)
801056ae:	e8 4d ea ff ff       	call   80104100 <kill>
801056b3:	83 c4 10             	add    $0x10,%esp
}
801056b6:	c9                   	leave  
801056b7:	c3                   	ret    
801056b8:	90                   	nop
801056b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801056c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056c5:	c9                   	leave  
801056c6:	c3                   	ret    
801056c7:	89 f6                	mov    %esi,%esi
801056c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056d0 <sys_getpid>:

int
sys_getpid(void)
{
801056d0:	55                   	push   %ebp
801056d1:	89 e5                	mov    %esp,%ebp
801056d3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801056d6:	e8 d5 e0 ff ff       	call   801037b0 <myproc>
801056db:	8b 40 10             	mov    0x10(%eax),%eax
}
801056de:	c9                   	leave  
801056df:	c3                   	ret    

801056e0 <sys_sbrk>:

int
sys_sbrk(void)
{
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
801056e3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801056e4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801056e7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801056ea:	50                   	push   %eax
801056eb:	6a 00                	push   $0x0
801056ed:	e8 0e f2 ff ff       	call   80104900 <argint>
801056f2:	83 c4 10             	add    $0x10,%esp
801056f5:	85 c0                	test   %eax,%eax
801056f7:	78 27                	js     80105720 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801056f9:	e8 b2 e0 ff ff       	call   801037b0 <myproc>
  if(growproc(n) < 0)
801056fe:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105701:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105703:	ff 75 f4             	pushl  -0xc(%ebp)
80105706:	e8 c5 e1 ff ff       	call   801038d0 <growproc>
8010570b:	83 c4 10             	add    $0x10,%esp
8010570e:	85 c0                	test   %eax,%eax
80105710:	78 0e                	js     80105720 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105712:	89 d8                	mov    %ebx,%eax
80105714:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105717:	c9                   	leave  
80105718:	c3                   	ret    
80105719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105720:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105725:	eb eb                	jmp    80105712 <sys_sbrk+0x32>
80105727:	89 f6                	mov    %esi,%esi
80105729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105730 <sys_sleep>:

int
sys_sleep(void)
{
80105730:	55                   	push   %ebp
80105731:	89 e5                	mov    %esp,%ebp
80105733:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105734:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105737:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010573a:	50                   	push   %eax
8010573b:	6a 00                	push   $0x0
8010573d:	e8 be f1 ff ff       	call   80104900 <argint>
80105742:	83 c4 10             	add    $0x10,%esp
80105745:	85 c0                	test   %eax,%eax
80105747:	0f 88 8a 00 00 00    	js     801057d7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010574d:	83 ec 0c             	sub    $0xc,%esp
80105750:	68 40 52 11 80       	push   $0x80115240
80105755:	e8 96 ed ff ff       	call   801044f0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010575a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010575d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105760:	8b 1d 80 5a 11 80    	mov    0x80115a80,%ebx
  while(ticks - ticks0 < n){
80105766:	85 d2                	test   %edx,%edx
80105768:	75 27                	jne    80105791 <sys_sleep+0x61>
8010576a:	eb 54                	jmp    801057c0 <sys_sleep+0x90>
8010576c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105770:	83 ec 08             	sub    $0x8,%esp
80105773:	68 40 52 11 80       	push   $0x80115240
80105778:	68 80 5a 11 80       	push   $0x80115a80
8010577d:	e8 6e e7 ff ff       	call   80103ef0 <sleep>
  while(ticks - ticks0 < n){
80105782:	a1 80 5a 11 80       	mov    0x80115a80,%eax
80105787:	83 c4 10             	add    $0x10,%esp
8010578a:	29 d8                	sub    %ebx,%eax
8010578c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010578f:	73 2f                	jae    801057c0 <sys_sleep+0x90>
    if(myproc()->killed){
80105791:	e8 1a e0 ff ff       	call   801037b0 <myproc>
80105796:	8b 40 24             	mov    0x24(%eax),%eax
80105799:	85 c0                	test   %eax,%eax
8010579b:	74 d3                	je     80105770 <sys_sleep+0x40>
      release(&tickslock);
8010579d:	83 ec 0c             	sub    $0xc,%esp
801057a0:	68 40 52 11 80       	push   $0x80115240
801057a5:	e8 06 ee ff ff       	call   801045b0 <release>
      return -1;
801057aa:	83 c4 10             	add    $0x10,%esp
801057ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
801057b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057b5:	c9                   	leave  
801057b6:	c3                   	ret    
801057b7:	89 f6                	mov    %esi,%esi
801057b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
801057c0:	83 ec 0c             	sub    $0xc,%esp
801057c3:	68 40 52 11 80       	push   $0x80115240
801057c8:	e8 e3 ed ff ff       	call   801045b0 <release>
  return 0;
801057cd:	83 c4 10             	add    $0x10,%esp
801057d0:	31 c0                	xor    %eax,%eax
}
801057d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057d5:	c9                   	leave  
801057d6:	c3                   	ret    
    return -1;
801057d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057dc:	eb f4                	jmp    801057d2 <sys_sleep+0xa2>
801057de:	66 90                	xchg   %ax,%ax

801057e0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
801057e3:	53                   	push   %ebx
801057e4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801057e7:	68 40 52 11 80       	push   $0x80115240
801057ec:	e8 ff ec ff ff       	call   801044f0 <acquire>
  xticks = ticks;
801057f1:	8b 1d 80 5a 11 80    	mov    0x80115a80,%ebx
  release(&tickslock);
801057f7:	c7 04 24 40 52 11 80 	movl   $0x80115240,(%esp)
801057fe:	e8 ad ed ff ff       	call   801045b0 <release>
  return xticks;
}
80105803:	89 d8                	mov    %ebx,%eax
80105805:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105808:	c9                   	leave  
80105809:	c3                   	ret    
8010580a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105810 <sys_lottery>:

int sys_lottery(void)
{
80105810:	55                   	push   %ebp
80105811:	89 e5                	mov    %esp,%ebp
80105813:	83 ec 20             	sub    $0x20,%esp
  int n;

  if(argint(0, &n) < 0)
80105816:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105819:	50                   	push   %eax
8010581a:	6a 00                	push   $0x0
8010581c:	e8 df f0 ff ff       	call   80104900 <argint>
      return  -1;
  }

  return 0;

}
80105821:	c9                   	leave  
  if(argint(0, &n) < 0)
80105822:	c1 f8 1f             	sar    $0x1f,%eax
}
80105825:	c3                   	ret    

80105826 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105826:	1e                   	push   %ds
  pushl %es
80105827:	06                   	push   %es
  pushl %fs
80105828:	0f a0                	push   %fs
  pushl %gs
8010582a:	0f a8                	push   %gs
  pushal
8010582c:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
8010582d:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105831:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105833:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105835:	54                   	push   %esp
  call trap
80105836:	e8 c5 00 00 00       	call   80105900 <trap>
  addl $4, %esp
8010583b:	83 c4 04             	add    $0x4,%esp

8010583e <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
8010583e:	61                   	popa   
  popl %gs
8010583f:	0f a9                	pop    %gs
  popl %fs
80105841:	0f a1                	pop    %fs
  popl %es
80105843:	07                   	pop    %es
  popl %ds
80105844:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105845:	83 c4 08             	add    $0x8,%esp
  iret
80105848:	cf                   	iret   
80105849:	66 90                	xchg   %ax,%ax
8010584b:	66 90                	xchg   %ax,%ax
8010584d:	66 90                	xchg   %ax,%ax
8010584f:	90                   	nop

80105850 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105850:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105851:	31 c0                	xor    %eax,%eax
{
80105853:	89 e5                	mov    %esp,%ebp
80105855:	83 ec 08             	sub    $0x8,%esp
80105858:	90                   	nop
80105859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105860:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105867:	c7 04 c5 82 52 11 80 	movl   $0x8e000008,-0x7feead7e(,%eax,8)
8010586e:	08 00 00 8e 
80105872:	66 89 14 c5 80 52 11 	mov    %dx,-0x7feead80(,%eax,8)
80105879:	80 
8010587a:	c1 ea 10             	shr    $0x10,%edx
8010587d:	66 89 14 c5 86 52 11 	mov    %dx,-0x7feead7a(,%eax,8)
80105884:	80 
  for(i = 0; i < 256; i++)
80105885:	83 c0 01             	add    $0x1,%eax
80105888:	3d 00 01 00 00       	cmp    $0x100,%eax
8010588d:	75 d1                	jne    80105860 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010588f:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105894:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105897:	c7 05 82 54 11 80 08 	movl   $0xef000008,0x80115482
8010589e:	00 00 ef 
  initlock(&tickslock, "time");
801058a1:	68 7d 7a 10 80       	push   $0x80107a7d
801058a6:	68 40 52 11 80       	push   $0x80115240
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801058ab:	66 a3 80 54 11 80    	mov    %ax,0x80115480
801058b1:	c1 e8 10             	shr    $0x10,%eax
801058b4:	66 a3 86 54 11 80    	mov    %ax,0x80115486
  initlock(&tickslock, "time");
801058ba:	e8 f1 ea ff ff       	call   801043b0 <initlock>
}
801058bf:	83 c4 10             	add    $0x10,%esp
801058c2:	c9                   	leave  
801058c3:	c3                   	ret    
801058c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801058ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801058d0 <idtinit>:

void
idtinit(void)
{
801058d0:	55                   	push   %ebp
  pd[0] = size-1;
801058d1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801058d6:	89 e5                	mov    %esp,%ebp
801058d8:	83 ec 10             	sub    $0x10,%esp
801058db:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801058df:	b8 80 52 11 80       	mov    $0x80115280,%eax
801058e4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801058e8:	c1 e8 10             	shr    $0x10,%eax
801058eb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801058ef:	8d 45 fa             	lea    -0x6(%ebp),%eax
801058f2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801058f5:	c9                   	leave  
801058f6:	c3                   	ret    
801058f7:	89 f6                	mov    %esi,%esi
801058f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105900 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105900:	55                   	push   %ebp
80105901:	89 e5                	mov    %esp,%ebp
80105903:	57                   	push   %edi
80105904:	56                   	push   %esi
80105905:	53                   	push   %ebx
80105906:	83 ec 1c             	sub    $0x1c,%esp
80105909:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
8010590c:	8b 47 30             	mov    0x30(%edi),%eax
8010590f:	83 f8 40             	cmp    $0x40,%eax
80105912:	0f 84 f0 00 00 00    	je     80105a08 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105918:	83 e8 20             	sub    $0x20,%eax
8010591b:	83 f8 1f             	cmp    $0x1f,%eax
8010591e:	77 10                	ja     80105930 <trap+0x30>
80105920:	ff 24 85 24 7b 10 80 	jmp    *-0x7fef84dc(,%eax,4)
80105927:	89 f6                	mov    %esi,%esi
80105929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105930:	e8 7b de ff ff       	call   801037b0 <myproc>
80105935:	85 c0                	test   %eax,%eax
80105937:	8b 5f 38             	mov    0x38(%edi),%ebx
8010593a:	0f 84 14 02 00 00    	je     80105b54 <trap+0x254>
80105940:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105944:	0f 84 0a 02 00 00    	je     80105b54 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010594a:	0f 20 d1             	mov    %cr2,%ecx
8010594d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105950:	e8 3b de ff ff       	call   80103790 <cpuid>
80105955:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105958:	8b 47 34             	mov    0x34(%edi),%eax
8010595b:	8b 77 30             	mov    0x30(%edi),%esi
8010595e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105961:	e8 4a de ff ff       	call   801037b0 <myproc>
80105966:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105969:	e8 42 de ff ff       	call   801037b0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010596e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105971:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105974:	51                   	push   %ecx
80105975:	53                   	push   %ebx
80105976:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80105977:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010597a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010597d:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010597e:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105981:	52                   	push   %edx
80105982:	ff 70 10             	pushl  0x10(%eax)
80105985:	68 e0 7a 10 80       	push   $0x80107ae0
8010598a:	e8 d1 ac ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
8010598f:	83 c4 20             	add    $0x20,%esp
80105992:	e8 19 de ff ff       	call   801037b0 <myproc>
80105997:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010599e:	e8 0d de ff ff       	call   801037b0 <myproc>
801059a3:	85 c0                	test   %eax,%eax
801059a5:	74 1d                	je     801059c4 <trap+0xc4>
801059a7:	e8 04 de ff ff       	call   801037b0 <myproc>
801059ac:	8b 50 24             	mov    0x24(%eax),%edx
801059af:	85 d2                	test   %edx,%edx
801059b1:	74 11                	je     801059c4 <trap+0xc4>
801059b3:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801059b7:	83 e0 03             	and    $0x3,%eax
801059ba:	66 83 f8 03          	cmp    $0x3,%ax
801059be:	0f 84 4c 01 00 00    	je     80105b10 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801059c4:	e8 e7 dd ff ff       	call   801037b0 <myproc>
801059c9:	85 c0                	test   %eax,%eax
801059cb:	74 0b                	je     801059d8 <trap+0xd8>
801059cd:	e8 de dd ff ff       	call   801037b0 <myproc>
801059d2:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801059d6:	74 68                	je     80105a40 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801059d8:	e8 d3 dd ff ff       	call   801037b0 <myproc>
801059dd:	85 c0                	test   %eax,%eax
801059df:	74 19                	je     801059fa <trap+0xfa>
801059e1:	e8 ca dd ff ff       	call   801037b0 <myproc>
801059e6:	8b 40 24             	mov    0x24(%eax),%eax
801059e9:	85 c0                	test   %eax,%eax
801059eb:	74 0d                	je     801059fa <trap+0xfa>
801059ed:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801059f1:	83 e0 03             	and    $0x3,%eax
801059f4:	66 83 f8 03          	cmp    $0x3,%ax
801059f8:	74 37                	je     80105a31 <trap+0x131>
    exit();
}
801059fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059fd:	5b                   	pop    %ebx
801059fe:	5e                   	pop    %esi
801059ff:	5f                   	pop    %edi
80105a00:	5d                   	pop    %ebp
80105a01:	c3                   	ret    
80105a02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
80105a08:	e8 a3 dd ff ff       	call   801037b0 <myproc>
80105a0d:	8b 58 24             	mov    0x24(%eax),%ebx
80105a10:	85 db                	test   %ebx,%ebx
80105a12:	0f 85 e8 00 00 00    	jne    80105b00 <trap+0x200>
    myproc()->tf = tf;
80105a18:	e8 93 dd ff ff       	call   801037b0 <myproc>
80105a1d:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105a20:	e8 cb ef ff ff       	call   801049f0 <syscall>
    if(myproc()->killed)
80105a25:	e8 86 dd ff ff       	call   801037b0 <myproc>
80105a2a:	8b 48 24             	mov    0x24(%eax),%ecx
80105a2d:	85 c9                	test   %ecx,%ecx
80105a2f:	74 c9                	je     801059fa <trap+0xfa>
}
80105a31:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a34:	5b                   	pop    %ebx
80105a35:	5e                   	pop    %esi
80105a36:	5f                   	pop    %edi
80105a37:	5d                   	pop    %ebp
      exit();
80105a38:	e9 33 e3 ff ff       	jmp    80103d70 <exit>
80105a3d:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105a40:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105a44:	75 92                	jne    801059d8 <trap+0xd8>
    yield();
80105a46:	e8 55 e4 ff ff       	call   80103ea0 <yield>
80105a4b:	eb 8b                	jmp    801059d8 <trap+0xd8>
80105a4d:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80105a50:	e8 3b dd ff ff       	call   80103790 <cpuid>
80105a55:	85 c0                	test   %eax,%eax
80105a57:	0f 84 c3 00 00 00    	je     80105b20 <trap+0x220>
    lapiceoi();
80105a5d:	e8 fe cc ff ff       	call   80102760 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a62:	e8 49 dd ff ff       	call   801037b0 <myproc>
80105a67:	85 c0                	test   %eax,%eax
80105a69:	0f 85 38 ff ff ff    	jne    801059a7 <trap+0xa7>
80105a6f:	e9 50 ff ff ff       	jmp    801059c4 <trap+0xc4>
80105a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105a78:	e8 a3 cb ff ff       	call   80102620 <kbdintr>
    lapiceoi();
80105a7d:	e8 de cc ff ff       	call   80102760 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a82:	e8 29 dd ff ff       	call   801037b0 <myproc>
80105a87:	85 c0                	test   %eax,%eax
80105a89:	0f 85 18 ff ff ff    	jne    801059a7 <trap+0xa7>
80105a8f:	e9 30 ff ff ff       	jmp    801059c4 <trap+0xc4>
80105a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105a98:	e8 53 02 00 00       	call   80105cf0 <uartintr>
    lapiceoi();
80105a9d:	e8 be cc ff ff       	call   80102760 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105aa2:	e8 09 dd ff ff       	call   801037b0 <myproc>
80105aa7:	85 c0                	test   %eax,%eax
80105aa9:	0f 85 f8 fe ff ff    	jne    801059a7 <trap+0xa7>
80105aaf:	e9 10 ff ff ff       	jmp    801059c4 <trap+0xc4>
80105ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105ab8:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105abc:	8b 77 38             	mov    0x38(%edi),%esi
80105abf:	e8 cc dc ff ff       	call   80103790 <cpuid>
80105ac4:	56                   	push   %esi
80105ac5:	53                   	push   %ebx
80105ac6:	50                   	push   %eax
80105ac7:	68 88 7a 10 80       	push   $0x80107a88
80105acc:	e8 8f ab ff ff       	call   80100660 <cprintf>
    lapiceoi();
80105ad1:	e8 8a cc ff ff       	call   80102760 <lapiceoi>
    break;
80105ad6:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ad9:	e8 d2 dc ff ff       	call   801037b0 <myproc>
80105ade:	85 c0                	test   %eax,%eax
80105ae0:	0f 85 c1 fe ff ff    	jne    801059a7 <trap+0xa7>
80105ae6:	e9 d9 fe ff ff       	jmp    801059c4 <trap+0xc4>
80105aeb:	90                   	nop
80105aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80105af0:	e8 9b c5 ff ff       	call   80102090 <ideintr>
80105af5:	e9 63 ff ff ff       	jmp    80105a5d <trap+0x15d>
80105afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105b00:	e8 6b e2 ff ff       	call   80103d70 <exit>
80105b05:	e9 0e ff ff ff       	jmp    80105a18 <trap+0x118>
80105b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80105b10:	e8 5b e2 ff ff       	call   80103d70 <exit>
80105b15:	e9 aa fe ff ff       	jmp    801059c4 <trap+0xc4>
80105b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105b20:	83 ec 0c             	sub    $0xc,%esp
80105b23:	68 40 52 11 80       	push   $0x80115240
80105b28:	e8 c3 e9 ff ff       	call   801044f0 <acquire>
      wakeup(&ticks);
80105b2d:	c7 04 24 80 5a 11 80 	movl   $0x80115a80,(%esp)
      ticks++;
80105b34:	83 05 80 5a 11 80 01 	addl   $0x1,0x80115a80
      wakeup(&ticks);
80105b3b:	e8 60 e5 ff ff       	call   801040a0 <wakeup>
      release(&tickslock);
80105b40:	c7 04 24 40 52 11 80 	movl   $0x80115240,(%esp)
80105b47:	e8 64 ea ff ff       	call   801045b0 <release>
80105b4c:	83 c4 10             	add    $0x10,%esp
80105b4f:	e9 09 ff ff ff       	jmp    80105a5d <trap+0x15d>
80105b54:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105b57:	e8 34 dc ff ff       	call   80103790 <cpuid>
80105b5c:	83 ec 0c             	sub    $0xc,%esp
80105b5f:	56                   	push   %esi
80105b60:	53                   	push   %ebx
80105b61:	50                   	push   %eax
80105b62:	ff 77 30             	pushl  0x30(%edi)
80105b65:	68 ac 7a 10 80       	push   $0x80107aac
80105b6a:	e8 f1 aa ff ff       	call   80100660 <cprintf>
      panic("trap");
80105b6f:	83 c4 14             	add    $0x14,%esp
80105b72:	68 82 7a 10 80       	push   $0x80107a82
80105b77:	e8 14 a8 ff ff       	call   80100390 <panic>
80105b7c:	66 90                	xchg   %ax,%ax
80105b7e:	66 90                	xchg   %ax,%ax

80105b80 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105b80:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
{
80105b85:	55                   	push   %ebp
80105b86:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105b88:	85 c0                	test   %eax,%eax
80105b8a:	74 1c                	je     80105ba8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105b8c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105b91:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105b92:	a8 01                	test   $0x1,%al
80105b94:	74 12                	je     80105ba8 <uartgetc+0x28>
80105b96:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105b9b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105b9c:	0f b6 c0             	movzbl %al,%eax
}
80105b9f:	5d                   	pop    %ebp
80105ba0:	c3                   	ret    
80105ba1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105ba8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105bad:	5d                   	pop    %ebp
80105bae:	c3                   	ret    
80105baf:	90                   	nop

80105bb0 <uartputc.part.0>:
uartputc(int c)
80105bb0:	55                   	push   %ebp
80105bb1:	89 e5                	mov    %esp,%ebp
80105bb3:	57                   	push   %edi
80105bb4:	56                   	push   %esi
80105bb5:	53                   	push   %ebx
80105bb6:	89 c7                	mov    %eax,%edi
80105bb8:	bb 80 00 00 00       	mov    $0x80,%ebx
80105bbd:	be fd 03 00 00       	mov    $0x3fd,%esi
80105bc2:	83 ec 0c             	sub    $0xc,%esp
80105bc5:	eb 1b                	jmp    80105be2 <uartputc.part.0+0x32>
80105bc7:	89 f6                	mov    %esi,%esi
80105bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80105bd0:	83 ec 0c             	sub    $0xc,%esp
80105bd3:	6a 0a                	push   $0xa
80105bd5:	e8 a6 cb ff ff       	call   80102780 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105bda:	83 c4 10             	add    $0x10,%esp
80105bdd:	83 eb 01             	sub    $0x1,%ebx
80105be0:	74 07                	je     80105be9 <uartputc.part.0+0x39>
80105be2:	89 f2                	mov    %esi,%edx
80105be4:	ec                   	in     (%dx),%al
80105be5:	a8 20                	test   $0x20,%al
80105be7:	74 e7                	je     80105bd0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105be9:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105bee:	89 f8                	mov    %edi,%eax
80105bf0:	ee                   	out    %al,(%dx)
}
80105bf1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bf4:	5b                   	pop    %ebx
80105bf5:	5e                   	pop    %esi
80105bf6:	5f                   	pop    %edi
80105bf7:	5d                   	pop    %ebp
80105bf8:	c3                   	ret    
80105bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105c00 <uartinit>:
{
80105c00:	55                   	push   %ebp
80105c01:	31 c9                	xor    %ecx,%ecx
80105c03:	89 c8                	mov    %ecx,%eax
80105c05:	89 e5                	mov    %esp,%ebp
80105c07:	57                   	push   %edi
80105c08:	56                   	push   %esi
80105c09:	53                   	push   %ebx
80105c0a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105c0f:	89 da                	mov    %ebx,%edx
80105c11:	83 ec 0c             	sub    $0xc,%esp
80105c14:	ee                   	out    %al,(%dx)
80105c15:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105c1a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105c1f:	89 fa                	mov    %edi,%edx
80105c21:	ee                   	out    %al,(%dx)
80105c22:	b8 0c 00 00 00       	mov    $0xc,%eax
80105c27:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c2c:	ee                   	out    %al,(%dx)
80105c2d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105c32:	89 c8                	mov    %ecx,%eax
80105c34:	89 f2                	mov    %esi,%edx
80105c36:	ee                   	out    %al,(%dx)
80105c37:	b8 03 00 00 00       	mov    $0x3,%eax
80105c3c:	89 fa                	mov    %edi,%edx
80105c3e:	ee                   	out    %al,(%dx)
80105c3f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105c44:	89 c8                	mov    %ecx,%eax
80105c46:	ee                   	out    %al,(%dx)
80105c47:	b8 01 00 00 00       	mov    $0x1,%eax
80105c4c:	89 f2                	mov    %esi,%edx
80105c4e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105c4f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105c54:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105c55:	3c ff                	cmp    $0xff,%al
80105c57:	74 5a                	je     80105cb3 <uartinit+0xb3>
  uart = 1;
80105c59:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105c60:	00 00 00 
80105c63:	89 da                	mov    %ebx,%edx
80105c65:	ec                   	in     (%dx),%al
80105c66:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c6b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105c6c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105c6f:	bb a4 7b 10 80       	mov    $0x80107ba4,%ebx
  ioapicenable(IRQ_COM1, 0);
80105c74:	6a 00                	push   $0x0
80105c76:	6a 04                	push   $0x4
80105c78:	e8 63 c6 ff ff       	call   801022e0 <ioapicenable>
80105c7d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105c80:	b8 78 00 00 00       	mov    $0x78,%eax
80105c85:	eb 13                	jmp    80105c9a <uartinit+0x9a>
80105c87:	89 f6                	mov    %esi,%esi
80105c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105c90:	83 c3 01             	add    $0x1,%ebx
80105c93:	0f be 03             	movsbl (%ebx),%eax
80105c96:	84 c0                	test   %al,%al
80105c98:	74 19                	je     80105cb3 <uartinit+0xb3>
  if(!uart)
80105c9a:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105ca0:	85 d2                	test   %edx,%edx
80105ca2:	74 ec                	je     80105c90 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80105ca4:	83 c3 01             	add    $0x1,%ebx
80105ca7:	e8 04 ff ff ff       	call   80105bb0 <uartputc.part.0>
80105cac:	0f be 03             	movsbl (%ebx),%eax
80105caf:	84 c0                	test   %al,%al
80105cb1:	75 e7                	jne    80105c9a <uartinit+0x9a>
}
80105cb3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cb6:	5b                   	pop    %ebx
80105cb7:	5e                   	pop    %esi
80105cb8:	5f                   	pop    %edi
80105cb9:	5d                   	pop    %ebp
80105cba:	c3                   	ret    
80105cbb:	90                   	nop
80105cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105cc0 <uartputc>:
  if(!uart)
80105cc0:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
{
80105cc6:	55                   	push   %ebp
80105cc7:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105cc9:	85 d2                	test   %edx,%edx
{
80105ccb:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105cce:	74 10                	je     80105ce0 <uartputc+0x20>
}
80105cd0:	5d                   	pop    %ebp
80105cd1:	e9 da fe ff ff       	jmp    80105bb0 <uartputc.part.0>
80105cd6:	8d 76 00             	lea    0x0(%esi),%esi
80105cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105ce0:	5d                   	pop    %ebp
80105ce1:	c3                   	ret    
80105ce2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105cf0 <uartintr>:

void
uartintr(void)
{
80105cf0:	55                   	push   %ebp
80105cf1:	89 e5                	mov    %esp,%ebp
80105cf3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105cf6:	68 80 5b 10 80       	push   $0x80105b80
80105cfb:	e8 10 ab ff ff       	call   80100810 <consoleintr>
}
80105d00:	83 c4 10             	add    $0x10,%esp
80105d03:	c9                   	leave  
80105d04:	c3                   	ret    

80105d05 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105d05:	6a 00                	push   $0x0
  pushl $0
80105d07:	6a 00                	push   $0x0
  jmp alltraps
80105d09:	e9 18 fb ff ff       	jmp    80105826 <alltraps>

80105d0e <vector1>:
.globl vector1
vector1:
  pushl $0
80105d0e:	6a 00                	push   $0x0
  pushl $1
80105d10:	6a 01                	push   $0x1
  jmp alltraps
80105d12:	e9 0f fb ff ff       	jmp    80105826 <alltraps>

80105d17 <vector2>:
.globl vector2
vector2:
  pushl $0
80105d17:	6a 00                	push   $0x0
  pushl $2
80105d19:	6a 02                	push   $0x2
  jmp alltraps
80105d1b:	e9 06 fb ff ff       	jmp    80105826 <alltraps>

80105d20 <vector3>:
.globl vector3
vector3:
  pushl $0
80105d20:	6a 00                	push   $0x0
  pushl $3
80105d22:	6a 03                	push   $0x3
  jmp alltraps
80105d24:	e9 fd fa ff ff       	jmp    80105826 <alltraps>

80105d29 <vector4>:
.globl vector4
vector4:
  pushl $0
80105d29:	6a 00                	push   $0x0
  pushl $4
80105d2b:	6a 04                	push   $0x4
  jmp alltraps
80105d2d:	e9 f4 fa ff ff       	jmp    80105826 <alltraps>

80105d32 <vector5>:
.globl vector5
vector5:
  pushl $0
80105d32:	6a 00                	push   $0x0
  pushl $5
80105d34:	6a 05                	push   $0x5
  jmp alltraps
80105d36:	e9 eb fa ff ff       	jmp    80105826 <alltraps>

80105d3b <vector6>:
.globl vector6
vector6:
  pushl $0
80105d3b:	6a 00                	push   $0x0
  pushl $6
80105d3d:	6a 06                	push   $0x6
  jmp alltraps
80105d3f:	e9 e2 fa ff ff       	jmp    80105826 <alltraps>

80105d44 <vector7>:
.globl vector7
vector7:
  pushl $0
80105d44:	6a 00                	push   $0x0
  pushl $7
80105d46:	6a 07                	push   $0x7
  jmp alltraps
80105d48:	e9 d9 fa ff ff       	jmp    80105826 <alltraps>

80105d4d <vector8>:
.globl vector8
vector8:
  pushl $8
80105d4d:	6a 08                	push   $0x8
  jmp alltraps
80105d4f:	e9 d2 fa ff ff       	jmp    80105826 <alltraps>

80105d54 <vector9>:
.globl vector9
vector9:
  pushl $0
80105d54:	6a 00                	push   $0x0
  pushl $9
80105d56:	6a 09                	push   $0x9
  jmp alltraps
80105d58:	e9 c9 fa ff ff       	jmp    80105826 <alltraps>

80105d5d <vector10>:
.globl vector10
vector10:
  pushl $10
80105d5d:	6a 0a                	push   $0xa
  jmp alltraps
80105d5f:	e9 c2 fa ff ff       	jmp    80105826 <alltraps>

80105d64 <vector11>:
.globl vector11
vector11:
  pushl $11
80105d64:	6a 0b                	push   $0xb
  jmp alltraps
80105d66:	e9 bb fa ff ff       	jmp    80105826 <alltraps>

80105d6b <vector12>:
.globl vector12
vector12:
  pushl $12
80105d6b:	6a 0c                	push   $0xc
  jmp alltraps
80105d6d:	e9 b4 fa ff ff       	jmp    80105826 <alltraps>

80105d72 <vector13>:
.globl vector13
vector13:
  pushl $13
80105d72:	6a 0d                	push   $0xd
  jmp alltraps
80105d74:	e9 ad fa ff ff       	jmp    80105826 <alltraps>

80105d79 <vector14>:
.globl vector14
vector14:
  pushl $14
80105d79:	6a 0e                	push   $0xe
  jmp alltraps
80105d7b:	e9 a6 fa ff ff       	jmp    80105826 <alltraps>

80105d80 <vector15>:
.globl vector15
vector15:
  pushl $0
80105d80:	6a 00                	push   $0x0
  pushl $15
80105d82:	6a 0f                	push   $0xf
  jmp alltraps
80105d84:	e9 9d fa ff ff       	jmp    80105826 <alltraps>

80105d89 <vector16>:
.globl vector16
vector16:
  pushl $0
80105d89:	6a 00                	push   $0x0
  pushl $16
80105d8b:	6a 10                	push   $0x10
  jmp alltraps
80105d8d:	e9 94 fa ff ff       	jmp    80105826 <alltraps>

80105d92 <vector17>:
.globl vector17
vector17:
  pushl $17
80105d92:	6a 11                	push   $0x11
  jmp alltraps
80105d94:	e9 8d fa ff ff       	jmp    80105826 <alltraps>

80105d99 <vector18>:
.globl vector18
vector18:
  pushl $0
80105d99:	6a 00                	push   $0x0
  pushl $18
80105d9b:	6a 12                	push   $0x12
  jmp alltraps
80105d9d:	e9 84 fa ff ff       	jmp    80105826 <alltraps>

80105da2 <vector19>:
.globl vector19
vector19:
  pushl $0
80105da2:	6a 00                	push   $0x0
  pushl $19
80105da4:	6a 13                	push   $0x13
  jmp alltraps
80105da6:	e9 7b fa ff ff       	jmp    80105826 <alltraps>

80105dab <vector20>:
.globl vector20
vector20:
  pushl $0
80105dab:	6a 00                	push   $0x0
  pushl $20
80105dad:	6a 14                	push   $0x14
  jmp alltraps
80105daf:	e9 72 fa ff ff       	jmp    80105826 <alltraps>

80105db4 <vector21>:
.globl vector21
vector21:
  pushl $0
80105db4:	6a 00                	push   $0x0
  pushl $21
80105db6:	6a 15                	push   $0x15
  jmp alltraps
80105db8:	e9 69 fa ff ff       	jmp    80105826 <alltraps>

80105dbd <vector22>:
.globl vector22
vector22:
  pushl $0
80105dbd:	6a 00                	push   $0x0
  pushl $22
80105dbf:	6a 16                	push   $0x16
  jmp alltraps
80105dc1:	e9 60 fa ff ff       	jmp    80105826 <alltraps>

80105dc6 <vector23>:
.globl vector23
vector23:
  pushl $0
80105dc6:	6a 00                	push   $0x0
  pushl $23
80105dc8:	6a 17                	push   $0x17
  jmp alltraps
80105dca:	e9 57 fa ff ff       	jmp    80105826 <alltraps>

80105dcf <vector24>:
.globl vector24
vector24:
  pushl $0
80105dcf:	6a 00                	push   $0x0
  pushl $24
80105dd1:	6a 18                	push   $0x18
  jmp alltraps
80105dd3:	e9 4e fa ff ff       	jmp    80105826 <alltraps>

80105dd8 <vector25>:
.globl vector25
vector25:
  pushl $0
80105dd8:	6a 00                	push   $0x0
  pushl $25
80105dda:	6a 19                	push   $0x19
  jmp alltraps
80105ddc:	e9 45 fa ff ff       	jmp    80105826 <alltraps>

80105de1 <vector26>:
.globl vector26
vector26:
  pushl $0
80105de1:	6a 00                	push   $0x0
  pushl $26
80105de3:	6a 1a                	push   $0x1a
  jmp alltraps
80105de5:	e9 3c fa ff ff       	jmp    80105826 <alltraps>

80105dea <vector27>:
.globl vector27
vector27:
  pushl $0
80105dea:	6a 00                	push   $0x0
  pushl $27
80105dec:	6a 1b                	push   $0x1b
  jmp alltraps
80105dee:	e9 33 fa ff ff       	jmp    80105826 <alltraps>

80105df3 <vector28>:
.globl vector28
vector28:
  pushl $0
80105df3:	6a 00                	push   $0x0
  pushl $28
80105df5:	6a 1c                	push   $0x1c
  jmp alltraps
80105df7:	e9 2a fa ff ff       	jmp    80105826 <alltraps>

80105dfc <vector29>:
.globl vector29
vector29:
  pushl $0
80105dfc:	6a 00                	push   $0x0
  pushl $29
80105dfe:	6a 1d                	push   $0x1d
  jmp alltraps
80105e00:	e9 21 fa ff ff       	jmp    80105826 <alltraps>

80105e05 <vector30>:
.globl vector30
vector30:
  pushl $0
80105e05:	6a 00                	push   $0x0
  pushl $30
80105e07:	6a 1e                	push   $0x1e
  jmp alltraps
80105e09:	e9 18 fa ff ff       	jmp    80105826 <alltraps>

80105e0e <vector31>:
.globl vector31
vector31:
  pushl $0
80105e0e:	6a 00                	push   $0x0
  pushl $31
80105e10:	6a 1f                	push   $0x1f
  jmp alltraps
80105e12:	e9 0f fa ff ff       	jmp    80105826 <alltraps>

80105e17 <vector32>:
.globl vector32
vector32:
  pushl $0
80105e17:	6a 00                	push   $0x0
  pushl $32
80105e19:	6a 20                	push   $0x20
  jmp alltraps
80105e1b:	e9 06 fa ff ff       	jmp    80105826 <alltraps>

80105e20 <vector33>:
.globl vector33
vector33:
  pushl $0
80105e20:	6a 00                	push   $0x0
  pushl $33
80105e22:	6a 21                	push   $0x21
  jmp alltraps
80105e24:	e9 fd f9 ff ff       	jmp    80105826 <alltraps>

80105e29 <vector34>:
.globl vector34
vector34:
  pushl $0
80105e29:	6a 00                	push   $0x0
  pushl $34
80105e2b:	6a 22                	push   $0x22
  jmp alltraps
80105e2d:	e9 f4 f9 ff ff       	jmp    80105826 <alltraps>

80105e32 <vector35>:
.globl vector35
vector35:
  pushl $0
80105e32:	6a 00                	push   $0x0
  pushl $35
80105e34:	6a 23                	push   $0x23
  jmp alltraps
80105e36:	e9 eb f9 ff ff       	jmp    80105826 <alltraps>

80105e3b <vector36>:
.globl vector36
vector36:
  pushl $0
80105e3b:	6a 00                	push   $0x0
  pushl $36
80105e3d:	6a 24                	push   $0x24
  jmp alltraps
80105e3f:	e9 e2 f9 ff ff       	jmp    80105826 <alltraps>

80105e44 <vector37>:
.globl vector37
vector37:
  pushl $0
80105e44:	6a 00                	push   $0x0
  pushl $37
80105e46:	6a 25                	push   $0x25
  jmp alltraps
80105e48:	e9 d9 f9 ff ff       	jmp    80105826 <alltraps>

80105e4d <vector38>:
.globl vector38
vector38:
  pushl $0
80105e4d:	6a 00                	push   $0x0
  pushl $38
80105e4f:	6a 26                	push   $0x26
  jmp alltraps
80105e51:	e9 d0 f9 ff ff       	jmp    80105826 <alltraps>

80105e56 <vector39>:
.globl vector39
vector39:
  pushl $0
80105e56:	6a 00                	push   $0x0
  pushl $39
80105e58:	6a 27                	push   $0x27
  jmp alltraps
80105e5a:	e9 c7 f9 ff ff       	jmp    80105826 <alltraps>

80105e5f <vector40>:
.globl vector40
vector40:
  pushl $0
80105e5f:	6a 00                	push   $0x0
  pushl $40
80105e61:	6a 28                	push   $0x28
  jmp alltraps
80105e63:	e9 be f9 ff ff       	jmp    80105826 <alltraps>

80105e68 <vector41>:
.globl vector41
vector41:
  pushl $0
80105e68:	6a 00                	push   $0x0
  pushl $41
80105e6a:	6a 29                	push   $0x29
  jmp alltraps
80105e6c:	e9 b5 f9 ff ff       	jmp    80105826 <alltraps>

80105e71 <vector42>:
.globl vector42
vector42:
  pushl $0
80105e71:	6a 00                	push   $0x0
  pushl $42
80105e73:	6a 2a                	push   $0x2a
  jmp alltraps
80105e75:	e9 ac f9 ff ff       	jmp    80105826 <alltraps>

80105e7a <vector43>:
.globl vector43
vector43:
  pushl $0
80105e7a:	6a 00                	push   $0x0
  pushl $43
80105e7c:	6a 2b                	push   $0x2b
  jmp alltraps
80105e7e:	e9 a3 f9 ff ff       	jmp    80105826 <alltraps>

80105e83 <vector44>:
.globl vector44
vector44:
  pushl $0
80105e83:	6a 00                	push   $0x0
  pushl $44
80105e85:	6a 2c                	push   $0x2c
  jmp alltraps
80105e87:	e9 9a f9 ff ff       	jmp    80105826 <alltraps>

80105e8c <vector45>:
.globl vector45
vector45:
  pushl $0
80105e8c:	6a 00                	push   $0x0
  pushl $45
80105e8e:	6a 2d                	push   $0x2d
  jmp alltraps
80105e90:	e9 91 f9 ff ff       	jmp    80105826 <alltraps>

80105e95 <vector46>:
.globl vector46
vector46:
  pushl $0
80105e95:	6a 00                	push   $0x0
  pushl $46
80105e97:	6a 2e                	push   $0x2e
  jmp alltraps
80105e99:	e9 88 f9 ff ff       	jmp    80105826 <alltraps>

80105e9e <vector47>:
.globl vector47
vector47:
  pushl $0
80105e9e:	6a 00                	push   $0x0
  pushl $47
80105ea0:	6a 2f                	push   $0x2f
  jmp alltraps
80105ea2:	e9 7f f9 ff ff       	jmp    80105826 <alltraps>

80105ea7 <vector48>:
.globl vector48
vector48:
  pushl $0
80105ea7:	6a 00                	push   $0x0
  pushl $48
80105ea9:	6a 30                	push   $0x30
  jmp alltraps
80105eab:	e9 76 f9 ff ff       	jmp    80105826 <alltraps>

80105eb0 <vector49>:
.globl vector49
vector49:
  pushl $0
80105eb0:	6a 00                	push   $0x0
  pushl $49
80105eb2:	6a 31                	push   $0x31
  jmp alltraps
80105eb4:	e9 6d f9 ff ff       	jmp    80105826 <alltraps>

80105eb9 <vector50>:
.globl vector50
vector50:
  pushl $0
80105eb9:	6a 00                	push   $0x0
  pushl $50
80105ebb:	6a 32                	push   $0x32
  jmp alltraps
80105ebd:	e9 64 f9 ff ff       	jmp    80105826 <alltraps>

80105ec2 <vector51>:
.globl vector51
vector51:
  pushl $0
80105ec2:	6a 00                	push   $0x0
  pushl $51
80105ec4:	6a 33                	push   $0x33
  jmp alltraps
80105ec6:	e9 5b f9 ff ff       	jmp    80105826 <alltraps>

80105ecb <vector52>:
.globl vector52
vector52:
  pushl $0
80105ecb:	6a 00                	push   $0x0
  pushl $52
80105ecd:	6a 34                	push   $0x34
  jmp alltraps
80105ecf:	e9 52 f9 ff ff       	jmp    80105826 <alltraps>

80105ed4 <vector53>:
.globl vector53
vector53:
  pushl $0
80105ed4:	6a 00                	push   $0x0
  pushl $53
80105ed6:	6a 35                	push   $0x35
  jmp alltraps
80105ed8:	e9 49 f9 ff ff       	jmp    80105826 <alltraps>

80105edd <vector54>:
.globl vector54
vector54:
  pushl $0
80105edd:	6a 00                	push   $0x0
  pushl $54
80105edf:	6a 36                	push   $0x36
  jmp alltraps
80105ee1:	e9 40 f9 ff ff       	jmp    80105826 <alltraps>

80105ee6 <vector55>:
.globl vector55
vector55:
  pushl $0
80105ee6:	6a 00                	push   $0x0
  pushl $55
80105ee8:	6a 37                	push   $0x37
  jmp alltraps
80105eea:	e9 37 f9 ff ff       	jmp    80105826 <alltraps>

80105eef <vector56>:
.globl vector56
vector56:
  pushl $0
80105eef:	6a 00                	push   $0x0
  pushl $56
80105ef1:	6a 38                	push   $0x38
  jmp alltraps
80105ef3:	e9 2e f9 ff ff       	jmp    80105826 <alltraps>

80105ef8 <vector57>:
.globl vector57
vector57:
  pushl $0
80105ef8:	6a 00                	push   $0x0
  pushl $57
80105efa:	6a 39                	push   $0x39
  jmp alltraps
80105efc:	e9 25 f9 ff ff       	jmp    80105826 <alltraps>

80105f01 <vector58>:
.globl vector58
vector58:
  pushl $0
80105f01:	6a 00                	push   $0x0
  pushl $58
80105f03:	6a 3a                	push   $0x3a
  jmp alltraps
80105f05:	e9 1c f9 ff ff       	jmp    80105826 <alltraps>

80105f0a <vector59>:
.globl vector59
vector59:
  pushl $0
80105f0a:	6a 00                	push   $0x0
  pushl $59
80105f0c:	6a 3b                	push   $0x3b
  jmp alltraps
80105f0e:	e9 13 f9 ff ff       	jmp    80105826 <alltraps>

80105f13 <vector60>:
.globl vector60
vector60:
  pushl $0
80105f13:	6a 00                	push   $0x0
  pushl $60
80105f15:	6a 3c                	push   $0x3c
  jmp alltraps
80105f17:	e9 0a f9 ff ff       	jmp    80105826 <alltraps>

80105f1c <vector61>:
.globl vector61
vector61:
  pushl $0
80105f1c:	6a 00                	push   $0x0
  pushl $61
80105f1e:	6a 3d                	push   $0x3d
  jmp alltraps
80105f20:	e9 01 f9 ff ff       	jmp    80105826 <alltraps>

80105f25 <vector62>:
.globl vector62
vector62:
  pushl $0
80105f25:	6a 00                	push   $0x0
  pushl $62
80105f27:	6a 3e                	push   $0x3e
  jmp alltraps
80105f29:	e9 f8 f8 ff ff       	jmp    80105826 <alltraps>

80105f2e <vector63>:
.globl vector63
vector63:
  pushl $0
80105f2e:	6a 00                	push   $0x0
  pushl $63
80105f30:	6a 3f                	push   $0x3f
  jmp alltraps
80105f32:	e9 ef f8 ff ff       	jmp    80105826 <alltraps>

80105f37 <vector64>:
.globl vector64
vector64:
  pushl $0
80105f37:	6a 00                	push   $0x0
  pushl $64
80105f39:	6a 40                	push   $0x40
  jmp alltraps
80105f3b:	e9 e6 f8 ff ff       	jmp    80105826 <alltraps>

80105f40 <vector65>:
.globl vector65
vector65:
  pushl $0
80105f40:	6a 00                	push   $0x0
  pushl $65
80105f42:	6a 41                	push   $0x41
  jmp alltraps
80105f44:	e9 dd f8 ff ff       	jmp    80105826 <alltraps>

80105f49 <vector66>:
.globl vector66
vector66:
  pushl $0
80105f49:	6a 00                	push   $0x0
  pushl $66
80105f4b:	6a 42                	push   $0x42
  jmp alltraps
80105f4d:	e9 d4 f8 ff ff       	jmp    80105826 <alltraps>

80105f52 <vector67>:
.globl vector67
vector67:
  pushl $0
80105f52:	6a 00                	push   $0x0
  pushl $67
80105f54:	6a 43                	push   $0x43
  jmp alltraps
80105f56:	e9 cb f8 ff ff       	jmp    80105826 <alltraps>

80105f5b <vector68>:
.globl vector68
vector68:
  pushl $0
80105f5b:	6a 00                	push   $0x0
  pushl $68
80105f5d:	6a 44                	push   $0x44
  jmp alltraps
80105f5f:	e9 c2 f8 ff ff       	jmp    80105826 <alltraps>

80105f64 <vector69>:
.globl vector69
vector69:
  pushl $0
80105f64:	6a 00                	push   $0x0
  pushl $69
80105f66:	6a 45                	push   $0x45
  jmp alltraps
80105f68:	e9 b9 f8 ff ff       	jmp    80105826 <alltraps>

80105f6d <vector70>:
.globl vector70
vector70:
  pushl $0
80105f6d:	6a 00                	push   $0x0
  pushl $70
80105f6f:	6a 46                	push   $0x46
  jmp alltraps
80105f71:	e9 b0 f8 ff ff       	jmp    80105826 <alltraps>

80105f76 <vector71>:
.globl vector71
vector71:
  pushl $0
80105f76:	6a 00                	push   $0x0
  pushl $71
80105f78:	6a 47                	push   $0x47
  jmp alltraps
80105f7a:	e9 a7 f8 ff ff       	jmp    80105826 <alltraps>

80105f7f <vector72>:
.globl vector72
vector72:
  pushl $0
80105f7f:	6a 00                	push   $0x0
  pushl $72
80105f81:	6a 48                	push   $0x48
  jmp alltraps
80105f83:	e9 9e f8 ff ff       	jmp    80105826 <alltraps>

80105f88 <vector73>:
.globl vector73
vector73:
  pushl $0
80105f88:	6a 00                	push   $0x0
  pushl $73
80105f8a:	6a 49                	push   $0x49
  jmp alltraps
80105f8c:	e9 95 f8 ff ff       	jmp    80105826 <alltraps>

80105f91 <vector74>:
.globl vector74
vector74:
  pushl $0
80105f91:	6a 00                	push   $0x0
  pushl $74
80105f93:	6a 4a                	push   $0x4a
  jmp alltraps
80105f95:	e9 8c f8 ff ff       	jmp    80105826 <alltraps>

80105f9a <vector75>:
.globl vector75
vector75:
  pushl $0
80105f9a:	6a 00                	push   $0x0
  pushl $75
80105f9c:	6a 4b                	push   $0x4b
  jmp alltraps
80105f9e:	e9 83 f8 ff ff       	jmp    80105826 <alltraps>

80105fa3 <vector76>:
.globl vector76
vector76:
  pushl $0
80105fa3:	6a 00                	push   $0x0
  pushl $76
80105fa5:	6a 4c                	push   $0x4c
  jmp alltraps
80105fa7:	e9 7a f8 ff ff       	jmp    80105826 <alltraps>

80105fac <vector77>:
.globl vector77
vector77:
  pushl $0
80105fac:	6a 00                	push   $0x0
  pushl $77
80105fae:	6a 4d                	push   $0x4d
  jmp alltraps
80105fb0:	e9 71 f8 ff ff       	jmp    80105826 <alltraps>

80105fb5 <vector78>:
.globl vector78
vector78:
  pushl $0
80105fb5:	6a 00                	push   $0x0
  pushl $78
80105fb7:	6a 4e                	push   $0x4e
  jmp alltraps
80105fb9:	e9 68 f8 ff ff       	jmp    80105826 <alltraps>

80105fbe <vector79>:
.globl vector79
vector79:
  pushl $0
80105fbe:	6a 00                	push   $0x0
  pushl $79
80105fc0:	6a 4f                	push   $0x4f
  jmp alltraps
80105fc2:	e9 5f f8 ff ff       	jmp    80105826 <alltraps>

80105fc7 <vector80>:
.globl vector80
vector80:
  pushl $0
80105fc7:	6a 00                	push   $0x0
  pushl $80
80105fc9:	6a 50                	push   $0x50
  jmp alltraps
80105fcb:	e9 56 f8 ff ff       	jmp    80105826 <alltraps>

80105fd0 <vector81>:
.globl vector81
vector81:
  pushl $0
80105fd0:	6a 00                	push   $0x0
  pushl $81
80105fd2:	6a 51                	push   $0x51
  jmp alltraps
80105fd4:	e9 4d f8 ff ff       	jmp    80105826 <alltraps>

80105fd9 <vector82>:
.globl vector82
vector82:
  pushl $0
80105fd9:	6a 00                	push   $0x0
  pushl $82
80105fdb:	6a 52                	push   $0x52
  jmp alltraps
80105fdd:	e9 44 f8 ff ff       	jmp    80105826 <alltraps>

80105fe2 <vector83>:
.globl vector83
vector83:
  pushl $0
80105fe2:	6a 00                	push   $0x0
  pushl $83
80105fe4:	6a 53                	push   $0x53
  jmp alltraps
80105fe6:	e9 3b f8 ff ff       	jmp    80105826 <alltraps>

80105feb <vector84>:
.globl vector84
vector84:
  pushl $0
80105feb:	6a 00                	push   $0x0
  pushl $84
80105fed:	6a 54                	push   $0x54
  jmp alltraps
80105fef:	e9 32 f8 ff ff       	jmp    80105826 <alltraps>

80105ff4 <vector85>:
.globl vector85
vector85:
  pushl $0
80105ff4:	6a 00                	push   $0x0
  pushl $85
80105ff6:	6a 55                	push   $0x55
  jmp alltraps
80105ff8:	e9 29 f8 ff ff       	jmp    80105826 <alltraps>

80105ffd <vector86>:
.globl vector86
vector86:
  pushl $0
80105ffd:	6a 00                	push   $0x0
  pushl $86
80105fff:	6a 56                	push   $0x56
  jmp alltraps
80106001:	e9 20 f8 ff ff       	jmp    80105826 <alltraps>

80106006 <vector87>:
.globl vector87
vector87:
  pushl $0
80106006:	6a 00                	push   $0x0
  pushl $87
80106008:	6a 57                	push   $0x57
  jmp alltraps
8010600a:	e9 17 f8 ff ff       	jmp    80105826 <alltraps>

8010600f <vector88>:
.globl vector88
vector88:
  pushl $0
8010600f:	6a 00                	push   $0x0
  pushl $88
80106011:	6a 58                	push   $0x58
  jmp alltraps
80106013:	e9 0e f8 ff ff       	jmp    80105826 <alltraps>

80106018 <vector89>:
.globl vector89
vector89:
  pushl $0
80106018:	6a 00                	push   $0x0
  pushl $89
8010601a:	6a 59                	push   $0x59
  jmp alltraps
8010601c:	e9 05 f8 ff ff       	jmp    80105826 <alltraps>

80106021 <vector90>:
.globl vector90
vector90:
  pushl $0
80106021:	6a 00                	push   $0x0
  pushl $90
80106023:	6a 5a                	push   $0x5a
  jmp alltraps
80106025:	e9 fc f7 ff ff       	jmp    80105826 <alltraps>

8010602a <vector91>:
.globl vector91
vector91:
  pushl $0
8010602a:	6a 00                	push   $0x0
  pushl $91
8010602c:	6a 5b                	push   $0x5b
  jmp alltraps
8010602e:	e9 f3 f7 ff ff       	jmp    80105826 <alltraps>

80106033 <vector92>:
.globl vector92
vector92:
  pushl $0
80106033:	6a 00                	push   $0x0
  pushl $92
80106035:	6a 5c                	push   $0x5c
  jmp alltraps
80106037:	e9 ea f7 ff ff       	jmp    80105826 <alltraps>

8010603c <vector93>:
.globl vector93
vector93:
  pushl $0
8010603c:	6a 00                	push   $0x0
  pushl $93
8010603e:	6a 5d                	push   $0x5d
  jmp alltraps
80106040:	e9 e1 f7 ff ff       	jmp    80105826 <alltraps>

80106045 <vector94>:
.globl vector94
vector94:
  pushl $0
80106045:	6a 00                	push   $0x0
  pushl $94
80106047:	6a 5e                	push   $0x5e
  jmp alltraps
80106049:	e9 d8 f7 ff ff       	jmp    80105826 <alltraps>

8010604e <vector95>:
.globl vector95
vector95:
  pushl $0
8010604e:	6a 00                	push   $0x0
  pushl $95
80106050:	6a 5f                	push   $0x5f
  jmp alltraps
80106052:	e9 cf f7 ff ff       	jmp    80105826 <alltraps>

80106057 <vector96>:
.globl vector96
vector96:
  pushl $0
80106057:	6a 00                	push   $0x0
  pushl $96
80106059:	6a 60                	push   $0x60
  jmp alltraps
8010605b:	e9 c6 f7 ff ff       	jmp    80105826 <alltraps>

80106060 <vector97>:
.globl vector97
vector97:
  pushl $0
80106060:	6a 00                	push   $0x0
  pushl $97
80106062:	6a 61                	push   $0x61
  jmp alltraps
80106064:	e9 bd f7 ff ff       	jmp    80105826 <alltraps>

80106069 <vector98>:
.globl vector98
vector98:
  pushl $0
80106069:	6a 00                	push   $0x0
  pushl $98
8010606b:	6a 62                	push   $0x62
  jmp alltraps
8010606d:	e9 b4 f7 ff ff       	jmp    80105826 <alltraps>

80106072 <vector99>:
.globl vector99
vector99:
  pushl $0
80106072:	6a 00                	push   $0x0
  pushl $99
80106074:	6a 63                	push   $0x63
  jmp alltraps
80106076:	e9 ab f7 ff ff       	jmp    80105826 <alltraps>

8010607b <vector100>:
.globl vector100
vector100:
  pushl $0
8010607b:	6a 00                	push   $0x0
  pushl $100
8010607d:	6a 64                	push   $0x64
  jmp alltraps
8010607f:	e9 a2 f7 ff ff       	jmp    80105826 <alltraps>

80106084 <vector101>:
.globl vector101
vector101:
  pushl $0
80106084:	6a 00                	push   $0x0
  pushl $101
80106086:	6a 65                	push   $0x65
  jmp alltraps
80106088:	e9 99 f7 ff ff       	jmp    80105826 <alltraps>

8010608d <vector102>:
.globl vector102
vector102:
  pushl $0
8010608d:	6a 00                	push   $0x0
  pushl $102
8010608f:	6a 66                	push   $0x66
  jmp alltraps
80106091:	e9 90 f7 ff ff       	jmp    80105826 <alltraps>

80106096 <vector103>:
.globl vector103
vector103:
  pushl $0
80106096:	6a 00                	push   $0x0
  pushl $103
80106098:	6a 67                	push   $0x67
  jmp alltraps
8010609a:	e9 87 f7 ff ff       	jmp    80105826 <alltraps>

8010609f <vector104>:
.globl vector104
vector104:
  pushl $0
8010609f:	6a 00                	push   $0x0
  pushl $104
801060a1:	6a 68                	push   $0x68
  jmp alltraps
801060a3:	e9 7e f7 ff ff       	jmp    80105826 <alltraps>

801060a8 <vector105>:
.globl vector105
vector105:
  pushl $0
801060a8:	6a 00                	push   $0x0
  pushl $105
801060aa:	6a 69                	push   $0x69
  jmp alltraps
801060ac:	e9 75 f7 ff ff       	jmp    80105826 <alltraps>

801060b1 <vector106>:
.globl vector106
vector106:
  pushl $0
801060b1:	6a 00                	push   $0x0
  pushl $106
801060b3:	6a 6a                	push   $0x6a
  jmp alltraps
801060b5:	e9 6c f7 ff ff       	jmp    80105826 <alltraps>

801060ba <vector107>:
.globl vector107
vector107:
  pushl $0
801060ba:	6a 00                	push   $0x0
  pushl $107
801060bc:	6a 6b                	push   $0x6b
  jmp alltraps
801060be:	e9 63 f7 ff ff       	jmp    80105826 <alltraps>

801060c3 <vector108>:
.globl vector108
vector108:
  pushl $0
801060c3:	6a 00                	push   $0x0
  pushl $108
801060c5:	6a 6c                	push   $0x6c
  jmp alltraps
801060c7:	e9 5a f7 ff ff       	jmp    80105826 <alltraps>

801060cc <vector109>:
.globl vector109
vector109:
  pushl $0
801060cc:	6a 00                	push   $0x0
  pushl $109
801060ce:	6a 6d                	push   $0x6d
  jmp alltraps
801060d0:	e9 51 f7 ff ff       	jmp    80105826 <alltraps>

801060d5 <vector110>:
.globl vector110
vector110:
  pushl $0
801060d5:	6a 00                	push   $0x0
  pushl $110
801060d7:	6a 6e                	push   $0x6e
  jmp alltraps
801060d9:	e9 48 f7 ff ff       	jmp    80105826 <alltraps>

801060de <vector111>:
.globl vector111
vector111:
  pushl $0
801060de:	6a 00                	push   $0x0
  pushl $111
801060e0:	6a 6f                	push   $0x6f
  jmp alltraps
801060e2:	e9 3f f7 ff ff       	jmp    80105826 <alltraps>

801060e7 <vector112>:
.globl vector112
vector112:
  pushl $0
801060e7:	6a 00                	push   $0x0
  pushl $112
801060e9:	6a 70                	push   $0x70
  jmp alltraps
801060eb:	e9 36 f7 ff ff       	jmp    80105826 <alltraps>

801060f0 <vector113>:
.globl vector113
vector113:
  pushl $0
801060f0:	6a 00                	push   $0x0
  pushl $113
801060f2:	6a 71                	push   $0x71
  jmp alltraps
801060f4:	e9 2d f7 ff ff       	jmp    80105826 <alltraps>

801060f9 <vector114>:
.globl vector114
vector114:
  pushl $0
801060f9:	6a 00                	push   $0x0
  pushl $114
801060fb:	6a 72                	push   $0x72
  jmp alltraps
801060fd:	e9 24 f7 ff ff       	jmp    80105826 <alltraps>

80106102 <vector115>:
.globl vector115
vector115:
  pushl $0
80106102:	6a 00                	push   $0x0
  pushl $115
80106104:	6a 73                	push   $0x73
  jmp alltraps
80106106:	e9 1b f7 ff ff       	jmp    80105826 <alltraps>

8010610b <vector116>:
.globl vector116
vector116:
  pushl $0
8010610b:	6a 00                	push   $0x0
  pushl $116
8010610d:	6a 74                	push   $0x74
  jmp alltraps
8010610f:	e9 12 f7 ff ff       	jmp    80105826 <alltraps>

80106114 <vector117>:
.globl vector117
vector117:
  pushl $0
80106114:	6a 00                	push   $0x0
  pushl $117
80106116:	6a 75                	push   $0x75
  jmp alltraps
80106118:	e9 09 f7 ff ff       	jmp    80105826 <alltraps>

8010611d <vector118>:
.globl vector118
vector118:
  pushl $0
8010611d:	6a 00                	push   $0x0
  pushl $118
8010611f:	6a 76                	push   $0x76
  jmp alltraps
80106121:	e9 00 f7 ff ff       	jmp    80105826 <alltraps>

80106126 <vector119>:
.globl vector119
vector119:
  pushl $0
80106126:	6a 00                	push   $0x0
  pushl $119
80106128:	6a 77                	push   $0x77
  jmp alltraps
8010612a:	e9 f7 f6 ff ff       	jmp    80105826 <alltraps>

8010612f <vector120>:
.globl vector120
vector120:
  pushl $0
8010612f:	6a 00                	push   $0x0
  pushl $120
80106131:	6a 78                	push   $0x78
  jmp alltraps
80106133:	e9 ee f6 ff ff       	jmp    80105826 <alltraps>

80106138 <vector121>:
.globl vector121
vector121:
  pushl $0
80106138:	6a 00                	push   $0x0
  pushl $121
8010613a:	6a 79                	push   $0x79
  jmp alltraps
8010613c:	e9 e5 f6 ff ff       	jmp    80105826 <alltraps>

80106141 <vector122>:
.globl vector122
vector122:
  pushl $0
80106141:	6a 00                	push   $0x0
  pushl $122
80106143:	6a 7a                	push   $0x7a
  jmp alltraps
80106145:	e9 dc f6 ff ff       	jmp    80105826 <alltraps>

8010614a <vector123>:
.globl vector123
vector123:
  pushl $0
8010614a:	6a 00                	push   $0x0
  pushl $123
8010614c:	6a 7b                	push   $0x7b
  jmp alltraps
8010614e:	e9 d3 f6 ff ff       	jmp    80105826 <alltraps>

80106153 <vector124>:
.globl vector124
vector124:
  pushl $0
80106153:	6a 00                	push   $0x0
  pushl $124
80106155:	6a 7c                	push   $0x7c
  jmp alltraps
80106157:	e9 ca f6 ff ff       	jmp    80105826 <alltraps>

8010615c <vector125>:
.globl vector125
vector125:
  pushl $0
8010615c:	6a 00                	push   $0x0
  pushl $125
8010615e:	6a 7d                	push   $0x7d
  jmp alltraps
80106160:	e9 c1 f6 ff ff       	jmp    80105826 <alltraps>

80106165 <vector126>:
.globl vector126
vector126:
  pushl $0
80106165:	6a 00                	push   $0x0
  pushl $126
80106167:	6a 7e                	push   $0x7e
  jmp alltraps
80106169:	e9 b8 f6 ff ff       	jmp    80105826 <alltraps>

8010616e <vector127>:
.globl vector127
vector127:
  pushl $0
8010616e:	6a 00                	push   $0x0
  pushl $127
80106170:	6a 7f                	push   $0x7f
  jmp alltraps
80106172:	e9 af f6 ff ff       	jmp    80105826 <alltraps>

80106177 <vector128>:
.globl vector128
vector128:
  pushl $0
80106177:	6a 00                	push   $0x0
  pushl $128
80106179:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010617e:	e9 a3 f6 ff ff       	jmp    80105826 <alltraps>

80106183 <vector129>:
.globl vector129
vector129:
  pushl $0
80106183:	6a 00                	push   $0x0
  pushl $129
80106185:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010618a:	e9 97 f6 ff ff       	jmp    80105826 <alltraps>

8010618f <vector130>:
.globl vector130
vector130:
  pushl $0
8010618f:	6a 00                	push   $0x0
  pushl $130
80106191:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106196:	e9 8b f6 ff ff       	jmp    80105826 <alltraps>

8010619b <vector131>:
.globl vector131
vector131:
  pushl $0
8010619b:	6a 00                	push   $0x0
  pushl $131
8010619d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801061a2:	e9 7f f6 ff ff       	jmp    80105826 <alltraps>

801061a7 <vector132>:
.globl vector132
vector132:
  pushl $0
801061a7:	6a 00                	push   $0x0
  pushl $132
801061a9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801061ae:	e9 73 f6 ff ff       	jmp    80105826 <alltraps>

801061b3 <vector133>:
.globl vector133
vector133:
  pushl $0
801061b3:	6a 00                	push   $0x0
  pushl $133
801061b5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801061ba:	e9 67 f6 ff ff       	jmp    80105826 <alltraps>

801061bf <vector134>:
.globl vector134
vector134:
  pushl $0
801061bf:	6a 00                	push   $0x0
  pushl $134
801061c1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801061c6:	e9 5b f6 ff ff       	jmp    80105826 <alltraps>

801061cb <vector135>:
.globl vector135
vector135:
  pushl $0
801061cb:	6a 00                	push   $0x0
  pushl $135
801061cd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801061d2:	e9 4f f6 ff ff       	jmp    80105826 <alltraps>

801061d7 <vector136>:
.globl vector136
vector136:
  pushl $0
801061d7:	6a 00                	push   $0x0
  pushl $136
801061d9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801061de:	e9 43 f6 ff ff       	jmp    80105826 <alltraps>

801061e3 <vector137>:
.globl vector137
vector137:
  pushl $0
801061e3:	6a 00                	push   $0x0
  pushl $137
801061e5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801061ea:	e9 37 f6 ff ff       	jmp    80105826 <alltraps>

801061ef <vector138>:
.globl vector138
vector138:
  pushl $0
801061ef:	6a 00                	push   $0x0
  pushl $138
801061f1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801061f6:	e9 2b f6 ff ff       	jmp    80105826 <alltraps>

801061fb <vector139>:
.globl vector139
vector139:
  pushl $0
801061fb:	6a 00                	push   $0x0
  pushl $139
801061fd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106202:	e9 1f f6 ff ff       	jmp    80105826 <alltraps>

80106207 <vector140>:
.globl vector140
vector140:
  pushl $0
80106207:	6a 00                	push   $0x0
  pushl $140
80106209:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010620e:	e9 13 f6 ff ff       	jmp    80105826 <alltraps>

80106213 <vector141>:
.globl vector141
vector141:
  pushl $0
80106213:	6a 00                	push   $0x0
  pushl $141
80106215:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010621a:	e9 07 f6 ff ff       	jmp    80105826 <alltraps>

8010621f <vector142>:
.globl vector142
vector142:
  pushl $0
8010621f:	6a 00                	push   $0x0
  pushl $142
80106221:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106226:	e9 fb f5 ff ff       	jmp    80105826 <alltraps>

8010622b <vector143>:
.globl vector143
vector143:
  pushl $0
8010622b:	6a 00                	push   $0x0
  pushl $143
8010622d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106232:	e9 ef f5 ff ff       	jmp    80105826 <alltraps>

80106237 <vector144>:
.globl vector144
vector144:
  pushl $0
80106237:	6a 00                	push   $0x0
  pushl $144
80106239:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010623e:	e9 e3 f5 ff ff       	jmp    80105826 <alltraps>

80106243 <vector145>:
.globl vector145
vector145:
  pushl $0
80106243:	6a 00                	push   $0x0
  pushl $145
80106245:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010624a:	e9 d7 f5 ff ff       	jmp    80105826 <alltraps>

8010624f <vector146>:
.globl vector146
vector146:
  pushl $0
8010624f:	6a 00                	push   $0x0
  pushl $146
80106251:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106256:	e9 cb f5 ff ff       	jmp    80105826 <alltraps>

8010625b <vector147>:
.globl vector147
vector147:
  pushl $0
8010625b:	6a 00                	push   $0x0
  pushl $147
8010625d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106262:	e9 bf f5 ff ff       	jmp    80105826 <alltraps>

80106267 <vector148>:
.globl vector148
vector148:
  pushl $0
80106267:	6a 00                	push   $0x0
  pushl $148
80106269:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010626e:	e9 b3 f5 ff ff       	jmp    80105826 <alltraps>

80106273 <vector149>:
.globl vector149
vector149:
  pushl $0
80106273:	6a 00                	push   $0x0
  pushl $149
80106275:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010627a:	e9 a7 f5 ff ff       	jmp    80105826 <alltraps>

8010627f <vector150>:
.globl vector150
vector150:
  pushl $0
8010627f:	6a 00                	push   $0x0
  pushl $150
80106281:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106286:	e9 9b f5 ff ff       	jmp    80105826 <alltraps>

8010628b <vector151>:
.globl vector151
vector151:
  pushl $0
8010628b:	6a 00                	push   $0x0
  pushl $151
8010628d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106292:	e9 8f f5 ff ff       	jmp    80105826 <alltraps>

80106297 <vector152>:
.globl vector152
vector152:
  pushl $0
80106297:	6a 00                	push   $0x0
  pushl $152
80106299:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010629e:	e9 83 f5 ff ff       	jmp    80105826 <alltraps>

801062a3 <vector153>:
.globl vector153
vector153:
  pushl $0
801062a3:	6a 00                	push   $0x0
  pushl $153
801062a5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801062aa:	e9 77 f5 ff ff       	jmp    80105826 <alltraps>

801062af <vector154>:
.globl vector154
vector154:
  pushl $0
801062af:	6a 00                	push   $0x0
  pushl $154
801062b1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801062b6:	e9 6b f5 ff ff       	jmp    80105826 <alltraps>

801062bb <vector155>:
.globl vector155
vector155:
  pushl $0
801062bb:	6a 00                	push   $0x0
  pushl $155
801062bd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801062c2:	e9 5f f5 ff ff       	jmp    80105826 <alltraps>

801062c7 <vector156>:
.globl vector156
vector156:
  pushl $0
801062c7:	6a 00                	push   $0x0
  pushl $156
801062c9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801062ce:	e9 53 f5 ff ff       	jmp    80105826 <alltraps>

801062d3 <vector157>:
.globl vector157
vector157:
  pushl $0
801062d3:	6a 00                	push   $0x0
  pushl $157
801062d5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801062da:	e9 47 f5 ff ff       	jmp    80105826 <alltraps>

801062df <vector158>:
.globl vector158
vector158:
  pushl $0
801062df:	6a 00                	push   $0x0
  pushl $158
801062e1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801062e6:	e9 3b f5 ff ff       	jmp    80105826 <alltraps>

801062eb <vector159>:
.globl vector159
vector159:
  pushl $0
801062eb:	6a 00                	push   $0x0
  pushl $159
801062ed:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801062f2:	e9 2f f5 ff ff       	jmp    80105826 <alltraps>

801062f7 <vector160>:
.globl vector160
vector160:
  pushl $0
801062f7:	6a 00                	push   $0x0
  pushl $160
801062f9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801062fe:	e9 23 f5 ff ff       	jmp    80105826 <alltraps>

80106303 <vector161>:
.globl vector161
vector161:
  pushl $0
80106303:	6a 00                	push   $0x0
  pushl $161
80106305:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010630a:	e9 17 f5 ff ff       	jmp    80105826 <alltraps>

8010630f <vector162>:
.globl vector162
vector162:
  pushl $0
8010630f:	6a 00                	push   $0x0
  pushl $162
80106311:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106316:	e9 0b f5 ff ff       	jmp    80105826 <alltraps>

8010631b <vector163>:
.globl vector163
vector163:
  pushl $0
8010631b:	6a 00                	push   $0x0
  pushl $163
8010631d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106322:	e9 ff f4 ff ff       	jmp    80105826 <alltraps>

80106327 <vector164>:
.globl vector164
vector164:
  pushl $0
80106327:	6a 00                	push   $0x0
  pushl $164
80106329:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010632e:	e9 f3 f4 ff ff       	jmp    80105826 <alltraps>

80106333 <vector165>:
.globl vector165
vector165:
  pushl $0
80106333:	6a 00                	push   $0x0
  pushl $165
80106335:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010633a:	e9 e7 f4 ff ff       	jmp    80105826 <alltraps>

8010633f <vector166>:
.globl vector166
vector166:
  pushl $0
8010633f:	6a 00                	push   $0x0
  pushl $166
80106341:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106346:	e9 db f4 ff ff       	jmp    80105826 <alltraps>

8010634b <vector167>:
.globl vector167
vector167:
  pushl $0
8010634b:	6a 00                	push   $0x0
  pushl $167
8010634d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106352:	e9 cf f4 ff ff       	jmp    80105826 <alltraps>

80106357 <vector168>:
.globl vector168
vector168:
  pushl $0
80106357:	6a 00                	push   $0x0
  pushl $168
80106359:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010635e:	e9 c3 f4 ff ff       	jmp    80105826 <alltraps>

80106363 <vector169>:
.globl vector169
vector169:
  pushl $0
80106363:	6a 00                	push   $0x0
  pushl $169
80106365:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010636a:	e9 b7 f4 ff ff       	jmp    80105826 <alltraps>

8010636f <vector170>:
.globl vector170
vector170:
  pushl $0
8010636f:	6a 00                	push   $0x0
  pushl $170
80106371:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106376:	e9 ab f4 ff ff       	jmp    80105826 <alltraps>

8010637b <vector171>:
.globl vector171
vector171:
  pushl $0
8010637b:	6a 00                	push   $0x0
  pushl $171
8010637d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106382:	e9 9f f4 ff ff       	jmp    80105826 <alltraps>

80106387 <vector172>:
.globl vector172
vector172:
  pushl $0
80106387:	6a 00                	push   $0x0
  pushl $172
80106389:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010638e:	e9 93 f4 ff ff       	jmp    80105826 <alltraps>

80106393 <vector173>:
.globl vector173
vector173:
  pushl $0
80106393:	6a 00                	push   $0x0
  pushl $173
80106395:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010639a:	e9 87 f4 ff ff       	jmp    80105826 <alltraps>

8010639f <vector174>:
.globl vector174
vector174:
  pushl $0
8010639f:	6a 00                	push   $0x0
  pushl $174
801063a1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801063a6:	e9 7b f4 ff ff       	jmp    80105826 <alltraps>

801063ab <vector175>:
.globl vector175
vector175:
  pushl $0
801063ab:	6a 00                	push   $0x0
  pushl $175
801063ad:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801063b2:	e9 6f f4 ff ff       	jmp    80105826 <alltraps>

801063b7 <vector176>:
.globl vector176
vector176:
  pushl $0
801063b7:	6a 00                	push   $0x0
  pushl $176
801063b9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801063be:	e9 63 f4 ff ff       	jmp    80105826 <alltraps>

801063c3 <vector177>:
.globl vector177
vector177:
  pushl $0
801063c3:	6a 00                	push   $0x0
  pushl $177
801063c5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801063ca:	e9 57 f4 ff ff       	jmp    80105826 <alltraps>

801063cf <vector178>:
.globl vector178
vector178:
  pushl $0
801063cf:	6a 00                	push   $0x0
  pushl $178
801063d1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801063d6:	e9 4b f4 ff ff       	jmp    80105826 <alltraps>

801063db <vector179>:
.globl vector179
vector179:
  pushl $0
801063db:	6a 00                	push   $0x0
  pushl $179
801063dd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801063e2:	e9 3f f4 ff ff       	jmp    80105826 <alltraps>

801063e7 <vector180>:
.globl vector180
vector180:
  pushl $0
801063e7:	6a 00                	push   $0x0
  pushl $180
801063e9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801063ee:	e9 33 f4 ff ff       	jmp    80105826 <alltraps>

801063f3 <vector181>:
.globl vector181
vector181:
  pushl $0
801063f3:	6a 00                	push   $0x0
  pushl $181
801063f5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801063fa:	e9 27 f4 ff ff       	jmp    80105826 <alltraps>

801063ff <vector182>:
.globl vector182
vector182:
  pushl $0
801063ff:	6a 00                	push   $0x0
  pushl $182
80106401:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106406:	e9 1b f4 ff ff       	jmp    80105826 <alltraps>

8010640b <vector183>:
.globl vector183
vector183:
  pushl $0
8010640b:	6a 00                	push   $0x0
  pushl $183
8010640d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106412:	e9 0f f4 ff ff       	jmp    80105826 <alltraps>

80106417 <vector184>:
.globl vector184
vector184:
  pushl $0
80106417:	6a 00                	push   $0x0
  pushl $184
80106419:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010641e:	e9 03 f4 ff ff       	jmp    80105826 <alltraps>

80106423 <vector185>:
.globl vector185
vector185:
  pushl $0
80106423:	6a 00                	push   $0x0
  pushl $185
80106425:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010642a:	e9 f7 f3 ff ff       	jmp    80105826 <alltraps>

8010642f <vector186>:
.globl vector186
vector186:
  pushl $0
8010642f:	6a 00                	push   $0x0
  pushl $186
80106431:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106436:	e9 eb f3 ff ff       	jmp    80105826 <alltraps>

8010643b <vector187>:
.globl vector187
vector187:
  pushl $0
8010643b:	6a 00                	push   $0x0
  pushl $187
8010643d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106442:	e9 df f3 ff ff       	jmp    80105826 <alltraps>

80106447 <vector188>:
.globl vector188
vector188:
  pushl $0
80106447:	6a 00                	push   $0x0
  pushl $188
80106449:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010644e:	e9 d3 f3 ff ff       	jmp    80105826 <alltraps>

80106453 <vector189>:
.globl vector189
vector189:
  pushl $0
80106453:	6a 00                	push   $0x0
  pushl $189
80106455:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010645a:	e9 c7 f3 ff ff       	jmp    80105826 <alltraps>

8010645f <vector190>:
.globl vector190
vector190:
  pushl $0
8010645f:	6a 00                	push   $0x0
  pushl $190
80106461:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106466:	e9 bb f3 ff ff       	jmp    80105826 <alltraps>

8010646b <vector191>:
.globl vector191
vector191:
  pushl $0
8010646b:	6a 00                	push   $0x0
  pushl $191
8010646d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106472:	e9 af f3 ff ff       	jmp    80105826 <alltraps>

80106477 <vector192>:
.globl vector192
vector192:
  pushl $0
80106477:	6a 00                	push   $0x0
  pushl $192
80106479:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010647e:	e9 a3 f3 ff ff       	jmp    80105826 <alltraps>

80106483 <vector193>:
.globl vector193
vector193:
  pushl $0
80106483:	6a 00                	push   $0x0
  pushl $193
80106485:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010648a:	e9 97 f3 ff ff       	jmp    80105826 <alltraps>

8010648f <vector194>:
.globl vector194
vector194:
  pushl $0
8010648f:	6a 00                	push   $0x0
  pushl $194
80106491:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106496:	e9 8b f3 ff ff       	jmp    80105826 <alltraps>

8010649b <vector195>:
.globl vector195
vector195:
  pushl $0
8010649b:	6a 00                	push   $0x0
  pushl $195
8010649d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801064a2:	e9 7f f3 ff ff       	jmp    80105826 <alltraps>

801064a7 <vector196>:
.globl vector196
vector196:
  pushl $0
801064a7:	6a 00                	push   $0x0
  pushl $196
801064a9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801064ae:	e9 73 f3 ff ff       	jmp    80105826 <alltraps>

801064b3 <vector197>:
.globl vector197
vector197:
  pushl $0
801064b3:	6a 00                	push   $0x0
  pushl $197
801064b5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801064ba:	e9 67 f3 ff ff       	jmp    80105826 <alltraps>

801064bf <vector198>:
.globl vector198
vector198:
  pushl $0
801064bf:	6a 00                	push   $0x0
  pushl $198
801064c1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801064c6:	e9 5b f3 ff ff       	jmp    80105826 <alltraps>

801064cb <vector199>:
.globl vector199
vector199:
  pushl $0
801064cb:	6a 00                	push   $0x0
  pushl $199
801064cd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801064d2:	e9 4f f3 ff ff       	jmp    80105826 <alltraps>

801064d7 <vector200>:
.globl vector200
vector200:
  pushl $0
801064d7:	6a 00                	push   $0x0
  pushl $200
801064d9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801064de:	e9 43 f3 ff ff       	jmp    80105826 <alltraps>

801064e3 <vector201>:
.globl vector201
vector201:
  pushl $0
801064e3:	6a 00                	push   $0x0
  pushl $201
801064e5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801064ea:	e9 37 f3 ff ff       	jmp    80105826 <alltraps>

801064ef <vector202>:
.globl vector202
vector202:
  pushl $0
801064ef:	6a 00                	push   $0x0
  pushl $202
801064f1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801064f6:	e9 2b f3 ff ff       	jmp    80105826 <alltraps>

801064fb <vector203>:
.globl vector203
vector203:
  pushl $0
801064fb:	6a 00                	push   $0x0
  pushl $203
801064fd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106502:	e9 1f f3 ff ff       	jmp    80105826 <alltraps>

80106507 <vector204>:
.globl vector204
vector204:
  pushl $0
80106507:	6a 00                	push   $0x0
  pushl $204
80106509:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010650e:	e9 13 f3 ff ff       	jmp    80105826 <alltraps>

80106513 <vector205>:
.globl vector205
vector205:
  pushl $0
80106513:	6a 00                	push   $0x0
  pushl $205
80106515:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010651a:	e9 07 f3 ff ff       	jmp    80105826 <alltraps>

8010651f <vector206>:
.globl vector206
vector206:
  pushl $0
8010651f:	6a 00                	push   $0x0
  pushl $206
80106521:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106526:	e9 fb f2 ff ff       	jmp    80105826 <alltraps>

8010652b <vector207>:
.globl vector207
vector207:
  pushl $0
8010652b:	6a 00                	push   $0x0
  pushl $207
8010652d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106532:	e9 ef f2 ff ff       	jmp    80105826 <alltraps>

80106537 <vector208>:
.globl vector208
vector208:
  pushl $0
80106537:	6a 00                	push   $0x0
  pushl $208
80106539:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010653e:	e9 e3 f2 ff ff       	jmp    80105826 <alltraps>

80106543 <vector209>:
.globl vector209
vector209:
  pushl $0
80106543:	6a 00                	push   $0x0
  pushl $209
80106545:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010654a:	e9 d7 f2 ff ff       	jmp    80105826 <alltraps>

8010654f <vector210>:
.globl vector210
vector210:
  pushl $0
8010654f:	6a 00                	push   $0x0
  pushl $210
80106551:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106556:	e9 cb f2 ff ff       	jmp    80105826 <alltraps>

8010655b <vector211>:
.globl vector211
vector211:
  pushl $0
8010655b:	6a 00                	push   $0x0
  pushl $211
8010655d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106562:	e9 bf f2 ff ff       	jmp    80105826 <alltraps>

80106567 <vector212>:
.globl vector212
vector212:
  pushl $0
80106567:	6a 00                	push   $0x0
  pushl $212
80106569:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010656e:	e9 b3 f2 ff ff       	jmp    80105826 <alltraps>

80106573 <vector213>:
.globl vector213
vector213:
  pushl $0
80106573:	6a 00                	push   $0x0
  pushl $213
80106575:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010657a:	e9 a7 f2 ff ff       	jmp    80105826 <alltraps>

8010657f <vector214>:
.globl vector214
vector214:
  pushl $0
8010657f:	6a 00                	push   $0x0
  pushl $214
80106581:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106586:	e9 9b f2 ff ff       	jmp    80105826 <alltraps>

8010658b <vector215>:
.globl vector215
vector215:
  pushl $0
8010658b:	6a 00                	push   $0x0
  pushl $215
8010658d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106592:	e9 8f f2 ff ff       	jmp    80105826 <alltraps>

80106597 <vector216>:
.globl vector216
vector216:
  pushl $0
80106597:	6a 00                	push   $0x0
  pushl $216
80106599:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010659e:	e9 83 f2 ff ff       	jmp    80105826 <alltraps>

801065a3 <vector217>:
.globl vector217
vector217:
  pushl $0
801065a3:	6a 00                	push   $0x0
  pushl $217
801065a5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801065aa:	e9 77 f2 ff ff       	jmp    80105826 <alltraps>

801065af <vector218>:
.globl vector218
vector218:
  pushl $0
801065af:	6a 00                	push   $0x0
  pushl $218
801065b1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801065b6:	e9 6b f2 ff ff       	jmp    80105826 <alltraps>

801065bb <vector219>:
.globl vector219
vector219:
  pushl $0
801065bb:	6a 00                	push   $0x0
  pushl $219
801065bd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801065c2:	e9 5f f2 ff ff       	jmp    80105826 <alltraps>

801065c7 <vector220>:
.globl vector220
vector220:
  pushl $0
801065c7:	6a 00                	push   $0x0
  pushl $220
801065c9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801065ce:	e9 53 f2 ff ff       	jmp    80105826 <alltraps>

801065d3 <vector221>:
.globl vector221
vector221:
  pushl $0
801065d3:	6a 00                	push   $0x0
  pushl $221
801065d5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801065da:	e9 47 f2 ff ff       	jmp    80105826 <alltraps>

801065df <vector222>:
.globl vector222
vector222:
  pushl $0
801065df:	6a 00                	push   $0x0
  pushl $222
801065e1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801065e6:	e9 3b f2 ff ff       	jmp    80105826 <alltraps>

801065eb <vector223>:
.globl vector223
vector223:
  pushl $0
801065eb:	6a 00                	push   $0x0
  pushl $223
801065ed:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801065f2:	e9 2f f2 ff ff       	jmp    80105826 <alltraps>

801065f7 <vector224>:
.globl vector224
vector224:
  pushl $0
801065f7:	6a 00                	push   $0x0
  pushl $224
801065f9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801065fe:	e9 23 f2 ff ff       	jmp    80105826 <alltraps>

80106603 <vector225>:
.globl vector225
vector225:
  pushl $0
80106603:	6a 00                	push   $0x0
  pushl $225
80106605:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010660a:	e9 17 f2 ff ff       	jmp    80105826 <alltraps>

8010660f <vector226>:
.globl vector226
vector226:
  pushl $0
8010660f:	6a 00                	push   $0x0
  pushl $226
80106611:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106616:	e9 0b f2 ff ff       	jmp    80105826 <alltraps>

8010661b <vector227>:
.globl vector227
vector227:
  pushl $0
8010661b:	6a 00                	push   $0x0
  pushl $227
8010661d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106622:	e9 ff f1 ff ff       	jmp    80105826 <alltraps>

80106627 <vector228>:
.globl vector228
vector228:
  pushl $0
80106627:	6a 00                	push   $0x0
  pushl $228
80106629:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010662e:	e9 f3 f1 ff ff       	jmp    80105826 <alltraps>

80106633 <vector229>:
.globl vector229
vector229:
  pushl $0
80106633:	6a 00                	push   $0x0
  pushl $229
80106635:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010663a:	e9 e7 f1 ff ff       	jmp    80105826 <alltraps>

8010663f <vector230>:
.globl vector230
vector230:
  pushl $0
8010663f:	6a 00                	push   $0x0
  pushl $230
80106641:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106646:	e9 db f1 ff ff       	jmp    80105826 <alltraps>

8010664b <vector231>:
.globl vector231
vector231:
  pushl $0
8010664b:	6a 00                	push   $0x0
  pushl $231
8010664d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106652:	e9 cf f1 ff ff       	jmp    80105826 <alltraps>

80106657 <vector232>:
.globl vector232
vector232:
  pushl $0
80106657:	6a 00                	push   $0x0
  pushl $232
80106659:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010665e:	e9 c3 f1 ff ff       	jmp    80105826 <alltraps>

80106663 <vector233>:
.globl vector233
vector233:
  pushl $0
80106663:	6a 00                	push   $0x0
  pushl $233
80106665:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010666a:	e9 b7 f1 ff ff       	jmp    80105826 <alltraps>

8010666f <vector234>:
.globl vector234
vector234:
  pushl $0
8010666f:	6a 00                	push   $0x0
  pushl $234
80106671:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106676:	e9 ab f1 ff ff       	jmp    80105826 <alltraps>

8010667b <vector235>:
.globl vector235
vector235:
  pushl $0
8010667b:	6a 00                	push   $0x0
  pushl $235
8010667d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106682:	e9 9f f1 ff ff       	jmp    80105826 <alltraps>

80106687 <vector236>:
.globl vector236
vector236:
  pushl $0
80106687:	6a 00                	push   $0x0
  pushl $236
80106689:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010668e:	e9 93 f1 ff ff       	jmp    80105826 <alltraps>

80106693 <vector237>:
.globl vector237
vector237:
  pushl $0
80106693:	6a 00                	push   $0x0
  pushl $237
80106695:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010669a:	e9 87 f1 ff ff       	jmp    80105826 <alltraps>

8010669f <vector238>:
.globl vector238
vector238:
  pushl $0
8010669f:	6a 00                	push   $0x0
  pushl $238
801066a1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801066a6:	e9 7b f1 ff ff       	jmp    80105826 <alltraps>

801066ab <vector239>:
.globl vector239
vector239:
  pushl $0
801066ab:	6a 00                	push   $0x0
  pushl $239
801066ad:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801066b2:	e9 6f f1 ff ff       	jmp    80105826 <alltraps>

801066b7 <vector240>:
.globl vector240
vector240:
  pushl $0
801066b7:	6a 00                	push   $0x0
  pushl $240
801066b9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801066be:	e9 63 f1 ff ff       	jmp    80105826 <alltraps>

801066c3 <vector241>:
.globl vector241
vector241:
  pushl $0
801066c3:	6a 00                	push   $0x0
  pushl $241
801066c5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801066ca:	e9 57 f1 ff ff       	jmp    80105826 <alltraps>

801066cf <vector242>:
.globl vector242
vector242:
  pushl $0
801066cf:	6a 00                	push   $0x0
  pushl $242
801066d1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801066d6:	e9 4b f1 ff ff       	jmp    80105826 <alltraps>

801066db <vector243>:
.globl vector243
vector243:
  pushl $0
801066db:	6a 00                	push   $0x0
  pushl $243
801066dd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801066e2:	e9 3f f1 ff ff       	jmp    80105826 <alltraps>

801066e7 <vector244>:
.globl vector244
vector244:
  pushl $0
801066e7:	6a 00                	push   $0x0
  pushl $244
801066e9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801066ee:	e9 33 f1 ff ff       	jmp    80105826 <alltraps>

801066f3 <vector245>:
.globl vector245
vector245:
  pushl $0
801066f3:	6a 00                	push   $0x0
  pushl $245
801066f5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801066fa:	e9 27 f1 ff ff       	jmp    80105826 <alltraps>

801066ff <vector246>:
.globl vector246
vector246:
  pushl $0
801066ff:	6a 00                	push   $0x0
  pushl $246
80106701:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106706:	e9 1b f1 ff ff       	jmp    80105826 <alltraps>

8010670b <vector247>:
.globl vector247
vector247:
  pushl $0
8010670b:	6a 00                	push   $0x0
  pushl $247
8010670d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106712:	e9 0f f1 ff ff       	jmp    80105826 <alltraps>

80106717 <vector248>:
.globl vector248
vector248:
  pushl $0
80106717:	6a 00                	push   $0x0
  pushl $248
80106719:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010671e:	e9 03 f1 ff ff       	jmp    80105826 <alltraps>

80106723 <vector249>:
.globl vector249
vector249:
  pushl $0
80106723:	6a 00                	push   $0x0
  pushl $249
80106725:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010672a:	e9 f7 f0 ff ff       	jmp    80105826 <alltraps>

8010672f <vector250>:
.globl vector250
vector250:
  pushl $0
8010672f:	6a 00                	push   $0x0
  pushl $250
80106731:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106736:	e9 eb f0 ff ff       	jmp    80105826 <alltraps>

8010673b <vector251>:
.globl vector251
vector251:
  pushl $0
8010673b:	6a 00                	push   $0x0
  pushl $251
8010673d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106742:	e9 df f0 ff ff       	jmp    80105826 <alltraps>

80106747 <vector252>:
.globl vector252
vector252:
  pushl $0
80106747:	6a 00                	push   $0x0
  pushl $252
80106749:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010674e:	e9 d3 f0 ff ff       	jmp    80105826 <alltraps>

80106753 <vector253>:
.globl vector253
vector253:
  pushl $0
80106753:	6a 00                	push   $0x0
  pushl $253
80106755:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010675a:	e9 c7 f0 ff ff       	jmp    80105826 <alltraps>

8010675f <vector254>:
.globl vector254
vector254:
  pushl $0
8010675f:	6a 00                	push   $0x0
  pushl $254
80106761:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106766:	e9 bb f0 ff ff       	jmp    80105826 <alltraps>

8010676b <vector255>:
.globl vector255
vector255:
  pushl $0
8010676b:	6a 00                	push   $0x0
  pushl $255
8010676d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106772:	e9 af f0 ff ff       	jmp    80105826 <alltraps>
80106777:	66 90                	xchg   %ax,%ax
80106779:	66 90                	xchg   %ax,%ax
8010677b:	66 90                	xchg   %ax,%ax
8010677d:	66 90                	xchg   %ax,%ax
8010677f:	90                   	nop

80106780 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106780:	55                   	push   %ebp
80106781:	89 e5                	mov    %esp,%ebp
80106783:	57                   	push   %edi
80106784:	56                   	push   %esi
80106785:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106786:	89 d3                	mov    %edx,%ebx
{
80106788:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010678a:	c1 eb 16             	shr    $0x16,%ebx
8010678d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106790:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106793:	8b 06                	mov    (%esi),%eax
80106795:	a8 01                	test   $0x1,%al
80106797:	74 27                	je     801067c0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106799:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010679e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801067a4:	c1 ef 0a             	shr    $0xa,%edi
}
801067a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
801067aa:	89 fa                	mov    %edi,%edx
801067ac:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801067b2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
801067b5:	5b                   	pop    %ebx
801067b6:	5e                   	pop    %esi
801067b7:	5f                   	pop    %edi
801067b8:	5d                   	pop    %ebp
801067b9:	c3                   	ret    
801067ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801067c0:	85 c9                	test   %ecx,%ecx
801067c2:	74 2c                	je     801067f0 <walkpgdir+0x70>
801067c4:	e8 07 bd ff ff       	call   801024d0 <kalloc>
801067c9:	85 c0                	test   %eax,%eax
801067cb:	89 c3                	mov    %eax,%ebx
801067cd:	74 21                	je     801067f0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
801067cf:	83 ec 04             	sub    $0x4,%esp
801067d2:	68 00 10 00 00       	push   $0x1000
801067d7:	6a 00                	push   $0x0
801067d9:	50                   	push   %eax
801067da:	e8 21 de ff ff       	call   80104600 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801067df:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801067e5:	83 c4 10             	add    $0x10,%esp
801067e8:	83 c8 07             	or     $0x7,%eax
801067eb:	89 06                	mov    %eax,(%esi)
801067ed:	eb b5                	jmp    801067a4 <walkpgdir+0x24>
801067ef:	90                   	nop
}
801067f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801067f3:	31 c0                	xor    %eax,%eax
}
801067f5:	5b                   	pop    %ebx
801067f6:	5e                   	pop    %esi
801067f7:	5f                   	pop    %edi
801067f8:	5d                   	pop    %ebp
801067f9:	c3                   	ret    
801067fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106800 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106800:	55                   	push   %ebp
80106801:	89 e5                	mov    %esp,%ebp
80106803:	57                   	push   %edi
80106804:	56                   	push   %esi
80106805:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106806:	89 d3                	mov    %edx,%ebx
80106808:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010680e:	83 ec 1c             	sub    $0x1c,%esp
80106811:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106814:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106818:	8b 7d 08             	mov    0x8(%ebp),%edi
8010681b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106820:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106823:	8b 45 0c             	mov    0xc(%ebp),%eax
80106826:	29 df                	sub    %ebx,%edi
80106828:	83 c8 01             	or     $0x1,%eax
8010682b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010682e:	eb 15                	jmp    80106845 <mappages+0x45>
    if(*pte & PTE_P)
80106830:	f6 00 01             	testb  $0x1,(%eax)
80106833:	75 45                	jne    8010687a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80106835:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106838:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
8010683b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010683d:	74 31                	je     80106870 <mappages+0x70>
      break;
    a += PGSIZE;
8010683f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106845:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106848:	b9 01 00 00 00       	mov    $0x1,%ecx
8010684d:	89 da                	mov    %ebx,%edx
8010684f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106852:	e8 29 ff ff ff       	call   80106780 <walkpgdir>
80106857:	85 c0                	test   %eax,%eax
80106859:	75 d5                	jne    80106830 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010685b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010685e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106863:	5b                   	pop    %ebx
80106864:	5e                   	pop    %esi
80106865:	5f                   	pop    %edi
80106866:	5d                   	pop    %ebp
80106867:	c3                   	ret    
80106868:	90                   	nop
80106869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106870:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106873:	31 c0                	xor    %eax,%eax
}
80106875:	5b                   	pop    %ebx
80106876:	5e                   	pop    %esi
80106877:	5f                   	pop    %edi
80106878:	5d                   	pop    %ebp
80106879:	c3                   	ret    
      panic("remap");
8010687a:	83 ec 0c             	sub    $0xc,%esp
8010687d:	68 ac 7b 10 80       	push   $0x80107bac
80106882:	e8 09 9b ff ff       	call   80100390 <panic>
80106887:	89 f6                	mov    %esi,%esi
80106889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106890 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106890:	55                   	push   %ebp
80106891:	89 e5                	mov    %esp,%ebp
80106893:	57                   	push   %edi
80106894:	56                   	push   %esi
80106895:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106896:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010689c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
8010689e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801068a4:	83 ec 1c             	sub    $0x1c,%esp
801068a7:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801068aa:	39 d3                	cmp    %edx,%ebx
801068ac:	73 66                	jae    80106914 <deallocuvm.part.0+0x84>
801068ae:	89 d6                	mov    %edx,%esi
801068b0:	eb 3d                	jmp    801068ef <deallocuvm.part.0+0x5f>
801068b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801068b8:	8b 10                	mov    (%eax),%edx
801068ba:	f6 c2 01             	test   $0x1,%dl
801068bd:	74 26                	je     801068e5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801068bf:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801068c5:	74 58                	je     8010691f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
801068c7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801068ca:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801068d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
801068d3:	52                   	push   %edx
801068d4:	e8 47 ba ff ff       	call   80102320 <kfree>
      *pte = 0;
801068d9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801068dc:	83 c4 10             	add    $0x10,%esp
801068df:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
801068e5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801068eb:	39 f3                	cmp    %esi,%ebx
801068ed:	73 25                	jae    80106914 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
801068ef:	31 c9                	xor    %ecx,%ecx
801068f1:	89 da                	mov    %ebx,%edx
801068f3:	89 f8                	mov    %edi,%eax
801068f5:	e8 86 fe ff ff       	call   80106780 <walkpgdir>
    if(!pte)
801068fa:	85 c0                	test   %eax,%eax
801068fc:	75 ba                	jne    801068b8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801068fe:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106904:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
8010690a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106910:	39 f3                	cmp    %esi,%ebx
80106912:	72 db                	jb     801068ef <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80106914:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106917:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010691a:	5b                   	pop    %ebx
8010691b:	5e                   	pop    %esi
8010691c:	5f                   	pop    %edi
8010691d:	5d                   	pop    %ebp
8010691e:	c3                   	ret    
        panic("kfree");
8010691f:	83 ec 0c             	sub    $0xc,%esp
80106922:	68 e6 74 10 80       	push   $0x801074e6
80106927:	e8 64 9a ff ff       	call   80100390 <panic>
8010692c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106930 <seginit>:
{
80106930:	55                   	push   %ebp
80106931:	89 e5                	mov    %esp,%ebp
80106933:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106936:	e8 55 ce ff ff       	call   80103790 <cpuid>
8010693b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80106941:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106946:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010694a:	c7 80 b8 31 11 80 ff 	movl   $0xffff,-0x7feece48(%eax)
80106951:	ff 00 00 
80106954:	c7 80 bc 31 11 80 00 	movl   $0xcf9a00,-0x7feece44(%eax)
8010695b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010695e:	c7 80 c0 31 11 80 ff 	movl   $0xffff,-0x7feece40(%eax)
80106965:	ff 00 00 
80106968:	c7 80 c4 31 11 80 00 	movl   $0xcf9200,-0x7feece3c(%eax)
8010696f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106972:	c7 80 c8 31 11 80 ff 	movl   $0xffff,-0x7feece38(%eax)
80106979:	ff 00 00 
8010697c:	c7 80 cc 31 11 80 00 	movl   $0xcffa00,-0x7feece34(%eax)
80106983:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106986:	c7 80 d0 31 11 80 ff 	movl   $0xffff,-0x7feece30(%eax)
8010698d:	ff 00 00 
80106990:	c7 80 d4 31 11 80 00 	movl   $0xcff200,-0x7feece2c(%eax)
80106997:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010699a:	05 b0 31 11 80       	add    $0x801131b0,%eax
  pd[1] = (uint)p;
8010699f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801069a3:	c1 e8 10             	shr    $0x10,%eax
801069a6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801069aa:	8d 45 f2             	lea    -0xe(%ebp),%eax
801069ad:	0f 01 10             	lgdtl  (%eax)
}
801069b0:	c9                   	leave  
801069b1:	c3                   	ret    
801069b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069c0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801069c0:	a1 84 5a 11 80       	mov    0x80115a84,%eax
{
801069c5:	55                   	push   %ebp
801069c6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801069c8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801069cd:	0f 22 d8             	mov    %eax,%cr3
}
801069d0:	5d                   	pop    %ebp
801069d1:	c3                   	ret    
801069d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069e0 <switchuvm>:
{
801069e0:	55                   	push   %ebp
801069e1:	89 e5                	mov    %esp,%ebp
801069e3:	57                   	push   %edi
801069e4:	56                   	push   %esi
801069e5:	53                   	push   %ebx
801069e6:	83 ec 1c             	sub    $0x1c,%esp
801069e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
801069ec:	85 db                	test   %ebx,%ebx
801069ee:	0f 84 cb 00 00 00    	je     80106abf <switchuvm+0xdf>
  if(p->kstack == 0)
801069f4:	8b 43 08             	mov    0x8(%ebx),%eax
801069f7:	85 c0                	test   %eax,%eax
801069f9:	0f 84 da 00 00 00    	je     80106ad9 <switchuvm+0xf9>
  if(p->pgdir == 0)
801069ff:	8b 43 04             	mov    0x4(%ebx),%eax
80106a02:	85 c0                	test   %eax,%eax
80106a04:	0f 84 c2 00 00 00    	je     80106acc <switchuvm+0xec>
  pushcli();
80106a0a:	e8 11 da ff ff       	call   80104420 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106a0f:	e8 2c cd ff ff       	call   80103740 <mycpu>
80106a14:	89 c6                	mov    %eax,%esi
80106a16:	e8 25 cd ff ff       	call   80103740 <mycpu>
80106a1b:	89 c7                	mov    %eax,%edi
80106a1d:	e8 1e cd ff ff       	call   80103740 <mycpu>
80106a22:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106a25:	83 c7 08             	add    $0x8,%edi
80106a28:	e8 13 cd ff ff       	call   80103740 <mycpu>
80106a2d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106a30:	83 c0 08             	add    $0x8,%eax
80106a33:	ba 67 00 00 00       	mov    $0x67,%edx
80106a38:	c1 e8 18             	shr    $0x18,%eax
80106a3b:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80106a42:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106a49:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106a4f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106a54:	83 c1 08             	add    $0x8,%ecx
80106a57:	c1 e9 10             	shr    $0x10,%ecx
80106a5a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106a60:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106a65:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106a6c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80106a71:	e8 ca cc ff ff       	call   80103740 <mycpu>
80106a76:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106a7d:	e8 be cc ff ff       	call   80103740 <mycpu>
80106a82:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106a86:	8b 73 08             	mov    0x8(%ebx),%esi
80106a89:	e8 b2 cc ff ff       	call   80103740 <mycpu>
80106a8e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106a94:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106a97:	e8 a4 cc ff ff       	call   80103740 <mycpu>
80106a9c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106aa0:	b8 28 00 00 00       	mov    $0x28,%eax
80106aa5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106aa8:	8b 43 04             	mov    0x4(%ebx),%eax
80106aab:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106ab0:	0f 22 d8             	mov    %eax,%cr3
}
80106ab3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ab6:	5b                   	pop    %ebx
80106ab7:	5e                   	pop    %esi
80106ab8:	5f                   	pop    %edi
80106ab9:	5d                   	pop    %ebp
  popcli();
80106aba:	e9 a1 d9 ff ff       	jmp    80104460 <popcli>
    panic("switchuvm: no process");
80106abf:	83 ec 0c             	sub    $0xc,%esp
80106ac2:	68 b2 7b 10 80       	push   $0x80107bb2
80106ac7:	e8 c4 98 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80106acc:	83 ec 0c             	sub    $0xc,%esp
80106acf:	68 dd 7b 10 80       	push   $0x80107bdd
80106ad4:	e8 b7 98 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80106ad9:	83 ec 0c             	sub    $0xc,%esp
80106adc:	68 c8 7b 10 80       	push   $0x80107bc8
80106ae1:	e8 aa 98 ff ff       	call   80100390 <panic>
80106ae6:	8d 76 00             	lea    0x0(%esi),%esi
80106ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106af0 <inituvm>:
{
80106af0:	55                   	push   %ebp
80106af1:	89 e5                	mov    %esp,%ebp
80106af3:	57                   	push   %edi
80106af4:	56                   	push   %esi
80106af5:	53                   	push   %ebx
80106af6:	83 ec 1c             	sub    $0x1c,%esp
80106af9:	8b 75 10             	mov    0x10(%ebp),%esi
80106afc:	8b 45 08             	mov    0x8(%ebp),%eax
80106aff:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106b02:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106b08:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106b0b:	77 49                	ja     80106b56 <inituvm+0x66>
  mem = kalloc();
80106b0d:	e8 be b9 ff ff       	call   801024d0 <kalloc>
  memset(mem, 0, PGSIZE);
80106b12:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80106b15:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106b17:	68 00 10 00 00       	push   $0x1000
80106b1c:	6a 00                	push   $0x0
80106b1e:	50                   	push   %eax
80106b1f:	e8 dc da ff ff       	call   80104600 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106b24:	58                   	pop    %eax
80106b25:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106b2b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106b30:	5a                   	pop    %edx
80106b31:	6a 06                	push   $0x6
80106b33:	50                   	push   %eax
80106b34:	31 d2                	xor    %edx,%edx
80106b36:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b39:	e8 c2 fc ff ff       	call   80106800 <mappages>
  memmove(mem, init, sz);
80106b3e:	89 75 10             	mov    %esi,0x10(%ebp)
80106b41:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106b44:	83 c4 10             	add    $0x10,%esp
80106b47:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106b4a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b4d:	5b                   	pop    %ebx
80106b4e:	5e                   	pop    %esi
80106b4f:	5f                   	pop    %edi
80106b50:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106b51:	e9 5a db ff ff       	jmp    801046b0 <memmove>
    panic("inituvm: more than a page");
80106b56:	83 ec 0c             	sub    $0xc,%esp
80106b59:	68 f1 7b 10 80       	push   $0x80107bf1
80106b5e:	e8 2d 98 ff ff       	call   80100390 <panic>
80106b63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b70 <loaduvm>:
{
80106b70:	55                   	push   %ebp
80106b71:	89 e5                	mov    %esp,%ebp
80106b73:	57                   	push   %edi
80106b74:	56                   	push   %esi
80106b75:	53                   	push   %ebx
80106b76:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106b79:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106b80:	0f 85 91 00 00 00    	jne    80106c17 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106b86:	8b 75 18             	mov    0x18(%ebp),%esi
80106b89:	31 db                	xor    %ebx,%ebx
80106b8b:	85 f6                	test   %esi,%esi
80106b8d:	75 1a                	jne    80106ba9 <loaduvm+0x39>
80106b8f:	eb 6f                	jmp    80106c00 <loaduvm+0x90>
80106b91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b98:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b9e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106ba4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106ba7:	76 57                	jbe    80106c00 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106ba9:	8b 55 0c             	mov    0xc(%ebp),%edx
80106bac:	8b 45 08             	mov    0x8(%ebp),%eax
80106baf:	31 c9                	xor    %ecx,%ecx
80106bb1:	01 da                	add    %ebx,%edx
80106bb3:	e8 c8 fb ff ff       	call   80106780 <walkpgdir>
80106bb8:	85 c0                	test   %eax,%eax
80106bba:	74 4e                	je     80106c0a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106bbc:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106bbe:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80106bc1:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106bc6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106bcb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106bd1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106bd4:	01 d9                	add    %ebx,%ecx
80106bd6:	05 00 00 00 80       	add    $0x80000000,%eax
80106bdb:	57                   	push   %edi
80106bdc:	51                   	push   %ecx
80106bdd:	50                   	push   %eax
80106bde:	ff 75 10             	pushl  0x10(%ebp)
80106be1:	e8 8a ad ff ff       	call   80101970 <readi>
80106be6:	83 c4 10             	add    $0x10,%esp
80106be9:	39 f8                	cmp    %edi,%eax
80106beb:	74 ab                	je     80106b98 <loaduvm+0x28>
}
80106bed:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106bf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106bf5:	5b                   	pop    %ebx
80106bf6:	5e                   	pop    %esi
80106bf7:	5f                   	pop    %edi
80106bf8:	5d                   	pop    %ebp
80106bf9:	c3                   	ret    
80106bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c00:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106c03:	31 c0                	xor    %eax,%eax
}
80106c05:	5b                   	pop    %ebx
80106c06:	5e                   	pop    %esi
80106c07:	5f                   	pop    %edi
80106c08:	5d                   	pop    %ebp
80106c09:	c3                   	ret    
      panic("loaduvm: address should exist");
80106c0a:	83 ec 0c             	sub    $0xc,%esp
80106c0d:	68 0b 7c 10 80       	push   $0x80107c0b
80106c12:	e8 79 97 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80106c17:	83 ec 0c             	sub    $0xc,%esp
80106c1a:	68 ac 7c 10 80       	push   $0x80107cac
80106c1f:	e8 6c 97 ff ff       	call   80100390 <panic>
80106c24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106c30 <allocuvm>:
{
80106c30:	55                   	push   %ebp
80106c31:	89 e5                	mov    %esp,%ebp
80106c33:	57                   	push   %edi
80106c34:	56                   	push   %esi
80106c35:	53                   	push   %ebx
80106c36:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106c39:	8b 7d 10             	mov    0x10(%ebp),%edi
80106c3c:	85 ff                	test   %edi,%edi
80106c3e:	0f 88 8e 00 00 00    	js     80106cd2 <allocuvm+0xa2>
  if(newsz < oldsz)
80106c44:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106c47:	0f 82 93 00 00 00    	jb     80106ce0 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
80106c4d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106c50:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106c56:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106c5c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106c5f:	0f 86 7e 00 00 00    	jbe    80106ce3 <allocuvm+0xb3>
80106c65:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106c68:	8b 7d 08             	mov    0x8(%ebp),%edi
80106c6b:	eb 42                	jmp    80106caf <allocuvm+0x7f>
80106c6d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106c70:	83 ec 04             	sub    $0x4,%esp
80106c73:	68 00 10 00 00       	push   $0x1000
80106c78:	6a 00                	push   $0x0
80106c7a:	50                   	push   %eax
80106c7b:	e8 80 d9 ff ff       	call   80104600 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106c80:	58                   	pop    %eax
80106c81:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106c87:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106c8c:	5a                   	pop    %edx
80106c8d:	6a 06                	push   $0x6
80106c8f:	50                   	push   %eax
80106c90:	89 da                	mov    %ebx,%edx
80106c92:	89 f8                	mov    %edi,%eax
80106c94:	e8 67 fb ff ff       	call   80106800 <mappages>
80106c99:	83 c4 10             	add    $0x10,%esp
80106c9c:	85 c0                	test   %eax,%eax
80106c9e:	78 50                	js     80106cf0 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80106ca0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106ca6:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106ca9:	0f 86 81 00 00 00    	jbe    80106d30 <allocuvm+0x100>
    mem = kalloc();
80106caf:	e8 1c b8 ff ff       	call   801024d0 <kalloc>
    if(mem == 0){
80106cb4:	85 c0                	test   %eax,%eax
    mem = kalloc();
80106cb6:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106cb8:	75 b6                	jne    80106c70 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106cba:	83 ec 0c             	sub    $0xc,%esp
80106cbd:	68 29 7c 10 80       	push   $0x80107c29
80106cc2:	e8 99 99 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106cc7:	83 c4 10             	add    $0x10,%esp
80106cca:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ccd:	39 45 10             	cmp    %eax,0x10(%ebp)
80106cd0:	77 6e                	ja     80106d40 <allocuvm+0x110>
}
80106cd2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106cd5:	31 ff                	xor    %edi,%edi
}
80106cd7:	89 f8                	mov    %edi,%eax
80106cd9:	5b                   	pop    %ebx
80106cda:	5e                   	pop    %esi
80106cdb:	5f                   	pop    %edi
80106cdc:	5d                   	pop    %ebp
80106cdd:	c3                   	ret    
80106cde:	66 90                	xchg   %ax,%ax
    return oldsz;
80106ce0:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80106ce3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ce6:	89 f8                	mov    %edi,%eax
80106ce8:	5b                   	pop    %ebx
80106ce9:	5e                   	pop    %esi
80106cea:	5f                   	pop    %edi
80106ceb:	5d                   	pop    %ebp
80106cec:	c3                   	ret    
80106ced:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106cf0:	83 ec 0c             	sub    $0xc,%esp
80106cf3:	68 41 7c 10 80       	push   $0x80107c41
80106cf8:	e8 63 99 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106cfd:	83 c4 10             	add    $0x10,%esp
80106d00:	8b 45 0c             	mov    0xc(%ebp),%eax
80106d03:	39 45 10             	cmp    %eax,0x10(%ebp)
80106d06:	76 0d                	jbe    80106d15 <allocuvm+0xe5>
80106d08:	89 c1                	mov    %eax,%ecx
80106d0a:	8b 55 10             	mov    0x10(%ebp),%edx
80106d0d:	8b 45 08             	mov    0x8(%ebp),%eax
80106d10:	e8 7b fb ff ff       	call   80106890 <deallocuvm.part.0>
      kfree(mem);
80106d15:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80106d18:	31 ff                	xor    %edi,%edi
      kfree(mem);
80106d1a:	56                   	push   %esi
80106d1b:	e8 00 b6 ff ff       	call   80102320 <kfree>
      return 0;
80106d20:	83 c4 10             	add    $0x10,%esp
}
80106d23:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d26:	89 f8                	mov    %edi,%eax
80106d28:	5b                   	pop    %ebx
80106d29:	5e                   	pop    %esi
80106d2a:	5f                   	pop    %edi
80106d2b:	5d                   	pop    %ebp
80106d2c:	c3                   	ret    
80106d2d:	8d 76 00             	lea    0x0(%esi),%esi
80106d30:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106d33:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d36:	5b                   	pop    %ebx
80106d37:	89 f8                	mov    %edi,%eax
80106d39:	5e                   	pop    %esi
80106d3a:	5f                   	pop    %edi
80106d3b:	5d                   	pop    %ebp
80106d3c:	c3                   	ret    
80106d3d:	8d 76 00             	lea    0x0(%esi),%esi
80106d40:	89 c1                	mov    %eax,%ecx
80106d42:	8b 55 10             	mov    0x10(%ebp),%edx
80106d45:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80106d48:	31 ff                	xor    %edi,%edi
80106d4a:	e8 41 fb ff ff       	call   80106890 <deallocuvm.part.0>
80106d4f:	eb 92                	jmp    80106ce3 <allocuvm+0xb3>
80106d51:	eb 0d                	jmp    80106d60 <deallocuvm>
80106d53:	90                   	nop
80106d54:	90                   	nop
80106d55:	90                   	nop
80106d56:	90                   	nop
80106d57:	90                   	nop
80106d58:	90                   	nop
80106d59:	90                   	nop
80106d5a:	90                   	nop
80106d5b:	90                   	nop
80106d5c:	90                   	nop
80106d5d:	90                   	nop
80106d5e:	90                   	nop
80106d5f:	90                   	nop

80106d60 <deallocuvm>:
{
80106d60:	55                   	push   %ebp
80106d61:	89 e5                	mov    %esp,%ebp
80106d63:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d66:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106d69:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106d6c:	39 d1                	cmp    %edx,%ecx
80106d6e:	73 10                	jae    80106d80 <deallocuvm+0x20>
}
80106d70:	5d                   	pop    %ebp
80106d71:	e9 1a fb ff ff       	jmp    80106890 <deallocuvm.part.0>
80106d76:	8d 76 00             	lea    0x0(%esi),%esi
80106d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106d80:	89 d0                	mov    %edx,%eax
80106d82:	5d                   	pop    %ebp
80106d83:	c3                   	ret    
80106d84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106d90 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106d90:	55                   	push   %ebp
80106d91:	89 e5                	mov    %esp,%ebp
80106d93:	57                   	push   %edi
80106d94:	56                   	push   %esi
80106d95:	53                   	push   %ebx
80106d96:	83 ec 0c             	sub    $0xc,%esp
80106d99:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106d9c:	85 f6                	test   %esi,%esi
80106d9e:	74 59                	je     80106df9 <freevm+0x69>
80106da0:	31 c9                	xor    %ecx,%ecx
80106da2:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106da7:	89 f0                	mov    %esi,%eax
80106da9:	e8 e2 fa ff ff       	call   80106890 <deallocuvm.part.0>
80106dae:	89 f3                	mov    %esi,%ebx
80106db0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106db6:	eb 0f                	jmp    80106dc7 <freevm+0x37>
80106db8:	90                   	nop
80106db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106dc0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106dc3:	39 fb                	cmp    %edi,%ebx
80106dc5:	74 23                	je     80106dea <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106dc7:	8b 03                	mov    (%ebx),%eax
80106dc9:	a8 01                	test   $0x1,%al
80106dcb:	74 f3                	je     80106dc0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106dcd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106dd2:	83 ec 0c             	sub    $0xc,%esp
80106dd5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106dd8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106ddd:	50                   	push   %eax
80106dde:	e8 3d b5 ff ff       	call   80102320 <kfree>
80106de3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106de6:	39 fb                	cmp    %edi,%ebx
80106de8:	75 dd                	jne    80106dc7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106dea:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106ded:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106df0:	5b                   	pop    %ebx
80106df1:	5e                   	pop    %esi
80106df2:	5f                   	pop    %edi
80106df3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106df4:	e9 27 b5 ff ff       	jmp    80102320 <kfree>
    panic("freevm: no pgdir");
80106df9:	83 ec 0c             	sub    $0xc,%esp
80106dfc:	68 5d 7c 10 80       	push   $0x80107c5d
80106e01:	e8 8a 95 ff ff       	call   80100390 <panic>
80106e06:	8d 76 00             	lea    0x0(%esi),%esi
80106e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e10 <setupkvm>:
{
80106e10:	55                   	push   %ebp
80106e11:	89 e5                	mov    %esp,%ebp
80106e13:	56                   	push   %esi
80106e14:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106e15:	e8 b6 b6 ff ff       	call   801024d0 <kalloc>
80106e1a:	85 c0                	test   %eax,%eax
80106e1c:	89 c6                	mov    %eax,%esi
80106e1e:	74 42                	je     80106e62 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80106e20:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106e23:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106e28:	68 00 10 00 00       	push   $0x1000
80106e2d:	6a 00                	push   $0x0
80106e2f:	50                   	push   %eax
80106e30:	e8 cb d7 ff ff       	call   80104600 <memset>
80106e35:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80106e38:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106e3b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106e3e:	83 ec 08             	sub    $0x8,%esp
80106e41:	8b 13                	mov    (%ebx),%edx
80106e43:	ff 73 0c             	pushl  0xc(%ebx)
80106e46:	50                   	push   %eax
80106e47:	29 c1                	sub    %eax,%ecx
80106e49:	89 f0                	mov    %esi,%eax
80106e4b:	e8 b0 f9 ff ff       	call   80106800 <mappages>
80106e50:	83 c4 10             	add    $0x10,%esp
80106e53:	85 c0                	test   %eax,%eax
80106e55:	78 19                	js     80106e70 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106e57:	83 c3 10             	add    $0x10,%ebx
80106e5a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106e60:	75 d6                	jne    80106e38 <setupkvm+0x28>
}
80106e62:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106e65:	89 f0                	mov    %esi,%eax
80106e67:	5b                   	pop    %ebx
80106e68:	5e                   	pop    %esi
80106e69:	5d                   	pop    %ebp
80106e6a:	c3                   	ret    
80106e6b:	90                   	nop
80106e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80106e70:	83 ec 0c             	sub    $0xc,%esp
80106e73:	56                   	push   %esi
      return 0;
80106e74:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80106e76:	e8 15 ff ff ff       	call   80106d90 <freevm>
      return 0;
80106e7b:	83 c4 10             	add    $0x10,%esp
}
80106e7e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106e81:	89 f0                	mov    %esi,%eax
80106e83:	5b                   	pop    %ebx
80106e84:	5e                   	pop    %esi
80106e85:	5d                   	pop    %ebp
80106e86:	c3                   	ret    
80106e87:	89 f6                	mov    %esi,%esi
80106e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e90 <kvmalloc>:
{
80106e90:	55                   	push   %ebp
80106e91:	89 e5                	mov    %esp,%ebp
80106e93:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106e96:	e8 75 ff ff ff       	call   80106e10 <setupkvm>
80106e9b:	a3 84 5a 11 80       	mov    %eax,0x80115a84
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106ea0:	05 00 00 00 80       	add    $0x80000000,%eax
80106ea5:	0f 22 d8             	mov    %eax,%cr3
}
80106ea8:	c9                   	leave  
80106ea9:	c3                   	ret    
80106eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106eb0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106eb0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106eb1:	31 c9                	xor    %ecx,%ecx
{
80106eb3:	89 e5                	mov    %esp,%ebp
80106eb5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106eb8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106ebb:	8b 45 08             	mov    0x8(%ebp),%eax
80106ebe:	e8 bd f8 ff ff       	call   80106780 <walkpgdir>
  if(pte == 0)
80106ec3:	85 c0                	test   %eax,%eax
80106ec5:	74 05                	je     80106ecc <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106ec7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106eca:	c9                   	leave  
80106ecb:	c3                   	ret    
    panic("clearpteu");
80106ecc:	83 ec 0c             	sub    $0xc,%esp
80106ecf:	68 6e 7c 10 80       	push   $0x80107c6e
80106ed4:	e8 b7 94 ff ff       	call   80100390 <panic>
80106ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ee0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106ee0:	55                   	push   %ebp
80106ee1:	89 e5                	mov    %esp,%ebp
80106ee3:	57                   	push   %edi
80106ee4:	56                   	push   %esi
80106ee5:	53                   	push   %ebx
80106ee6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106ee9:	e8 22 ff ff ff       	call   80106e10 <setupkvm>
80106eee:	85 c0                	test   %eax,%eax
80106ef0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106ef3:	0f 84 9f 00 00 00    	je     80106f98 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106ef9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106efc:	85 c9                	test   %ecx,%ecx
80106efe:	0f 84 94 00 00 00    	je     80106f98 <copyuvm+0xb8>
80106f04:	31 ff                	xor    %edi,%edi
80106f06:	eb 4a                	jmp    80106f52 <copyuvm+0x72>
80106f08:	90                   	nop
80106f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106f10:	83 ec 04             	sub    $0x4,%esp
80106f13:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80106f19:	68 00 10 00 00       	push   $0x1000
80106f1e:	53                   	push   %ebx
80106f1f:	50                   	push   %eax
80106f20:	e8 8b d7 ff ff       	call   801046b0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80106f25:	58                   	pop    %eax
80106f26:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106f2c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106f31:	5a                   	pop    %edx
80106f32:	ff 75 e4             	pushl  -0x1c(%ebp)
80106f35:	50                   	push   %eax
80106f36:	89 fa                	mov    %edi,%edx
80106f38:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106f3b:	e8 c0 f8 ff ff       	call   80106800 <mappages>
80106f40:	83 c4 10             	add    $0x10,%esp
80106f43:	85 c0                	test   %eax,%eax
80106f45:	78 61                	js     80106fa8 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80106f47:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106f4d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80106f50:	76 46                	jbe    80106f98 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106f52:	8b 45 08             	mov    0x8(%ebp),%eax
80106f55:	31 c9                	xor    %ecx,%ecx
80106f57:	89 fa                	mov    %edi,%edx
80106f59:	e8 22 f8 ff ff       	call   80106780 <walkpgdir>
80106f5e:	85 c0                	test   %eax,%eax
80106f60:	74 61                	je     80106fc3 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80106f62:	8b 00                	mov    (%eax),%eax
80106f64:	a8 01                	test   $0x1,%al
80106f66:	74 4e                	je     80106fb6 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80106f68:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
80106f6a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
80106f6f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80106f75:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80106f78:	e8 53 b5 ff ff       	call   801024d0 <kalloc>
80106f7d:	85 c0                	test   %eax,%eax
80106f7f:	89 c6                	mov    %eax,%esi
80106f81:	75 8d                	jne    80106f10 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80106f83:	83 ec 0c             	sub    $0xc,%esp
80106f86:	ff 75 e0             	pushl  -0x20(%ebp)
80106f89:	e8 02 fe ff ff       	call   80106d90 <freevm>
  return 0;
80106f8e:	83 c4 10             	add    $0x10,%esp
80106f91:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80106f98:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106f9b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f9e:	5b                   	pop    %ebx
80106f9f:	5e                   	pop    %esi
80106fa0:	5f                   	pop    %edi
80106fa1:	5d                   	pop    %ebp
80106fa2:	c3                   	ret    
80106fa3:	90                   	nop
80106fa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80106fa8:	83 ec 0c             	sub    $0xc,%esp
80106fab:	56                   	push   %esi
80106fac:	e8 6f b3 ff ff       	call   80102320 <kfree>
      goto bad;
80106fb1:	83 c4 10             	add    $0x10,%esp
80106fb4:	eb cd                	jmp    80106f83 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80106fb6:	83 ec 0c             	sub    $0xc,%esp
80106fb9:	68 92 7c 10 80       	push   $0x80107c92
80106fbe:	e8 cd 93 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80106fc3:	83 ec 0c             	sub    $0xc,%esp
80106fc6:	68 78 7c 10 80       	push   $0x80107c78
80106fcb:	e8 c0 93 ff ff       	call   80100390 <panic>

80106fd0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106fd0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106fd1:	31 c9                	xor    %ecx,%ecx
{
80106fd3:	89 e5                	mov    %esp,%ebp
80106fd5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106fd8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106fdb:	8b 45 08             	mov    0x8(%ebp),%eax
80106fde:	e8 9d f7 ff ff       	call   80106780 <walkpgdir>
  if((*pte & PTE_P) == 0)
80106fe3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80106fe5:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80106fe6:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80106fe8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80106fed:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80106ff0:	05 00 00 00 80       	add    $0x80000000,%eax
80106ff5:	83 fa 05             	cmp    $0x5,%edx
80106ff8:	ba 00 00 00 00       	mov    $0x0,%edx
80106ffd:	0f 45 c2             	cmovne %edx,%eax
}
80107000:	c3                   	ret    
80107001:	eb 0d                	jmp    80107010 <copyout>
80107003:	90                   	nop
80107004:	90                   	nop
80107005:	90                   	nop
80107006:	90                   	nop
80107007:	90                   	nop
80107008:	90                   	nop
80107009:	90                   	nop
8010700a:	90                   	nop
8010700b:	90                   	nop
8010700c:	90                   	nop
8010700d:	90                   	nop
8010700e:	90                   	nop
8010700f:	90                   	nop

80107010 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107010:	55                   	push   %ebp
80107011:	89 e5                	mov    %esp,%ebp
80107013:	57                   	push   %edi
80107014:	56                   	push   %esi
80107015:	53                   	push   %ebx
80107016:	83 ec 1c             	sub    $0x1c,%esp
80107019:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010701c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010701f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107022:	85 db                	test   %ebx,%ebx
80107024:	75 40                	jne    80107066 <copyout+0x56>
80107026:	eb 70                	jmp    80107098 <copyout+0x88>
80107028:	90                   	nop
80107029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107030:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107033:	89 f1                	mov    %esi,%ecx
80107035:	29 d1                	sub    %edx,%ecx
80107037:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010703d:	39 d9                	cmp    %ebx,%ecx
8010703f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107042:	29 f2                	sub    %esi,%edx
80107044:	83 ec 04             	sub    $0x4,%esp
80107047:	01 d0                	add    %edx,%eax
80107049:	51                   	push   %ecx
8010704a:	57                   	push   %edi
8010704b:	50                   	push   %eax
8010704c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010704f:	e8 5c d6 ff ff       	call   801046b0 <memmove>
    len -= n;
    buf += n;
80107054:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80107057:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
8010705a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107060:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107062:	29 cb                	sub    %ecx,%ebx
80107064:	74 32                	je     80107098 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107066:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107068:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
8010706b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010706e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107074:	56                   	push   %esi
80107075:	ff 75 08             	pushl  0x8(%ebp)
80107078:	e8 53 ff ff ff       	call   80106fd0 <uva2ka>
    if(pa0 == 0)
8010707d:	83 c4 10             	add    $0x10,%esp
80107080:	85 c0                	test   %eax,%eax
80107082:	75 ac                	jne    80107030 <copyout+0x20>
  }
  return 0;
}
80107084:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107087:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010708c:	5b                   	pop    %ebx
8010708d:	5e                   	pop    %esi
8010708e:	5f                   	pop    %edi
8010708f:	5d                   	pop    %ebp
80107090:	c3                   	ret    
80107091:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107098:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010709b:	31 c0                	xor    %eax,%eax
}
8010709d:	5b                   	pop    %ebx
8010709e:	5e                   	pop    %esi
8010709f:	5f                   	pop    %edi
801070a0:	5d                   	pop    %ebp
801070a1:	c3                   	ret    
801070a2:	66 90                	xchg   %ax,%ax
801070a4:	66 90                	xchg   %ax,%ax
801070a6:	66 90                	xchg   %ax,%ax
801070a8:	66 90                	xchg   %ax,%ax
801070aa:	66 90                	xchg   %ax,%ax
801070ac:	66 90                	xchg   %ax,%ax
801070ae:	66 90                	xchg   %ax,%ax

801070b0 <sgenrand>:
static int mti=N+1; /* mti==N+1 means mt[N] is not initialized */

/* initializing the array with a NONZERO seed */
void
sgenrand(unsigned long seed)
{
801070b0:	55                   	push   %ebp
801070b1:	b8 c4 a5 10 80       	mov    $0x8010a5c4,%eax
801070b6:	b9 7c af 10 80       	mov    $0x8010af7c,%ecx
801070bb:	89 e5                	mov    %esp,%ebp
801070bd:	8b 55 08             	mov    0x8(%ebp),%edx
    /* setting initial seeds to mt[N] using         */
    /* the generator Line 25 of Table 1 in          */
    /* [KNUTH 1981, The Art of Computer Programming */
    /*    Vol. 2 (2nd Ed.), pp102]                  */
    mt[0]= seed & 0xffffffff;
801070c0:	89 15 c0 a5 10 80    	mov    %edx,0x8010a5c0
801070c6:	eb 0b                	jmp    801070d3 <sgenrand+0x23>
801070c8:	90                   	nop
801070c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070d0:	83 c0 04             	add    $0x4,%eax
    for (mti=1; mti<N; mti++)
        mt[mti] = (69069 * mt[mti-1]) & 0xffffffff;
801070d3:	69 d2 cd 0d 01 00    	imul   $0x10dcd,%edx,%edx
    for (mti=1; mti<N; mti++)
801070d9:	39 c1                	cmp    %eax,%ecx
        mt[mti] = (69069 * mt[mti-1]) & 0xffffffff;
801070db:	89 10                	mov    %edx,(%eax)
    for (mti=1; mti<N; mti++)
801070dd:	75 f1                	jne    801070d0 <sgenrand+0x20>
801070df:	c7 05 60 a4 10 80 70 	movl   $0x270,0x8010a460
801070e6:	02 00 00 
}
801070e9:	5d                   	pop    %ebp
801070ea:	c3                   	ret    
801070eb:	90                   	nop
801070ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801070f0 <genrand>:
{
    unsigned long y;
    static unsigned long mag01[2]={0x0, MATRIX_A};
    /* mag01[x] = x * MATRIX_A  for x=0,1 */

    if (mti >= N) { /* generate N words at one time */
801070f0:	a1 60 a4 10 80       	mov    0x8010a460,%eax
{
801070f5:	55                   	push   %ebp
801070f6:	89 e5                	mov    %esp,%ebp
801070f8:	56                   	push   %esi
801070f9:	53                   	push   %ebx
    if (mti >= N) { /* generate N words at one time */
801070fa:	3d 6f 02 00 00       	cmp    $0x26f,%eax
801070ff:	0f 8e f9 00 00 00    	jle    801071fe <genrand+0x10e>
        int kk;

        if (mti == N+1)   /* if sgenrand() has not been called, */
80107105:	3d 71 02 00 00       	cmp    $0x271,%eax
8010710a:	0f 84 fa 00 00 00    	je     8010720a <genrand+0x11a>
80107110:	ba c0 a5 10 80       	mov    $0x8010a5c0,%edx
80107115:	bb 4c a9 10 80       	mov    $0x8010a94c,%ebx
    mt[0]= seed & 0xffffffff;
8010711a:	89 d1                	mov    %edx,%ecx
8010711c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            sgenrand(4357); /* a default initial seed is used   */

        for (kk=0;kk<N-M;kk++) {
            y = (mt[kk]&UPPER_MASK)|(mt[kk+1]&LOWER_MASK);
80107120:	8b 01                	mov    (%ecx),%eax
80107122:	8b 71 04             	mov    0x4(%ecx),%esi
80107125:	83 c1 04             	add    $0x4,%ecx
80107128:	81 e6 ff ff ff 7f    	and    $0x7fffffff,%esi
8010712e:	25 00 00 00 80       	and    $0x80000000,%eax
80107133:	09 f0                	or     %esi,%eax
            mt[kk] = mt[kk+M] ^ (y >> 1) ^ mag01[y & 0x1];
80107135:	89 c6                	mov    %eax,%esi
80107137:	83 e0 01             	and    $0x1,%eax
8010713a:	d1 ee                	shr    %esi
8010713c:	33 b1 30 06 00 00    	xor    0x630(%ecx),%esi
80107142:	33 34 85 d0 7c 10 80 	xor    -0x7fef8330(,%eax,4),%esi
80107149:	89 71 fc             	mov    %esi,-0x4(%ecx)
        for (kk=0;kk<N-M;kk++) {
8010714c:	39 cb                	cmp    %ecx,%ebx
8010714e:	75 d0                	jne    80107120 <genrand+0x30>
80107150:	b9 f0 ab 10 80       	mov    $0x8010abf0,%ecx
80107155:	8d 76 00             	lea    0x0(%esi),%esi
        }
        for (;kk<N-1;kk++) {
            y = (mt[kk]&UPPER_MASK)|(mt[kk+1]&LOWER_MASK);
80107158:	8b 82 8c 03 00 00    	mov    0x38c(%edx),%eax
8010715e:	8b 9a 90 03 00 00    	mov    0x390(%edx),%ebx
80107164:	83 c2 04             	add    $0x4,%edx
80107167:	81 e3 ff ff ff 7f    	and    $0x7fffffff,%ebx
8010716d:	25 00 00 00 80       	and    $0x80000000,%eax
80107172:	09 d8                	or     %ebx,%eax
            mt[kk] = mt[kk+(M-N)] ^ (y >> 1) ^ mag01[y & 0x1];
80107174:	89 c3                	mov    %eax,%ebx
80107176:	83 e0 01             	and    $0x1,%eax
80107179:	d1 eb                	shr    %ebx
8010717b:	33 5a fc             	xor    -0x4(%edx),%ebx
8010717e:	33 1c 85 d0 7c 10 80 	xor    -0x7fef8330(,%eax,4),%ebx
80107185:	89 9a 88 03 00 00    	mov    %ebx,0x388(%edx)
        for (;kk<N-1;kk++) {
8010718b:	39 d1                	cmp    %edx,%ecx
8010718d:	75 c9                	jne    80107158 <genrand+0x68>
        }
        y = (mt[N-1]&UPPER_MASK)|(mt[0]&LOWER_MASK);
8010718f:	a1 c0 a5 10 80       	mov    0x8010a5c0,%eax
80107194:	8b 0d 7c af 10 80    	mov    0x8010af7c,%ecx
8010719a:	89 c2                	mov    %eax,%edx
8010719c:	81 e1 00 00 00 80    	and    $0x80000000,%ecx
801071a2:	81 e2 ff ff ff 7f    	and    $0x7fffffff,%edx
801071a8:	09 d1                	or     %edx,%ecx
        mt[N-1] = mt[M-1] ^ (y >> 1) ^ mag01[y & 0x1];
801071aa:	89 ca                	mov    %ecx,%edx
801071ac:	83 e1 01             	and    $0x1,%ecx
801071af:	d1 ea                	shr    %edx
801071b1:	33 15 f0 ab 10 80    	xor    0x8010abf0,%edx
801071b7:	33 14 8d d0 7c 10 80 	xor    -0x7fef8330(,%ecx,4),%edx
801071be:	89 15 7c af 10 80    	mov    %edx,0x8010af7c
801071c4:	ba 01 00 00 00       	mov    $0x1,%edx

        mti = 0;
    }

    y = mt[mti++];
801071c9:	89 15 60 a4 10 80    	mov    %edx,0x8010a460
    y ^= TEMPERING_SHIFT_U(y);
801071cf:	89 c2                	mov    %eax,%edx
801071d1:	c1 ea 0b             	shr    $0xb,%edx
801071d4:	31 c2                	xor    %eax,%edx
    y ^= TEMPERING_SHIFT_S(y) & TEMPERING_MASK_B;
801071d6:	89 d0                	mov    %edx,%eax
801071d8:	c1 e0 07             	shl    $0x7,%eax
801071db:	25 80 56 2c 9d       	and    $0x9d2c5680,%eax
801071e0:	31 c2                	xor    %eax,%edx
    y ^= TEMPERING_SHIFT_T(y) & TEMPERING_MASK_C;
801071e2:	89 d0                	mov    %edx,%eax
801071e4:	c1 e0 0f             	shl    $0xf,%eax
801071e7:	25 00 00 c6 ef       	and    $0xefc60000,%eax
801071ec:	31 d0                	xor    %edx,%eax
    y ^= TEMPERING_SHIFT_L(y);
801071ee:	89 c2                	mov    %eax,%edx
801071f0:	c1 ea 12             	shr    $0x12,%edx
801071f3:	31 d0                	xor    %edx,%eax

    // Strip off uppermost bit because we want a long,
    // not an unsigned long
    return y & RAND_MAX;
}
801071f5:	5b                   	pop    %ebx
    return y & RAND_MAX;
801071f6:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
801071fb:	5e                   	pop    %esi
801071fc:	5d                   	pop    %ebp
801071fd:	c3                   	ret    
801071fe:	8d 50 01             	lea    0x1(%eax),%edx
80107201:	8b 04 85 c0 a5 10 80 	mov    -0x7fef5a40(,%eax,4),%eax
80107208:	eb bf                	jmp    801071c9 <genrand+0xd9>
    mt[0]= seed & 0xffffffff;
8010720a:	c7 05 c0 a5 10 80 05 	movl   $0x1105,0x8010a5c0
80107211:	11 00 00 
80107214:	b8 c4 a5 10 80       	mov    $0x8010a5c4,%eax
80107219:	b9 7c af 10 80       	mov    $0x8010af7c,%ecx
8010721e:	ba 05 11 00 00       	mov    $0x1105,%edx
80107223:	eb 06                	jmp    8010722b <genrand+0x13b>
80107225:	8d 76 00             	lea    0x0(%esi),%esi
80107228:	83 c0 04             	add    $0x4,%eax
        mt[mti] = (69069 * mt[mti-1]) & 0xffffffff;
8010722b:	69 d2 cd 0d 01 00    	imul   $0x10dcd,%edx,%edx
    for (mti=1; mti<N; mti++)
80107231:	39 c1                	cmp    %eax,%ecx
        mt[mti] = (69069 * mt[mti-1]) & 0xffffffff;
80107233:	89 10                	mov    %edx,(%eax)
    for (mti=1; mti<N; mti++)
80107235:	75 f1                	jne    80107228 <genrand+0x138>
80107237:	e9 d4 fe ff ff       	jmp    80107110 <genrand+0x20>
8010723c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107240 <random_at_most>:

// Assumes 0 <= max <= RAND_MAX
// Returns in the half-open interval [0, max]
long random_at_most(long max) {
80107240:	55                   	push   %ebp
    unsigned long
    // max <= RAND_MAX < ULONG_MAX, so this is okay.
            num_bins = (unsigned long) max + 1,
            num_rand = (unsigned long) RAND_MAX + 1,
            bin_size = num_rand / num_bins,
80107241:	31 d2                	xor    %edx,%edx
long random_at_most(long max) {
80107243:	89 e5                	mov    %esp,%ebp
80107245:	56                   	push   %esi
80107246:	53                   	push   %ebx
            num_bins = (unsigned long) max + 1,
80107247:	8b 45 08             	mov    0x8(%ebp),%eax
            bin_size = num_rand / num_bins,
8010724a:	bb 00 00 00 80       	mov    $0x80000000,%ebx
            num_bins = (unsigned long) max + 1,
8010724f:	8d 48 01             	lea    0x1(%eax),%ecx
            bin_size = num_rand / num_bins,
80107252:	89 d8                	mov    %ebx,%eax
80107254:	f7 f1                	div    %ecx
80107256:	89 c6                	mov    %eax,%esi
80107258:	29 d3                	sub    %edx,%ebx
8010725a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            defect   = num_rand % num_bins;

    long x;
    do {
        x = genrand();
80107260:	e8 8b fe ff ff       	call   801070f0 <genrand>
    }
        // This is carefully written not to overflow
    while (num_rand - defect <= (unsigned long)x);
80107265:	39 d8                	cmp    %ebx,%eax
80107267:	73 f7                	jae    80107260 <random_at_most+0x20>

    // Truncated division is intentional
    return x/bin_size;
80107269:	31 d2                	xor    %edx,%edx
8010726b:	f7 f6                	div    %esi
8010726d:	5b                   	pop    %ebx
8010726e:	5e                   	pop    %esi
8010726f:	5d                   	pop    %ebp
80107270:	c3                   	ret    
