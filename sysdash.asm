
_sysdash:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
  struct pstat procs[64];
  struct kstat ks;
  int n, i;
  
  // Get kernel stats
  if(getkernelstats(&ks) < 0){
   f:	8d 85 d8 f3 ff ff    	lea    -0xc28(%ebp),%eax
{
  15:	53                   	push   %ebx
  16:	51                   	push   %ecx
  17:	81 ec 24 0c 00 00    	sub    $0xc24,%esp
  if(getkernelstats(&ks) < 0){
  1d:	50                   	push   %eax
  1e:	e8 60 04 00 00       	call   483 <getkernelstats>
  23:	83 c4 10             	add    $0x10,%esp
  26:	85 c0                	test   %eax,%eax
  28:	0f 88 fb 00 00 00    	js     129 <main+0x129>
    printf(2, "Error getting kernel stats\n");
    exit();
  }
  
  // Get process stats
  n = getprocstats(procs, 64);
  2e:	8d 85 e8 f3 ff ff    	lea    -0xc18(%ebp),%eax
  34:	57                   	push   %edi
  35:	57                   	push   %edi
  36:	6a 40                	push   $0x40
  38:	50                   	push   %eax
  39:	e8 3d 04 00 00       	call   47b <getprocstats>
  if(n < 0){
  3e:	83 c4 10             	add    $0x10,%esp
  n = getprocstats(procs, 64);
  41:	89 c7                	mov    %eax,%edi
  if(n < 0){
  43:	85 c0                	test   %eax,%eax
  45:	0f 88 cb 00 00 00    	js     116 <main+0x116>
    printf(2, "Error getting process stats\n");
    exit();
  }
  
  // Display dashboard
  printf(1, "\n========== xv6 System Dashboard ==========\n");
  4b:	51                   	push   %ecx
  4c:	51                   	push   %ecx
  4d:	68 34 09 00 00       	push   $0x934
  52:	6a 01                	push   $0x1
  54:	e8 07 05 00 00       	call   560 <printf>
  printf(1, "Uptime: %d ticks | CPU Temp: %d C | CPU Load: %d%%\n", 
  59:	5b                   	pop    %ebx
  5a:	ff b5 dc f3 ff ff    	push   -0xc24(%ebp)
  60:	ff b5 e0 f3 ff ff    	push   -0xc20(%ebp)
  66:	ff b5 d8 f3 ff ff    	push   -0xc28(%ebp)
  6c:	68 64 09 00 00       	push   $0x964
  71:	6a 01                	push   $0x1
  73:	e8 e8 04 00 00       	call   560 <printf>
         ks.uptime, ks.cputemp, ks.cpuload);
  printf(1, "Active Processes: %d\n", ks.numproc);
  78:	83 c4 1c             	add    $0x1c,%esp
  7b:	ff b5 e4 f3 ff ff    	push   -0xc1c(%ebp)
  81:	68 01 09 00 00       	push   $0x901
  86:	6a 01                	push   $0x1
  88:	e8 d3 04 00 00       	call   560 <printf>
  printf(1, "==========================================\n\n");
  8d:	5e                   	pop    %esi
  8e:	58                   	pop    %eax
  8f:	68 98 09 00 00       	push   $0x998
  94:	6a 01                	push   $0x1
  
  printf(1, "PID | Name       | State     | Memory\n");
  printf(1, "----+------------+-----------+--------\n");
  
  for(i = 0; i < n; i++){
  96:	31 f6                	xor    %esi,%esi
  printf(1, "==========================================\n\n");
  98:	e8 c3 04 00 00       	call   560 <printf>
  printf(1, "PID | Name       | State     | Memory\n");
  9d:	58                   	pop    %eax
  9e:	5a                   	pop    %edx
  9f:	68 c8 09 00 00       	push   $0x9c8
  a4:	6a 01                	push   $0x1
  a6:	e8 b5 04 00 00       	call   560 <printf>
  printf(1, "----+------------+-----------+--------\n");
  ab:	59                   	pop    %ecx
  ac:	5b                   	pop    %ebx
  ad:	68 f0 09 00 00       	push   $0x9f0
  b2:	6a 01                	push   $0x1
  b4:	8d 9d f0 f3 ff ff    	lea    -0xc10(%ebp),%ebx
  ba:	e8 a1 04 00 00       	call   560 <printf>
  for(i = 0; i < n; i++){
  bf:	83 c4 10             	add    $0x10,%esp
  c2:	85 ff                	test   %edi,%edi
  c4:	74 31                	je     f7 <main+0xf7>
  c6:	66 90                	xchg   %ax,%ax
  c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  cf:	00 
    printf(1, "%d | %s | %s | %d\n",
  d0:	83 ec 08             	sub    $0x8,%esp
           procs[i].pid,
           procs[i].name,
           procs[i].state,
  d3:	8d 43 10             	lea    0x10(%ebx),%eax
    printf(1, "%d | %s | %s | %d\n",
  d6:	ff 73 1c             	push   0x1c(%ebx)
  for(i = 0; i < n; i++){
  d9:	83 c6 01             	add    $0x1,%esi
    printf(1, "%d | %s | %s | %d\n",
  dc:	50                   	push   %eax
  dd:	53                   	push   %ebx
  for(i = 0; i < n; i++){
  de:	83 c3 30             	add    $0x30,%ebx
    printf(1, "%d | %s | %s | %d\n",
  e1:	ff 73 cc             	push   -0x34(%ebx)
  e4:	68 17 09 00 00       	push   $0x917
  e9:	6a 01                	push   $0x1
  eb:	e8 70 04 00 00       	call   560 <printf>
  for(i = 0; i < n; i++){
  f0:	83 c4 20             	add    $0x20,%esp
  f3:	39 f7                	cmp    %esi,%edi
  f5:	75 d9                	jne    d0 <main+0xd0>
           procs[i].sz);
  }
  
  printf(1, "\n");
  f7:	52                   	push   %edx
  f8:	52                   	push   %edx
  f9:	68 15 09 00 00       	push   $0x915
  fe:	6a 01                	push   $0x1
 100:	e8 5b 04 00 00       	call   560 <printf>
  
  // Temperature warning
  if(ks.cputemp > 80){
 105:	83 c4 10             	add    $0x10,%esp
 108:	83 bd e0 f3 ff ff 50 	cmpl   $0x50,-0xc20(%ebp)
 10f:	7f 2b                	jg     13c <main+0x13c>
    printf(1, "WARNING: CPU temperature high!\n");
  }
  
  exit();
 111:	e8 bd 02 00 00       	call   3d3 <exit>
    printf(2, "Error getting process stats\n");
 116:	56                   	push   %esi
 117:	56                   	push   %esi
 118:	68 e4 08 00 00       	push   $0x8e4
 11d:	6a 02                	push   $0x2
 11f:	e8 3c 04 00 00       	call   560 <printf>
    exit();
 124:	e8 aa 02 00 00       	call   3d3 <exit>
    printf(2, "Error getting kernel stats\n");
 129:	50                   	push   %eax
 12a:	50                   	push   %eax
 12b:	68 c8 08 00 00       	push   $0x8c8
 130:	6a 02                	push   $0x2
 132:	e8 29 04 00 00       	call   560 <printf>
    exit();
 137:	e8 97 02 00 00       	call   3d3 <exit>
    printf(1, "WARNING: CPU temperature high!\n");
 13c:	50                   	push   %eax
 13d:	50                   	push   %eax
 13e:	68 18 0a 00 00       	push   $0xa18
 143:	6a 01                	push   $0x1
 145:	e8 16 04 00 00       	call   560 <printf>
 14a:	83 c4 10             	add    $0x10,%esp
 14d:	eb c2                	jmp    111 <main+0x111>
 14f:	66 90                	xchg   %ax,%ax
 151:	66 90                	xchg   %ax,%ax
 153:	66 90                	xchg   %ax,%ax
 155:	66 90                	xchg   %ax,%ax
 157:	66 90                	xchg   %ax,%ax
 159:	66 90                	xchg   %ax,%ax
 15b:	66 90                	xchg   %ax,%ax
 15d:	66 90                	xchg   %ax,%ax
 15f:	90                   	nop

00000160 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 160:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 161:	31 c0                	xor    %eax,%eax
{
 163:	89 e5                	mov    %esp,%ebp
 165:	53                   	push   %ebx
 166:	8b 4d 08             	mov    0x8(%ebp),%ecx
 169:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 16c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 170:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 174:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 177:	83 c0 01             	add    $0x1,%eax
 17a:	84 d2                	test   %dl,%dl
 17c:	75 f2                	jne    170 <strcpy+0x10>
    ;
  return os;
}
 17e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 181:	89 c8                	mov    %ecx,%eax
 183:	c9                   	leave
 184:	c3                   	ret
 185:	8d 76 00             	lea    0x0(%esi),%esi
 188:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 18f:	00 

00000190 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	53                   	push   %ebx
 194:	8b 55 08             	mov    0x8(%ebp),%edx
 197:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 19a:	0f b6 02             	movzbl (%edx),%eax
 19d:	84 c0                	test   %al,%al
 19f:	75 2d                	jne    1ce <strcmp+0x3e>
 1a1:	eb 4a                	jmp    1ed <strcmp+0x5d>
 1a3:	eb 1b                	jmp    1c0 <strcmp+0x30>
 1a5:	8d 76 00             	lea    0x0(%esi),%esi
 1a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1af:	00 
 1b0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1b7:	00 
 1b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1bf:	00 
 1c0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 1c4:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 1c7:	84 c0                	test   %al,%al
 1c9:	74 15                	je     1e0 <strcmp+0x50>
 1cb:	83 c1 01             	add    $0x1,%ecx
 1ce:	0f b6 19             	movzbl (%ecx),%ebx
 1d1:	38 c3                	cmp    %al,%bl
 1d3:	74 eb                	je     1c0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 1d5:	29 d8                	sub    %ebx,%eax
}
 1d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1da:	c9                   	leave
 1db:	c3                   	ret
 1dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return (uchar)*p - (uchar)*q;
 1e0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1e4:	31 c0                	xor    %eax,%eax
 1e6:	29 d8                	sub    %ebx,%eax
}
 1e8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1eb:	c9                   	leave
 1ec:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 1ed:	0f b6 19             	movzbl (%ecx),%ebx
 1f0:	31 c0                	xor    %eax,%eax
 1f2:	eb e1                	jmp    1d5 <strcmp+0x45>
 1f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ff:	00 

00000200 <strlen>:

uint
strlen(const char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 206:	80 3a 00             	cmpb   $0x0,(%edx)
 209:	74 15                	je     220 <strlen+0x20>
 20b:	31 c0                	xor    %eax,%eax
 20d:	8d 76 00             	lea    0x0(%esi),%esi
 210:	83 c0 01             	add    $0x1,%eax
 213:	89 c1                	mov    %eax,%ecx
 215:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 219:	75 f5                	jne    210 <strlen+0x10>
    ;
  return n;
}
 21b:	89 c8                	mov    %ecx,%eax
 21d:	5d                   	pop    %ebp
 21e:	c3                   	ret
 21f:	90                   	nop
  for(n = 0; s[n]; n++)
 220:	31 c9                	xor    %ecx,%ecx
}
 222:	5d                   	pop    %ebp
 223:	89 c8                	mov    %ecx,%eax
 225:	c3                   	ret
 226:	66 90                	xchg   %ax,%ax
 228:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 22f:	00 

00000230 <memset>:

void*
memset(void *dst, int c, uint n)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 234:	8b 4d 10             	mov    0x10(%ebp),%ecx
 237:	8b 45 0c             	mov    0xc(%ebp),%eax
 23a:	8b 7d 08             	mov    0x8(%ebp),%edi
 23d:	fc                   	cld
 23e:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 240:	8b 45 08             	mov    0x8(%ebp),%eax
 243:	8b 7d fc             	mov    -0x4(%ebp),%edi
 246:	c9                   	leave
 247:	c3                   	ret
 248:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 24f:	00 

00000250 <strchr>:

char*
strchr(const char *s, char c)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	8b 45 08             	mov    0x8(%ebp),%eax
 256:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 25a:	0f b6 10             	movzbl (%eax),%edx
 25d:	84 d2                	test   %dl,%dl
 25f:	75 1a                	jne    27b <strchr+0x2b>
 261:	eb 25                	jmp    288 <strchr+0x38>
 263:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 268:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 26f:	00 
 270:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 274:	83 c0 01             	add    $0x1,%eax
 277:	84 d2                	test   %dl,%dl
 279:	74 0d                	je     288 <strchr+0x38>
    if(*s == c)
 27b:	38 d1                	cmp    %dl,%cl
 27d:	75 f1                	jne    270 <strchr+0x20>
      return (char*)s;
  return 0;
}
 27f:	5d                   	pop    %ebp
 280:	c3                   	ret
 281:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 288:	31 c0                	xor    %eax,%eax
}
 28a:	5d                   	pop    %ebp
 28b:	c3                   	ret
 28c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000290 <gets>:

char*
gets(char *buf, int max)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	57                   	push   %edi
 294:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 295:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 298:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 299:	31 db                	xor    %ebx,%ebx
{
 29b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 29e:	eb 27                	jmp    2c7 <gets+0x37>
    cc = read(0, &c, 1);
 2a0:	83 ec 04             	sub    $0x4,%esp
 2a3:	6a 01                	push   $0x1
 2a5:	57                   	push   %edi
 2a6:	6a 00                	push   $0x0
 2a8:	e8 3e 01 00 00       	call   3eb <read>
    if(cc < 1)
 2ad:	83 c4 10             	add    $0x10,%esp
 2b0:	85 c0                	test   %eax,%eax
 2b2:	7e 1d                	jle    2d1 <gets+0x41>
      break;
    buf[i++] = c;
 2b4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2b8:	8b 55 08             	mov    0x8(%ebp),%edx
 2bb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2bf:	3c 0a                	cmp    $0xa,%al
 2c1:	74 1d                	je     2e0 <gets+0x50>
 2c3:	3c 0d                	cmp    $0xd,%al
 2c5:	74 19                	je     2e0 <gets+0x50>
  for(i=0; i+1 < max; ){
 2c7:	89 de                	mov    %ebx,%esi
 2c9:	83 c3 01             	add    $0x1,%ebx
 2cc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2cf:	7c cf                	jl     2a0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 2d1:	8b 45 08             	mov    0x8(%ebp),%eax
 2d4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2db:	5b                   	pop    %ebx
 2dc:	5e                   	pop    %esi
 2dd:	5f                   	pop    %edi
 2de:	5d                   	pop    %ebp
 2df:	c3                   	ret
  buf[i] = '\0';
 2e0:	8b 45 08             	mov    0x8(%ebp),%eax
    buf[i++] = c;
 2e3:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 2e5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 2e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2ec:	5b                   	pop    %ebx
 2ed:	5e                   	pop    %esi
 2ee:	5f                   	pop    %edi
 2ef:	5d                   	pop    %ebp
 2f0:	c3                   	ret
 2f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ff:	00 

00000300 <stat>:

int
stat(const char *n, struct stat *st)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	56                   	push   %esi
 304:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 305:	83 ec 08             	sub    $0x8,%esp
 308:	6a 00                	push   $0x0
 30a:	ff 75 08             	push   0x8(%ebp)
 30d:	e8 01 01 00 00       	call   413 <open>
  if(fd < 0)
 312:	83 c4 10             	add    $0x10,%esp
 315:	85 c0                	test   %eax,%eax
 317:	78 27                	js     340 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 319:	83 ec 08             	sub    $0x8,%esp
 31c:	ff 75 0c             	push   0xc(%ebp)
 31f:	89 c3                	mov    %eax,%ebx
 321:	50                   	push   %eax
 322:	e8 04 01 00 00       	call   42b <fstat>
  close(fd);
 327:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 32a:	89 c6                	mov    %eax,%esi
  close(fd);
 32c:	e8 ca 00 00 00       	call   3fb <close>
  return r;
 331:	83 c4 10             	add    $0x10,%esp
}
 334:	8d 65 f8             	lea    -0x8(%ebp),%esp
 337:	89 f0                	mov    %esi,%eax
 339:	5b                   	pop    %ebx
 33a:	5e                   	pop    %esi
 33b:	5d                   	pop    %ebp
 33c:	c3                   	ret
 33d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 340:	be ff ff ff ff       	mov    $0xffffffff,%esi
 345:	eb ed                	jmp    334 <stat+0x34>
 347:	90                   	nop
 348:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 34f:	00 

00000350 <atoi>:

int
atoi(const char *s)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	53                   	push   %ebx
 354:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 357:	0f be 02             	movsbl (%edx),%eax
 35a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 35d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 360:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 365:	77 2e                	ja     395 <atoi+0x45>
 367:	eb 17                	jmp    380 <atoi+0x30>
 369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 370:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 377:	00 
 378:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 37f:	00 
    n = n*10 + *s++ - '0';
 380:	83 c2 01             	add    $0x1,%edx
 383:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 386:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 38a:	0f be 02             	movsbl (%edx),%eax
 38d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 390:	80 fb 09             	cmp    $0x9,%bl
 393:	76 eb                	jbe    380 <atoi+0x30>
  return n;
}
 395:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 398:	89 c8                	mov    %ecx,%eax
 39a:	c9                   	leave
 39b:	c3                   	ret
 39c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	8b 45 10             	mov    0x10(%ebp),%eax
 3a7:	8b 55 08             	mov    0x8(%ebp),%edx
 3aa:	56                   	push   %esi
 3ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3ae:	85 c0                	test   %eax,%eax
 3b0:	7e 13                	jle    3c5 <memmove+0x25>
 3b2:	01 d0                	add    %edx,%eax
  dst = vdst;
 3b4:	89 d7                	mov    %edx,%edi
 3b6:	66 90                	xchg   %ax,%ax
 3b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3bf:	00 
    *dst++ = *src++;
 3c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3c1:	39 f8                	cmp    %edi,%eax
 3c3:	75 fb                	jne    3c0 <memmove+0x20>
  return vdst;
}
 3c5:	5e                   	pop    %esi
 3c6:	89 d0                	mov    %edx,%eax
 3c8:	5f                   	pop    %edi
 3c9:	5d                   	pop    %ebp
 3ca:	c3                   	ret

000003cb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3cb:	b8 01 00 00 00       	mov    $0x1,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <exit>:
SYSCALL(exit)
 3d3:	b8 02 00 00 00       	mov    $0x2,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <wait>:
SYSCALL(wait)
 3db:	b8 03 00 00 00       	mov    $0x3,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <pipe>:
SYSCALL(pipe)
 3e3:	b8 04 00 00 00       	mov    $0x4,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <read>:
SYSCALL(read)
 3eb:	b8 05 00 00 00       	mov    $0x5,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <write>:
SYSCALL(write)
 3f3:	b8 10 00 00 00       	mov    $0x10,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <close>:
SYSCALL(close)
 3fb:	b8 15 00 00 00       	mov    $0x15,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <kill>:
SYSCALL(kill)
 403:	b8 06 00 00 00       	mov    $0x6,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <exec>:
SYSCALL(exec)
 40b:	b8 07 00 00 00       	mov    $0x7,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <open>:
SYSCALL(open)
 413:	b8 0f 00 00 00       	mov    $0xf,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <mknod>:
SYSCALL(mknod)
 41b:	b8 11 00 00 00       	mov    $0x11,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <unlink>:
SYSCALL(unlink)
 423:	b8 12 00 00 00       	mov    $0x12,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <fstat>:
SYSCALL(fstat)
 42b:	b8 08 00 00 00       	mov    $0x8,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <link>:
SYSCALL(link)
 433:	b8 13 00 00 00       	mov    $0x13,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <mkdir>:
SYSCALL(mkdir)
 43b:	b8 14 00 00 00       	mov    $0x14,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

00000443 <chdir>:
SYSCALL(chdir)
 443:	b8 09 00 00 00       	mov    $0x9,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

0000044b <dup>:
SYSCALL(dup)
 44b:	b8 0a 00 00 00       	mov    $0xa,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

00000453 <getpid>:
SYSCALL(getpid)
 453:	b8 0b 00 00 00       	mov    $0xb,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret

0000045b <sbrk>:
SYSCALL(sbrk)
 45b:	b8 0c 00 00 00       	mov    $0xc,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret

00000463 <sleep>:
SYSCALL(sleep)
 463:	b8 0d 00 00 00       	mov    $0xd,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret

0000046b <uptime>:
SYSCALL(uptime)
 46b:	b8 0e 00 00 00       	mov    $0xe,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret

00000473 <getklogs>:
SYSCALL(getklogs)
 473:	b8 16 00 00 00       	mov    $0x16,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret

0000047b <getprocstats>:
SYSCALL(getprocstats)
 47b:	b8 17 00 00 00       	mov    $0x17,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret

00000483 <getkernelstats>:
SYSCALL(getkernelstats)
 483:	b8 18 00 00 00       	mov    $0x18,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret
 48b:	66 90                	xchg   %ax,%ax
 48d:	66 90                	xchg   %ax,%ax
 48f:	66 90                	xchg   %ax,%ax
 491:	66 90                	xchg   %ax,%ax
 493:	66 90                	xchg   %ax,%ax
 495:	66 90                	xchg   %ax,%ax
 497:	66 90                	xchg   %ax,%ax
 499:	66 90                	xchg   %ax,%ax
 49b:	66 90                	xchg   %ax,%ax
 49d:	66 90                	xchg   %ax,%ax
 49f:	90                   	nop

000004a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
 4a5:	53                   	push   %ebx
 4a6:	89 cb                	mov    %ecx,%ebx
 4a8:	83 ec 3c             	sub    $0x3c,%esp
 4ab:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4ae:	85 d2                	test   %edx,%edx
 4b0:	0f 89 9a 00 00 00    	jns    550 <printint+0xb0>
 4b6:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4ba:	0f 84 90 00 00 00    	je     550 <printint+0xb0>
    neg = 1;
    x = -xx;
 4c0:	f7 da                	neg    %edx
    neg = 1;
 4c2:	b8 01 00 00 00       	mov    $0x1,%eax
 4c7:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4ca:	89 d1                	mov    %edx,%ecx
  } else {
    x = xx;
  }

  i = 0;
 4cc:	31 f6                	xor    %esi,%esi
 4ce:	66 90                	xchg   %ax,%ax
 4d0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4d7:	00 
 4d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4df:	00 
  do{
    buf[i++] = digits[x % base];
 4e0:	89 c8                	mov    %ecx,%eax
 4e2:	31 d2                	xor    %edx,%edx
 4e4:	89 f7                	mov    %esi,%edi
 4e6:	f7 f3                	div    %ebx
 4e8:	8d 76 01             	lea    0x1(%esi),%esi
  }while((x /= base) != 0);
 4eb:	39 d9                	cmp    %ebx,%ecx
    buf[i++] = digits[x % base];
 4ed:	0f b6 92 90 0a 00 00 	movzbl 0xa90(%edx),%edx
  }while((x /= base) != 0);
 4f4:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
 4f6:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 4fa:	73 e4                	jae    4e0 <printint+0x40>
  if(neg)
 4fc:	8b 45 c0             	mov    -0x40(%ebp),%eax
 4ff:	85 c0                	test   %eax,%eax
 501:	74 07                	je     50a <printint+0x6a>
    buf[i++] = '-';
 503:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 508:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 50a:	8d 74 3d d8          	lea    -0x28(%ebp,%edi,1),%esi
 50e:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 511:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 518:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 51f:	00 
    putc(fd, buf[i]);
 520:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 523:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 526:	83 ee 01             	sub    $0x1,%esi
 529:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 52c:	8d 45 d7             	lea    -0x29(%ebp),%eax
 52f:	6a 01                	push   $0x1
 531:	50                   	push   %eax
 532:	57                   	push   %edi
 533:	e8 bb fe ff ff       	call   3f3 <write>
  while(--i >= 0)
 538:	83 c4 10             	add    $0x10,%esp
 53b:	39 f3                	cmp    %esi,%ebx
 53d:	75 e1                	jne    520 <printint+0x80>
}
 53f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 542:	5b                   	pop    %ebx
 543:	5e                   	pop    %esi
 544:	5f                   	pop    %edi
 545:	5d                   	pop    %ebp
 546:	c3                   	ret
 547:	90                   	nop
 548:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 54f:	00 
  neg = 0;
 550:	31 c0                	xor    %eax,%eax
 552:	e9 70 ff ff ff       	jmp    4c7 <printint+0x27>
 557:	90                   	nop
 558:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 55f:	00 

00000560 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	56                   	push   %esi
 565:	53                   	push   %ebx
 566:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 569:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 56c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 56f:	0f b6 13             	movzbl (%ebx),%edx
 572:	83 c3 01             	add    $0x1,%ebx
 575:	84 d2                	test   %dl,%dl
 577:	0f 84 a0 00 00 00    	je     61d <printf+0xbd>
 57d:	8d 45 10             	lea    0x10(%ebp),%eax
 580:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 583:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 586:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 589:	eb 28                	jmp    5b3 <printf+0x53>
 58b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 590:	83 ec 04             	sub    $0x4,%esp
 593:	8d 45 e7             	lea    -0x19(%ebp),%eax
 596:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 599:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 59c:	6a 01                	push   $0x1
 59e:	50                   	push   %eax
 59f:	56                   	push   %esi
 5a0:	e8 4e fe ff ff       	call   3f3 <write>
  for(i = 0; fmt[i]; i++){
 5a5:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5a9:	83 c4 10             	add    $0x10,%esp
 5ac:	84 d2                	test   %dl,%dl
 5ae:	74 6d                	je     61d <printf+0xbd>
    c = fmt[i] & 0xff;
 5b0:	0f b6 c2             	movzbl %dl,%eax
      if(c == '%'){
 5b3:	83 f8 25             	cmp    $0x25,%eax
 5b6:	75 d8                	jne    590 <printf+0x30>
  for(i = 0; fmt[i]; i++){
 5b8:	0f b6 13             	movzbl (%ebx),%edx
 5bb:	84 d2                	test   %dl,%dl
 5bd:	74 5e                	je     61d <printf+0xbd>
    c = fmt[i] & 0xff;
 5bf:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 5c2:	80 fa 25             	cmp    $0x25,%dl
 5c5:	0f 84 25 01 00 00    	je     6f0 <printf+0x190>
 5cb:	83 e8 63             	sub    $0x63,%eax
 5ce:	83 f8 15             	cmp    $0x15,%eax
 5d1:	77 0d                	ja     5e0 <printf+0x80>
 5d3:	ff 24 85 38 0a 00 00 	jmp    *0xa38(,%eax,4)
 5da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5e0:	83 ec 04             	sub    $0x4,%esp
 5e3:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 5e6:	88 55 d0             	mov    %dl,-0x30(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5e9:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 5ed:	6a 01                	push   $0x1
 5ef:	51                   	push   %ecx
 5f0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 5f3:	56                   	push   %esi
 5f4:	e8 fa fd ff ff       	call   3f3 <write>
        putc(fd, c);
 5f9:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 5fd:	83 c4 0c             	add    $0xc,%esp
 600:	88 55 e7             	mov    %dl,-0x19(%ebp)
 603:	6a 01                	push   $0x1
 605:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 608:	51                   	push   %ecx
  for(i = 0; fmt[i]; i++){
 609:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 60c:	56                   	push   %esi
 60d:	e8 e1 fd ff ff       	call   3f3 <write>
  for(i = 0; fmt[i]; i++){
 612:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 616:	83 c4 10             	add    $0x10,%esp
 619:	84 d2                	test   %dl,%dl
 61b:	75 93                	jne    5b0 <printf+0x50>
      }
      state = 0;
    }
  }
}
 61d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 620:	5b                   	pop    %ebx
 621:	5e                   	pop    %esi
 622:	5f                   	pop    %edi
 623:	5d                   	pop    %ebp
 624:	c3                   	ret
 625:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 628:	83 ec 0c             	sub    $0xc,%esp
 62b:	8b 17                	mov    (%edi),%edx
 62d:	b9 10 00 00 00       	mov    $0x10,%ecx
 632:	89 f0                	mov    %esi,%eax
 634:	6a 00                	push   $0x0
 636:	e8 65 fe ff ff       	call   4a0 <printint>
  for(i = 0; fmt[i]; i++){
 63b:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 63f:	83 c3 02             	add    $0x2,%ebx
 642:	83 c4 10             	add    $0x10,%esp
 645:	84 d2                	test   %dl,%dl
 647:	74 d4                	je     61d <printf+0xbd>
        ap++;
 649:	83 c7 04             	add    $0x4,%edi
 64c:	e9 5f ff ff ff       	jmp    5b0 <printf+0x50>
 651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 658:	8b 07                	mov    (%edi),%eax
        ap++;
 65a:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 65d:	85 c0                	test   %eax,%eax
 65f:	0f 84 9b 00 00 00    	je     700 <printf+0x1a0>
        while(*s != 0){
 665:	0f b6 10             	movzbl (%eax),%edx
 668:	84 d2                	test   %dl,%dl
 66a:	0f 84 a2 00 00 00    	je     712 <printf+0x1b2>
 670:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 673:	89 c7                	mov    %eax,%edi
 675:	89 d0                	mov    %edx,%eax
 677:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 67a:	89 fb                	mov    %edi,%ebx
 67c:	8d 7d e7             	lea    -0x19(%ebp),%edi
 67f:	90                   	nop
  write(fd, &c, 1);
 680:	83 ec 04             	sub    $0x4,%esp
 683:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 686:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 689:	6a 01                	push   $0x1
 68b:	57                   	push   %edi
 68c:	56                   	push   %esi
 68d:	e8 61 fd ff ff       	call   3f3 <write>
        while(*s != 0){
 692:	0f b6 03             	movzbl (%ebx),%eax
 695:	83 c4 10             	add    $0x10,%esp
 698:	84 c0                	test   %al,%al
 69a:	75 e4                	jne    680 <printf+0x120>
 69c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 69f:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 6a3:	83 c3 02             	add    $0x2,%ebx
 6a6:	84 d2                	test   %dl,%dl
 6a8:	0f 85 d5 fe ff ff    	jne    583 <printf+0x23>
 6ae:	e9 6a ff ff ff       	jmp    61d <printf+0xbd>
 6b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 6b8:	83 ec 0c             	sub    $0xc,%esp
 6bb:	8b 17                	mov    (%edi),%edx
 6bd:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6c2:	89 f0                	mov    %esi,%eax
 6c4:	6a 01                	push   $0x1
 6c6:	e8 d5 fd ff ff       	call   4a0 <printint>
  for(i = 0; fmt[i]; i++){
 6cb:	e9 6b ff ff ff       	jmp    63b <printf+0xdb>
        putc(fd, *ap);
 6d0:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 6d2:	83 ec 04             	sub    $0x4,%esp
 6d5:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        putc(fd, *ap);
 6d8:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6db:	6a 01                	push   $0x1
 6dd:	51                   	push   %ecx
 6de:	56                   	push   %esi
 6df:	e8 0f fd ff ff       	call   3f3 <write>
 6e4:	e9 52 ff ff ff       	jmp    63b <printf+0xdb>
 6e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6f0:	83 ec 04             	sub    $0x4,%esp
 6f3:	88 55 e7             	mov    %dl,-0x19(%ebp)
 6f6:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 6f9:	6a 01                	push   $0x1
 6fb:	e9 08 ff ff ff       	jmp    608 <printf+0xa8>
          s = "(null)";
 700:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 703:	b8 28 00 00 00       	mov    $0x28,%eax
 708:	bf 2a 09 00 00       	mov    $0x92a,%edi
 70d:	e9 65 ff ff ff       	jmp    677 <printf+0x117>
  for(i = 0; fmt[i]; i++){
 712:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 716:	83 c3 02             	add    $0x2,%ebx
 719:	84 d2                	test   %dl,%dl
 71b:	0f 85 8f fe ff ff    	jne    5b0 <printf+0x50>
 721:	e9 f7 fe ff ff       	jmp    61d <printf+0xbd>
 726:	66 90                	xchg   %ax,%ax
 728:	66 90                	xchg   %ax,%ax
 72a:	66 90                	xchg   %ax,%ax
 72c:	66 90                	xchg   %ax,%ax
 72e:	66 90                	xchg   %ax,%ax
 730:	66 90                	xchg   %ax,%ax
 732:	66 90                	xchg   %ax,%ax
 734:	66 90                	xchg   %ax,%ax
 736:	66 90                	xchg   %ax,%ax
 738:	66 90                	xchg   %ax,%ax
 73a:	66 90                	xchg   %ax,%ax
 73c:	66 90                	xchg   %ax,%ax
 73e:	66 90                	xchg   %ax,%ax

00000740 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 740:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 741:	a1 44 0d 00 00       	mov    0xd44,%eax
{
 746:	89 e5                	mov    %esp,%ebp
 748:	57                   	push   %edi
 749:	56                   	push   %esi
 74a:	53                   	push   %ebx
 74b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 74e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 751:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 758:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 75f:	00 
 760:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 762:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 764:	39 ca                	cmp    %ecx,%edx
 766:	73 30                	jae    798 <free+0x58>
 768:	39 c1                	cmp    %eax,%ecx
 76a:	72 04                	jb     770 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 76c:	39 c2                	cmp    %eax,%edx
 76e:	72 f0                	jb     760 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 770:	8b 73 fc             	mov    -0x4(%ebx),%esi
 773:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 776:	39 f8                	cmp    %edi,%eax
 778:	74 36                	je     7b0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 77a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 77d:	8b 42 04             	mov    0x4(%edx),%eax
 780:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 783:	39 f1                	cmp    %esi,%ecx
 785:	74 40                	je     7c7 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 787:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 789:	5b                   	pop    %ebx
  freep = p;
 78a:	89 15 44 0d 00 00    	mov    %edx,0xd44
}
 790:	5e                   	pop    %esi
 791:	5f                   	pop    %edi
 792:	5d                   	pop    %ebp
 793:	c3                   	ret
 794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 798:	39 c2                	cmp    %eax,%edx
 79a:	72 c4                	jb     760 <free+0x20>
 79c:	39 c1                	cmp    %eax,%ecx
 79e:	73 c0                	jae    760 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 7a0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7a3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7a6:	39 f8                	cmp    %edi,%eax
 7a8:	75 d0                	jne    77a <free+0x3a>
 7aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 7b0:	03 70 04             	add    0x4(%eax),%esi
 7b3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7b6:	8b 02                	mov    (%edx),%eax
 7b8:	8b 00                	mov    (%eax),%eax
 7ba:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 7bd:	8b 42 04             	mov    0x4(%edx),%eax
 7c0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 7c3:	39 f1                	cmp    %esi,%ecx
 7c5:	75 c0                	jne    787 <free+0x47>
    p->s.size += bp->s.size;
 7c7:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 7ca:	89 15 44 0d 00 00    	mov    %edx,0xd44
    p->s.size += bp->s.size;
 7d0:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 7d3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 7d6:	89 0a                	mov    %ecx,(%edx)
}
 7d8:	5b                   	pop    %ebx
 7d9:	5e                   	pop    %esi
 7da:	5f                   	pop    %edi
 7db:	5d                   	pop    %ebp
 7dc:	c3                   	ret
 7dd:	8d 76 00             	lea    0x0(%esi),%esi

000007e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	57                   	push   %edi
 7e4:	56                   	push   %esi
 7e5:	53                   	push   %ebx
 7e6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7ec:	8b 15 44 0d 00 00    	mov    0xd44,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f2:	8d 78 07             	lea    0x7(%eax),%edi
 7f5:	c1 ef 03             	shr    $0x3,%edi
 7f8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 7fb:	85 d2                	test   %edx,%edx
 7fd:	0f 84 8d 00 00 00    	je     890 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 803:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 805:	8b 48 04             	mov    0x4(%eax),%ecx
 808:	39 f9                	cmp    %edi,%ecx
 80a:	73 64                	jae    870 <malloc+0x90>
  if(nu < 4096)
 80c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 811:	39 df                	cmp    %ebx,%edi
 813:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 816:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 81d:	eb 0a                	jmp    829 <malloc+0x49>
 81f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 820:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 822:	8b 48 04             	mov    0x4(%eax),%ecx
 825:	39 f9                	cmp    %edi,%ecx
 827:	73 47                	jae    870 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 829:	89 c2                	mov    %eax,%edx
 82b:	39 05 44 0d 00 00    	cmp    %eax,0xd44
 831:	75 ed                	jne    820 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 833:	83 ec 0c             	sub    $0xc,%esp
 836:	56                   	push   %esi
 837:	e8 1f fc ff ff       	call   45b <sbrk>
  if(p == (char*)-1)
 83c:	83 c4 10             	add    $0x10,%esp
 83f:	83 f8 ff             	cmp    $0xffffffff,%eax
 842:	74 1c                	je     860 <malloc+0x80>
  hp->s.size = nu;
 844:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 847:	83 ec 0c             	sub    $0xc,%esp
 84a:	83 c0 08             	add    $0x8,%eax
 84d:	50                   	push   %eax
 84e:	e8 ed fe ff ff       	call   740 <free>
  return freep;
 853:	8b 15 44 0d 00 00    	mov    0xd44,%edx
      if((p = morecore(nunits)) == 0)
 859:	83 c4 10             	add    $0x10,%esp
 85c:	85 d2                	test   %edx,%edx
 85e:	75 c0                	jne    820 <malloc+0x40>
        return 0;
  }
}
 860:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 863:	31 c0                	xor    %eax,%eax
}
 865:	5b                   	pop    %ebx
 866:	5e                   	pop    %esi
 867:	5f                   	pop    %edi
 868:	5d                   	pop    %ebp
 869:	c3                   	ret
 86a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 870:	39 cf                	cmp    %ecx,%edi
 872:	74 4c                	je     8c0 <malloc+0xe0>
        p->s.size -= nunits;
 874:	29 f9                	sub    %edi,%ecx
 876:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 879:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 87c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 87f:	89 15 44 0d 00 00    	mov    %edx,0xd44
}
 885:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 888:	83 c0 08             	add    $0x8,%eax
}
 88b:	5b                   	pop    %ebx
 88c:	5e                   	pop    %esi
 88d:	5f                   	pop    %edi
 88e:	5d                   	pop    %ebp
 88f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 890:	c7 05 44 0d 00 00 48 	movl   $0xd48,0xd44
 897:	0d 00 00 
    base.s.size = 0;
 89a:	b8 48 0d 00 00       	mov    $0xd48,%eax
    base.s.ptr = freep = prevp = &base;
 89f:	c7 05 48 0d 00 00 48 	movl   $0xd48,0xd48
 8a6:	0d 00 00 
    base.s.size = 0;
 8a9:	c7 05 4c 0d 00 00 00 	movl   $0x0,0xd4c
 8b0:	00 00 00 
    if(p->s.size >= nunits){
 8b3:	e9 54 ff ff ff       	jmp    80c <malloc+0x2c>
 8b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8bf:	00 
        prevp->s.ptr = p->s.ptr;
 8c0:	8b 08                	mov    (%eax),%ecx
 8c2:	89 0a                	mov    %ecx,(%edx)
 8c4:	eb b9                	jmp    87f <malloc+0x9f>
