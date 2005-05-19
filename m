From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: driver W83784
Message-Id: <3F512C2C.4020103@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.3.96.1030722161727.25099C-100000@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.3.96.1030722161727.25099C-100000@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

what standards we have are in doc/developers/proc.
the two examples you cited, we don't have standards for.

Rudolf Marek wrote:
> Hello,
> 
> My new driver is in progress. But I dont know how to interface to user
> things like PWM divisor (not PWM duty cycle) or SMI mask reg etc.
> 
> I looked some sources and it seems that every driver is unique this way.
> Is this general true ?
> 
> Or there are some standard way - format of files in /proc ?
> 
> 
> Regards
> 
> Rudolf 
> 
> 
