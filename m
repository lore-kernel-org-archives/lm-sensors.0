From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 27 Sep 2011 23:30:06 +0000
Subject: [lm-sensors] dynamic-debug enhancements
Message-Id: <CAJfuBxz0ZRJZjKUcJs=jOABJ2Jp0rtEvA=P7754FJMtct2g7ag@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi good folks,

Ive made some enhancements to the dynamic-debug facility,
and submitted the patchset to LKML.

I belatedly thought to let you all know, and invite you to try them out,
and report success / failure, or things that might be nice to have.
Since drivers/* are a major user of dev_dbg, pr_debug,
your input is pertinent.

Easiest is to get it from github,
git://github.com/jimc/linux-2.6.git  dyndbg/on-driver-core

Its had a few rounds of review & revision, so is mostly stable.
Of course, it could change some more, so you should merge
your branch and it into a test branch so as not to create hassles
if it does change further.

I'll push a branch on v3.0 if anyone wants that.


I managed (somehow) to not put [patch 00/26] on the 1st message :-(
so I copy-paste its contents here..

- multiple queries on bootline, via ddebug_query='"...", formerly just
 1 query was accepted.  This also allows cat foo-queries > $CONTROL
 to add numerous rules together.

- tolerance to errors in ddebug_query.  Formerly, a bad rule would
 kill the facility, now it stays up, you can correct the rule without
 rebooting.

- pending queries.  bootline can enable pr_debugs in an uninstalled
 module, by adding 'a' flag. When module is loaded later, pr_debug
 callsites are enabled, before module-init is run, so pr_debug can be
 used in module-init.  Currently pending queries are readable in
 $DBGMT/dynamic_debug/pending

- filter flags.  flags before the operator [+-=] are used to narrow
 selection of callsites.  This augments module, filename, function
 filters, allowing:

echo p+t > $CONTROL  # add TID to ALL enabled sites
echo ml+p > $CONTROL # enable sites marked earlier.

- src-dir relative paths in $CONTROL.  Formerly, filenames were
 printed with full path, and new rules had to use full path if
 basename wasnt enough.  Now theyre printed with relative paths, and
 relative paths are accepted when writing new rules.

Ive updated Documentation/dynamic-debug-howto.txt,
which I hope is a coherent explanation - please let me know
if its not sufficiently clear.


0001-dynamic_debug-drop-enabled-field-from-struct-_ddebug.patch
0002-dynamic_debug-make-dynamic-debug-supersede-DEBUG-ccf.patch
0003-dynamic_debug-replace-strcpy-with-strlcpy-in-ddebug_.patch
0004-dynamic_debug-warn-when-1-of-each-type-of-match-spec.patch
0005-dynamic_debug-pr_err-call-should-not-depend-upon-ver.patch
0006-dynamic_debug-add-trim_prefix-to-provide-source-root.patch
0007-dynamic_debug-change-verbosity-at-runtime.patch
0008-dynamic_debug-define-several-levels-of-verbosity.patch
0009-dynamic_debug-process-multiple-commands-on-a-line.patch
0010-dynamic_debug-enlarge-command-query-write-buffer.patch
0011-dynamic_debug-hoist-locking-in-ddebug_change-to-call.patch
0012-dynamic_debug-dont-kill-entire-facility-on-error-par.patch
0013-dynamic_debug-factor-vpr_info_dq-out-of-ddebug_parse.patch
0014-dynamic_debug-refactor-query_matches_callsite-out-of.patch
0015-dynamic_debug-drop-explicit-foo-NULL-checks.patch
0016-dynamic_debug-save-a-queries-to-pending-list-for-lat.patch
0017-dynamic_debug-remove-pending-query-when-flags-zeroed.patch
0018-dynamic_debug-describe_flags-with-pmflta_.patch
0019-dynamic_debug-add-flags-filtering-to-flags-spec.patch
0020-dynamic_debug-make-ddebug_describe_flags-more-generi.patch
0021-dynamic_debug-add-DBGFS-dynamic_debug-pending-file.patch
0022-dynamic_debug-early-return-if-_ddebug-table-is-empty.patch
0023-dynamic_debug-document-pending-queries-flags-filter-.patch
0024-dynamic_debug-reduce-lineno-field-to-a-saner-18-bits.patch
0025-dynamic_debug-add-pr_fmt_debug-for-dynamic_pr_debug.patch
0026-scx200_acb-use-pr_-info-warn-err-debug-and-dynamic-d.patch

Last patch adjusts drivers/i2c/busses/scx200_acb, like so:

+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define pr_fmt_debug(fmt) fmt
+
and lots of:
-		pr_debug(NAME ": enabled, but NMINTE won't be set, "
+		pr_debug("enabled, but NMINTE won't be set, "


The main issue here is that non dynamic-debug builds lose the
KBUILD_MODNAME if done as above, fixable per module by:

#if CONFIG_DYNAMIC_DEBUG
#define pr_fmt_debug(fmt) fmt
#endif
// else get pr_fmt_debug(fmt) pr_fmt(fmt) by default...

This could go into printk.h also, but its been suggested to wait on that,
subject to some emerging consensus.  Opinions ?

thanks
Jim Cromie

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
