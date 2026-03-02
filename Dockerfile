# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
RUN comfy node install --exit-on-fail comfyui-easy-use@1.3.6 --mode remote
RUN comfy node install --exit-on-fail was-ns@3.0.1
RUN comfy node install --exit-on-fail rgthree-comfy@1.0.2512112053
RUN comfy node install --exit-on-fail comfyui_essentials@1.1.0
RUN comfy node install --exit-on-fail ComfyMath
RUN comfy node install --exit-on-fail comfyui-crystools@1.27.4
RUN comfy node install --exit-on-fail comfyui-custom-scripts@1.2.5

# The following custom nodes were listed under "unknown_registry" but no aux_id (GitHub repo) was provided,
# so they could not be automatically resolved/installed. Please provide GitHub repos (aux_id) for these
# if you want them cloned into /comfyui/custom_nodes/:
# - Label (rgthree)
# - Reroute (multiple instances)
# - MarkdownNote
# - Note (multiple instances)

# download models into comfyui
RUN comfy model download --url https://huggingface.co/modelzpalace/juggernautXL_ragnarok/blob/main/juggernautXL_ragnarokBy.safetensors --relative-path models/diffusion_models --filename juggernautXL_ragnarokBy.safetensors
RUN comfy model download --url https://huggingface.co/shubhdotai/upscaler/blob/9b9bfba2a119bee0d175427cadb05283a3ed2fb1/4xNMKDSuperscale_4xNMKDSuperscale.pt --relative-path models/upscale_models --filename 4xNMKDSuperscale_4xNMKDSuperscale.pt

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
