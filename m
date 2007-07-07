From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 07 Jul 2007 19:04:09 +0000
Subject: Re: [lm-sensors] Better generic print fault handling
Message-Id: <20070707210409.1e12476d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070707174935.7d4e56e4@hyperion.delvare>
In-Reply-To: <20070707174935.7d4e56e4@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 07 Jul 2007 18:38:03 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > I guess that the main problem here is that we have an artificial split
> > of temp_print_info() outside of the generic temperature printing
> > function, while we shouldn't. This explains in part why the this
> > generic temperature printing function doesn't look quite good.
> 
> Hmm, I don't think putting all the temp_print_info() stuff into the function 
> will make it better, maybe it will, but I don't know if a function becomes tom 
> large splitting of small sub functions can be a good idea.

Agreed. But the number of arguments we are passing to temp_print_info()
right now clearly shows that something is wrong. Having everything in
the same file will make it easier to decide how to best split the code
between functions.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
