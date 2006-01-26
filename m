From: samag70-2@yahoo.ca (samag70-2@yahoo.ca)
Date: Thu, 26 Jan 2006 18:44:53 +0000
Subject: [lm-sensors] No sensors found!
Message-Id: <20060126184453.56370.qmail@web88201.mail.re2.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <62A29338972397468405C79C4FE13C3B916AFA@ex1.messagegate.local>
In-Reply-To: <62A29338972397468405C79C4FE13C3B916AFA@ex1.messagegate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the fast response.
  
  I get the exact same output and results even if I choose ISA at that  step.  I have tried removing/reinstalling the software,  unloading/loading modules, re-running sensors-detect many times and I'm  not having any luck.  I think I am missing something.  Or my  hardware is not supported.
  
  Sam

Jim Cromie <jim.cromie at gmail.com> wrote:  samag70-2 at yahoo.ca wrote:



>  I will now generate the commands needed to load the I2C modules.
>  Sometimes, a chip is available both through the ISA bus and an I2C bus.
>  ISA bus access is faster, but you need to load an additional driver 
> module
>  for it. If you have the choice, do you want to use the ISA bus or the
>  I2C/SMBus (ISA/smbus)? smbus


I suspect youre running afoul on this question (which IIRC is going away 
soon,
since ISA is faster when its available)

anyway, in sensors-detect packaged in lm_sensors-2.9.1-3.FC4.2,
the answer is being parsed by this:
     my $use_isa = not  =~ /\s*[Ss]/;

since your answer started with 's', youve told it not to use isa.

try rerunning, hit return for this question, and youll get ISA used.
Then see what it recommends next.

good luck.
pls report back ok/not


-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060126/67ffc6af/attachment-0001.html
