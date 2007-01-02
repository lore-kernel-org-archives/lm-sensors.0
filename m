From: r.marek@assembler.cz (Rudolf Marek)
Date: Tue, 02 Jan 2007 18:49:24 +0000
Subject: [lm-sensors] W83627DHG, steps to use
Message-Id: <459AA934.3000700@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200612271943.00165@goldspace.net>
In-Reply-To: <200612271943.00165@goldspace.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David Hubbard wrote:
> Hi Rudolf,
> 
> It looks like there is some code in the kernel that could be extended
> to provide MSR data for the coretemp driver--maybe you already know
> about this?

My last incarnation of the driver uses the msr.c functions. I wrote to LKML
about this but there was no result. The interface is bit unclean.

Jean,

Any ideas how to proceed with coretemp driver? Maybe best would be just to copy
the routines to the driver and wait until some sane interface to msr appear?

Thanks,

Rudolf


