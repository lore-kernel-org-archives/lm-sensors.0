From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 19 Jan 2009 21:26:36 +0000
Subject: [lm-sensors] Branches in lm-sensors repository
Message-Id: <20090119222636.0380a479@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I think it is a bit confusing that all the development of lm-sensors is
happening in branch lm-sensors-3.0.0, and trunk is in maintenance mode.
It would make sense to use trunk for development again, and move the
2.10.x maintenance to a branch. What is even more confusing is that
what we are developing in branch lm-sensors-3.0.0 is no longer
lm-sensors 3.0.0, but 3.0.4, and as time passes the difference between
the name and the actual version will become larger.

Moving 2.10.x to a branch shouldn't be difficult: a svn copy or svn
move should do if I understand how SVN works. The only thing to decide
is the name of the new branch. At first I had "legacy" in mind but it
might not be the best for long term, as chances are that our active
3.0.0 branch will someday become the new legacy branch. So, what about
"lm-sensors-2.10"?

Moving development back to trunk might be a little more difficult, if
SVN considers trunk as special. If not, then maybe a svn move will
work. I am no SVN expert, so if anyone knows more about this type of
operation and has suggestions, these are very welcome.

I will proceed next week. One reason why I want this done quickly is
that I am currently updating our documentation in the wiki and I don't
want to have to update all the links when we rename the branches. So
better do the rename now and I'll continue the documentation updates
after that.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
