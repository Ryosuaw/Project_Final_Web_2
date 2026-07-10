

<?php $__env->startSection('title', 'Chat dengan ' . $partner->name . ' - NOERA'); ?>

<?php $__env->startSection('content'); ?>
<div class="page-header">
    <div class="page-header-content">
        <h1>
            <a href="<?php echo e(route('messages.index')); ?>" style="color: var(--gray-400); text-decoration: none; margin-right: 8px;">←</a>
            Chat dengan <?php echo e($partner->name); ?>

        </h1>
        <p><?php echo e($partner->major ?? '-'); ?> — <?php echo e($partner->university ?? '-'); ?></p>
    </div>
</div>

<div class="section-card" style="display: flex; flex-direction: column; height: 60vh;">
    <div id="chat-box" style="flex: 1; overflow-y: auto; display: flex; flex-direction: column; gap: 12px; padding-bottom: 16px;">
        <?php $__empty_1 = true; $__currentLoopData = $messages; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $msg): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); $__empty_1 = false; ?>
            <?php $isMine = $msg->sender_id === $user->id; ?>
            <div style="display: flex; justify-content: <?php echo e($isMine ? 'flex-end' : 'flex-start'); ?>;">
                <div style="max-width: 60%; padding: 10px 14px; border-radius: 14px; font-size: 13px; line-height: 1.5;
                    background: <?php echo e($isMine ? 'var(--primary)' : 'var(--gray-100)'); ?>;
                    color: <?php echo e($isMine ? 'white' : 'var(--gray-900)'); ?>;">
                    <?php echo e($msg->content); ?>

                    <div style="font-size: 10px; margin-top: 4px; opacity: 0.7;">
                        <?php echo e(\Carbon\Carbon::parse($msg->created_at)->format('H:i')); ?>

                    </div>
                </div>
            </div>
        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); if ($__empty_1): ?>
            <div class="empty-state">Belum ada pesan. Mulai percakapan dengan <?php echo e($partner->name); ?>!</div>
        <?php endif; ?>
    </div>

    <form method="POST" action="<?php echo e(route('messages.store', $partner->id)); ?>" style="display: flex; gap: 10px; border-top: 1px solid var(--border-default); padding-top: 16px;">
        <?php echo csrf_field(); ?>
        <input type="text" name="content" placeholder="Tulis pesan..." required
            style="flex: 1; padding: 10px 14px; border: 1px solid var(--border-default); border-radius: var(--radius-md); font-size: 13px; font-family: var(--font-sans);">
        <button type="submit" class="btn btn-primary">Kirim</button>
    </form>
</div>

<script>
    var chatBox = document.getElementById('chat-box');
    chatBox.scrollTop = chatBox.scrollHeight;
</script>
<?php $__env->stopSection(); ?>
<?php echo $__env->make('layouts.app', array_diff_key(get_defined_vars(), ['__data' => 1, '__path' => 1]))->render(); ?><?php /**PATH D:\laragon\www\Project_Final_Web_2\resources\views/messages/show.blade.php ENDPATH**/ ?>