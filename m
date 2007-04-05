From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Apr 2007 20:15:04 +0000
Subject: Re: [lm-sensors] Checking out and comitting to the libsensors-3.x
Message-Id: <20070405221504.83071162.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4610BC25.8050507@hhs.nl>
In-Reply-To: <4610BC25.8050507@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Axel,

Sorry for the delay.

On Wed, 4 Apr 2007 21:43:17 +0200, Axel Thimm wrote:
> Hi,
> 
> On Wed, Apr 04, 2007 at 09:29:10PM +0200, Jean Delvare wrote:
> > BTW, lm-sensors.org's trac looks broken to me, it spits python errors
> > at me for every page but the main page.
> 
> That's bad, can you give me a failing URL? I can't seem to be
> (un)lucky enough to find one. :/

http://www.lm-sensors.org/wiki/Devices

Oops…
Trac detected an internal error:

If you think this really should work and you can reproduce it, you should consider reporting this problem to the Trac team.

Go to http://trac.edgewall.org/ and create a new ticket where you describe the problem, how to reproduce it. Don't forget to include the Python traceback found below.

TracGuide — The Trac User and Administration Guide
Python Traceback

Traceback (most recent call last):
  File "/usr/lib/python2.4/site-packages/trac/web/main.py", line 387, in dispatch_request
    dispatcher.dispatch(req)
  File "/usr/lib/python2.4/site-packages/trac/web/main.py", line 191, in dispatch
    chosen_handler = self._pre_process_request(req, chosen_handler)
  File "/usr/lib/python2.4/site-packages/trac/web/main.py", line 263, in _pre_process_request
    chosen_handler = f.pre_process_request(req, chosen_handler)
  File "/usr/lib/python2.4/site-packages/trac/versioncontrol/api.py", line 73, in pre_process_request
    self.get_repository(req.authname) # triggers a sync if applicable
  File "/usr/lib/python2.4/site-packages/trac/versioncontrol/api.py", line 101, in get_repository
    repos = self._connector.get_repository(rtype, rdir, authname)
  File "/usr/lib/python2.4/site-packages/trac/versioncontrol/svn_fs.py", line 259, in get_repository
    repos = SubversionRepository(dir, None, self.log)
  File "/usr/lib/python2.4/site-packages/trac/versioncontrol/svn_fs.py", line 281, in __init__
    self.pool = Pool()
  File "/usr/lib/python2.4/site-packages/trac/versioncontrol/svn_fs.py", line 158, in __init__
    self._pool = core.svn_pool_create(self._parent_pool())
  File "/usr/lib64/python2.4/site-packages/svn/core.py", line 177, in svn_pool_create
    return Pool(parent_pool)
  File "/usr/lib64/python2.4/site-packages/libsvn/core.py", line 1080, in svn_pool_create
    return apply(_core.svn_pool_create, args)
  File "/usr/lib64/python2.4/site-packages/libsvn/core.py", line 3081, in _wrap
    obj.set_parent_pool(self)
  File "/usr/lib64/python2.4/site-packages/libsvn/core.py", line 2994, in set_parent_pool
    self._parent_pool = parent_pool or application_pool
  File "/usr/lib64/python2.4/site-packages/libsvn/core.py", line 2982, in <lambda>
    __setattr__ = lambda self, name, value: _swig_setattr(self, apr_pool_t, name, value)
  File "/usr/lib64/python2.4/site-packages/libsvn/core.py", line 22, in _swig_setattr
    return _swig_setattr_nondynamic(self,class_type,name,value,0)
  File "/usr/lib64/python2.4/site-packages/libsvn/core.py", line 17, in _swig_setattr_nondynamic
    self.__dict__[name] = value
RuntimeError: instance.__dict__ not accessible in restricted mode

It's an intermittent error, sometimes I get it, sometimes I don't.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
