

<?php $__env->startSection('title', 'Pesan - NOERA'); ?>

<?php $__env->startSection('content'); ?>
<div class="page-header">
    <div class="page-header-content">
        <h1>Pesan</h1>
        <p>Chat dengan partner skill exchange yang sudah kamu terima.</p>
    </div>
</div>

<div class="section-card">
    <div class="section-header">
        <div class="section-title">Semua Percakapan</div>
    </div>

    <div style="display: flex; flex-direction: column; gap: 4px;">
        <?php $__empty_1 = true; $__currentLoopData = $conversations; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $partner): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); $__empty_1 = false; ?>
            <a href="<?php echo e(route('messages.show', $partner->id)); ?>" style="text-decoration: none; color: inherit;">
                <div style="display: flex; align-items: center; gap: var(--space-4); padding: var(--space-4); border-radius: var(--radius-lg); transition: background 0.1s ease;"
                     onmouseover="this.style.background='var(--gray-50)'" onmouseout="this.style.background='transparent'">
                    <div class="partner-avatar" style="width: 48px; height: 48px;">
                        <img src="https://ui-avatars.com/api/?name=<?php echo e(urlencode($partner->name)); ?>&background=0066ff&color=fff" alt="<?php echo e($partner->name); ?>">
                    </div>
                    <div style="flex: 1; min-width: 0;">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <span style="font-family: var(--font-display); font-weight: 700; font-size: 14px; color: var(--gray-900);"><?php echo e($partner->name); ?></span>
                            <?php if($partner->last_message): ?>
                                <span style="font-size: 11px; color: var(--gray-500);"><?php echo e(\Carbon\Carbon::parse($partner->last_message->created_at)->diffForHumans()); ?></span>
                            <?php endif; ?>
                        </div>
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 2px;">
                            <span style="font-size: 13px; color: var(--gray-600); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 400px;">
                                <?php echo e($partner->last_message->content ?? 'Belum ada pesan. Mulai chat sekarang!'); ?>

                            </span>
                            <?php if($partner->unread_count > 0): ?>
                                <span class="badge-count" style="position: static; border: none;"><?php echo e($partner->unread_count); ?></span>
                            <?php endif; ?>
                        </div>
                    </div>
                </div>
            </a>
        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); if ($__empty_1): ?>
            <div class="empty-state">Belum ada partner untuk dichat. Terima partner request terlebih dahulu di Skill Exchange.</div>
        <?php endif; ?>
    </div>
</div>
<?php $__env->stopSection(); ?>
<?php echo $__env->make('layouts.app', array_diff_key(get_defined_vars(), ['__data' => 1, '__path' => 1]))->render(); ?><?php /**PATH D:\laragon\www\Project_Final_Web_2\resources\views/messages/index.blade.php ENDPATH**/ ?>