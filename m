From: r.marek@assembler.cz (Rudolf Marek)
Date: Thu, 08 Feb 2007 19:47:21 +0000
Subject: [lm-sensors] Inconsistents results
Message-Id: <45CB7E49.1010100@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <45C17E27.70603@free.fr>
In-Reply-To: <45C17E27.70603@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello again,
> Hi !
> May I add the response from AMD regarding the difference between the 
> Core 0 temp and Core 1 temp ?
> I quote :
> ==================================
> En ce qui concerne la diff?rence de temp?rature entre les deux core, il
> semblerait que lors du test, un seul des core soit actif car la charge
> de travail ne devait pas n?cessiter l activation du deuxieme core. En
> effet 17? correspond a peu pres a la temperature de l environement ou` le
> PC est plac?.
> 
> En ce qui concerne la difference de temperature annonc? part la carte
> mere, il est normal qu elle soit legerement differente car moins
> precise. En effet la capteur de temperature du processeur est in?gr? a
> celui ci donc plus fiable.
> ==================================> As it is in French, I translate it roughly as : "the cause of the 
> difference is that the second core is not used at all because the 
> workload is too low. The core 1 temp is about the ambient temp.
> Regarding the difference between the temp of the core0  as seen by the 
> AMD 64 sensor and the Mobo the cause is a difference in precision, the 
> mobo being less precise/accurate thand the in CPU sensor."

Well is the 18C possible? Have you some heatpipes CPU?

You may for example load both CPUs running following command 2 times:

dd if=/dev/urandom of=/dev/null
dd if=/dev/urandom of=/dev/null

And see what happens. (Of course you need to have the SMP kernel)

Rudolf


