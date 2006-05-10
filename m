From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 10 May 2006 19:12:45 +0000
Subject: [lm-sensors] W83627EHF driver enhancements
Message-Id: <44623B2D.3090304@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <442ED616.4070109@sh.cvut.cz>
In-Reply-To: <442ED616.4070109@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David Hubbard wrote:
> Hi Rudolf,
> 
> I have two more patches I'd like to send, and I'm updating the
> regression test. Testing all the parts of SmartFan I has taken some
> time. What do you think of the patches I've sent? Can I get them ready
> for inclusion in the kernel?

Well as far I rember those were just our internal step. I think we can merge 
them once we have something that works. Last patch on the to should be the 
cleanup patch. Because we cannot mess too many things at once :/

Please can you send all patches you have right now ready plus the version of 
w83627ehf I should use so I can test/comment it?

I think you may ommit:

* 0->DC variable voltage, 1->PWM variable duty cycle
+			 * Note that this is backward from the datasheet, but
+			 * consistent with the w83792d driver. Hopefully, any
+			 * new drivers which have PWM and DC modes will also
+			 * follow this convention for the sysfs pwmN_mode file.
+			 */

Because we agreed with Jean somewhere in the past that we may estabilish this as 
standard. I will prepare the docs patch in near feature.

thanks,

regards
Rudolf

