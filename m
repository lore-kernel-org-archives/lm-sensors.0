From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: CVS tests report
Message-Id: <3EE22F3D.2070201@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030606183514.2e884183.khali@linux-fr.org>
In-Reply-To: <20030606183514.2e884183.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I think i2c-proc is fixed. Please test.

I've added several updates to the home page and the download page
in the last few days.
On the download page we already have a warning in bold that CVS is under 
"active development" which is intended as a warning.

On your issue with matroxfb_maven unresolved symbols,
we unfortunately are no longer compatible with i2c modules in stock 2.4 kernels,
due to struct changes adding owner and removing inc_use and dec_use.
You definitely don't want i2c drivers from a 2.4 kernel compiled-in or
loaded as modules

Let's discuss what to do about this - some possiblilities:
We can back out the struct changes...
We can add big warnings to the release and work on submitting a 2.4 patch....
We can try and require a very recent 2.4 kernel...
We can include a patch to a recent 2.4 kernel to convert all i2c drivers...
We can include some compatibility code...

Would anybody like to work on a patch for 2.4 for submission to Marcelo?


Jean Delvare wrote:
>>BTW when you rmmod i2c-proc right now, it doesn't completely remove
>>the sysctl table, and things really go bad.
>>I'm doing lots of diffs to figure out what to do next and hope to get
>>things into shape tomorrow. mds
> 
> 
> OK, thanks. Let me know if I can help (though I really have no knowledge
> about I2C and such).
> 
> Maybe adding a news item saying I2C is known to be somewhat broken could
> be welcome? The latest related new item was added in March, readers
> could believe the situation has changed since.
> 
