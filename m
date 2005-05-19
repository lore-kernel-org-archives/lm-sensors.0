From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: Compile problem RH9
Message-Id: <3ED80847.1040007@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1053818740.7444.16.camel@localhost.localdomain>
In-Reply-To: <1053818740.7444.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

replace -idirafter with -I in the makefile (CPPFLAGS line).
We're working on something better.

Filipko Zdenko wrote:
> Hi, 
>  
> I have a new board (MSI KT4V, with VIA KT400 & VT8235 & W83697HF). While trying to compile current lm_sensors cvs,
> the following errors occur:
> 
