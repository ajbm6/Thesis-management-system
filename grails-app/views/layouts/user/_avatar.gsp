<div class="avatar">
    <richg:avatar user="${userInstance}" id="avatar"/>
    <!-- Button to trigger modal -->
    <a href="#change-avatar" role="button" id="avatar-button" data-toggle="modal">
        <g:message code="uploader.text.changeAvatar.button"/>
    </a>
</div>
<!-- Modal -->
<div id="change-avatar" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-wrapper">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3><g:message code="uploader.text.changeAvatar.title"/></h3>
        </div>
        <div class="modal-body">
            <u:uploader id="avatar-uploader"
                        topic="avatar"
                        text="[uploadButton: message(code: 'avatar.select.button')]"
                        multiple="${false}"
                        params="${[id: userInstance.id]}"
                        callbacks="[complete: 'avatarUploaded']">
                <u:deleteLink class="tms-btn pull-right"
                              id="${userInstance.id}"
                              topic="avatar"
                              onSuccess="avatarUpdated(data)">
                    <i class="icon-remove-sign"></i>
                    <g:message code="avatar.delete.button"/>
                </u:deleteLink>

                <u:trigger id="triggerUpload" class="tms-btn pull-right">
                    <i class="icon-upload"></i>
                    <g:message code="uploader.text.startUpload.button"/>
                </u:trigger>
            </u:uploader>
        </div>
    </div>
</div>

<script type="text/javascript">
    function avatarUpdated(data) {
        if (!data.success) {
            return false;
        }

        var image;
        if (data.id) {
            image = "${grid.createLink(mongoId: '{id}', bucket: 'user').decodeURL()}"
            image = image.replace(/{id}/g, data.id)
        } else {
            image = "${resource(dir: 'images', file: 'avatar.png')}";
        }

        // TODO: reset uploader after success
        $('#avatar').attr('src', image);
        $('#change-avatar').modal('toggle');
    }

    %{-- Hack to user function from above as fine uploader callback --}%
    avatarUploaded = function (event, id, name, data) {
        avatarUpdated(data);
    }
</script>
