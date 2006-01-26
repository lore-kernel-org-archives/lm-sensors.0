From: jim.cromie@gmail.com (Jim Cromie)
Date: Thu, 26 Jan 2006 18:36:13 +0000
Subject: [lm-sensors] No sensors found!
Message-Id: <43D9169D.5010008@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <62A29338972397468405C79C4FE13C3B916AFA@ex1.messagegate.local>
In-Reply-To: <62A29338972397468405C79C4FE13C3B916AFA@ex1.messagegate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

samag70-2 at yahoo.ca wrote:

<snip>

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
     my $use_isa = not <STDIN> =~ /\s*[Ss]/;

since your answer started with 's', youve told it not to use isa.

try rerunning, hit return for this question, and youll get ISA used.
Then see what it recommends next.

good luck.
pls report back ok/not

