From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 24 Oct 2008 08:52:39 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] Allow it87.c to handle IT8720
Message-Id: <20081024105239.30571c6a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48FF7DA8.3020902@Spaggiari.org>
In-Reply-To: <48FF7DA8.3020902@Spaggiari.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean-Marc,

On Thu, 23 Oct 2008 18:09:14 -0400, Jean-Marc Spaggiari wrote:
> Jean Delvare wrote:
> > I am surprised. Compared to the previous version of your patch, some
> > occurrences of the data->type = it8720 test have been _removed_. For
> > example, in has_16bit_fans(), and also once in it87_probe(). You did
> > not really mean to revert these changes, did you?
> > (...)
> > All the rest looks OK to me now.
> 
> I just update the patch. I have restore the missing occurrences off 
> IT8720. I have also update some comments, Will post the patch in a new 
> email thread since I think it's now clean.

OK, thanks. I'll review it later today. Unfortunately we missed the
merge window so this patch will be queued up for kernel 2.6.29.

> Also, I saw in a previous thread that we might use tabulations instead 
> of spaces. There is a lot of spaces that can be replaced by tabulations. 
> Do you think I can modify that and provide a "cosmetic" patch? Just let 
> me know, and I will do.

Anything checkpatch.pl --file complains about is a candidate for a
cleanup patch, yes. As far as tabs vs. spaces are concerned, we indeed
prefer tabs in the code. When large comments use spaces I tend to leave
that as is though. Also note that it's perfectly OK to use a few spaces
after tabulations in order to align the second line of a statement on
the opening parenthesis of the first line of that statement.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
