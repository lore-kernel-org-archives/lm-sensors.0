From: kronos.it@gmail.com (Luca Tettamanti)
Date: Sat, 30 Dec 2006 18:11:12 +0000
Subject: [lm-sensors] W83627DHG, steps to use
Message-Id: <20061230181112.GA7317@dreamland.darkstar.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <200612271943.00165@goldspace.net>
In-Reply-To: <200612271943.00165@goldspace.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Il Fri, Dec 29, 2006 at 07:50:54PM -0700, David Hubbard ha scritto: 
> Hi Rudolf,
> 
> It looks like there is some code in the kernel that could be extended
> to provide MSR data for the coretemp driver--maybe you already know
> about this?
> 
> >Btw, using /dev/cpuX/msr device you can read core temperatures, I just
> >copied the algorithm used by the kernel driver. Of course it's not
> >integrated with the rest of the hwmon subsystem...
> >If you're interested I can send you the source file as soon as I get
> >back to home.

I'm talking about an userspace application that read directly msr device
exposed by the kernel driver.
The program itself it's very trivial (I just added a bit of error checking so
it doesn't look so bad ;))

#include <stdio.h>
#include <stdint.h>

#define MSR_IA32_THERM_STATUS 0x019c
#define TJ_MAX 100

int main(void) {
	int cpus = 2;
	int i;
	char msr_name[64];
	FILE *msr;
	uint64_t val;
	int temp;

	for (i = 0; i < cpus; i++) {
		sprintf(msr_name, "/dev/cpu/%d/msr", i);

		msr = fopen(msr_name, "r");
		if (!msr) {
			perror("fopen()");
			return 1;
		}
		fseek(msr, MSR_IA32_THERM_STATUS, SEEK_SET);
		fread(&val, 8, 1, msr);
		fclose(msr);

		/* Valid bit */
		if (!(val & 0x80000000)) {
			fprintf(stderr, "Invalid reading for CPU %d\n", i);
			continue;
		}
		temp = TJ_MAX - ((val >> 16) & 0x7f);

		printf("CPU%d: %d?C\n", i, temp);
	}

	return 0;
}


What Rudolf wants (AFAICS) is a mean to call into the msr module from
the kernel.

Luca
-- 
Recursion n.:
	See Recursion.

